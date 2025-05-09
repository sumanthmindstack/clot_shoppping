"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ensureSparkApis = exports.ensureApis = void 0;
const api = require("../api");
const ensureApiEnabled_1 = require("../ensureApiEnabled");
async function ensureApis(projectId) {
    const prefix = "dataconnect";
    await (0, ensureApiEnabled_1.ensure)(projectId, api.dataconnectOrigin(), prefix);
    await (0, ensureApiEnabled_1.ensure)(projectId, api.cloudSQLAdminOrigin(), prefix);
    await (0, ensureApiEnabled_1.ensure)(projectId, api.computeOrigin(), prefix);
}
exports.ensureApis = ensureApis;
async function ensureSparkApis(projectId) {
    const prefix = "dataconnect";
    await (0, ensureApiEnabled_1.ensure)(projectId, api.cloudSQLAdminOrigin(), prefix);
}
exports.ensureSparkApis = ensureSparkApis;
