"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.upgradeInstructions = exports.printFreeTrialUnavailable = exports.isFreeTrialError = exports.getFreeTrialInstanceId = exports.checkFreeTrialInstanceUsed = exports.freeTrialTermsLink = void 0;
const cloudmonitoring_1 = require("../gcp/cloudmonitoring");
const cloudsqladmin_1 = require("../gcp/cloudsql/cloudsqladmin");
const utils = require("../utils");
const clc = require("colorette");
function freeTrialTermsLink() {
    return "https://firebase.google.com/pricing";
}
exports.freeTrialTermsLink = freeTrialTermsLink;
const FREE_TRIAL_METRIC = "sqladmin.googleapis.com/fdc_lifetime_free_trial_per_project";
async function checkFreeTrialInstanceUsed(projectId) {
    const past7d = new Date();
    past7d.setDate(past7d.getDate() - 7);
    const query = {
        filter: `metric.type="serviceruntime.googleapis.com/quota/allocation/usage" AND metric.label.quota_metric = "${FREE_TRIAL_METRIC}"`,
        "interval.endTime": new Date().toJSON(),
        "interval.startTime": past7d.toJSON(),
    };
    try {
        const ts = await (0, cloudmonitoring_1.queryTimeSeries)(query, projectId);
        if (ts.length) {
            return ts[0].points.some((p) => p.value.int64Value);
        }
        return true;
    }
    catch (err) {
        return false;
    }
}
exports.checkFreeTrialInstanceUsed = checkFreeTrialInstanceUsed;
async function getFreeTrialInstanceId(projectId) {
    var _a;
    const instances = await (0, cloudsqladmin_1.listInstances)(projectId);
    return (_a = instances.find((i) => { var _a; return ((_a = i.settings.userLabels) === null || _a === void 0 ? void 0 : _a["firebase-data-connect"]) === "ft"; })) === null || _a === void 0 ? void 0 : _a.name;
}
exports.getFreeTrialInstanceId = getFreeTrialInstanceId;
async function isFreeTrialError(err, projectId) {
    return err.message.includes("Quota Exhausted") && (await checkFreeTrialInstanceUsed(projectId))
        ? true
        : false;
}
exports.isFreeTrialError = isFreeTrialError;
function printFreeTrialUnavailable(projectId, configYamlPath, instanceId) {
    if (!instanceId) {
        utils.logLabeledError("dataconnect", "The CloudSQL free trial has already been used on this project.");
        utils.logLabeledError("dataconnect", `You may create or use a paid CloudSQL instance by visiting https://console.cloud.google.com/sql/instances`);
        return;
    }
    utils.logLabeledError("dataconnect", `Project '${projectId} already has a CloudSQL instance '${instanceId}' on the Firebase Data Connect no-cost trial.`);
    const reuseHint = `To use a different database in the same instance, ${clc.bold(`change the ${clc.blue("instanceId")} to "${instanceId}"`)} and update ${clc.blue("location")} in ` +
        `${clc.green(configYamlPath)}.`;
    utils.logLabeledError("dataconnect", reuseHint);
    utils.logLabeledError("dataconnect", `Alternatively, you may create a new (paid) CloudSQL instance at https://console.cloud.google.com/sql/instances`);
}
exports.printFreeTrialUnavailable = printFreeTrialUnavailable;
function upgradeInstructions(projectId) {
    return `If you'd like to provision a CloudSQL Postgres instance on the Firebase Data Connect no-cost trial:
1. Please upgrade to the pay-as-you-go (Blaze) billing plan. Visit the following page:
     https://console.firebase.google.com/project/${projectId}/usage/details
2. Run ${clc.bold("firebase init dataconnect")} again to configure the Cloud SQL instance.
3. Run ${clc.bold("firebase deploy --only dataconnect")} to deploy your Data Connect service.`;
}
exports.upgradeInstructions = upgradeInstructions;
