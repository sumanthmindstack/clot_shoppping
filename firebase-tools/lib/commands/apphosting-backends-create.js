"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.command = void 0;
const command_1 = require("../command");
const projectUtils_1 = require("../projectUtils");
const requireInteractive_1 = require("../requireInteractive");
const backend_1 = require("../apphosting/backend");
const apphosting_1 = require("../gcp/apphosting");
const firedata_1 = require("../gcp/firedata");
const requireTosAcceptance_1 = require("../requireTosAcceptance");
exports.command = new command_1.Command("apphosting:backends:create")
    .description("create a Firebase App Hosting backend")
    .option("-a, --app <webAppId>", "specify an existing Firebase web app's ID to associate your App Hosting backend with")
    .option("-s, --service-account <serviceAccount>", "specify the service account used to run the server", "")
    .before(apphosting_1.ensureApiEnabled)
    .before(requireInteractive_1.default)
    .before((0, requireTosAcceptance_1.requireTosAcceptance)(firedata_1.APPHOSTING_TOS_ID))
    .action(async (options) => {
    const projectId = (0, projectUtils_1.needProjectId)(options);
    const webAppId = options.app;
    const serviceAccount = options.serviceAccount;
    await (0, backend_1.doSetup)(projectId, webAppId, serviceAccount);
});
