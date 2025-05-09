"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Fabricator = void 0;
const clc = require("colorette");
const executor_1 = require("./executor");
const error_1 = require("../../../error");
const sourceTokenScraper_1 = require("./sourceTokenScraper");
const timer_1 = require("./timer");
const functional_1 = require("../../../functional");
const supported_1 = require("../runtimes/supported");
const api_1 = require("../../../api");
const logger_1 = require("../../../logger");
const backend = require("../backend");
const cloudtasks = require("../../../gcp/cloudtasks");
const deploymentTool = require("../../../deploymentTool");
const gcf = require("../../../gcp/cloudfunctions");
const gcfV2 = require("../../../gcp/cloudfunctionsv2");
const eventarc = require("../../../gcp/eventarc");
const experiments = require("../../../experiments");
const helper = require("../functionsDeployHelper");
const poller = require("../../../operation-poller");
const pubsub = require("../../../gcp/pubsub");
const reporter = require("./reporter");
const run = require("../../../gcp/run");
const scheduler = require("../../../gcp/cloudscheduler");
const utils = require("../../../utils");
const services = require("../services");
const v1_1 = require("../../../functions/events/v1");
const gce = require("../../../gcp/computeEngine");
const functionsDeployHelper_1 = require("../functionsDeployHelper");
const gcfV1PollerOptions = {
    apiOrigin: (0, api_1.functionsOrigin)(),
    apiVersion: gcf.API_VERSION,
    masterTimeout: 25 * 60 * 1000,
    maxBackoff: 10000,
};
const gcfV2PollerOptions = {
    apiOrigin: (0, api_1.functionsV2Origin)(),
    apiVersion: gcfV2.API_VERSION,
    masterTimeout: 25 * 60 * 1000,
    maxBackoff: 10000,
};
const eventarcPollerOptions = {
    apiOrigin: (0, api_1.eventarcOrigin)(),
    apiVersion: "v1",
    masterTimeout: 25 * 60 * 1000,
    maxBackoff: 10000,
};
const CLOUD_RUN_RESOURCE_EXHAUSTED_CODE = 8;
const rethrowAs = (endpoint, op) => (err) => {
    logger_1.logger.error(err.message);
    throw new reporter.DeploymentError(endpoint, op, err);
};
class Fabricator {
    constructor(args) {
        this.executor = args.executor;
        this.functionExecutor = args.functionExecutor;
        this.sources = args.sources;
        this.appEngineLocation = args.appEngineLocation;
        this.projectNumber = args.projectNumber;
    }
    async applyPlan(plan) {
        const timer = new timer_1.Timer();
        const summary = {
            totalTime: 0,
            results: [],
        };
        const deployChangesets = Object.values(plan).map(async (changes) => {
            const results = await this.applyChangeset(changes);
            summary.results.push(...results);
            return;
        });
        const promiseResults = await utils.allSettled(deployChangesets);
        const errs = promiseResults
            .filter((r) => r.status === "rejected")
            .map((r) => r.reason);
        if (errs.length) {
            logger_1.logger.debug("Fabricator.applyRegionalChanges returned an unhandled exception. This should never happen", JSON.stringify(errs, null, 2));
        }
        summary.totalTime = timer.stop();
        return summary;
    }
    async applyChangeset(changes) {
        const deployResults = [];
        const handle = async (op, endpoint, fn) => {
            const timer = new timer_1.Timer();
            const result = { endpoint };
            try {
                await fn();
                this.logOpSuccess(op, endpoint);
            }
            catch (err) {
                result.error = err;
            }
            result.durationMs = timer.stop();
            deployResults.push(result);
        };
        const upserts = [];
        const scraperV1 = new sourceTokenScraper_1.SourceTokenScraper();
        const scraperV2 = new sourceTokenScraper_1.SourceTokenScraper();
        for (const endpoint of changes.endpointsToCreate) {
            this.logOpStart("creating", endpoint);
            upserts.push(handle("create", endpoint, () => this.createEndpoint(endpoint, scraperV1, scraperV2)));
        }
        for (const endpoint of changes.endpointsToSkip) {
            utils.logSuccess(this.getLogSuccessMessage("skip", endpoint));
        }
        for (const update of changes.endpointsToUpdate) {
            this.logOpStart("updating", update.endpoint);
            upserts.push(handle("update", update.endpoint, () => this.updateEndpoint(update, scraperV1, scraperV2)));
        }
        await utils.allSettled(upserts);
        if (deployResults.find((r) => r.error)) {
            for (const endpoint of changes.endpointsToDelete) {
                deployResults.push({
                    endpoint,
                    durationMs: 0,
                    error: new reporter.AbortedDeploymentError(endpoint),
                });
            }
            return deployResults;
        }
        const deletes = [];
        for (const endpoint of changes.endpointsToDelete) {
            this.logOpStart("deleting", endpoint);
            deletes.push(handle("delete", endpoint, () => this.deleteEndpoint(endpoint)));
        }
        await utils.allSettled(deletes);
        return deployResults;
    }
    async createEndpoint(endpoint, scraperV1, scraperV2) {
        endpoint.labels = Object.assign(Object.assign({}, endpoint.labels), deploymentTool.labels());
        if (endpoint.platform === "gcfv1") {
            await this.createV1Function(endpoint, scraperV1);
        }
        else if (endpoint.platform === "gcfv2") {
            await this.createV2Function(endpoint, scraperV2);
        }
        else {
            (0, functional_1.assertExhaustive)(endpoint.platform);
        }
        await this.setTrigger(endpoint);
    }
    async updateEndpoint(update, scraperV1, scraperV2) {
        update.endpoint.labels = Object.assign(Object.assign({}, update.endpoint.labels), deploymentTool.labels());
        if (update.deleteAndRecreate) {
            await this.deleteEndpoint(update.deleteAndRecreate);
            await this.createEndpoint(update.endpoint, scraperV1, scraperV2);
            return;
        }
        if (update.endpoint.platform === "gcfv1") {
            await this.updateV1Function(update.endpoint, scraperV1);
        }
        else if (update.endpoint.platform === "gcfv2") {
            await this.updateV2Function(update.endpoint, scraperV2);
        }
        else {
            (0, functional_1.assertExhaustive)(update.endpoint.platform);
        }
        await this.setTrigger(update.endpoint);
    }
    async deleteEndpoint(endpoint) {
        await this.deleteTrigger(endpoint);
        if (endpoint.platform === "gcfv1") {
            await this.deleteV1Function(endpoint);
        }
        else {
            await this.deleteV2Function(endpoint);
        }
    }
    async createV1Function(endpoint, scraper) {
        var _a, _b;
        const sourceUrl = (_a = this.sources[endpoint.codebase]) === null || _a === void 0 ? void 0 : _a.sourceUrl;
        if (!sourceUrl) {
            logger_1.logger.debug("Precondition failed. Cannot create a GCF function without sourceUrl");
            throw new Error("Precondition failed");
        }
        const apiFunction = gcf.functionFromEndpoint(endpoint, sourceUrl);
        if (apiFunction.httpsTrigger) {
            apiFunction.httpsTrigger.securityLevel = "SECURE_ALWAYS";
        }
        const resultFunction = await this.functionExecutor
            .run(async () => {
            apiFunction.sourceToken = await scraper.getToken();
            const op = await gcf.createFunction(apiFunction);
            return poller.pollOperation(Object.assign(Object.assign({}, gcfV1PollerOptions), { pollerName: `create-${endpoint.codebase}-${endpoint.region}-${endpoint.id}`, operationResourceName: op.name, onPoll: scraper.poller }));
        })
            .catch(rethrowAs(endpoint, "create"));
        endpoint.uri = (_b = resultFunction === null || resultFunction === void 0 ? void 0 : resultFunction.httpsTrigger) === null || _b === void 0 ? void 0 : _b.url;
        if (backend.isHttpsTriggered(endpoint)) {
            const invoker = endpoint.httpsTrigger.invoker || ["public"];
            if (!invoker.includes("private")) {
                await this.executor
                    .run(async () => {
                    await gcf.setInvokerCreate(endpoint.project, backend.functionName(endpoint), invoker);
                })
                    .catch(rethrowAs(endpoint, "set invoker"));
            }
        }
        else if (backend.isCallableTriggered(endpoint)) {
            await this.executor
                .run(async () => {
                await gcf.setInvokerCreate(endpoint.project, backend.functionName(endpoint), ["public"]);
            })
                .catch(rethrowAs(endpoint, "set invoker"));
        }
        else if (backend.isTaskQueueTriggered(endpoint)) {
            const invoker = endpoint.taskQueueTrigger.invoker;
            if (invoker && !invoker.includes("private")) {
                await this.executor
                    .run(async () => {
                    await gcf.setInvokerCreate(endpoint.project, backend.functionName(endpoint), invoker);
                })
                    .catch(rethrowAs(endpoint, "set invoker"));
            }
        }
        else if (backend.isBlockingTriggered(endpoint) &&
            v1_1.AUTH_BLOCKING_EVENTS.includes(endpoint.blockingTrigger.eventType)) {
            await this.executor
                .run(async () => {
                await gcf.setInvokerCreate(endpoint.project, backend.functionName(endpoint), ["public"]);
            })
                .catch(rethrowAs(endpoint, "set invoker"));
        }
    }
    async createV2Function(endpoint, scraper) {
        var _a, _b, _c, _d;
        const storageSource = (_a = this.sources[endpoint.codebase]) === null || _a === void 0 ? void 0 : _a.storage;
        if (!storageSource) {
            logger_1.logger.debug("Precondition failed. Cannot create a GCFv2 function without storage");
            throw new Error("Precondition failed");
        }
        const apiFunction = gcfV2.functionFromEndpoint(Object.assign(Object.assign({}, endpoint), { source: { storageSource } }));
        const topic = (_b = apiFunction.eventTrigger) === null || _b === void 0 ? void 0 : _b.pubsubTopic;
        if (topic) {
            await this.executor
                .run(async () => {
                try {
                    await pubsub.createTopic({ name: topic });
                }
                catch (err) {
                    if (err.status === 409) {
                        return;
                    }
                    throw new error_1.FirebaseError("Unexpected error creating Pub/Sub topic", {
                        original: err,
                        status: err.status,
                    });
                }
            })
                .catch(rethrowAs(endpoint, "create topic"));
        }
        const channel = (_c = apiFunction.eventTrigger) === null || _c === void 0 ? void 0 : _c.channel;
        if (channel) {
            await this.executor
                .run(async () => {
                try {
                    if ((await eventarc.getChannel(channel)) !== undefined) {
                        return;
                    }
                    const op = await eventarc.createChannel({ name: channel });
                    return await poller.pollOperation(Object.assign(Object.assign({}, eventarcPollerOptions), { pollerName: `create-${channel}-${endpoint.region}-${endpoint.id}`, operationResourceName: op.name }));
                }
                catch (err) {
                    if (err.status === 409) {
                        return;
                    }
                    throw new error_1.FirebaseError("Unexpected error creating Eventarc channel", {
                        original: err,
                        status: err.status,
                    });
                }
            })
                .catch(rethrowAs(endpoint, "upsert eventarc channel"));
        }
        let resultFunction = null;
        while (!resultFunction) {
            resultFunction = await this.functionExecutor
                .run(async () => {
                if (experiments.isEnabled("functionsv2deployoptimizations")) {
                    apiFunction.buildConfig.sourceToken = await scraper.getToken();
                }
                const op = await gcfV2.createFunction(apiFunction);
                return await poller.pollOperation(Object.assign(Object.assign({}, gcfV2PollerOptions), { pollerName: `create-${endpoint.codebase}-${endpoint.region}-${endpoint.id}`, operationResourceName: op.name, onPoll: scraper.poller }));
            })
                .catch(async (err) => {
                scraper.abort();
                if (err.code === CLOUD_RUN_RESOURCE_EXHAUSTED_CODE) {
                    await this.deleteV2Function(endpoint);
                    return null;
                }
                else {
                    logger_1.logger.error(err.message);
                    throw new reporter.DeploymentError(endpoint, "create", err);
                }
            });
        }
        endpoint.uri = resultFunction.url;
        const serviceName = (_d = resultFunction.serviceConfig) === null || _d === void 0 ? void 0 : _d.service;
        endpoint.runServiceId = utils.last(serviceName === null || serviceName === void 0 ? void 0 : serviceName.split("/"));
        if (!serviceName) {
            logger_1.logger.debug("Result function unexpectedly didn't have a service name.");
            utils.logLabeledWarning("functions", "Updated function is not associated with a service. This deployment is in an unexpected state - please re-deploy your functions.");
            return;
        }
        if (backend.isHttpsTriggered(endpoint)) {
            const invoker = endpoint.httpsTrigger.invoker || ["public"];
            if (!invoker.includes("private")) {
                await this.executor
                    .run(() => run.setInvokerCreate(endpoint.project, serviceName, invoker))
                    .catch(rethrowAs(endpoint, "set invoker"));
            }
        }
        else if (backend.isCallableTriggered(endpoint)) {
            await this.executor
                .run(() => run.setInvokerCreate(endpoint.project, serviceName, ["public"]))
                .catch(rethrowAs(endpoint, "set invoker"));
        }
        else if (backend.isTaskQueueTriggered(endpoint)) {
            const invoker = endpoint.taskQueueTrigger.invoker;
            if (invoker && !invoker.includes("private")) {
                await this.executor
                    .run(async () => {
                    await run.setInvokerCreate(endpoint.project, serviceName, invoker);
                })
                    .catch(rethrowAs(endpoint, "set invoker"));
            }
        }
        else if (backend.isBlockingTriggered(endpoint) &&
            v1_1.AUTH_BLOCKING_EVENTS.includes(endpoint.blockingTrigger.eventType)) {
            await this.executor
                .run(() => run.setInvokerCreate(endpoint.project, serviceName, ["public"]))
                .catch(rethrowAs(endpoint, "set invoker"));
        }
        else if (backend.isScheduleTriggered(endpoint)) {
            const invoker = endpoint.serviceAccount
                ? [endpoint.serviceAccount]
                : [gce.getDefaultServiceAccount(this.projectNumber)];
            await this.executor
                .run(() => run.setInvokerCreate(endpoint.project, serviceName, invoker))
                .catch(rethrowAs(endpoint, "set invoker"));
        }
    }
    async updateV1Function(endpoint, scraper) {
        var _a, _b;
        const sourceUrl = (_a = this.sources[endpoint.codebase]) === null || _a === void 0 ? void 0 : _a.sourceUrl;
        if (!sourceUrl) {
            logger_1.logger.debug("Precondition failed. Cannot update a GCF function without sourceUrl");
            throw new Error("Precondition failed");
        }
        const apiFunction = gcf.functionFromEndpoint(endpoint, sourceUrl);
        const resultFunction = await this.functionExecutor
            .run(async () => {
            apiFunction.sourceToken = await scraper.getToken();
            const op = await gcf.updateFunction(apiFunction);
            return await poller.pollOperation(Object.assign(Object.assign({}, gcfV1PollerOptions), { pollerName: `update-${endpoint.codebase}-${endpoint.region}-${endpoint.id}`, operationResourceName: op.name, onPoll: scraper.poller }));
        })
            .catch(rethrowAs(endpoint, "update"));
        endpoint.uri = (_b = resultFunction === null || resultFunction === void 0 ? void 0 : resultFunction.httpsTrigger) === null || _b === void 0 ? void 0 : _b.url;
        let invoker;
        if (backend.isHttpsTriggered(endpoint)) {
            invoker = endpoint.httpsTrigger.invoker === null ? ["public"] : endpoint.httpsTrigger.invoker;
        }
        else if (backend.isTaskQueueTriggered(endpoint)) {
            invoker = endpoint.taskQueueTrigger.invoker === null ? [] : endpoint.taskQueueTrigger.invoker;
        }
        else if (backend.isBlockingTriggered(endpoint) &&
            v1_1.AUTH_BLOCKING_EVENTS.includes(endpoint.blockingTrigger.eventType)) {
            invoker = ["public"];
        }
        if (invoker) {
            await this.executor
                .run(() => gcf.setInvokerUpdate(endpoint.project, backend.functionName(endpoint), invoker))
                .catch(rethrowAs(endpoint, "set invoker"));
        }
    }
    async updateV2Function(endpoint, scraper) {
        var _a, _b, _c, _d;
        const storageSource = (_a = this.sources[endpoint.codebase]) === null || _a === void 0 ? void 0 : _a.storage;
        if (!storageSource) {
            logger_1.logger.debug("Precondition failed. Cannot update a GCFv2 function without storage");
            throw new Error("Precondition failed");
        }
        const apiFunction = gcfV2.functionFromEndpoint(Object.assign(Object.assign({}, endpoint), { source: { storageSource } }));
        if ((_b = apiFunction.eventTrigger) === null || _b === void 0 ? void 0 : _b.pubsubTopic) {
            delete apiFunction.eventTrigger.pubsubTopic;
        }
        const resultFunction = await this.functionExecutor
            .run(async () => {
            if (experiments.isEnabled("functionsv2deployoptimizations")) {
                apiFunction.buildConfig.sourceToken = await scraper.getToken();
            }
            const op = await gcfV2.updateFunction(apiFunction);
            return await poller.pollOperation(Object.assign(Object.assign({}, gcfV2PollerOptions), { pollerName: `update-${endpoint.codebase}-${endpoint.region}-${endpoint.id}`, operationResourceName: op.name, onPoll: scraper.poller }));
        }, { retryCodes: [...executor_1.DEFAULT_RETRY_CODES, CLOUD_RUN_RESOURCE_EXHAUSTED_CODE] })
            .catch((err) => {
            scraper.abort();
            logger_1.logger.error(err.message);
            throw new reporter.DeploymentError(endpoint, "update", err);
        });
        endpoint.uri = (_c = resultFunction.serviceConfig) === null || _c === void 0 ? void 0 : _c.uri;
        const serviceName = (_d = resultFunction.serviceConfig) === null || _d === void 0 ? void 0 : _d.service;
        endpoint.runServiceId = utils.last(serviceName === null || serviceName === void 0 ? void 0 : serviceName.split("/"));
        if (!serviceName) {
            logger_1.logger.debug("Result function unexpectedly didn't have a service name.");
            utils.logLabeledWarning("functions", "Updated function is not associated with a service. This deployment is in an unexpected state - please re-deploy your functions.");
            return;
        }
        let invoker;
        if (backend.isHttpsTriggered(endpoint)) {
            invoker = endpoint.httpsTrigger.invoker === null ? ["public"] : endpoint.httpsTrigger.invoker;
        }
        else if (backend.isTaskQueueTriggered(endpoint)) {
            invoker = endpoint.taskQueueTrigger.invoker === null ? [] : endpoint.taskQueueTrigger.invoker;
        }
        else if (backend.isBlockingTriggered(endpoint) &&
            v1_1.AUTH_BLOCKING_EVENTS.includes(endpoint.blockingTrigger.eventType)) {
            invoker = ["public"];
        }
        else if (backend.isScheduleTriggered(endpoint)) {
            invoker = endpoint.serviceAccount
                ? [endpoint.serviceAccount]
                : [gce.getDefaultServiceAccount(this.projectNumber)];
        }
        if (invoker) {
            await this.executor
                .run(() => run.setInvokerUpdate(endpoint.project, serviceName, invoker))
                .catch(rethrowAs(endpoint, "set invoker"));
        }
    }
    async deleteV1Function(endpoint) {
        const fnName = backend.functionName(endpoint);
        await this.functionExecutor
            .run(async () => {
            const op = await gcf.deleteFunction(fnName);
            const pollerOptions = Object.assign(Object.assign({}, gcfV1PollerOptions), { pollerName: `delete-${endpoint.codebase}-${endpoint.region}-${endpoint.id}`, operationResourceName: op.name });
            await poller.pollOperation(pollerOptions);
        })
            .catch(rethrowAs(endpoint, "delete"));
    }
    async deleteV2Function(endpoint) {
        const fnName = backend.functionName(endpoint);
        await this.functionExecutor
            .run(async () => {
            const op = await gcfV2.deleteFunction(fnName);
            const pollerOptions = Object.assign(Object.assign({}, gcfV2PollerOptions), { pollerName: `delete-${endpoint.codebase}-${endpoint.region}-${endpoint.id}`, operationResourceName: op.name });
            await poller.pollOperation(pollerOptions);
        }, { retryCodes: [...executor_1.DEFAULT_RETRY_CODES, CLOUD_RUN_RESOURCE_EXHAUSTED_CODE] })
            .catch(rethrowAs(endpoint, "delete"));
    }
    async setRunTraits(serviceName, endpoint) {
        await this.functionExecutor
            .run(async () => {
            const service = await run.getService(serviceName);
            let changed = false;
            if (service.spec.template.spec.containerConcurrency !== endpoint.concurrency) {
                service.spec.template.spec.containerConcurrency = endpoint.concurrency;
                changed = true;
            }
            if (+service.spec.template.spec.containers[0].resources.limits.cpu !== endpoint.cpu) {
                service.spec.template.spec.containers[0].resources.limits.cpu = `${endpoint.cpu}`;
                changed = true;
            }
            if (!changed) {
                logger_1.logger.debug("Skipping setRunTraits on", serviceName, " because it already matches");
                return;
            }
            delete service.spec.template.metadata.name;
            await run.updateService(serviceName, service);
        })
            .catch(rethrowAs(endpoint, "set concurrency"));
    }
    async setTrigger(endpoint) {
        if (backend.isScheduleTriggered(endpoint)) {
            if (endpoint.platform === "gcfv1") {
                await this.upsertScheduleV1(endpoint);
                return;
            }
            else if (endpoint.platform === "gcfv2") {
                await this.upsertScheduleV2(endpoint);
                return;
            }
            (0, functional_1.assertExhaustive)(endpoint.platform);
        }
        else if (backend.isTaskQueueTriggered(endpoint)) {
            await this.upsertTaskQueue(endpoint);
        }
        else if (backend.isBlockingTriggered(endpoint)) {
            await this.registerBlockingTrigger(endpoint);
        }
    }
    async deleteTrigger(endpoint) {
        if (backend.isScheduleTriggered(endpoint)) {
            if (endpoint.platform === "gcfv1") {
                await this.deleteScheduleV1(endpoint);
                return;
            }
            else if (endpoint.platform === "gcfv2") {
                await this.deleteScheduleV2(endpoint);
                return;
            }
            (0, functional_1.assertExhaustive)(endpoint.platform);
        }
        else if (backend.isTaskQueueTriggered(endpoint)) {
            await this.disableTaskQueue(endpoint);
        }
        else if (backend.isBlockingTriggered(endpoint)) {
            await this.unregisterBlockingTrigger(endpoint);
        }
    }
    async upsertScheduleV1(endpoint) {
        const job = scheduler.jobFromEndpoint(endpoint, this.appEngineLocation, this.projectNumber);
        await this.executor
            .run(() => scheduler.createOrReplaceJob(job))
            .catch(rethrowAs(endpoint, "upsert schedule"));
    }
    async upsertScheduleV2(endpoint) {
        const job = scheduler.jobFromEndpoint(endpoint, endpoint.region, this.projectNumber);
        await this.executor
            .run(() => scheduler.createOrReplaceJob(job))
            .catch(rethrowAs(endpoint, "upsert schedule"));
    }
    async upsertTaskQueue(endpoint) {
        const queue = cloudtasks.queueFromEndpoint(endpoint);
        await this.executor
            .run(() => cloudtasks.upsertQueue(queue))
            .catch(rethrowAs(endpoint, "upsert task queue"));
        if (endpoint.taskQueueTrigger.invoker) {
            await this.executor
                .run(() => cloudtasks.setEnqueuer(queue.name, endpoint.taskQueueTrigger.invoker))
                .catch(rethrowAs(endpoint, "set invoker"));
        }
    }
    async registerBlockingTrigger(endpoint) {
        await this.executor
            .run(() => services.serviceForEndpoint(endpoint).registerTrigger(endpoint))
            .catch(rethrowAs(endpoint, "register blocking trigger"));
    }
    async deleteScheduleV1(endpoint) {
        const jobName = scheduler.jobNameForEndpoint(endpoint, this.appEngineLocation);
        await this.executor
            .run(() => scheduler.deleteJob(jobName))
            .catch(rethrowAs(endpoint, "delete schedule"));
        const topicName = scheduler.topicNameForEndpoint(endpoint);
        await this.executor
            .run(() => pubsub.deleteTopic(topicName))
            .catch(rethrowAs(endpoint, "delete topic"));
    }
    async deleteScheduleV2(endpoint) {
        const jobName = scheduler.jobNameForEndpoint(endpoint, endpoint.region);
        await this.executor
            .run(() => scheduler.deleteJob(jobName))
            .catch(rethrowAs(endpoint, "delete schedule"));
    }
    async disableTaskQueue(endpoint) {
        const update = {
            name: cloudtasks.queueNameForEndpoint(endpoint),
            state: "DISABLED",
        };
        await this.executor
            .run(() => cloudtasks.updateQueue(update))
            .catch(rethrowAs(endpoint, "disable task queue"));
    }
    async unregisterBlockingTrigger(endpoint) {
        await this.executor
            .run(() => services.serviceForEndpoint(endpoint).unregisterTrigger(endpoint))
            .catch(rethrowAs(endpoint, "unregister blocking trigger"));
    }
    logOpStart(op, endpoint) {
        const runtime = supported_1.RUNTIMES[endpoint.runtime].friendly;
        const platform = (0, functionsDeployHelper_1.getHumanFriendlyPlatformName)(endpoint.platform);
        const label = helper.getFunctionLabel(endpoint);
        utils.logLabeledBullet("functions", `${op} ${runtime} (${platform}) function ${clc.bold(label)}...`);
    }
    logOpSuccess(op, endpoint) {
        utils.logSuccess(this.getLogSuccessMessage(op, endpoint));
    }
    getLogSuccessMessage(op, endpoint) {
        const label = helper.getFunctionLabel(endpoint);
        switch (op) {
            case "skip":
                return `${clc.bold(clc.magenta(`functions[${label}]`))} Skipped (No changes detected)`;
            default:
                return `${clc.bold(clc.green(`functions[${label}]`))} Successful ${op} operation.`;
        }
    }
    getSkippedDeployingNopOpMessage(endpoints) {
        const functionNames = endpoints.map((endpoint) => endpoint.id).join(",");
        return `${clc.bold(clc.magenta(`functions:`))} You can re-deploy skipped functions with:
              ${clc.bold(`firebase deploy --only functions:${functionNames}`)} or ${clc.bold(`FUNCTIONS_DEPLOY_UNCHANGED=true firebase deploy`)}`;
    }
}
exports.Fabricator = Fabricator;
