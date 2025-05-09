"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getBackend = exports.getBackendForAmbiguousLocation = exports.chooseBackends = exports.getBackendForLocation = exports.promptLocation = exports.deleteBackendAndPoll = exports.setDefaultTrafficPolicy = exports.createBackend = exports.ensureAppHostingComputeServiceAccount = exports.createGitRepoLink = exports.doSetup = void 0;
const clc = require("colorette");
const poller = require("../operation-poller");
const apphosting = require("../gcp/apphosting");
const githubConnections = require("./githubConnections");
const utils_1 = require("../utils");
const api_1 = require("../api");
const apphosting_1 = require("../gcp/apphosting");
const resourceManager_1 = require("../gcp/resourceManager");
const iam = require("../gcp/iam");
const error_1 = require("../error");
const prompt_1 = require("../prompt");
const constants_1 = require("./constants");
const ensureApiEnabled_1 = require("../ensureApiEnabled");
const deploymentTool = require("../deploymentTool");
const app_1 = require("./app");
const ora = require("ora");
const node_fetch_1 = require("node-fetch");
const rollout_1 = require("./rollout");
const DEFAULT_COMPUTE_SERVICE_ACCOUNT_NAME = "firebase-app-hosting-compute";
const apphostingPollerOptions = {
    apiOrigin: (0, api_1.apphostingOrigin)(),
    apiVersion: apphosting_1.API_VERSION,
    masterTimeout: 25 * 60 * 1000,
    maxBackoff: 10000,
};
async function tlsReady(url) {
    var _a;
    try {
        await (0, node_fetch_1.default)(url);
        return true;
    }
    catch (err) {
        const maybeNodeError = err;
        if (/HANDSHAKE_FAILURE/.test((_a = maybeNodeError === null || maybeNodeError === void 0 ? void 0 : maybeNodeError.cause) === null || _a === void 0 ? void 0 : _a.code) ||
            "EPROTO" === (maybeNodeError === null || maybeNodeError === void 0 ? void 0 : maybeNodeError.code)) {
            return false;
        }
        return true;
    }
}
async function awaitTlsReady(url) {
    let ready;
    do {
        ready = await tlsReady(url);
        if (!ready) {
            await (0, utils_1.sleep)(1000);
        }
    } while (!ready);
}
async function doSetup(projectId, webAppName, serviceAccount) {
    await Promise.all([
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.developerConnectOrigin)(), "apphosting", true),
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.cloudbuildOrigin)(), "apphosting", true),
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.secretManagerOrigin)(), "apphosting", true),
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.cloudRunApiOrigin)(), "apphosting", true),
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.artifactRegistryDomain)(), "apphosting", true),
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.iamOrigin)(), "apphosting", true),
    ]);
    await ensureAppHostingComputeServiceAccount(projectId, serviceAccount);
    const location = await promptLocation(projectId, "Select a primary region to host your backend:\n");
    const gitRepositoryLink = await githubConnections.linkGitHubRepository(projectId, location);
    const rootDir = await (0, prompt_1.promptOnce)({
        name: "rootDir",
        type: "input",
        default: "/",
        message: "Specify your app's root directory relative to your repository",
    });
    const branch = await githubConnections.promptGitHubBranch(gitRepositoryLink);
    (0, utils_1.logSuccess)(`Repo linked successfully!\n`);
    (0, utils_1.logBullet)(`${clc.yellow("===")} Set up your backend`);
    const backendId = await promptNewBackendId(projectId, location, {
        name: "backendId",
        type: "input",
        default: "my-web-app",
        message: "Provide a name for your backend [1-30 characters]",
    });
    (0, utils_1.logSuccess)(`Name set to ${backendId}\n`);
    const webApp = await app_1.webApps.getOrCreateWebApp(projectId, webAppName, backendId);
    if (!webApp) {
        (0, utils_1.logWarning)(`Firebase web app not set`);
    }
    const createBackendSpinner = ora("Creating your new backend...").start();
    const backend = await createBackend(projectId, location, backendId, gitRepositoryLink, serviceAccount, webApp === null || webApp === void 0 ? void 0 : webApp.id, rootDir);
    createBackendSpinner.succeed(`Successfully created backend!\n\t${backend.name}\n`);
    await setDefaultTrafficPolicy(projectId, location, backendId, branch);
    const confirmRollout = await (0, prompt_1.promptOnce)({
        type: "confirm",
        name: "rollout",
        default: true,
        message: "Do you want to deploy now?",
    });
    if (!confirmRollout) {
        (0, utils_1.logSuccess)(`Your backend will be deployed at:\n\thttps://${backend.uri}`);
        return;
    }
    const url = `https://${backend.uri}`;
    (0, utils_1.logBullet)(`You may also track this rollout at:\n\t${(0, api_1.consoleOrigin)()}/project/${projectId}/apphosting`);
    const createRolloutSpinner = ora("Starting a new rollout; this may take a few minutes. It's safe to exit now.").start();
    await (0, rollout_1.orchestrateRollout)({
        projectId,
        location,
        backendId,
        buildInput: {
            source: {
                codebase: {
                    branch,
                },
            },
        },
        isFirstRollout: true,
    });
    createRolloutSpinner.succeed("Rollout complete");
    if (!(await tlsReady(url))) {
        const tlsSpinner = ora("Finalizing your backend's TLS certificate; this may take a few minutes.").start();
        await awaitTlsReady(url);
        tlsSpinner.succeed("TLS certificate ready");
    }
    (0, utils_1.logSuccess)(`Your backend is now deployed at:\n\thttps://${backend.uri}`);
}
exports.doSetup = doSetup;
async function createGitRepoLink(projectId, location, connectionId) {
    await Promise.all([
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.developerConnectOrigin)(), "apphosting", true),
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.secretManagerOrigin)(), "apphosting", true),
        (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.iamOrigin)(), "apphosting", true),
    ]);
    const allowedLocations = (await apphosting.listLocations(projectId)).map((loc) => loc.locationId);
    if (location) {
        if (!allowedLocations.includes(location)) {
            throw new error_1.FirebaseError(`Invalid location ${location}. Valid choices are ${allowedLocations.join(", ")}`);
        }
    }
    location =
        location ||
            (await promptLocation(projectId, "Select a location for your GitRepoLink's connection:\n"));
    await githubConnections.linkGitHubRepository(projectId, location, connectionId);
}
exports.createGitRepoLink = createGitRepoLink;
async function ensureAppHostingComputeServiceAccount(projectId, serviceAccount) {
    const sa = serviceAccount || defaultComputeServiceAccountEmail(projectId);
    const name = `projects/${projectId}/serviceAccounts/${sa}`;
    try {
        await iam.testResourceIamPermissions((0, api_1.iamOrigin)(), "v1", name, ["iam.serviceAccounts.actAs"], `projects/${projectId}`);
    }
    catch (err) {
        if (!(err instanceof error_1.FirebaseError)) {
            throw err;
        }
        if (err.status === 404) {
            await provisionDefaultComputeServiceAccount(projectId);
        }
        else if (err.status === 403) {
            throw new error_1.FirebaseError(`Failed to create backend due to missing delegation permissions for ${sa}. Make sure you have the iam.serviceAccounts.actAs permission.`, { original: err });
        }
    }
}
exports.ensureAppHostingComputeServiceAccount = ensureAppHostingComputeServiceAccount;
async function promptNewBackendId(projectId, location, prompt) {
    while (true) {
        const backendId = await (0, prompt_1.promptOnce)(prompt);
        try {
            await apphosting.getBackend(projectId, location, backendId);
        }
        catch (err) {
            if ((0, error_1.getErrStatus)(err) === 404) {
                return backendId;
            }
            throw new error_1.FirebaseError(`Failed to check if backend with id ${backendId} already exists in ${location}`, { original: (0, error_1.getError)(err) });
        }
        (0, utils_1.logWarning)(`Backend with id ${backendId} already exists in ${location}`);
    }
}
function defaultComputeServiceAccountEmail(projectId) {
    return `${DEFAULT_COMPUTE_SERVICE_ACCOUNT_NAME}@${projectId}.iam.gserviceaccount.com`;
}
async function createBackend(projectId, location, backendId, repository, serviceAccount, webAppId, rootDir = "/") {
    const defaultServiceAccount = defaultComputeServiceAccountEmail(projectId);
    const backendReqBody = {
        servingLocality: "GLOBAL_ACCESS",
        codebase: {
            repository: `${repository.name}`,
            rootDirectory: rootDir,
        },
        labels: deploymentTool.labels(),
        serviceAccount: serviceAccount || defaultServiceAccount,
        appId: webAppId,
    };
    async function createBackendAndPoll() {
        const op = await apphosting.createBackend(projectId, location, backendReqBody, backendId);
        return await poller.pollOperation(Object.assign(Object.assign({}, apphostingPollerOptions), { pollerName: `create-${projectId}-${location}-${backendId}`, operationResourceName: op.name }));
    }
    return await createBackendAndPoll();
}
exports.createBackend = createBackend;
async function provisionDefaultComputeServiceAccount(projectId) {
    try {
        await iam.createServiceAccount(projectId, DEFAULT_COMPUTE_SERVICE_ACCOUNT_NAME, "Default service account used to run builds and deploys for Firebase App Hosting", "Firebase App Hosting compute service account");
    }
    catch (err) {
        if ((0, error_1.getErrStatus)(err) !== 409) {
            throw err;
        }
    }
    await (0, resourceManager_1.addServiceAccountToRoles)(projectId, defaultComputeServiceAccountEmail(projectId), [
        "roles/firebaseapphosting.computeRunner",
        "roles/firebase.sdkAdminServiceAgent",
        "roles/developerconnect.readTokenAccessor",
    ], true);
}
async function setDefaultTrafficPolicy(projectId, location, backendId, codebaseBranch) {
    const traffic = {
        rolloutPolicy: {
            codebaseBranch: codebaseBranch,
        },
    };
    const op = await apphosting.updateTraffic(projectId, location, backendId, traffic);
    await poller.pollOperation(Object.assign(Object.assign({}, apphostingPollerOptions), { pollerName: `updateTraffic-${projectId}-${location}-${backendId}`, operationResourceName: op.name }));
}
exports.setDefaultTrafficPolicy = setDefaultTrafficPolicy;
async function deleteBackendAndPoll(projectId, location, backendId) {
    const op = await apphosting.deleteBackend(projectId, location, backendId);
    await poller.pollOperation(Object.assign(Object.assign({}, apphostingPollerOptions), { pollerName: `delete-${projectId}-${location}-${backendId}`, operationResourceName: op.name }));
}
exports.deleteBackendAndPoll = deleteBackendAndPoll;
async function promptLocation(projectId, prompt = "Please select a location:") {
    const allowedLocations = (await apphosting.listLocations(projectId)).map((loc) => loc.locationId);
    if (allowedLocations.length === 1) {
        return allowedLocations[0];
    }
    const location = (await (0, prompt_1.promptOnce)({
        name: "location",
        type: "list",
        default: constants_1.DEFAULT_LOCATION,
        message: prompt,
        choices: allowedLocations,
    }));
    (0, utils_1.logSuccess)(`Location set to ${location}.\n`);
    return location;
}
exports.promptLocation = promptLocation;
async function getBackendForLocation(projectId, location, backendId) {
    try {
        return await apphosting.getBackend(projectId, location, backendId);
    }
    catch (err) {
        throw new error_1.FirebaseError(`No backend named "${backendId}" found in ${location}.`, {
            original: (0, error_1.getError)(err),
        });
    }
}
exports.getBackendForLocation = getBackendForLocation;
async function chooseBackends(projectId, backendId, chooseBackendPrompt, force) {
    let { unreachable, backends } = await apphosting.listBackends(projectId, "-");
    if (unreachable && unreachable.length !== 0) {
        (0, utils_1.logWarning)(`The following locations are currently unreachable: ${unreachable.join(",")}.\n` +
            "If your backend is in one of these regions, please try again later.");
    }
    backends = backends.filter((backend) => apphosting.parseBackendName(backend.name).id === backendId);
    if (backends.length === 0) {
        throw new error_1.FirebaseError(`No backend named "${backendId}" found.`);
    }
    if (backends.length === 1) {
        return backends;
    }
    if (force) {
        throw new error_1.FirebaseError(`Force cannot be used because multiple backends were found with ID ${backendId}.`);
    }
    const backendsByDisplay = new Map();
    backends.forEach((backend) => {
        const { location, id } = apphosting.parseBackendName(backend.name);
        backendsByDisplay.set(`${id}(${location})`, backend);
    });
    const chosenBackendDisplays = await (0, prompt_1.promptOnce)({
        name: "backend",
        type: "checkbox",
        message: chooseBackendPrompt,
        choices: Array.from(backendsByDisplay.keys(), (name) => {
            return {
                checked: false,
                name: name,
                value: name,
            };
        }),
    });
    const chosenBackends = [];
    chosenBackendDisplays.forEach((backendDisplay) => {
        const backend = backendsByDisplay.get(backendDisplay);
        if (backend !== undefined) {
            chosenBackends.push(backend);
        }
    });
    return chosenBackends;
}
exports.chooseBackends = chooseBackends;
async function getBackendForAmbiguousLocation(projectId, backendId, locationDisambugationPrompt, force) {
    let { unreachable, backends } = await apphosting.listBackends(projectId, "-");
    if (unreachable && unreachable.length !== 0) {
        (0, utils_1.logWarning)(`The following locations are currently unreachable: ${unreachable.join(", ")}.\n` +
            "If your backend is in one of these regions, please try again later.");
    }
    backends = backends.filter((backend) => apphosting.parseBackendName(backend.name).id === backendId);
    if (backends.length === 0) {
        throw new error_1.FirebaseError(`No backend named "${backendId}" found.`);
    }
    if (backends.length === 1) {
        return backends[0];
    }
    if (force) {
        throw new error_1.FirebaseError(`Multiple backends found with ID ${backendId}. Please specify the region of your target backend.`);
    }
    const backendsByLocation = new Map();
    backends.forEach((backend) => backendsByLocation.set(apphosting.parseBackendName(backend.name).location, backend));
    const location = await (0, prompt_1.promptOnce)({
        name: "location",
        type: "list",
        message: locationDisambugationPrompt,
        choices: [...backendsByLocation.keys()],
    });
    return backendsByLocation.get(location);
}
exports.getBackendForAmbiguousLocation = getBackendForAmbiguousLocation;
async function getBackend(projectId, backendId) {
    let { unreachable, backends } = await apphosting.listBackends(projectId, "-");
    backends = backends.filter((backend) => apphosting.parseBackendName(backend.name).id === backendId);
    if (backends.length > 1) {
        const locations = backends.map((b) => apphosting.parseBackendName(b.name).location);
        throw new error_1.FirebaseError(`You have multiple backends with the same ${backendId} ID in regions: ${locations.join(", ")}. This is not allowed until we can support more locations. ` +
            "Please delete and recreate any backends that share an ID with another backend.");
    }
    if (backends.length === 1) {
        return backends[0];
    }
    if (unreachable && unreachable.length !== 0) {
        (0, utils_1.logWarning)(`Backends with the following primary regions are unreachable: ${unreachable.join(", ")}.\n` +
            "If your backend is in one of these regions, please try again later.");
    }
    throw new error_1.FirebaseError(`No backend named ${backendId} found.`);
}
exports.getBackend = getBackend;
