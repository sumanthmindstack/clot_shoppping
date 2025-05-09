"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.isIncomaptibleArchError = exports.start = exports.downloadIfNecessary = exports.stop = exports.getPID = exports.get = exports.getDownloadDetails = exports.requiresJava = exports.handleEmulatorProcessError = exports._getCommand = exports.getLogFileName = exports.DownloadDetails = void 0;
const lsofi = require("lsofi");
const types_1 = require("./types");
const constants_1 = require("./constants");
const error_1 = require("../error");
const childProcess = require("child_process");
const utils = require("../utils");
const emulatorLogger_1 = require("./emulatorLogger");
const clc = require("colorette");
const fs = require("fs-extra");
const path = require("path");
const os = require("os");
const registry_1 = require("./registry");
const download_1 = require("../emulator/download");
const experiments = require("../experiments");
const process = require("process");
const EMULATOR_INSTANCE_KILL_TIMEOUT = 4000;
const CACHE_DIR = process.env.FIREBASE_EMULATORS_PATH || path.join(os.homedir(), ".cache", "firebase", "emulators");
const EMULATOR_UPDATE_DETAILS = {
    database: {
        version: "4.11.2",
        expectedSize: 34495935,
        expectedChecksum: "2fd771101c0e1f7898c04c9204f2ce63",
    },
    firestore: {
        version: "1.19.8",
        expectedSize: 63634791,
        expectedChecksum: "9b43a6daa590678de9b7df6d68260395",
    },
    storage: {
        version: "1.1.3",
        expectedSize: 52892936,
        expectedChecksum: "2ca11ec1193003bea89f806cc085fa25",
    },
    ui: experiments.isEnabled("emulatoruisnapshot")
        ? { version: "SNAPSHOT", expectedSize: -1, expectedChecksum: "" }
        : {
            version: "1.14.0",
            expectedSize: 3615311,
            expectedChecksum: "30763ff4a8b81e2c482f05b56799b5c0",
        },
    pubsub: {
        version: "0.8.14",
        expectedSize: 66786933,
        expectedChecksum: "a9025b3e53fdeafd2969ccb3ba1e1d38",
    },
    dataconnect: process.platform === "darwin"
        ? {
            version: "2.1.0",
            expectedSize: 26440448,
            expectedChecksum: "92f70b6815e1f9e46facc241728b7255",
        }
        : process.platform === "win32"
            ? {
                version: "2.1.0",
                expectedSize: 26884096,
                expectedChecksum: "14964736145cc67764574a01e193b997",
            }
            : {
                version: "2.1.0",
                expectedSize: 26357912,
                expectedChecksum: "0afb18767e56be16331be2b2b6d09ea1",
            },
};
exports.DownloadDetails = {
    database: {
        downloadPath: path.join(CACHE_DIR, `firebase-database-emulator-v${EMULATOR_UPDATE_DETAILS.database.version}.jar`),
        version: EMULATOR_UPDATE_DETAILS.database.version,
        opts: {
            cacheDir: CACHE_DIR,
            remoteUrl: `https://storage.googleapis.com/firebase-preview-drop/emulator/firebase-database-emulator-v${EMULATOR_UPDATE_DETAILS.database.version}.jar`,
            expectedSize: EMULATOR_UPDATE_DETAILS.database.expectedSize,
            expectedChecksum: EMULATOR_UPDATE_DETAILS.database.expectedChecksum,
            namePrefix: "firebase-database-emulator",
        },
    },
    firestore: {
        downloadPath: path.join(CACHE_DIR, `cloud-firestore-emulator-v${EMULATOR_UPDATE_DETAILS.firestore.version}.jar`),
        version: EMULATOR_UPDATE_DETAILS.firestore.version,
        opts: {
            cacheDir: CACHE_DIR,
            remoteUrl: `https://storage.googleapis.com/firebase-preview-drop/emulator/cloud-firestore-emulator-v${EMULATOR_UPDATE_DETAILS.firestore.version}.jar`,
            expectedSize: EMULATOR_UPDATE_DETAILS.firestore.expectedSize,
            expectedChecksum: EMULATOR_UPDATE_DETAILS.firestore.expectedChecksum,
            namePrefix: "cloud-firestore-emulator",
        },
    },
    storage: {
        downloadPath: path.join(CACHE_DIR, `cloud-storage-rules-runtime-v${EMULATOR_UPDATE_DETAILS.storage.version}.jar`),
        version: EMULATOR_UPDATE_DETAILS.storage.version,
        opts: {
            cacheDir: CACHE_DIR,
            remoteUrl: `https://storage.googleapis.com/firebase-preview-drop/emulator/cloud-storage-rules-runtime-v${EMULATOR_UPDATE_DETAILS.storage.version}.jar`,
            expectedSize: EMULATOR_UPDATE_DETAILS.storage.expectedSize,
            expectedChecksum: EMULATOR_UPDATE_DETAILS.storage.expectedChecksum,
            namePrefix: "cloud-storage-rules-emulator",
        },
    },
    ui: {
        version: EMULATOR_UPDATE_DETAILS.ui.version,
        downloadPath: path.join(CACHE_DIR, `ui-v${EMULATOR_UPDATE_DETAILS.ui.version}.zip`),
        unzipDir: path.join(CACHE_DIR, `ui-v${EMULATOR_UPDATE_DETAILS.ui.version}`),
        binaryPath: path.join(CACHE_DIR, `ui-v${EMULATOR_UPDATE_DETAILS.ui.version}`, "server", "server.mjs"),
        opts: {
            cacheDir: CACHE_DIR,
            remoteUrl: `https://storage.googleapis.com/firebase-preview-drop/emulator/ui-v${EMULATOR_UPDATE_DETAILS.ui.version}.zip`,
            expectedSize: EMULATOR_UPDATE_DETAILS.ui.expectedSize,
            expectedChecksum: EMULATOR_UPDATE_DETAILS.ui.expectedChecksum,
            skipCache: experiments.isEnabled("emulatoruisnapshot"),
            skipChecksumAndSize: experiments.isEnabled("emulatoruisnapshot"),
            namePrefix: "ui",
        },
    },
    pubsub: {
        downloadPath: path.join(CACHE_DIR, `pubsub-emulator-${EMULATOR_UPDATE_DETAILS.pubsub.version}.zip`),
        version: EMULATOR_UPDATE_DETAILS.pubsub.version,
        unzipDir: path.join(CACHE_DIR, `pubsub-emulator-${EMULATOR_UPDATE_DETAILS.pubsub.version}`),
        binaryPath: path.join(CACHE_DIR, `pubsub-emulator-${EMULATOR_UPDATE_DETAILS.pubsub.version}`, `pubsub-emulator/bin/cloud-pubsub-emulator${process.platform === "win32" ? ".bat" : ""}`),
        opts: {
            cacheDir: CACHE_DIR,
            remoteUrl: `https://storage.googleapis.com/firebase-preview-drop/emulator/pubsub-emulator-${EMULATOR_UPDATE_DETAILS.pubsub.version}.zip`,
            expectedSize: EMULATOR_UPDATE_DETAILS.pubsub.expectedSize,
            expectedChecksum: EMULATOR_UPDATE_DETAILS.pubsub.expectedChecksum,
            namePrefix: "pubsub-emulator",
        },
    },
    dataconnect: {
        downloadPath: path.join(CACHE_DIR, `dataconnect-emulator-${EMULATOR_UPDATE_DETAILS.dataconnect.version}${process.platform === "win32" ? ".exe" : ""}`),
        version: EMULATOR_UPDATE_DETAILS.dataconnect.version,
        binaryPath: path.join(CACHE_DIR, `dataconnect-emulator-${EMULATOR_UPDATE_DETAILS.dataconnect.version}${process.platform === "win32" ? ".exe" : ""}`),
        opts: {
            cacheDir: CACHE_DIR,
            remoteUrl: process.platform === "darwin"
                ? `https://storage.googleapis.com/firemat-preview-drop/emulator/dataconnect-emulator-macos-v${EMULATOR_UPDATE_DETAILS.dataconnect.version}`
                : process.platform === "win32"
                    ? `https://storage.googleapis.com/firemat-preview-drop/emulator/dataconnect-emulator-windows-v${EMULATOR_UPDATE_DETAILS.dataconnect.version}`
                    : `https://storage.googleapis.com/firemat-preview-drop/emulator/dataconnect-emulator-linux-v${EMULATOR_UPDATE_DETAILS.dataconnect.version}`,
            expectedSize: EMULATOR_UPDATE_DETAILS.dataconnect.expectedSize,
            expectedChecksum: EMULATOR_UPDATE_DETAILS.dataconnect.expectedChecksum,
            skipChecksumAndSize: false,
            namePrefix: "dataconnect-emulator",
            auth: false,
        },
    },
};
const EmulatorDetails = {
    database: {
        name: types_1.Emulators.DATABASE,
        instance: null,
        stdout: null,
    },
    firestore: {
        name: types_1.Emulators.FIRESTORE,
        instance: null,
        stdout: null,
    },
    storage: {
        name: types_1.Emulators.STORAGE,
        instance: null,
        stdout: null,
    },
    pubsub: {
        name: types_1.Emulators.PUBSUB,
        instance: null,
        stdout: null,
    },
    ui: {
        name: types_1.Emulators.UI,
        instance: null,
        stdout: null,
    },
    dataconnect: {
        name: types_1.Emulators.DATACONNECT,
        instance: null,
        stdout: null,
    },
};
const Commands = {
    database: {
        binary: "java",
        args: ["-Duser.language=en", "-jar", getExecPath(types_1.Emulators.DATABASE)],
        optionalArgs: [
            "port",
            "host",
            "functions_emulator_port",
            "functions_emulator_host",
            "single_project_mode",
        ],
        joinArgs: false,
        shell: false,
    },
    firestore: {
        binary: "java",
        args: [
            "-Dgoogle.cloud_firestore.debug_log_level=FINE",
            "-Duser.language=en",
            "-jar",
            getExecPath(types_1.Emulators.FIRESTORE),
        ],
        optionalArgs: [
            "port",
            "webchannel_port",
            "host",
            "rules",
            "websocket_port",
            "functions_emulator",
            "seed_from_export",
            "project_id",
            "single_project_mode",
        ],
        joinArgs: false,
        shell: false,
    },
    storage: {
        binary: "java",
        args: [
            "-Duser.language=en",
            "-jar",
            getExecPath(types_1.Emulators.STORAGE),
            "serve",
        ],
        optionalArgs: [],
        joinArgs: false,
        shell: false,
    },
    pubsub: {
        binary: `${getExecPath(types_1.Emulators.PUBSUB)}`,
        args: [],
        optionalArgs: ["port", "host"],
        joinArgs: true,
        shell: true,
    },
    ui: {
        binary: "",
        args: [],
        optionalArgs: [],
        joinArgs: false,
        shell: false,
    },
    dataconnect: {
        binary: `${getExecPath(types_1.Emulators.DATACONNECT)}`,
        args: ["--logtostderr", "-v=2", "dev"],
        optionalArgs: [
            "listen",
            "config_dir",
            "enable_output_schema_extensions",
            "enable_output_generated_sdk",
        ],
        joinArgs: true,
        shell: false,
    },
};
function getExecPath(name) {
    const details = getDownloadDetails(name);
    return details.binaryPath || details.downloadPath;
}
function getLogFileName(name) {
    return `${name}-debug.log`;
}
exports.getLogFileName = getLogFileName;
function _getCommand(emulator, args) {
    const baseCmd = Commands[emulator];
    const defaultPort = constants_1.Constants.getDefaultPort(emulator);
    if (!args.port) {
        args.port = defaultPort;
    }
    const cmdLineArgs = baseCmd.args.slice();
    if (baseCmd.binary === "java" &&
        utils.isRunningInWSL() &&
        (!args.host || !args.host.includes(":"))) {
        cmdLineArgs.unshift("-Djava.net.preferIPv4Stack=true");
    }
    const logger = emulatorLogger_1.EmulatorLogger.forEmulator(emulator);
    Object.keys(args).forEach((key) => {
        if (!baseCmd.optionalArgs.includes(key)) {
            logger.log("DEBUG", `Ignoring unsupported arg: ${key}`);
            return;
        }
        const argKey = "--" + key;
        const argVal = args[key];
        if (argVal === undefined) {
            logger.log("DEBUG", `Ignoring empty arg for key: ${key}`);
            return;
        }
        if (baseCmd.joinArgs) {
            cmdLineArgs.push(`${argKey}=${argVal}`);
        }
        else {
            cmdLineArgs.push(argKey, argVal);
        }
    });
    return {
        binary: baseCmd.binary,
        args: cmdLineArgs,
        optionalArgs: baseCmd.optionalArgs,
        joinArgs: baseCmd.joinArgs,
        shell: baseCmd.shell,
        port: args.port,
    };
}
exports._getCommand = _getCommand;
async function _fatal(emulator, errorMsg) {
    try {
        const logger = emulatorLogger_1.EmulatorLogger.forEmulator(emulator);
        logger.logLabeled("WARN", emulator, `Fatal error occurred: \n   ${errorMsg}, \n   stopping all running emulators`);
        await registry_1.EmulatorRegistry.stopAll();
    }
    finally {
        process.exit(1);
    }
}
async function handleEmulatorProcessError(emulator, err, port) {
    const description = constants_1.Constants.description(emulator);
    if (err.path === "java" && err.code === "ENOENT") {
        await _fatal(emulator, `${description} has exited because java is not installed, you can install it from https://openjdk.java.net/install/`);
    }
    else if (err.code === "EADDRINUSE") {
        const ps = port ? await lsofi(port) : false;
        await _fatal(emulator, `${description} has exited because its configured port is already in use${ps ? ` by process number ${ps}` : ""}. Are you running another copy of the emulator suite?`);
    }
    else {
        await _fatal(emulator, `${description} has exited: ${err}`);
    }
}
exports.handleEmulatorProcessError = handleEmulatorProcessError;
function requiresJava(emulator) {
    if (emulator in Commands) {
        return Commands[emulator].binary === "java";
    }
    return false;
}
exports.requiresJava = requiresJava;
async function _runBinary(emulator, command, extraEnv) {
    return new Promise((resolve) => {
        var _a, _b;
        const logger = emulatorLogger_1.EmulatorLogger.forEmulator(emulator.name);
        emulator.stdout = fs.createWriteStream(getLogFileName(emulator.name));
        try {
            const opts = {
                env: Object.assign(Object.assign({}, process.env), extraEnv),
                detached: true,
                stdio: ["inherit", "pipe", "pipe"],
            };
            if (command.shell && utils.IS_WINDOWS) {
                opts.shell = true;
                if (command.binary.includes(" ")) {
                    command.binary = `"${command.binary}"`;
                }
            }
            emulator.instance = childProcess.spawn(command.binary, command.args, opts);
        }
        catch (e) {
            if (e.code === "EACCES") {
                logger.logLabeled("WARN", emulator.name, `Could not spawn child process for emulator, check that java is installed and on your $PATH.`);
            }
            else if (isIncomaptibleArchError(e)) {
                logger.logLabeled("WARN", emulator.name, `Unknown system error when starting emulator binary. ` +
                    `You may be able to fix this by installing Rosetta: ` +
                    `softwareupdate --install-rosetta`);
            }
            _fatal(emulator.name, e);
        }
        const description = constants_1.Constants.description(emulator.name);
        if (emulator.instance == null) {
            logger.logLabeled("WARN", emulator.name, `Could not spawn child process for ${description}.`);
            return;
        }
        logger.logLabeled("BULLET", emulator.name, `${description} logging to ${clc.bold(getLogFileName(emulator.name))}`);
        (_a = emulator.instance.stdout) === null || _a === void 0 ? void 0 : _a.on("data", (data) => {
            logger.log("DEBUG", data.toString());
            emulator.stdout.write(data);
        });
        (_b = emulator.instance.stderr) === null || _b === void 0 ? void 0 : _b.on("data", (data) => {
            logger.log("DEBUG", data.toString());
            emulator.stdout.write(data);
            if (data.toString().includes("java.lang.UnsupportedClassVersionError")) {
                logger.logLabeled("WARN", emulator.name, "Unsupported java version, make sure java --version reports 1.8 or higher.");
            }
            if (data.toString().includes("address already in use")) {
                const message = `${description} has exited because its configured port ${command.port} is already in use. Are you running another copy of the emulator suite?`;
                logger.logLabeled("ERROR", emulator.name, message);
            }
        });
        emulator.instance.on("error", (err) => {
            void handleEmulatorProcessError(emulator.name, err, command.port);
        });
        emulator.instance.once("exit", async (code, signal) => {
            if (signal) {
                utils.logWarning(`${description} has exited upon receiving signal: ${signal}`);
            }
            else if (code && code !== 0 && code !== 130) {
                await _fatal(emulator.name, `${description} has exited with code: ${code}`);
            }
        });
        resolve();
    });
}
function getDownloadDetails(emulator) {
    const details = exports.DownloadDetails[emulator];
    const pathOverride = process.env[`${emulator.toUpperCase()}_EMULATOR_BINARY_PATH`];
    if (pathOverride) {
        const logger = emulatorLogger_1.EmulatorLogger.forEmulator(emulator);
        logger.logLabeled("WARN", emulator, `Env variable override detected. Using ${emulator} emulator at ${pathOverride}`);
        details.downloadPath = pathOverride;
        details.binaryPath = pathOverride;
        details.localOnly = true;
        fs.chmodSync(pathOverride, 0o755);
    }
    return details;
}
exports.getDownloadDetails = getDownloadDetails;
function get(emulator) {
    return EmulatorDetails[emulator];
}
exports.get = get;
function getPID(emulator) {
    const emulatorInstance = get(emulator).instance;
    return emulatorInstance && emulatorInstance.pid ? emulatorInstance.pid : 0;
}
exports.getPID = getPID;
async function stop(targetName) {
    const emulator = get(targetName);
    return new Promise((resolve, reject) => {
        const logger = emulatorLogger_1.EmulatorLogger.forEmulator(emulator.name);
        if (emulator.instance && emulator.instance.kill(0)) {
            const killTimeout = setTimeout(() => {
                const pid = emulator.instance ? emulator.instance.pid : -1;
                const errorMsg = constants_1.Constants.description(emulator.name) + ": Unable to terminate process (PID=" + pid + ")";
                logger.log("DEBUG", errorMsg);
                reject(new error_1.FirebaseError(emulator.name + ": " + errorMsg));
            }, EMULATOR_INSTANCE_KILL_TIMEOUT);
            emulator.instance.once("exit", () => {
                clearTimeout(killTimeout);
                resolve();
            });
            emulator.instance.kill("SIGINT");
        }
        else {
            resolve();
        }
    });
}
exports.stop = stop;
async function downloadIfNecessary(targetName) {
    const hasEmulator = fs.existsSync(getExecPath(targetName));
    if (!hasEmulator) {
        await (0, download_1.downloadEmulator)(targetName);
    }
    return Commands[targetName];
}
exports.downloadIfNecessary = downloadIfNecessary;
async function start(targetName, args, extraEnv = {}) {
    const downloadDetails = getDownloadDetails(targetName);
    const emulator = get(targetName);
    const hasEmulator = fs.existsSync(getExecPath(targetName));
    const logger = emulatorLogger_1.EmulatorLogger.forEmulator(targetName);
    if (!hasEmulator || downloadDetails.opts.skipCache) {
        if (args.auto_download) {
            if (process.env.CI) {
                utils.logWarning(`It appears you are running in a CI environment. You can avoid downloading the ${constants_1.Constants.description(targetName)} repeatedly by caching the ${downloadDetails.opts.cacheDir} directory.`);
            }
            await (0, download_1.downloadEmulator)(targetName);
        }
        else {
            utils.logWarning("Setup required, please run: firebase setup:emulators:" + targetName);
            throw new error_1.FirebaseError("emulator not found");
        }
    }
    const command = _getCommand(targetName, args);
    logger.log("DEBUG", `Starting ${constants_1.Constants.description(targetName)} with command ${JSON.stringify(command)}`);
    return _runBinary(emulator, command, extraEnv);
}
exports.start = start;
function isIncomaptibleArchError(err) {
    var _a;
    return ((0, error_1.hasMessage)(err) &&
        /Unknown system error/.test((_a = err.message) !== null && _a !== void 0 ? _a : "") &&
        process.platform === "darwin");
}
exports.isIncomaptibleArchError = isIncomaptibleArchError;
