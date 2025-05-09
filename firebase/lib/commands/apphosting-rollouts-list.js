"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.command = void 0;
const apphosting = require("../gcp/apphosting");
const logger_1 = require("../logger");
const command_1 = require("../command");
const projectUtils_1 = require("../projectUtils");
const utils_1 = require("../utils");
exports.command = new command_1.Command("apphosting:rollouts:list <backendId>")
    .description("list rollouts of an App Hosting backend")
    .option("-l, --location <location>", "region of the rollouts (defaults to listing rollouts from all regions)")
    .before(apphosting.ensureApiEnabled)
    .action(async (backendId, options) => {
    var _a;
    if (options.location !== undefined) {
        (0, utils_1.logWarning)("--location is being removed in the next major release.");
    }
    const projectId = (0, projectUtils_1.needProjectId)(options);
    const location = (_a = options.location) !== null && _a !== void 0 ? _a : "-";
    const rollouts = await apphosting.listRollouts(projectId, location, backendId);
    if (rollouts.unreachable) {
        logger_1.logger.error(`WARNING: the following locations were unreachable: ${rollouts.unreachable.join(", ")}`);
    }
    logger_1.logger.info(JSON.stringify(rollouts.rollouts, null, 2));
    return rollouts;
});
