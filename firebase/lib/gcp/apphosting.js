"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getNextRolloutId = exports.ensureApiEnabled = exports.listLocations = exports.updateTraffic = exports.listRollouts = exports.createRollout = exports.createBuild = exports.listBuilds = exports.getBuild = exports.deleteBackend = exports.listBackends = exports.getBackend = exports.createBackend = exports.parseBackendName = exports.serviceAgentEmail = exports.client = exports.API_VERSION = void 0;
const proto = require("../gcp/proto");
const apiv2_1 = require("../apiv2");
const projectUtils_1 = require("../projectUtils");
const api_1 = require("../api");
const ensureApiEnabled_1 = require("../ensureApiEnabled");
const deploymentTool = require("../deploymentTool");
const error_1 = require("../error");
const metaprogramming_1 = require("../metaprogramming");
exports.API_VERSION = "v1beta";
exports.client = new apiv2_1.Client({
    urlPrefix: (0, api_1.apphostingOrigin)(),
    auth: true,
    apiVersion: exports.API_VERSION,
});
(0, metaprogramming_1.assertImplements)();
(0, metaprogramming_1.assertImplements)();
(0, metaprogramming_1.assertImplements)();
(0, metaprogramming_1.assertImplements)();
const P4SA_DOMAIN = (0, api_1.apphostingP4SADomain)();
function serviceAgentEmail(projectNumber) {
    return `service-${projectNumber}@${P4SA_DOMAIN}`;
}
exports.serviceAgentEmail = serviceAgentEmail;
function parseBackendName(backendName) {
    const [, projectName, , location, , id] = backendName.split("/");
    return { projectName, location, id };
}
exports.parseBackendName = parseBackendName;
async function createBackend(projectId, location, backendReqBoby, backendId) {
    const res = await exports.client.post(`projects/${projectId}/locations/${location}/backends`, Object.assign(Object.assign({}, backendReqBoby), { labels: Object.assign(Object.assign({}, backendReqBoby.labels), deploymentTool.labels()) }), { queryParams: { backendId } });
    return res.body;
}
exports.createBackend = createBackend;
async function getBackend(projectId, location, backendId) {
    const name = `projects/${projectId}/locations/${location}/backends/${backendId}`;
    const res = await exports.client.get(name);
    return res.body;
}
exports.getBackend = getBackend;
async function listBackends(projectId, location) {
    var _a;
    const name = `projects/${projectId}/locations/${location}/backends`;
    let pageToken;
    const res = {
        backends: [],
        unreachable: [],
    };
    do {
        const queryParams = pageToken ? { pageToken } : {};
        const int = await exports.client.get(name, { queryParams });
        res.backends.push(...(int.body.backends || []));
        (_a = res.unreachable) === null || _a === void 0 ? void 0 : _a.push(...(int.body.unreachable || []));
        pageToken = int.body.nextPageToken;
    } while (pageToken);
    res.unreachable = [...new Set(res.unreachable)];
    return res;
}
exports.listBackends = listBackends;
async function deleteBackend(projectId, location, backendId) {
    const name = `projects/${projectId}/locations/${location}/backends/${backendId}`;
    const res = await exports.client.delete(name, { queryParams: { force: "true" } });
    return res.body;
}
exports.deleteBackend = deleteBackend;
async function getBuild(projectId, location, backendId, buildId) {
    const name = `projects/${projectId}/locations/${location}/backends/${backendId}/builds/${buildId}`;
    const res = await exports.client.get(name);
    return res.body;
}
exports.getBuild = getBuild;
async function listBuilds(projectId, location, backendId) {
    var _a;
    const name = `projects/${projectId}/locations/${location}/backends/${backendId}/builds`;
    let pageToken;
    const res = {
        builds: [],
        unreachable: [],
    };
    do {
        const queryParams = pageToken ? { pageToken } : {};
        const int = await exports.client.get(name, { queryParams });
        res.builds.push(...(int.body.builds || []));
        (_a = res.unreachable) === null || _a === void 0 ? void 0 : _a.push(...(int.body.unreachable || []));
        pageToken = int.body.nextPageToken;
    } while (pageToken);
    res.unreachable = [...new Set(res.unreachable)];
    return res;
}
exports.listBuilds = listBuilds;
async function createBuild(projectId, location, backendId, buildId, buildInput) {
    const res = await exports.client.post(`projects/${projectId}/locations/${location}/backends/${backendId}/builds`, Object.assign(Object.assign({}, buildInput), { labels: Object.assign(Object.assign({}, buildInput.labels), deploymentTool.labels()) }), { queryParams: { buildId } });
    return res.body;
}
exports.createBuild = createBuild;
async function createRollout(projectId, location, backendId, rolloutId, rollout, validateOnly = false) {
    const res = await exports.client.post(`projects/${projectId}/locations/${location}/backends/${backendId}/rollouts`, Object.assign(Object.assign({}, rollout), { labels: Object.assign(Object.assign({}, rollout.labels), deploymentTool.labels()) }), { queryParams: { rolloutId, validateOnly: validateOnly ? "true" : "false" } });
    return res.body;
}
exports.createRollout = createRollout;
async function listRollouts(projectId, location, backendId) {
    const name = `projects/${projectId}/locations/${location}/backends/${backendId}/rollouts`;
    let pageToken = undefined;
    const res = {
        rollouts: [],
        unreachable: [],
    };
    do {
        const queryParams = pageToken ? { pageToken } : {};
        const int = await exports.client.get(name, { queryParams });
        res.rollouts.splice(res.rollouts.length, 0, ...(int.body.rollouts || []));
        res.unreachable.splice(res.unreachable.length, 0, ...(int.body.unreachable || []));
        pageToken = int.body.nextPageToken;
    } while (pageToken);
    res.unreachable = [...new Set(res.unreachable)];
    return res;
}
exports.listRollouts = listRollouts;
async function updateTraffic(projectId, location, backendId, traffic) {
    const fieldMasks = proto.fieldMasks(traffic, "rolloutPolicy");
    const queryParams = {
        updateMask: fieldMasks.join(","),
    };
    const name = `projects/${projectId}/locations/${location}/backends/${backendId}/traffic`;
    const res = await exports.client.patch(name, Object.assign(Object.assign({}, traffic), { name }), {
        queryParams,
    });
    return res.body;
}
exports.updateTraffic = updateTraffic;
async function listLocations(projectId) {
    let pageToken = undefined;
    let locations = [];
    do {
        const queryParams = pageToken ? { pageToken } : {};
        const response = await exports.client.get(`projects/${projectId}/locations`, {
            queryParams,
        });
        if (response.body.locations && response.body.locations.length > 0) {
            locations = locations.concat(response.body.locations);
        }
        pageToken = response.body.nextPageToken;
    } while (pageToken);
    return locations;
}
exports.listLocations = listLocations;
async function ensureApiEnabled(options) {
    const projectId = (0, projectUtils_1.needProjectId)(options);
    return await (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.apphostingOrigin)(), "app hosting", true);
}
exports.ensureApiEnabled = ensureApiEnabled;
async function getNextRolloutId(projectId, location, backendId, counter) {
    var _a, _b;
    const date = new Date();
    const year = date.getUTCFullYear();
    const month = String(date.getUTCMonth() + 1).padStart(2, "0");
    const day = String(date.getUTCDate()).padStart(2, "0");
    if (counter) {
        return `build-${year}-${month}-${day}-${String(counter).padStart(3, "0")}`;
    }
    const rolloutsPromise = exports.listRollouts(projectId, location, backendId);
    const buildsPromise = exports.listBuilds(projectId, location, backendId);
    const [rollouts, builds] = await Promise.all([rolloutsPromise, buildsPromise]);
    if (((_a = builds.unreachable) === null || _a === void 0 ? void 0 : _a.includes(location)) || ((_b = rollouts.unreachable) === null || _b === void 0 ? void 0 : _b.includes(location))) {
        throw new error_1.FirebaseError(`Firebase App Hosting is currently unreachable in location ${location}`);
    }
    const test = new RegExp(`projects/${projectId}/locations/${location}/backends/${backendId}/(rollouts|builds)/build-${year}-${month}-${day}-(\\d+)`);
    const highestId = (input) => {
        let highest = 0;
        for (const i of input) {
            const match = i.name.match(test);
            if (!match) {
                continue;
            }
            const n = Number(match[2]);
            if (n > highest) {
                highest = n;
            }
        }
        return highest;
    };
    const highest = Math.max(highestId(builds.builds), highestId(rollouts.rollouts));
    return `build-${year}-${month}-${day}-${String(highest + 1).padStart(3, "0")}`;
}
exports.getNextRolloutId = getNextRolloutId;
