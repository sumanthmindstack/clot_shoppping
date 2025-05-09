"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.actuate = exports.generateSdkYaml = exports.doSetup = exports.FDC_APP_FOLDER = void 0;
const yaml = require("yaml");
const clc = require("colorette");
const path = require("path");
const fsutils_1 = require("../../../fsutils");
const prompt_1 = require("../../../prompt");
const fileUtils_1 = require("../../../dataconnect/fileUtils");
const load_1 = require("../../../dataconnect/load");
const types_1 = require("../../../dataconnect/types");
const dataconnectEmulator_1 = require("../../../emulator/dataconnectEmulator");
const error_1 = require("../../../error");
const lodash_1 = require("lodash");
const utils_1 = require("../../../utils");
const auth_1 = require("../../../auth");
exports.FDC_APP_FOLDER = "_FDC_APP_FOLDER";
async function doSetup(setup, config) {
    const sdkInfo = await askQuestions(setup, config);
    await actuate(sdkInfo, config);
    (0, utils_1.logSuccess)(`If you'd like to add more generated SDKs to your app your later, run ${clc.bold("firebase init dataconnect:sdk")} again`);
}
exports.doSetup = doSetup;
async function askQuestions(setup, config) {
    var _a;
    const serviceCfgs = (0, fileUtils_1.readFirebaseJson)(config);
    const serviceInfos = await Promise.all(serviceCfgs.map((c) => (0, load_1.load)(setup.projectId || "", config, c.source)));
    const connectorChoices = serviceInfos
        .map((si) => {
        return si.connectorInfo.map((ci) => {
            return {
                name: `${si.dataConnectYaml.serviceId}/${ci.connectorYaml.connectorId}`,
                value: ci,
            };
        });
    })
        .flat();
    if (!connectorChoices.length) {
        throw new error_1.FirebaseError(`Your config has no connectors to set up SDKs for. Run ${clc.bold("firebase init dataconnect")} to set up a service and connectors.`);
    }
    let appDir = process.env[exports.FDC_APP_FOLDER] || process.cwd();
    let targetPlatform = await (0, fileUtils_1.getPlatformFromFolder)(appDir);
    if (targetPlatform === types_1.Platform.NONE && !((_a = process.env[exports.FDC_APP_FOLDER]) === null || _a === void 0 ? void 0 : _a.length)) {
        appDir = await (0, prompt_1.promptForDirectory)({
            config,
            message: "Where is your app directory? Leave blank to set up a generated SDK in your current directory.",
        });
        targetPlatform = await (0, fileUtils_1.getPlatformFromFolder)(appDir);
    }
    if (targetPlatform === types_1.Platform.NONE || targetPlatform === types_1.Platform.MULTIPLE) {
        if (targetPlatform === types_1.Platform.NONE) {
            (0, utils_1.logBullet)(`Couldn't automatically detect app your in directory ${appDir}.`);
        }
        else {
            (0, utils_1.logSuccess)(`Detected multiple app platforms in directory ${appDir}`);
        }
        const platforms = [
            { name: "iOS (Swift)", value: types_1.Platform.IOS },
            { name: "Web (JavaScript)", value: types_1.Platform.WEB },
            { name: "Android (Kotlin)", value: types_1.Platform.ANDROID },
            { name: "Flutter (Dart)", value: types_1.Platform.FLUTTER },
        ];
        targetPlatform = await (0, prompt_1.promptOnce)({
            message: "Which platform do you want to set up a generated SDK for?",
            type: "list",
            choices: platforms,
        });
    }
    else {
        (0, utils_1.logSuccess)(`Detected ${targetPlatform} app in directory ${appDir}`);
    }
    const connectorInfo = await (0, prompt_1.promptOnce)({
        message: "Which connector do you want set up a generated SDK for?",
        type: "list",
        choices: connectorChoices,
    });
    const connectorYaml = JSON.parse(JSON.stringify(connectorInfo.connectorYaml));
    const newConnectorYaml = await generateSdkYaml(targetPlatform, connectorYaml, connectorInfo.directory, appDir);
    if (targetPlatform === types_1.Platform.WEB) {
        const unusedFrameworks = fileUtils_1.SUPPORTED_FRAMEWORKS.filter((framework) => { var _a; return !((_a = newConnectorYaml.generate) === null || _a === void 0 ? void 0 : _a.javascriptSdk[framework]); });
        const hasFrameworkEnabled = unusedFrameworks.length < fileUtils_1.SUPPORTED_FRAMEWORKS.length;
        if (unusedFrameworks.length > 0) {
            const additionalFrameworks = await (0, prompt_1.prompt)(setup, [
                {
                    type: "checkbox",
                    name: "fdcFrameworks",
                    message: `Which ${hasFrameworkEnabled ? "additional " : ""}frameworks would you like to generate SDKs for? ` +
                        "Press Space to select features, then Enter to confirm your choices.",
                    choices: unusedFrameworks.map((frameworkStr) => ({
                        value: frameworkStr,
                        name: frameworkStr,
                        checked: false,
                    })),
                },
            ]);
            for (const framework of additionalFrameworks.fdcFrameworks) {
                newConnectorYaml.generate.javascriptSdk[framework] = true;
            }
        }
    }
    const connectorYamlContents = yaml.stringify(newConnectorYaml);
    connectorInfo.connectorYaml = newConnectorYaml;
    const displayIOSWarning = targetPlatform === types_1.Platform.IOS;
    return { connectorYamlContents, connectorInfo, displayIOSWarning };
}
async function generateSdkYaml(targetPlatform, connectorYaml, connectorDir, appDir) {
    if (!connectorYaml.generate) {
        connectorYaml.generate = {};
    }
    if (targetPlatform === types_1.Platform.IOS) {
        const swiftSdk = {
            outputDir: path.relative(connectorDir, path.join(appDir, `dataconnect-generated/swift`)),
            package: (0, lodash_1.upperFirst)((0, lodash_1.camelCase)(connectorYaml.connectorId)) + "Connector",
        };
        connectorYaml.generate.swiftSdk = swiftSdk;
    }
    if (targetPlatform === types_1.Platform.WEB) {
        const pkg = `${connectorYaml.connectorId}-connector`;
        const packageJsonDir = path.relative(connectorDir, appDir);
        const javascriptSdk = {
            outputDir: path.relative(connectorDir, path.join(appDir, `dataconnect-generated/js/${pkg}`)),
            package: `@firebasegen/${pkg}`,
            packageJsonDir,
        };
        const packageJson = await (0, fileUtils_1.resolvePackageJson)(appDir);
        if (packageJson) {
            const frameworksUsed = (0, fileUtils_1.getFrameworksFromPackageJson)(packageJson);
            for (const framework of frameworksUsed) {
                (0, utils_1.logBullet)(`Detected ${framework} app. Enabling ${framework} generated SDKs.`);
                javascriptSdk[framework] = true;
            }
        }
        connectorYaml.generate.javascriptSdk = javascriptSdk;
    }
    if (targetPlatform === types_1.Platform.FLUTTER) {
        const pkg = `${(0, lodash_1.snakeCase)(connectorYaml.connectorId)}_connector`;
        const dartSdk = {
            outputDir: path.relative(connectorDir, path.join(appDir, `dataconnect-generated/dart/${pkg}`)),
            package: pkg,
        };
        connectorYaml.generate.dartSdk = dartSdk;
    }
    if (targetPlatform === types_1.Platform.ANDROID) {
        const kotlinSdk = {
            outputDir: path.relative(connectorDir, path.join(appDir, `dataconnect-generated/kotlin`)),
            package: `connectors.${(0, lodash_1.snakeCase)(connectorYaml.connectorId)}`,
        };
        for (const candidateSubdir of ["app/src/main/java", "app/src/main/kotlin"]) {
            const candidateDir = path.join(appDir, candidateSubdir);
            if ((0, fsutils_1.dirExistsSync)(candidateDir)) {
                kotlinSdk.outputDir = path.relative(connectorDir, candidateDir);
            }
        }
        connectorYaml.generate.kotlinSdk = kotlinSdk;
    }
    return connectorYaml;
}
exports.generateSdkYaml = generateSdkYaml;
async function actuate(sdkInfo, config) {
    var _a, _b;
    const connectorYamlPath = `${sdkInfo.connectorInfo.directory}/connector.yaml`;
    (0, utils_1.logBullet)(`Writing your new SDK configuration to ${connectorYamlPath}`);
    await config.askWriteProjectFile(path.relative(config.projectDir, connectorYamlPath), sdkInfo.connectorYamlContents);
    const account = (0, auth_1.getGlobalDefaultAccount)();
    await dataconnectEmulator_1.DataConnectEmulator.generate({
        configDir: sdkInfo.connectorInfo.directory,
        connectorId: sdkInfo.connectorInfo.connectorYaml.connectorId,
        account,
    });
    (0, utils_1.logBullet)(`Generated SDK code for ${sdkInfo.connectorInfo.connectorYaml.connectorId}`);
    if (((_a = sdkInfo.connectorInfo.connectorYaml.generate) === null || _a === void 0 ? void 0 : _a.swiftSdk) && sdkInfo.displayIOSWarning) {
        (0, utils_1.logBullet)(clc.bold("Please follow the instructions here to add your generated sdk to your XCode project:\n\thttps://firebase.google.com/docs/data-connect/ios-sdk#set-client"));
    }
    if ((_b = sdkInfo.connectorInfo.connectorYaml.generate) === null || _b === void 0 ? void 0 : _b.javascriptSdk) {
        for (const framework of fileUtils_1.SUPPORTED_FRAMEWORKS) {
            if (sdkInfo.connectorInfo.connectorYaml.generate.javascriptSdk[framework]) {
                logInfoForFramework(framework);
            }
        }
    }
}
exports.actuate = actuate;
function logInfoForFramework(framework) {
    if (framework === "react") {
        (0, utils_1.logBullet)("Visit https://firebase.google.com/docs/data-connect/web-sdk#react for more information on how to set up React Generated SDKs for Firebase Data Connect");
    }
    else if (framework === "angular") {
        (0, utils_1.logBullet)("Run `npm i --save @angular/fire @tanstack-query-firebase/angular @tanstack/angular-query-experimental` to install angular sdk dependencies.\nVisit https://github.com/invertase/tanstack-query-firebase/tree/main/packages/angular for more information on how to set up Angular Generated SDKs for Firebase Data Connect");
    }
}
