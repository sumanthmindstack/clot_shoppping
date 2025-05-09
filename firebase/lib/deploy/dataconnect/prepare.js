"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const clc = require("colorette");
const load_1 = require("../../dataconnect/load");
const fileUtils_1 = require("../../dataconnect/fileUtils");
const logger_1 = require("../../logger");
const utils = require("../../utils");
const projectUtils_1 = require("../../projectUtils");
const filters_1 = require("../../dataconnect/filters");
const build_1 = require("../../dataconnect/build");
const ensureApis_1 = require("../../dataconnect/ensureApis");
const requireTosAcceptance_1 = require("../../requireTosAcceptance");
const firedata_1 = require("../../gcp/firedata");
const provisionCloudSql_1 = require("../../dataconnect/provisionCloudSql");
const cloudbilling_1 = require("../../gcp/cloudbilling");
const names_1 = require("../../dataconnect/names");
const error_1 = require("../../error");
const types_1 = require("../../dataconnect/types");
const schemaMigration_1 = require("../../dataconnect/schemaMigration");
const node_path_1 = require("node:path");
const freeTrial_1 = require("../../dataconnect/freeTrial");
async function default_1(context, options) {
    var _a;
    const projectId = (0, projectUtils_1.needProjectId)(options);
    if (!(await (0, cloudbilling_1.checkBillingEnabled)(projectId))) {
        throw new error_1.FirebaseError((0, freeTrial_1.upgradeInstructions)(projectId));
    }
    await (0, ensureApis_1.ensureApis)(projectId);
    await (0, requireTosAcceptance_1.requireTosAcceptance)(firedata_1.DATA_CONNECT_TOS_ID)(options);
    const serviceCfgs = (0, fileUtils_1.readFirebaseJson)(options.config);
    utils.logLabeledBullet("dataconnect", `Preparing to deploy`);
    const filters = (0, filters_1.getResourceFilters)(options);
    const serviceInfos = await Promise.all(serviceCfgs.map((c) => (0, load_1.load)(projectId, options.config, c.source)));
    for (const si of serviceInfos) {
        si.deploymentMetadata = await (0, build_1.build)(options, si.sourceDirectory, options.dryRun);
    }
    const unmatchedFilters = filters === null || filters === void 0 ? void 0 : filters.filter((f) => {
        const serviceMatched = serviceInfos.some((s) => s.dataConnectYaml.serviceId === f.serviceId);
        const connectorMatched = f.connectorId
            ? serviceInfos.some((s) => {
                return (s.dataConnectYaml.serviceId === f.serviceId &&
                    s.connectorInfo.some((c) => c.connectorYaml.connectorId === f.connectorId));
            })
            : true;
        return !serviceMatched || !connectorMatched;
    });
    if (unmatchedFilters === null || unmatchedFilters === void 0 ? void 0 : unmatchedFilters.length) {
        throw new error_1.FirebaseError(`The following filters were specified in --only but didn't match anything in this project: ${unmatchedFilters.map(filters_1.toString).map(clc.bold).join(", ")}`);
    }
    context.dataconnect = {
        serviceInfos,
        filters,
    };
    utils.logLabeledBullet("dataconnect", `Successfully prepared schema and connectors`);
    if (options.dryRun) {
        for (const si of serviceInfos) {
            await (0, schemaMigration_1.diffSchema)(options, si.schema, (_a = si.dataConnectYaml.schema.datasource.postgresql) === null || _a === void 0 ? void 0 : _a.schemaValidation);
        }
        utils.logLabeledBullet("dataconnect", "Checking for CloudSQL resources...");
        await Promise.all(serviceInfos
            .filter((si) => {
            return !filters || (filters === null || filters === void 0 ? void 0 : filters.some((f) => si.dataConnectYaml.serviceId === f.serviceId));
        })
            .map(async (s) => {
            var _a, _b;
            const postgresDatasource = s.schema.datasources.find((d) => d.postgresql);
            if (postgresDatasource) {
                const instanceId = (_a = postgresDatasource.postgresql) === null || _a === void 0 ? void 0 : _a.cloudSql.instance.split("/").pop();
                const databaseId = (_b = postgresDatasource.postgresql) === null || _b === void 0 ? void 0 : _b.database;
                if (!instanceId || !databaseId) {
                    return Promise.resolve();
                }
                const enableGoogleMlIntegration = (0, types_1.requiresVector)(s.deploymentMetadata);
                return (0, provisionCloudSql_1.provisionCloudSql)({
                    projectId,
                    locationId: (0, names_1.parseServiceName)(s.serviceName).location,
                    instanceId,
                    databaseId,
                    configYamlPath: (0, node_path_1.join)(s.sourceDirectory, "dataconnect.yaml"),
                    enableGoogleMlIntegration,
                    waitForCreation: true,
                    dryRun: options.dryRun,
                });
            }
        }));
    }
    logger_1.logger.debug(JSON.stringify(context.dataconnect, null, 2));
    return;
}
exports.default = default_1;
