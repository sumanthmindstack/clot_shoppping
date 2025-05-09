"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.initRules = void 0;
const clc = require("colorette");
const gcp = require("../../../gcp");
const fsutils = require("../../../fsutils");
const prompt_1 = require("../../../prompt");
const logger_1 = require("../../../logger");
const utils = require("../../../utils");
const templates_1 = require("../../../templates");
const DEFAULT_RULES_FILE = "firestore.rules";
const RULES_TEMPLATE = (0, templates_1.readTemplateSync)("init/firestore/firestore.rules");
function initRules(setup, config) {
    logger_1.logger.info();
    logger_1.logger.info("Firestore Security Rules allow you to define how and when to allow");
    logger_1.logger.info("requests. You can keep these rules in your project directory");
    logger_1.logger.info("and publish them with " + clc.bold("firebase deploy") + ".");
    logger_1.logger.info();
    return (0, prompt_1.prompt)(setup.config.firestore, [
        {
            type: "input",
            name: "rules",
            message: "What file should be used for Firestore Rules?",
            default: DEFAULT_RULES_FILE,
        },
    ])
        .then(() => {
        const filename = setup.config.firestore.rules;
        if (fsutils.fileExistsSync(filename)) {
            const msg = "File " +
                clc.bold(filename) +
                " already exists." +
                " Do you want to overwrite it with the Firestore Rules from the Firebase Console?";
            return (0, prompt_1.promptOnce)({
                type: "confirm",
                message: msg,
                default: false,
            });
        }
        return Promise.resolve(true);
    })
        .then((overwrite) => {
        if (!overwrite) {
            return Promise.resolve();
        }
        if (!setup.projectId) {
            return config.writeProjectFile(setup.config.firestore.rules, getDefaultRules());
        }
        return getRulesFromConsole(setup.projectId).then((contents) => {
            return config.writeProjectFile(setup.config.firestore.rules, contents);
        });
    });
}
exports.initRules = initRules;
function getDefaultRules() {
    const date = utils.thirtyDaysFromNow();
    const formattedForRules = `${date.getFullYear()}, ${date.getMonth() + 1}, ${date.getDate()}`;
    return RULES_TEMPLATE.replace(/{{IN_30_DAYS}}/g, formattedForRules);
}
function getRulesFromConsole(projectId) {
    return gcp.rules
        .getLatestRulesetName(projectId, "cloud.firestore")
        .then((name) => {
        if (!name) {
            logger_1.logger.debug("No rulesets found, using default.");
            return [{ name: DEFAULT_RULES_FILE, content: getDefaultRules() }];
        }
        logger_1.logger.debug("Found ruleset: " + name);
        return gcp.rules.getRulesetContent(name);
    })
        .then((rules) => {
        if (rules.length <= 0) {
            return utils.reject("Ruleset has no files", { exit: 1 });
        }
        if (rules.length > 1) {
            return utils.reject("Ruleset has too many files: " + rules.length, { exit: 1 });
        }
        return rules[0].content;
    });
}
