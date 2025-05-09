"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.executeGraphQL = exports.dataconnectDataplaneClient = exports.DATACONNECT_API_VERSION = exports.dataconnectOrigin = void 0;
const api_1 = require("../api");
var api_2 = require("../api");
Object.defineProperty(exports, "dataconnectOrigin", { enumerable: true, get: function () { return api_2.dataconnectOrigin; } });
const apiv2_1 = require("../apiv2");
exports.DATACONNECT_API_VERSION = "v1";
function dataconnectDataplaneClient() {
    return new apiv2_1.Client({
        urlPrefix: (0, api_1.dataconnectOrigin)(),
        apiVersion: exports.DATACONNECT_API_VERSION,
        auth: true,
    });
}
exports.dataconnectDataplaneClient = dataconnectDataplaneClient;
async function executeGraphQL(client, servicePath, body) {
    const res = await client.post(`${servicePath}:executeGraphql`, body, { resolveOnHTTPError: true });
    return res;
}
exports.executeGraphQL = executeGraphQL;
