"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.command = void 0;
const command_1 = require("../command");
const projectUtils_1 = require("../projectUtils");
const ensureApis_1 = require("../dataconnect/ensureApis");
const requirePermissions_1 = require("../requirePermissions");
const fileUtils_1 = require("../dataconnect/fileUtils");
const schemaMigration_1 = require("../dataconnect/schemaMigration");
const requireAuth_1 = require("../requireAuth");
exports.command = new command_1.Command("dataconnect:sql:diff [serviceId]")
    .description("display the differences between a local Data Connect schema and your CloudSQL database's current schema")
    .before(requirePermissions_1.requirePermissions, [
    "firebasedataconnect.services.list",
    "firebasedataconnect.schemas.list",
    "firebasedataconnect.schemas.update",
])
    .before(requireAuth_1.requireAuth)
    .action(async (serviceId, options) => {
    var _a;
    const projectId = (0, projectUtils_1.needProjectId)(options);
    await (0, ensureApis_1.ensureApis)(projectId);
    const serviceInfo = await (0, fileUtils_1.pickService)(projectId, options.config, serviceId);
    const diffs = await (0, schemaMigration_1.diffSchema)(options, serviceInfo.schema, (_a = serviceInfo.dataConnectYaml.schema.datasource.postgresql) === null || _a === void 0 ? void 0 : _a.schemaValidation);
    return { projectId, serviceId, diffs };
});
