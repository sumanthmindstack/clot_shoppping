"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Config = void 0;
const _ = require("lodash");
const clc = require("colorette");
const fs = require("fs-extra");
const path = require("path");
const cjson = require("cjson");
const detectProjectRoot_1 = require("./detectProjectRoot");
const error_1 = require("./error");
const fsutils = require("./fsutils");
const prompt_1 = require("./prompt");
const projectPath_1 = require("./projectPath");
const utils = require("./utils");
const firebaseConfigValidate_1 = require("./firebaseConfigValidate");
const logger_1 = require("./logger");
const loadCJSON_1 = require("./loadCJSON");
const parseBoltRules = require("./parseBoltRules");
class Config {
    constructor(src, options = {}) {
        var _a, _b;
        this.data = {};
        this.defaults = {};
        this.notes = {};
        this.options = options;
        this.projectDir = this.options.projectDir || (0, detectProjectRoot_1.detectProjectRoot)(this.options);
        this._src = src;
        if (this._src.firebase) {
            this.defaults.project = this._src.firebase;
            utils.logWarning(clc.bold('"firebase"') +
                " key in firebase.json is deprecated. Run " +
                clc.bold("firebase use --add") +
                " instead");
        }
        if ((_a = this._src) === null || _a === void 0 ? void 0 : _a.rules) {
            this._src.database = Object.assign(Object.assign({}, this._src.database), { rules: this._src.rules });
        }
        Config.MATERIALIZE_TARGETS.forEach((target) => {
            if (_.get(this._src, target)) {
                _.set(this.data, target, this.materialize(target));
            }
        });
        if (this.get("functions")) {
            if (this.projectDir && fsutils.dirExistsSync(this.path(Config.DEFAULT_FUNCTIONS_SOURCE))) {
                if (Array.isArray(this.get("functions"))) {
                    if (!this.get("functions.[0].source")) {
                        this.set("functions.[0].source", Config.DEFAULT_FUNCTIONS_SOURCE);
                    }
                }
                else {
                    if (!this.get("functions.source")) {
                        this.set("functions.source", Config.DEFAULT_FUNCTIONS_SOURCE);
                    }
                }
            }
        }
        if (((_b = this._src.dataconnect) === null || _b === void 0 ? void 0 : _b.location) ||
            (Array.isArray(this._src.dataconnect) && this._src.dataconnect.some((c) => c === null || c === void 0 ? void 0 : c.location))) {
            utils.logLabeledWarning("dataconnect", "'location' has been moved from 'firebase.json' to 'dataconnect.yaml'. " +
                "Please remove 'dataconnect.location' from 'firebase.json' and add it as top level field to 'dataconnect.yaml' instead ");
        }
    }
    materialize(target) {
        const val = _.get(this._src, target);
        if (typeof val === "string") {
            let out = this.parseFile(target, val);
            const segments = target.split(".");
            const lastSegment = segments[segments.length - 1];
            if (Object.keys(out).length === 1 && out[lastSegment]) {
                out = out[lastSegment];
            }
            return out;
        }
        else if (val !== null && typeof val === "object") {
            return val;
        }
        throw new error_1.FirebaseError('Parse Error: "' + target + '" must be object or import path', {
            exit: 1,
        });
    }
    parseFile(target, filePath) {
        const fullPath = (0, projectPath_1.resolveProjectPath)(this.options, filePath);
        const ext = path.extname(filePath);
        if (!fsutils.fileExistsSync(fullPath)) {
            throw new error_1.FirebaseError("Parse Error: Imported file " + filePath + " does not exist", {
                exit: 1,
            });
        }
        switch (ext) {
            case ".json":
                if (target === "database") {
                    this.notes.databaseRules = "json";
                }
                else if (target === "database.rules") {
                    this.notes.databaseRulesFile = filePath;
                    try {
                        return fs.readFileSync(fullPath, "utf8");
                    }
                    catch (e) {
                        if (e.code === "ENOENT") {
                            throw new error_1.FirebaseError(`File not found: ${fullPath}`, { original: e });
                        }
                        throw e;
                    }
                }
                return (0, loadCJSON_1.loadCJSON)(fullPath);
            case ".bolt":
                if (target === "database") {
                    this.notes.databaseRules = "bolt";
                }
                return parseBoltRules(fullPath);
            default:
                throw new error_1.FirebaseError("Parse Error: " + filePath + " is not of a supported config file type", { exit: 1 });
        }
    }
    get src() {
        return this._src;
    }
    get(key, fallback) {
        return _.get(this.data, key, fallback);
    }
    set(key, value) {
        _.set(this._src, key, value);
        return _.set(this.data, key, value);
    }
    has(key) {
        return _.has(this.data, key);
    }
    path(pathName) {
        if (path.isAbsolute(pathName)) {
            return pathName;
        }
        const outPath = path.normalize(path.join(this.projectDir, pathName));
        if (path.relative(this.projectDir, outPath).includes("..")) {
            throw new error_1.FirebaseError(clc.bold(pathName) + " is outside of project directory", { exit: 1 });
        }
        return outPath;
    }
    readProjectFile(p, options = {}) {
        options = options || {};
        try {
            const content = fs.readFileSync(this.path(p), "utf8");
            if (options.json) {
                return JSON.parse(content);
            }
            return content;
        }
        catch (e) {
            if (options.fallback) {
                return options.fallback;
            }
            if (e.code === "ENOENT") {
                throw new error_1.FirebaseError(`File not found: ${this.path(p)}`, { original: e });
            }
            throw e;
        }
    }
    writeProjectFile(p, content) {
        if (typeof content !== "string") {
            content = JSON.stringify(content, null, 2) + "\n";
        }
        fs.ensureFileSync(this.path(p));
        fs.writeFileSync(this.path(p), content, "utf8");
    }
    projectFileExists(p) {
        return fs.existsSync(this.path(p));
    }
    deleteProjectFile(p) {
        fs.removeSync(this.path(p));
    }
    async askWriteProjectFile(path, content, force, confirmByDefault) {
        const writeTo = this.path(path);
        let next = true;
        if (typeof content !== "string") {
            content = JSON.stringify(content, null, 2) + "\n";
        }
        let existingContent;
        if (fsutils.fileExistsSync(writeTo)) {
            existingContent = fsutils.readFile(writeTo);
        }
        if (existingContent && existingContent !== content && !force) {
            next = await (0, prompt_1.promptOnce)({
                type: "confirm",
                message: "File " + clc.underline(path) + " already exists. Overwrite?",
                default: !!confirmByDefault,
            });
        }
        if (existingContent === content) {
            utils.logBullet(clc.bold(path) + " is unchanged");
        }
        else if (next) {
            this.writeProjectFile(path, content);
            utils.logSuccess("Wrote " + clc.bold(path));
        }
        else {
            utils.logBullet("Skipping write of " + clc.bold(path));
        }
    }
    static load(options, allowMissing) {
        const pd = (0, detectProjectRoot_1.detectProjectRoot)(options);
        const filename = options.configPath || Config.FILENAME;
        if (pd) {
            try {
                const filePath = path.resolve(pd, path.basename(filename));
                const data = cjson.load(filePath);
                const validator = (0, firebaseConfigValidate_1.getValidator)();
                const valid = validator(data);
                if (!valid && validator.errors) {
                    for (const e of validator.errors) {
                        logger_1.logger.debug((0, firebaseConfigValidate_1.getErrorMessage)(e));
                    }
                }
                return new Config(data, options);
            }
            catch (e) {
                throw new error_1.FirebaseError(`There was an error loading ${filename}:\n\n` + e.message, {
                    exit: 1,
                });
            }
        }
        if (allowMissing) {
            return null;
        }
        throw new error_1.FirebaseError("Not in a Firebase app directory (could not locate firebase.json)", {
            exit: 1,
            status: 404,
        });
    }
}
exports.Config = Config;
Config.DEFAULT_FUNCTIONS_SOURCE = "functions";
Config.FILENAME = "firebase.json";
Config.MATERIALIZE_TARGETS = [
    "database",
    "emulators",
    "extensions",
    "firestore",
    "functions",
    "hosting",
    "storage",
    "remoteconfig",
    "dataconnect",
];
