"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client = require("../../dataconnect/client");
const utils = require("../../utils");
const types_1 = require("../../dataconnect/types");
const projectUtils_1 = require("../../projectUtils");
const provisionCloudSql_1 = require("../../dataconnect/provisionCloudSql");
const names_1 = require("../../dataconnect/names");
const api_1 = require("../../api");
const ensureApiEnabled = require("../../ensureApiEnabled");
const node_path_1 = require("node:path");
const prompt_1 = require("../../prompt");
async function default_1(context, options) {
    const projectId = (0, projectUtils_1.needProjectId)(options);
    const serviceInfos = context.dataconnect.serviceInfos;
    const services = await client.listAllServices(projectId);
    const filters = context.dataconnect.filters;
    if (serviceInfos.some((si) => {
        return (0, types_1.requiresVector)(si.deploymentMetadata);
    })) {
        await ensureApiEnabled.ensure(projectId, (0, api_1.vertexAIOrigin)(), "dataconnect");
    }
    const servicesToCreate = serviceInfos
        .filter((si) => !services.some((s) => matches(si, s)))
        .filter((si) => {
        return !filters || (filters === null || filters === void 0 ? void 0 : filters.some((f) => si.dataConnectYaml.serviceId === f.serviceId));
    });
    const servicesToDelete = filters
        ? []
        : services.filter((s) => !serviceInfos.some((si) => matches(si, s)));
    await Promise.all(servicesToCreate.map(async (s) => {
        const { projectId, locationId, serviceId } = splitName(s.serviceName);
        await client.createService(projectId, locationId, serviceId);
        utils.logLabeledSuccess("dataconnect", `Created service ${s.serviceName}`);
    }));
    if (servicesToDelete.length) {
        if (await (0, prompt_1.confirm)({
            force: options.force,
            nonInteractive: options.nonInteractive,
            message: `The following services exist on ${projectId} but are not listed in your 'firebase.json'\n${servicesToDelete
                .map((s) => s.name)
                .join("\n")}\nWould you like to delete these services?`,
        })) {
            await Promise.all(servicesToDelete.map(async (s) => {
                await client.deleteService(s.name);
                utils.logLabeledSuccess("dataconnect", `Deleted service ${s.name}`);
            }));
        }
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
            });
        }
    }));
    return;
}
exports.default = default_1;
function matches(si, s) {
    return si.serviceName === s.name;
}
function splitName(serviceName) {
    const parts = serviceName.split("/");
    return {
        projectId: parts[1],
        locationId: parts[3],
        serviceId: parts[5],
    };
}
