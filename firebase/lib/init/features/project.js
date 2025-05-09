"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.doSetup = void 0;
const clc = require("colorette");
const _ = require("lodash");
const error_1 = require("../../error");
const projects_1 = require("../../management/projects");
const logger_1 = require("../../logger");
const prompt_1 = require("../../prompt");
const utils = require("../../utils");
const OPTION_NO_PROJECT = "Don't set up a default project";
const OPTION_USE_PROJECT = "Use an existing project";
const OPTION_NEW_PROJECT = "Create a new project";
const OPTION_ADD_FIREBASE = "Add Firebase to an existing Google Cloud Platform project";
function toInitProjectInfo(projectMetaData) {
    const { projectId, displayName, resources } = projectMetaData;
    return {
        id: projectId,
        label: `${projectId}` + (displayName ? ` (${displayName})` : ""),
        instance: resources === null || resources === void 0 ? void 0 : resources.realtimeDatabaseInstance,
        location: resources === null || resources === void 0 ? void 0 : resources.locationId,
    };
}
async function promptAndCreateNewProject() {
    utils.logBullet("If you want to create a project in a Google Cloud organization or folder, please use " +
        `"firebase projects:create" instead, and return to this command when you've created the project.`);
    const promptAnswer = {};
    await (0, prompt_1.prompt)(promptAnswer, projects_1.PROJECTS_CREATE_QUESTIONS);
    if (!promptAnswer.projectId) {
        throw new error_1.FirebaseError("Project ID cannot be empty");
    }
    return await (0, projects_1.createFirebaseProjectAndLog)(promptAnswer.projectId, {
        displayName: promptAnswer.displayName,
    });
}
async function promptAndAddFirebaseToCloudProject() {
    const projectId = await (0, projects_1.promptAvailableProjectId)();
    if (!projectId) {
        throw new error_1.FirebaseError("Project ID cannot be empty");
    }
    return await (0, projects_1.addFirebaseToCloudProjectAndLog)(projectId);
}
async function projectChoicePrompt(options) {
    const choices = [
        { name: OPTION_USE_PROJECT, value: OPTION_USE_PROJECT },
        { name: OPTION_NEW_PROJECT, value: OPTION_NEW_PROJECT },
        { name: OPTION_ADD_FIREBASE, value: OPTION_ADD_FIREBASE },
        { name: OPTION_NO_PROJECT, value: OPTION_NO_PROJECT },
    ];
    const projectSetupOption = await (0, prompt_1.promptOnce)({
        type: "list",
        name: "id",
        message: "Please select an option:",
        choices,
    });
    switch (projectSetupOption) {
        case OPTION_USE_PROJECT:
            return (0, projects_1.getOrPromptProject)(options);
        case OPTION_NEW_PROJECT:
            return promptAndCreateNewProject();
        case OPTION_ADD_FIREBASE:
            return promptAndAddFirebaseToCloudProject();
        default:
            return;
    }
}
async function doSetup(setup, config, options) {
    var _a, _b, _c;
    setup.project = {};
    logger_1.logger.info();
    logger_1.logger.info(`First, let's associate this project directory with a Firebase project.`);
    logger_1.logger.info(`You can create multiple project aliases by running ${clc.bold("firebase use --add")}, `);
    logger_1.logger.info(`but for now we'll just set up a default project.`);
    logger_1.logger.info();
    const projectFromRcFile = (_b = (_a = setup.rcfile) === null || _a === void 0 ? void 0 : _a.projects) === null || _b === void 0 ? void 0 : _b.default;
    if (projectFromRcFile && !options.project) {
        utils.logBullet(`.firebaserc already has a default project, using ${projectFromRcFile}.`);
        const rcProject = await (0, projects_1.getFirebaseProject)(projectFromRcFile);
        setup.projectId = rcProject.projectId;
        setup.projectLocation = (_c = rcProject === null || rcProject === void 0 ? void 0 : rcProject.resources) === null || _c === void 0 ? void 0 : _c.locationId;
        return;
    }
    let projectMetaData;
    if (options.project) {
        logger_1.logger.debug(`Using project from CLI flag: ${options.project}`);
        projectMetaData = await (0, projects_1.getFirebaseProject)(options.project);
    }
    else {
        projectMetaData = await projectChoicePrompt(options);
        if (!projectMetaData) {
            return;
        }
    }
    const projectInfo = toInitProjectInfo(projectMetaData);
    utils.logBullet(`Using project ${projectInfo.label}`);
    _.set(setup.rcfile, "projects.default", projectInfo.id);
    setup.projectId = projectInfo.id;
    setup.instance = projectInfo.instance;
    setup.projectLocation = projectInfo.location;
    utils.makeActiveProject(config.projectDir, projectInfo.id);
}
exports.doSetup = doSetup;
