"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getProject = exports.getFirebaseProject = exports.listFirebaseProjects = exports.getAvailableCloudProjectPage = exports.getFirebaseProjectPage = exports.addFirebaseToCloudProject = exports.createCloudProject = exports.promptAvailableProjectId = exports.getOrPromptProject = exports.addFirebaseToCloudProjectAndLog = exports.createFirebaseProjectAndLog = exports.PROJECTS_CREATE_QUESTIONS = exports.ProjectParentResourceType = void 0;
const clc = require("colorette");
const ora = require("ora");
const apiv2_1 = require("../apiv2");
const error_1 = require("../error");
const operation_poller_1 = require("../operation-poller");
const prompt_1 = require("../prompt");
const api = require("../api");
const logger_1 = require("../logger");
const utils = require("../utils");
const TIMEOUT_MILLIS = 30000;
const MAXIMUM_PROMPT_LIST = 100;
const PROJECT_LIST_PAGE_SIZE = 1000;
const CREATE_PROJECT_API_REQUEST_TIMEOUT_MILLIS = 15000;
var ProjectParentResourceType;
(function (ProjectParentResourceType) {
    ProjectParentResourceType["ORGANIZATION"] = "organization";
    ProjectParentResourceType["FOLDER"] = "folder";
})(ProjectParentResourceType = exports.ProjectParentResourceType || (exports.ProjectParentResourceType = {}));
exports.PROJECTS_CREATE_QUESTIONS = [
    {
        type: "input",
        name: "projectId",
        default: "",
        message: "Please specify a unique project id " +
            `(${clc.yellow("warning")}: cannot be modified afterward) [6-30 characters]:\n`,
        validate: (projectId) => {
            if (projectId.length < 6) {
                return "Project ID must be at least 6 characters long";
            }
            else if (projectId.length > 30) {
                return "Project ID cannot be longer than 30 characters";
            }
            else {
                return true;
            }
        },
    },
    {
        type: "input",
        name: "displayName",
        default: (answers) => answers.projectId,
        message: "What would you like to call your project? (defaults to your project ID)",
        validate: (displayName) => {
            if (displayName.length < 4) {
                return "Project name must be at least 4 characters long";
            }
            else if (displayName.length > 30) {
                return "Project name cannot be longer than 30 characters";
            }
            else {
                return true;
            }
        },
    },
];
const firebaseAPIClient = new apiv2_1.Client({
    urlPrefix: api.firebaseApiOrigin(),
    auth: true,
    apiVersion: "v1beta1",
});
const resourceManagerClient = new apiv2_1.Client({
    urlPrefix: api.resourceManagerOrigin(),
    apiVersion: "v1",
});
async function createFirebaseProjectAndLog(projectId, options) {
    const spinner = ora("Creating Google Cloud Platform project").start();
    try {
        await createCloudProject(projectId, options);
        spinner.succeed();
    }
    catch (err) {
        spinner.fail();
        throw err;
    }
    return addFirebaseToCloudProjectAndLog(projectId);
}
exports.createFirebaseProjectAndLog = createFirebaseProjectAndLog;
async function addFirebaseToCloudProjectAndLog(projectId) {
    let projectInfo;
    const spinner = ora("Adding Firebase resources to Google Cloud Platform project").start();
    try {
        projectInfo = await addFirebaseToCloudProject(projectId);
    }
    catch (err) {
        spinner.fail();
        throw err;
    }
    spinner.succeed();
    logNewFirebaseProjectInfo(projectInfo);
    return projectInfo;
}
exports.addFirebaseToCloudProjectAndLog = addFirebaseToCloudProjectAndLog;
function logNewFirebaseProjectInfo(projectInfo) {
    logger_1.logger.info("");
    if (process.platform === "win32") {
        logger_1.logger.info("=== Your Firebase project is ready! ===");
    }
    else {
        logger_1.logger.info("🎉🎉🎉 Your Firebase project is ready! 🎉🎉🎉");
    }
    logger_1.logger.info("");
    logger_1.logger.info("Project information:");
    logger_1.logger.info(`   - Project ID: ${clc.bold(projectInfo.projectId)}`);
    if (projectInfo.displayName) {
        logger_1.logger.info(`   - Project Name: ${clc.bold(projectInfo.displayName)}`);
    }
    logger_1.logger.info("");
    logger_1.logger.info("Firebase console is available at");
    logger_1.logger.info(`https://console.firebase.google.com/project/${clc.bold(projectInfo.projectId)}/overview`);
}
async function getOrPromptProject(options) {
    if (options.project) {
        return await getFirebaseProject(options.project);
    }
    return selectProjectInteractively();
}
exports.getOrPromptProject = getOrPromptProject;
async function selectProjectInteractively(pageSize = MAXIMUM_PROMPT_LIST) {
    const { projects, nextPageToken } = await getFirebaseProjectPage(pageSize);
    if (projects.length === 0) {
        throw new error_1.FirebaseError("There are no Firebase projects associated with this account.");
    }
    if (nextPageToken) {
        logger_1.logger.debug(`Found more than ${projects.length} projects, selecting via prompt`);
        return selectProjectByPrompting();
    }
    return selectProjectFromList(projects);
}
async function selectProjectByPrompting() {
    const projectId = await (0, prompt_1.promptOnce)({
        type: "input",
        message: "Please input the project ID you would like to use:",
    });
    return await getFirebaseProject(projectId);
}
async function selectProjectFromList(projects = []) {
    const choices = projects
        .filter((p) => !!p)
        .map((p) => {
        return {
            name: p.projectId + (p.displayName ? ` (${p.displayName})` : ""),
            value: p.projectId,
        };
    })
        .sort((a, b) => a.name.localeCompare(b.name));
    if (choices.length >= 25) {
        utils.logBullet(`Don't want to scroll through all your projects? If you know your project ID, ` +
            `you can initialize it directly using ${clc.bold("firebase init --project <project_id>")}.\n`);
    }
    const projectId = await (0, prompt_1.promptOnce)({
        type: "list",
        name: "id",
        message: "Select a default Firebase project for this directory:",
        choices,
    });
    const project = projects.find((p) => p.projectId === projectId);
    if (!project) {
        throw new error_1.FirebaseError("Unexpected error. Project does not exist");
    }
    return project;
}
function getProjectId(cloudProject) {
    const resourceName = cloudProject.project;
    return resourceName.substring(resourceName.lastIndexOf("/") + 1);
}
async function promptAvailableProjectId() {
    const { projects, nextPageToken } = await getAvailableCloudProjectPage(MAXIMUM_PROMPT_LIST);
    if (projects.length === 0) {
        throw new error_1.FirebaseError("There are no available Google Cloud projects to add Firebase services.");
    }
    if (nextPageToken) {
        return await (0, prompt_1.promptOnce)({
            type: "input",
            message: "Please input the ID of the Google Cloud Project you would like to add Firebase:",
        });
    }
    else {
        const choices = projects
            .filter((p) => !!p)
            .map((p) => {
            const projectId = getProjectId(p);
            return {
                name: projectId + (p.displayName ? ` (${p.displayName})` : ""),
                value: projectId,
            };
        })
            .sort((a, b) => a.name.localeCompare(b.name));
        return await (0, prompt_1.promptOnce)({
            type: "list",
            name: "id",
            message: "Select the Google Cloud Platform project you would like to add Firebase:",
            choices,
        });
    }
}
exports.promptAvailableProjectId = promptAvailableProjectId;
async function createCloudProject(projectId, options) {
    try {
        const data = {
            projectId,
            name: options.displayName || projectId,
            parent: options.parentResource,
        };
        const response = await resourceManagerClient.request({
            method: "POST",
            path: "/projects",
            body: data,
            timeout: CREATE_PROJECT_API_REQUEST_TIMEOUT_MILLIS,
        });
        const projectInfo = await (0, operation_poller_1.pollOperation)({
            pollerName: "Project Creation Poller",
            apiOrigin: api.resourceManagerOrigin(),
            apiVersion: "v1",
            operationResourceName: response.body.name,
        });
        return projectInfo;
    }
    catch (err) {
        if (err.status === 409) {
            throw new error_1.FirebaseError(`Failed to create project because there is already a project with ID ${clc.bold(projectId)}. Please try again with a unique project ID.`, {
                exit: 2,
                original: err,
            });
        }
        else {
            throw new error_1.FirebaseError("Failed to create project. See firebase-debug.log for more info.", {
                exit: 2,
                original: err,
            });
        }
    }
}
exports.createCloudProject = createCloudProject;
async function addFirebaseToCloudProject(projectId) {
    try {
        const response = await firebaseAPIClient.request({
            method: "POST",
            path: `/projects/${projectId}:addFirebase`,
            timeout: CREATE_PROJECT_API_REQUEST_TIMEOUT_MILLIS,
        });
        const projectInfo = await (0, operation_poller_1.pollOperation)({
            pollerName: "Add Firebase Poller",
            apiOrigin: api.firebaseApiOrigin(),
            apiVersion: "v1beta1",
            operationResourceName: response.body.name,
        });
        return projectInfo;
    }
    catch (err) {
        logger_1.logger.debug(err.message);
        throw new error_1.FirebaseError("Failed to add Firebase to Google Cloud Platform project. See firebase-debug.log for more info.", { exit: 2, original: err });
    }
}
exports.addFirebaseToCloudProject = addFirebaseToCloudProject;
async function getProjectPage(apiResource, options) {
    const queryParams = {
        pageSize: `${options.pageSize}`,
    };
    if (options.pageToken) {
        queryParams.pageToken = options.pageToken;
    }
    const res = await firebaseAPIClient.request({
        method: "GET",
        path: apiResource,
        queryParams,
        timeout: TIMEOUT_MILLIS,
        skipLog: { resBody: true },
    });
    const projects = res.body[options.responseKey];
    const token = res.body.nextPageToken;
    return {
        projects: Array.isArray(projects) ? projects : [],
        nextPageToken: typeof token === "string" ? token : undefined,
    };
}
async function getFirebaseProjectPage(pageSize = PROJECT_LIST_PAGE_SIZE, pageToken) {
    let projectPage;
    try {
        projectPage = await getProjectPage("/projects", {
            responseKey: "results",
            pageSize,
            pageToken,
        });
    }
    catch (err) {
        logger_1.logger.debug(err.message);
        throw new error_1.FirebaseError("Failed to list Firebase projects. See firebase-debug.log for more info.", { exit: 2, original: err });
    }
    return projectPage;
}
exports.getFirebaseProjectPage = getFirebaseProjectPage;
async function getAvailableCloudProjectPage(pageSize = PROJECT_LIST_PAGE_SIZE, pageToken) {
    try {
        return await getProjectPage("/availableProjects", {
            responseKey: "projectInfo",
            pageSize,
            pageToken,
        });
    }
    catch (err) {
        logger_1.logger.debug(err.message);
        throw new error_1.FirebaseError("Failed to list available Google Cloud Platform projects. See firebase-debug.log for more info.", { exit: 2, original: err });
    }
}
exports.getAvailableCloudProjectPage = getAvailableCloudProjectPage;
async function listFirebaseProjects(pageSize) {
    const projects = [];
    let nextPageToken;
    do {
        const projectPage = await getFirebaseProjectPage(pageSize, nextPageToken);
        projects.push(...projectPage.projects);
        nextPageToken = projectPage.nextPageToken;
    } while (nextPageToken);
    return projects;
}
exports.listFirebaseProjects = listFirebaseProjects;
async function getFirebaseProject(projectId) {
    try {
        const res = await firebaseAPIClient.request({
            method: "GET",
            path: `/projects/${projectId}`,
            timeout: TIMEOUT_MILLIS,
        });
        return res.body;
    }
    catch (err) {
        if ((0, error_1.getErrStatus)(err) === 404) {
            try {
                logger_1.logger.debug(`Couldn't get project info from firedata for ${projectId}, trying resource manager. Original error: ${err}`);
                const info = await getProject(projectId);
                return info;
            }
            catch (err) {
                logger_1.logger.debug(`Unable to get project info from resourcemanager for ${projectId}: ${err}`);
            }
        }
        let message = err.message;
        if (err.original) {
            message += ` (original: ${err.original.message})`;
        }
        logger_1.logger.debug(message);
        throw new error_1.FirebaseError(`Failed to get Firebase project ${projectId}. ` +
            "Please make sure the project exists and your account has permission to access it.", { exit: 2, original: err });
    }
}
exports.getFirebaseProject = getFirebaseProject;
async function getProject(projectId) {
    const response = await resourceManagerClient.get(`/projects/${projectId}`);
    return response.body;
}
exports.getProject = getProject;
