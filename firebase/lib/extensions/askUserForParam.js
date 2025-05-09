"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getInquirerDefault = exports.promptCreateSecret = exports.askForParam = exports.ask = exports.checkResponse = exports.SecretLocation = void 0;
const _ = require("lodash");
const clc = require("colorette");
const marked_1 = require("marked");
const types_1 = require("./types");
const secretManagerApi = require("../gcp/secretManager");
const secretsUtils = require("./secretsUtils");
const extensionsHelper_1 = require("./extensionsHelper");
const utils_1 = require("./utils");
const logger_1 = require("../logger");
const prompt_1 = require("../prompt");
const utils = require("../utils");
const projectUtils_1 = require("../projectUtils");
const functional_1 = require("../functional");
var SecretLocation;
(function (SecretLocation) {
    SecretLocation[SecretLocation["CLOUD"] = 1] = "CLOUD";
    SecretLocation[SecretLocation["LOCAL"] = 2] = "LOCAL";
})(SecretLocation = exports.SecretLocation || (exports.SecretLocation = {}));
var SecretUpdateAction;
(function (SecretUpdateAction) {
    SecretUpdateAction[SecretUpdateAction["LEAVE"] = 1] = "LEAVE";
    SecretUpdateAction[SecretUpdateAction["SET_NEW"] = 2] = "SET_NEW";
})(SecretUpdateAction || (SecretUpdateAction = {}));
function checkResponse(response, spec) {
    var _a;
    let valid = true;
    let responses;
    if (spec.required && (response === "" || response === undefined)) {
        utils.logWarning(`Param ${spec.param} is required, but no value was provided.`);
        return false;
    }
    if (spec.type === types_1.ParamType.MULTISELECT) {
        responses = response.split(",");
    }
    else {
        responses = [response];
    }
    if (spec.validationRegex && !!response) {
        const re = new RegExp(spec.validationRegex);
        for (const resp of responses) {
            if ((spec.required || resp !== "") && !re.test(resp)) {
                const genericWarn = `${resp} is not a valid value for ${spec.param} since it` +
                    ` does not meet the requirements of the regex validation: "${spec.validationRegex}"`;
                utils.logWarning(spec.validationErrorMessage || genericWarn);
                valid = false;
            }
        }
    }
    if (spec.type && (spec.type === types_1.ParamType.MULTISELECT || spec.type === types_1.ParamType.SELECT)) {
        for (const r of responses) {
            const validChoice = (_a = spec.options) === null || _a === void 0 ? void 0 : _a.some((option) => r === option.value);
            if (r && !validChoice) {
                utils.logWarning(`${r} is not a valid option for ${spec.param}.`);
                valid = false;
            }
        }
    }
    return valid;
}
exports.checkResponse = checkResponse;
async function ask(args) {
    if (_.isEmpty(args.paramSpecs)) {
        logger_1.logger.debug("No params were specified for this extension.");
        return {};
    }
    utils.logLabeledBullet(extensionsHelper_1.logPrefix, "answer the questions below to configure your extension:");
    const substituted = (0, extensionsHelper_1.substituteParams)(args.paramSpecs, args.firebaseProjectParams);
    const [advancedParams, standardParams] = (0, functional_1.partition)(substituted, (p) => { var _a; return (_a = p.advanced) !== null && _a !== void 0 ? _a : false; });
    const result = {};
    const promises = standardParams.map((paramSpec) => {
        return async () => {
            result[paramSpec.param] = await askForParam({
                projectId: args.projectId,
                instanceId: args.instanceId,
                paramSpec: paramSpec,
                reconfiguring: args.reconfiguring,
            });
        };
    });
    if (advancedParams.length) {
        promises.push(async () => {
            const shouldPrompt = await (0, prompt_1.promptOnce)({
                type: "confirm",
                message: "Do you want to configure any advanced parameters for this instance?",
                default: false,
            });
            if (shouldPrompt) {
                const advancedPromises = advancedParams.map((paramSpec) => {
                    return async () => {
                        result[paramSpec.param] = await askForParam({
                            projectId: args.projectId,
                            instanceId: args.instanceId,
                            paramSpec: paramSpec,
                            reconfiguring: args.reconfiguring,
                        });
                    };
                });
                await advancedPromises.reduce((prev, cur) => prev.then(cur), Promise.resolve());
            }
            else {
                for (const paramSpec of advancedParams) {
                    if (paramSpec.required && paramSpec.default) {
                        result[paramSpec.param] = { baseValue: paramSpec.default };
                    }
                }
            }
        });
    }
    await promises.reduce((prev, cur) => prev.then(cur), Promise.resolve());
    logger_1.logger.info();
    return result;
}
exports.ask = ask;
async function askForParam(args) {
    const paramSpec = args.paramSpec;
    let valid = false;
    let response = "";
    let responseForLocal;
    let secretLocations = [];
    const description = paramSpec.description || "";
    const label = paramSpec.label.trim();
    logger_1.logger.info(`\n${clc.bold(label)}${clc.bold(paramSpec.required ? "" : " (Optional)")}: ${(await (0, marked_1.marked)(description)).trim()}`);
    while (!valid) {
        switch (paramSpec.type) {
            case types_1.ParamType.SELECT:
                response = await (0, prompt_1.promptOnce)({
                    name: "input",
                    type: "list",
                    default: () => {
                        if (paramSpec.default) {
                            return getInquirerDefault(_.get(paramSpec, "options", []), paramSpec.default);
                        }
                    },
                    message: "Which option do you want enabled for this parameter? " +
                        "Select an option with the arrow keys, and use Enter to confirm your choice. " +
                        "You may only select one option.",
                    choices: (0, utils_1.convertExtensionOptionToLabeledList)(paramSpec.options),
                });
                valid = checkResponse(response, paramSpec);
                break;
            case types_1.ParamType.MULTISELECT:
                response = await (0, utils_1.onceWithJoin)({
                    name: "input",
                    type: "checkbox",
                    default: () => {
                        if (paramSpec.default) {
                            const defaults = paramSpec.default.split(",");
                            return defaults.map((def) => {
                                return getInquirerDefault(_.get(paramSpec, "options", []), def);
                            });
                        }
                    },
                    message: "Which options do you want enabled for this parameter? " +
                        "Press Space to select, then Enter to confirm your choices. ",
                    choices: (0, utils_1.convertExtensionOptionToLabeledList)(paramSpec.options),
                });
                valid = checkResponse(response, paramSpec);
                break;
            case types_1.ParamType.SECRET:
                do {
                    secretLocations = await promptSecretLocations(paramSpec);
                } while (!isValidSecretLocations(secretLocations, paramSpec));
                if (secretLocations.includes(SecretLocation.CLOUD.toString())) {
                    const projectId = (0, projectUtils_1.needProjectId)({ projectId: args.projectId });
                    response = args.reconfiguring
                        ? await promptReconfigureSecret(projectId, args.instanceId, paramSpec)
                        : await promptCreateSecret(projectId, args.instanceId, paramSpec);
                }
                if (secretLocations.includes(SecretLocation.LOCAL.toString())) {
                    responseForLocal = await promptLocalSecret(args.instanceId, paramSpec);
                }
                valid = true;
                break;
            default:
                response = await (0, prompt_1.promptOnce)({
                    name: paramSpec.param,
                    type: "input",
                    default: paramSpec.default,
                    message: `Enter a value for ${label}:`,
                });
                valid = checkResponse(response, paramSpec);
        }
    }
    return Object.assign({ baseValue: response }, (responseForLocal ? { local: responseForLocal } : {}));
}
exports.askForParam = askForParam;
function isValidSecretLocations(secretLocations, paramSpec) {
    if (paramSpec.required) {
        return !!secretLocations.length;
    }
    return true;
}
async function promptSecretLocations(paramSpec) {
    if (paramSpec.required) {
        return await (0, prompt_1.promptOnce)({
            name: "input",
            type: "checkbox",
            message: "Where would you like to store your secrets? You must select at least one value",
            choices: [
                {
                    checked: true,
                    name: "Google Cloud Secret Manager (Used by deployed extensions and emulator)",
                    value: SecretLocation.CLOUD.toString(),
                },
                {
                    checked: false,
                    name: "Local file (Used by emulator only)",
                    value: SecretLocation.LOCAL.toString(),
                },
            ],
        });
    }
    return await (0, prompt_1.promptOnce)({
        name: "input",
        type: "checkbox",
        message: "Where would you like to store your secrets? " +
            "If you don't want to set this optional secret, leave both options unselected to skip it",
        choices: [
            {
                checked: false,
                name: "Google Cloud Secret Manager (Used by deployed extensions and emulator)",
                value: SecretLocation.CLOUD.toString(),
            },
            {
                checked: false,
                name: "Local file (Used by emulator only)",
                value: SecretLocation.LOCAL.toString(),
            },
        ],
    });
}
async function promptLocalSecret(instanceId, paramSpec) {
    let value;
    do {
        utils.logLabeledBullet(extensionsHelper_1.logPrefix, "Configure a local secret value for Extensions Emulator");
        value = await (0, prompt_1.promptOnce)({
            name: paramSpec.param,
            type: "input",
            message: `This secret will be stored in ./extensions/${instanceId}.secret.local.\n` +
                `Enter value for "${paramSpec.label.trim()}" to be used by Extensions Emulator:`,
        });
    } while (!value);
    return value;
}
async function promptReconfigureSecret(projectId, instanceId, paramSpec) {
    const action = await (0, prompt_1.promptOnce)({
        type: "list",
        message: `Choose what you would like to do with this secret:`,
        choices: [
            { name: "Leave unchanged", value: SecretUpdateAction.LEAVE },
            { name: "Set new value", value: SecretUpdateAction.SET_NEW },
        ],
    });
    switch (action) {
        case SecretUpdateAction.SET_NEW: {
            let secret;
            let secretName;
            if (paramSpec.default) {
                secret = secretManagerApi.parseSecretResourceName(paramSpec.default);
                secretName = secret.name;
            }
            else {
                secretName = await generateSecretName(projectId, instanceId, paramSpec.param);
            }
            const secretValue = await (0, prompt_1.promptOnce)({
                name: paramSpec.param,
                type: "password",
                message: `This secret will be stored in Cloud Secret Manager as ${secretName}.\nEnter new value for ${paramSpec.label.trim()}:`,
            });
            if (secretValue === "" && paramSpec.required) {
                logger_1.logger.info(`Secret value cannot be empty for required param ${paramSpec.param}`);
                return promptReconfigureSecret(projectId, instanceId, paramSpec);
            }
            else if (secretValue !== "") {
                if (checkResponse(secretValue, paramSpec)) {
                    if (!secret) {
                        secret = await secretManagerApi.createSecret(projectId, secretName, secretsUtils.getSecretLabels(instanceId));
                    }
                    return addNewSecretVersion(projectId, instanceId, secret, paramSpec, secretValue);
                }
                else {
                    return promptReconfigureSecret(projectId, instanceId, paramSpec);
                }
            }
            else {
                return "";
            }
        }
        case SecretUpdateAction.LEAVE:
        default:
            return paramSpec.default || "";
    }
}
async function promptCreateSecret(projectId, instanceId, paramSpec, secretName) {
    const name = secretName !== null && secretName !== void 0 ? secretName : (await generateSecretName(projectId, instanceId, paramSpec.param));
    const secretValue = await (0, prompt_1.promptOnce)({
        name: paramSpec.param,
        type: "password",
        default: paramSpec.default,
        message: `This secret will be stored in Cloud Secret Manager (https://cloud.google.com/secret-manager/pricing) as ${name} and managed by Firebase Extensions (Firebase Extensions Service Agent will be granted Secret Admin role on this secret).\nEnter a value for ${paramSpec.label.trim()}:`,
    });
    if (secretValue === "" && paramSpec.required) {
        logger_1.logger.info(`Secret value cannot be empty for required param ${paramSpec.param}`);
        return promptCreateSecret(projectId, instanceId, paramSpec, name);
    }
    else if (secretValue !== "") {
        if (checkResponse(secretValue, paramSpec)) {
            const secret = await secretManagerApi.createSecret(projectId, name, secretsUtils.getSecretLabels(instanceId));
            return addNewSecretVersion(projectId, instanceId, secret, paramSpec, secretValue);
        }
        else {
            return promptCreateSecret(projectId, instanceId, paramSpec, name);
        }
    }
    else {
        return "";
    }
}
exports.promptCreateSecret = promptCreateSecret;
async function generateSecretName(projectId, instanceId, paramName) {
    let secretName = `ext-${instanceId}-${paramName}`;
    while (await secretManagerApi.secretExists(projectId, secretName)) {
        secretName += `-${(0, utils_1.getRandomString)(3)}`;
    }
    return secretName;
}
async function addNewSecretVersion(projectId, instanceId, secret, paramSpec, secretValue) {
    const version = await secretManagerApi.addVersion(projectId, secret.name, secretValue);
    await secretsUtils.grantFirexServiceAgentSecretAdminRole(secret);
    return `projects/${version.secret.projectId}/secrets/${version.secret.name}/versions/${version.versionId}`;
}
function getInquirerDefault(options, def) {
    const defaultOption = options.find((o) => o.value === def);
    return defaultOption ? defaultOption.label || defaultOption.value : "";
}
exports.getInquirerDefault = getInquirerDefault;
