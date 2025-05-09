"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.command = void 0;
const command_1 = require("../command");
const projectUtils_1 = require("../projectUtils");
const names = require("../dataconnect/names");
const client = require("../dataconnect/client");
const logger_1 = require("../logger");
const requirePermissions_1 = require("../requirePermissions");
const ensureApis_1 = require("../dataconnect/ensureApis");
const Table = require("cli-table3");
exports.command = new command_1.Command("dataconnect:services:list")
    .description("list all deployed Data Connect services")
    .before(requirePermissions_1.requirePermissions, [
    "dataconnect.services.list",
    "dataconnect.schemas.list",
    "dataconnect.connectors.list",
])
    .action(async (options) => {
    var _a, _b, _c, _d, _e, _f, _g;
    const projectId = (0, projectUtils_1.needProjectId)(options);
    await (0, ensureApis_1.ensureApis)(projectId);
    const services = await client.listAllServices(projectId);
    const table = new Table({
        head: [
            "Service ID",
            "Location",
            "Data Source",
            "Schema Last Updated",
            "Connector ID",
            "Connector Last Updated",
        ],
        style: { head: ["yellow"] },
    });
    const jsonOutput = { services: [] };
    for (const service of services) {
        const schema = (_a = (await client.getSchema(service.name))) !== null && _a !== void 0 ? _a : {
            name: "",
            datasources: [{}],
            source: { files: [] },
        };
        const connectors = await client.listConnectors(service.name);
        const serviceName = names.parseServiceName(service.name);
        const postgresDatasource = schema === null || schema === void 0 ? void 0 : schema.datasources.find((d) => d.postgresql);
        const instanceName = (_c = (_b = postgresDatasource === null || postgresDatasource === void 0 ? void 0 : postgresDatasource.postgresql) === null || _b === void 0 ? void 0 : _b.cloudSql.instance) !== null && _c !== void 0 ? _c : "";
        const instanceId = instanceName.split("/").pop();
        const dbId = (_e = (_d = postgresDatasource === null || postgresDatasource === void 0 ? void 0 : postgresDatasource.postgresql) === null || _d === void 0 ? void 0 : _d.database) !== null && _e !== void 0 ? _e : "";
        const dbName = `CloudSQL Instance: ${instanceId}\nDatabase: ${dbId}`;
        table.push([
            serviceName.serviceId,
            serviceName.location,
            dbName,
            (_f = schema === null || schema === void 0 ? void 0 : schema.updateTime) !== null && _f !== void 0 ? _f : "",
            "",
            "",
        ]);
        const serviceJson = {
            serviceId: serviceName.serviceId,
            location: serviceName.location,
            datasource: dbName,
            schemaUpdateTime: schema === null || schema === void 0 ? void 0 : schema.updateTime,
            connectors: [],
        };
        for (const conn of connectors) {
            const connectorName = names.parseConnectorName(conn.name);
            table.push(["", "", "", "", connectorName.connectorId, conn.updateTime]);
            serviceJson.connectors.push({
                connectorId: connectorName.connectorId,
                connectorLastUpdated: (_g = conn.updateTime) !== null && _g !== void 0 ? _g : "",
            });
        }
        jsonOutput.services.push(serviceJson);
    }
    logger_1.logger.info(table.toString());
    return jsonOutput;
});
