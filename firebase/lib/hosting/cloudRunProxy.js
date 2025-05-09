"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const apiv2_1 = require("../apiv2");
const api_1 = require("../api");
const proxy_1 = require("./proxy");
const error_1 = require("../error");
const logger_1 = require("../logger");
const projectUtils_1 = require("../projectUtils");
const cloudRunCache = {};
const apiClient = new apiv2_1.Client({ urlPrefix: (0, api_1.cloudRunApiOrigin)(), apiVersion: "v1" });
async function getCloudRunUrl(rewrite, projectId) {
    var _a;
    const alreadyFetched = cloudRunCache[`${rewrite.run.region}/${rewrite.run.serviceId}`];
    if (alreadyFetched) {
        return Promise.resolve(alreadyFetched);
    }
    const path = `/projects/${projectId}/locations/${rewrite.run.region || "us-central1"}/services/${rewrite.run.serviceId}`;
    try {
        logger_1.logger.info(`[hosting] Looking up Cloud Run service "${path}" for its URL`);
        const res = await apiClient.get(path);
        const url = (_a = res.body.status) === null || _a === void 0 ? void 0 : _a.url;
        if (!url) {
            throw new error_1.FirebaseError("Cloud Run URL doesn't exist in response.");
        }
        cloudRunCache[`${rewrite.run.region}/${rewrite.run.serviceId}`] = url;
        return url;
    }
    catch (err) {
        throw new error_1.FirebaseError(`Error looking up URL for Cloud Run service: ${err}`, {
            original: err,
        });
    }
}
function default_1(options) {
    return async (rewrite) => {
        if (!rewrite.run) {
            return (0, proxy_1.errorRequestHandler)('Cloud Run rewrites must have a valid "run" field.');
        }
        if (!rewrite.run.serviceId) {
            return (0, proxy_1.errorRequestHandler)("Cloud Run rewrites must supply a service ID.");
        }
        if (!rewrite.run.region) {
            rewrite.run.region = "us-central1";
        }
        logger_1.logger.info(`[hosting] Cloud Run rewrite ${JSON.stringify(rewrite)} triggered`);
        const textIdentifier = `Cloud Run service "${rewrite.run.serviceId}" for region "${rewrite.run.region}"`;
        return getCloudRunUrl(rewrite, (0, projectUtils_1.needProjectId)(options))
            .then((url) => (0, proxy_1.proxyRequestHandler)(url, textIdentifier))
            .catch(proxy_1.errorRequestHandler);
    };
}
exports.default = default_1;
