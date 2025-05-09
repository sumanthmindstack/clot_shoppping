"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.promptForCleanupPolicyDays = exports.promptForMinInstances = exports.promptForUnsafeMigration = exports.promptForFunctionDeletion = exports.promptForFailurePolicies = void 0;
const clc = require("colorette");
const functionsDeployHelper_1 = require("./functionsDeployHelper");
const error_1 = require("../../error");
const prompt_1 = require("../../prompt");
const logger_1 = require("../../logger");
const backend = require("./backend");
const pricing = require("./pricing");
const utils = require("../../utils");
const artifacts = require("../../functions/artifacts");
async function promptForFailurePolicies(options, want, have) {
    const retryEndpoints = backend.allEndpoints(want).filter((e) => {
        return backend.isEventTriggered(e) && e.eventTrigger.retry;
    });
    if (retryEndpoints.length === 0) {
        return;
    }
    const newRetryEndpoints = retryEndpoints.filter((endpoint) => {
        var _a;
        const existing = (_a = have.endpoints[endpoint.region]) === null || _a === void 0 ? void 0 : _a[endpoint.id];
        return !(existing && backend.isEventTriggered(existing) && existing.eventTrigger.retry);
    });
    if (newRetryEndpoints.length === 0) {
        return;
    }
    const warnMessage = "The following functions will newly be retried in case of failure: " +
        clc.bold(newRetryEndpoints.sort(backend.compareFunctions).map(functionsDeployHelper_1.getFunctionLabel).join(", ")) +
        ". " +
        "Retried executions are billed as any other execution, and functions are retried repeatedly until they either successfully execute or the maximum retry period has elapsed, which can be up to 7 days. " +
        "For safety, you might want to ensure that your functions are idempotent; see https://firebase.google.com/docs/functions/retries to learn more.";
    utils.logLabeledWarning("functions", warnMessage);
    if (options.force) {
        return;
    }
    if (options.nonInteractive) {
        throw new error_1.FirebaseError("Pass the --force option to deploy functions with a failure policy", {
            exit: 1,
        });
    }
    const proceed = await (0, prompt_1.promptOnce)({
        type: "confirm",
        name: "confirm",
        default: false,
        message: "Would you like to proceed with deployment?",
    });
    if (!proceed) {
        throw new error_1.FirebaseError("Deployment canceled.", { exit: 1 });
    }
}
exports.promptForFailurePolicies = promptForFailurePolicies;
async function promptForFunctionDeletion(functionsToDelete, options) {
    let shouldDeleteFns = true;
    if (functionsToDelete.length === 0 || options.force) {
        return true;
    }
    const deleteList = functionsToDelete
        .sort(backend.compareFunctions)
        .map((fn) => "\t" + (0, functionsDeployHelper_1.getFunctionLabel)(fn))
        .join("\n");
    if (options.nonInteractive) {
        const deleteCommands = functionsToDelete
            .map((func) => {
            return "\tfirebase functions:delete " + func.id + " --region " + func.region;
        })
            .join("\n");
        throw new error_1.FirebaseError("The following functions are found in your project but do not exist in your local source code:\n" +
            deleteList +
            "\n\nAborting because deletion cannot proceed in non-interactive mode. To fix, manually delete the functions by running:\n" +
            clc.bold(deleteCommands));
    }
    else {
        logger_1.logger.info("\nThe following functions are found in your project but do not exist in your local source code:\n" +
            deleteList +
            "\n\nIf you are renaming a function or changing its region, it is recommended that you create the new " +
            "function first before deleting the old one to prevent event loss. For more info, visit " +
            clc.underline("https://firebase.google.com/docs/functions/manage-functions#modify" + "\n"));
        shouldDeleteFns = await (0, prompt_1.confirm)({
            default: false,
            message: "Would you like to proceed with deletion? Selecting no will continue the rest of the deployments.",
        });
    }
    return shouldDeleteFns;
}
exports.promptForFunctionDeletion = promptForFunctionDeletion;
async function promptForUnsafeMigration(fnsToUpdate, options) {
    const unsafeUpdates = fnsToUpdate.filter((eu) => eu.unsafe);
    if (unsafeUpdates.length === 0 || options.force) {
        return fnsToUpdate;
    }
    const warnMessage = "The following functions are unsafely changing event types: " +
        clc.bold(unsafeUpdates
            .map((eu) => eu.endpoint)
            .sort(backend.compareFunctions)
            .map(functionsDeployHelper_1.getFunctionLabel)
            .join(", ")) +
        ". " +
        "While automatic migration is allowed for these functions, updating the underlying event type may result in data loss. " +
        "To avoid this, consider the best practices outlined in the migration guide: https://firebase.google.com/docs/functions/manage-functions?gen=2nd#modify-trigger";
    utils.logLabeledWarning("functions", warnMessage);
    const safeUpdates = fnsToUpdate.filter((eu) => !eu.unsafe);
    if (options.nonInteractive) {
        utils.logLabeledWarning("functions", "Skipping updates for functions that may be unsafe to update. To update these functions anyway, deploy again in interactive mode or use the --force option.");
        return safeUpdates;
    }
    for (const eu of unsafeUpdates) {
        const shouldUpdate = await (0, prompt_1.promptOnce)({
            type: "confirm",
            name: "confirm",
            default: false,
            message: `[${(0, functionsDeployHelper_1.getFunctionLabel)(eu.endpoint)}] Would you like to proceed with the unsafe migration?`,
        });
        if (shouldUpdate) {
            safeUpdates.push(eu);
        }
    }
    return safeUpdates;
}
exports.promptForUnsafeMigration = promptForUnsafeMigration;
async function promptForMinInstances(options, want, have) {
    if (options.force) {
        return;
    }
    const increasesCost = backend.someEndpoint(want, (wantE) => {
        var _a;
        if (!pricing.canCalculateMinInstanceCost(wantE)) {
            return true;
        }
        const wantCost = pricing.monthlyMinInstanceCost([wantE]);
        const haveE = (_a = have.endpoints[wantE.region]) === null || _a === void 0 ? void 0 : _a[wantE.id];
        let haveCost;
        if (!haveE) {
            haveCost = 0;
        }
        else if (!pricing.canCalculateMinInstanceCost(wantE)) {
            return true;
        }
        else {
            haveCost = pricing.monthlyMinInstanceCost([haveE]);
        }
        return wantCost > haveCost;
    });
    if (!increasesCost) {
        return;
    }
    if (options.nonInteractive) {
        throw new error_1.FirebaseError("Pass the --force option to deploy functions that increase the minimum bill", {
            exit: 1,
        });
    }
    const functionLines = backend
        .allEndpoints(want)
        .filter((fn) => fn.minInstances)
        .sort(backend.compareFunctions)
        .map((fn) => {
        return (`\t${(0, functionsDeployHelper_1.getFunctionLabel)(fn)}: ${fn.minInstances} instances, ` +
            backend.memoryOptionDisplayName(fn.availableMemoryMb || backend.DEFAULT_MEMORY) +
            " of memory each");
    })
        .join("\n");
    let costLine;
    if (backend.someEndpoint(want, (fn) => !pricing.canCalculateMinInstanceCost(fn))) {
        costLine =
            "Cannot calculate the minimum monthly bill for this configuration. Consider running " +
                clc.bold("npm install -g firebase-tools");
    }
    else {
        const cost = pricing.monthlyMinInstanceCost(backend.allEndpoints(want)).toFixed(2);
        costLine = `With these options, your minimum bill will be $${cost} in a 30-day month`;
    }
    const warnMessage = "The following functions have reserved minimum instances. This will " +
        "reduce the frequency of cold starts but increases the minimum cost. " +
        "You will be charged for the memory allocation and a fraction of the " +
        "CPU allocation of instances while they are idle.\n\n" +
        functionLines +
        "\n\n" +
        costLine;
    utils.logLabeledWarning("functions", warnMessage);
    const proceed = await (0, prompt_1.promptOnce)({
        type: "confirm",
        name: "confirm",
        default: false,
        message: "Would you like to proceed with deployment?",
    });
    if (!proceed) {
        throw new error_1.FirebaseError("Deployment canceled.", { exit: 1 });
    }
}
exports.promptForMinInstances = promptForMinInstances;
async function promptForCleanupPolicyDays(options, locations) {
    utils.logLabeledWarning("functions", `No cleanup policy detected for repositories in ${locations.join(", ")}. ` +
        "This may result in a small monthly bill as container images accumulate over time.");
    if (options.force) {
        return artifacts.DEFAULT_CLEANUP_DAYS;
    }
    if (options.nonInteractive) {
        throw new error_1.FirebaseError(`Functions successfully deployed but could not set up cleanup policy in ` +
            `${locations.length > 1 ? "locations" : "location"} ${locations.join(", ")}. ` +
            `Pass the --force option to automatically set up a cleanup policy or ` +
            "run 'firebase functions:artifacts:setpolicy' to manually set up a cleanup policy.");
    }
    const result = await (0, prompt_1.promptOnce)({
        type: "input",
        name: "days",
        default: artifacts.DEFAULT_CLEANUP_DAYS.toString(),
        message: "How many days do you want to keep container images before they're deleted?",
        validate: (input) => {
            const days = parseInt(input);
            if (isNaN(days) || days < 0) {
                return "Please enter a non-negative number";
            }
            return true;
        },
    });
    return parseInt(result);
}
exports.promptForCleanupPolicyDays = promptForCleanupPolicyDays;
