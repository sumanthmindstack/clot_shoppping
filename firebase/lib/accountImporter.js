"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.serialImportUsers = exports.validateUserJson = exports.validateOptions = exports.transArrayToUser = void 0;
const clc = require("colorette");
const apiv2_1 = require("./apiv2");
const api_1 = require("./api");
const logger_1 = require("./logger");
const error_1 = require("./error");
const utils = require("./utils");
const apiClient = new apiv2_1.Client({
    urlPrefix: (0, api_1.googleOrigin)(),
});
const ALLOWED_JSON_KEYS = [
    "localId",
    "email",
    "emailVerified",
    "passwordHash",
    "salt",
    "displayName",
    "photoUrl",
    "createdAt",
    "lastSignedInAt",
    "providerUserInfo",
    "phoneNumber",
    "disabled",
    "customAttributes",
];
const ALLOWED_JSON_KEYS_RENAMING = {
    lastSignedInAt: "lastLoginAt",
};
const ALLOWED_PROVIDER_USER_INFO_KEYS = ["providerId", "rawId", "email", "displayName", "photoUrl"];
const ALLOWED_PROVIDER_IDS = ["google.com", "facebook.com", "twitter.com", "github.com"];
function isValidBase64(str) {
    const expected = Buffer.from(str, "base64").toString("base64");
    if (str.length < expected.length && !str.endsWith("=")) {
        str += "=".repeat(expected.length - str.length);
    }
    return expected === str;
}
function toWebSafeBase64(data) {
    return data.replace(/\//g, "_").replace(/\+/g, "-");
}
function addProviderUserInfo(user, providerId, arr) {
    if (arr[0]) {
        user.providerUserInfo.push({
            providerId: providerId,
            rawId: arr[0],
            email: arr[1],
            displayName: arr[2],
            photoUrl: arr[3],
        });
    }
}
function genUploadAccountPostBody(projectId, accounts, hashOptions) {
    const postBody = {
        users: accounts.map((account) => {
            if (account.passwordHash) {
                account.passwordHash = toWebSafeBase64(account.passwordHash);
            }
            if (account.salt) {
                account.salt = toWebSafeBase64(account.salt);
            }
            for (const [key, value] of Object.entries(ALLOWED_JSON_KEYS_RENAMING)) {
                if (account[key]) {
                    account[value] = account[key];
                    delete account[key];
                }
            }
            return account;
        }),
    };
    if (hashOptions.hashAlgo) {
        postBody.hashAlgorithm = hashOptions.hashAlgo;
    }
    if (hashOptions.hashKey) {
        postBody.signerKey = toWebSafeBase64(hashOptions.hashKey);
    }
    if (hashOptions.saltSeparator) {
        postBody.saltSeparator = toWebSafeBase64(hashOptions.saltSeparator);
    }
    if (hashOptions.rounds) {
        postBody.rounds = hashOptions.rounds;
    }
    if (hashOptions.memCost) {
        postBody.memoryCost = hashOptions.memCost;
    }
    if (hashOptions.cpuMemCost) {
        postBody.cpuMemCost = hashOptions.cpuMemCost;
    }
    if (hashOptions.parallelization) {
        postBody.parallelization = hashOptions.parallelization;
    }
    if (hashOptions.blockSize) {
        postBody.blockSize = hashOptions.blockSize;
    }
    if (hashOptions.dkLen) {
        postBody.dkLen = hashOptions.dkLen;
    }
    if (hashOptions.passwordHashOrder) {
        postBody.passwordHashOrder = hashOptions.passwordHashOrder;
    }
    postBody.targetProjectId = projectId;
    return postBody;
}
function transArrayToUser(arr) {
    const user = {
        localId: arr[0],
        email: arr[1],
        emailVerified: arr[2] === "true",
        passwordHash: arr[3],
        salt: arr[4],
        displayName: arr[5],
        photoUrl: arr[6],
        createdAt: arr[23],
        lastLoginAt: arr[24],
        phoneNumber: arr[25],
        providerUserInfo: [],
        disabled: arr[26],
        customAttributes: arr[27],
    };
    addProviderUserInfo(user, "google.com", arr.slice(7, 11));
    addProviderUserInfo(user, "facebook.com", arr.slice(11, 15));
    addProviderUserInfo(user, "twitter.com", arr.slice(15, 19));
    addProviderUserInfo(user, "github.com", arr.slice(19, 23));
    if (user.passwordHash && !isValidBase64(user.passwordHash)) {
        return {
            error: "Password hash should be base64 encoded.",
        };
    }
    if (user.salt && !isValidBase64(user.salt)) {
        return {
            error: "Password salt should be base64 encoded.",
        };
    }
    return user;
}
exports.transArrayToUser = transArrayToUser;
function validateOptions(options) {
    const hashOptions = validateRequiredParameters(options);
    if (!hashOptions.valid) {
        return hashOptions;
    }
    const hashInputOrder = options.hashInputOrder ? options.hashInputOrder.toUpperCase() : undefined;
    if (hashInputOrder) {
        if (hashInputOrder !== "SALT_FIRST" && hashInputOrder !== "PASSWORD_FIRST") {
            throw new error_1.FirebaseError("Unknown password hash order flag");
        }
        else {
            hashOptions["passwordHashOrder"] =
                hashInputOrder === "SALT_FIRST" ? "SALT_AND_PASSWORD" : "PASSWORD_AND_SALT";
        }
    }
    return hashOptions;
}
exports.validateOptions = validateOptions;
function validateRequiredParameters(options) {
    if (!options.hashAlgo) {
        utils.logWarning("No hash algorithm specified. Password users cannot be imported.");
        return { valid: true };
    }
    const hashAlgo = options.hashAlgo.toUpperCase();
    let roundsNum;
    switch (hashAlgo) {
        case "HMAC_SHA512":
        case "HMAC_SHA256":
        case "HMAC_SHA1":
        case "HMAC_MD5":
            if (!options.hashKey || options.hashKey === "") {
                throw new error_1.FirebaseError("Must provide hash key(base64 encoded) for hash algorithm " + options.hashAlgo);
            }
            return { hashAlgo: hashAlgo, hashKey: options.hashKey, valid: true };
        case "MD5":
        case "SHA1":
        case "SHA256":
        case "SHA512":
            roundsNum = parseInt(options.rounds, 10);
            const minRounds = hashAlgo === "MD5" ? 0 : 1;
            if (isNaN(roundsNum) || roundsNum < minRounds || roundsNum > 8192) {
                throw new error_1.FirebaseError(`Must provide valid rounds(${minRounds}..8192) for hash algorithm ${options.hashAlgo}`);
            }
            return { hashAlgo: hashAlgo, rounds: options.rounds, valid: true };
        case "PBKDF_SHA1":
        case "PBKDF2_SHA256":
            roundsNum = parseInt(options.rounds, 10);
            if (isNaN(roundsNum) || roundsNum < 0 || roundsNum > 120000) {
                throw new error_1.FirebaseError("Must provide valid rounds(0..120000) for hash algorithm " + options.hashAlgo);
            }
            return { hashAlgo: hashAlgo, rounds: options.rounds, valid: true };
        case "SCRYPT":
            if (!options.hashKey || options.hashKey === "") {
                throw new error_1.FirebaseError("Must provide hash key(base64 encoded) for hash algorithm " + options.hashAlgo);
            }
            roundsNum = parseInt(options.rounds, 10);
            if (isNaN(roundsNum) || roundsNum <= 0 || roundsNum > 8) {
                throw new error_1.FirebaseError("Must provide valid rounds(1..8) for hash algorithm " + options.hashAlgo);
            }
            const memCost = parseInt(options.memCost, 10);
            if (isNaN(memCost) || memCost <= 0 || memCost > 14) {
                throw new error_1.FirebaseError("Must provide valid memory cost(1..14) for hash algorithm " + options.hashAlgo);
            }
            let saltSeparator = "";
            if (options.saltSeparator) {
                saltSeparator = options.saltSeparator;
            }
            return {
                hashAlgo: hashAlgo,
                hashKey: options.hashKey,
                saltSeparator: saltSeparator,
                rounds: options.rounds,
                memCost: options.memCost,
                valid: true,
            };
        case "BCRYPT":
            return { hashAlgo: hashAlgo, valid: true };
        case "STANDARD_SCRYPT":
            const cpuMemCost = parseInt(options.memCost, 10);
            const parallelization = parseInt(options.parallelization, 10);
            const blockSize = parseInt(options.blockSize, 10);
            const dkLen = parseInt(options.dkLen, 10);
            return {
                hashAlgo: hashAlgo,
                valid: true,
                cpuMemCost: cpuMemCost,
                parallelization: parallelization,
                blockSize: blockSize,
                dkLen: dkLen,
            };
        default:
            throw new error_1.FirebaseError("Unsupported hash algorithm " + clc.bold(options.hashAlgo));
    }
}
function validateProviderUserInfo(providerUserInfo) {
    if (!ALLOWED_PROVIDER_IDS.includes(providerUserInfo.providerId)) {
        return {
            error: JSON.stringify(providerUserInfo, null, 2) + " has unsupported providerId",
        };
    }
    const keydiff = Object.keys(providerUserInfo).filter((k) => !ALLOWED_PROVIDER_USER_INFO_KEYS.includes(k));
    if (keydiff.length) {
        return {
            error: JSON.stringify(providerUserInfo, null, 2) + " has unsupported keys: " + keydiff.join(","),
        };
    }
    return {};
}
function validateUserJson(userJson) {
    const keydiff = Object.keys(userJson).filter((k) => !ALLOWED_JSON_KEYS.includes(k));
    if (keydiff.length) {
        return {
            error: JSON.stringify(userJson, null, 2) + " has unsupported keys: " + keydiff.join(","),
        };
    }
    if (userJson.providerUserInfo) {
        for (let i = 0; i < userJson.providerUserInfo.length; i++) {
            const res = validateProviderUserInfo(userJson.providerUserInfo[i]);
            if (res.error) {
                return res;
            }
        }
    }
    const badFormat = JSON.stringify(userJson, null, 2) + " has invalid data format: ";
    if (userJson.passwordHash && !isValidBase64(userJson.passwordHash)) {
        return {
            error: badFormat + "Password hash should be base64 encoded.",
        };
    }
    if (userJson.salt && !isValidBase64(userJson.salt)) {
        return {
            error: badFormat + "Password salt should be base64 encoded.",
        };
    }
    return {};
}
exports.validateUserJson = validateUserJson;
async function sendRequest(projectId, userList, hashOptions) {
    logger_1.logger.info("Starting importing " + userList.length + " account(s).");
    const postData = genUploadAccountPostBody(projectId, userList, hashOptions);
    return apiClient
        .post("/identitytoolkit/v3/relyingparty/uploadAccount", postData, {
        skipLog: { body: true },
    })
        .then((ret) => {
        if (ret.body.error) {
            logger_1.logger.info("Encountered problems while importing accounts. Details:");
            logger_1.logger.info(ret.body.error.map((rawInfo) => {
                return {
                    account: JSON.stringify(userList[parseInt(rawInfo.index, 10)], null, 2),
                    reason: rawInfo.message,
                };
            }));
        }
        else {
            utils.logSuccess("Imported successfully.");
        }
        logger_1.logger.info();
    });
}
function serialImportUsers(projectId, hashOptions, userListArr, index) {
    return sendRequest(projectId, userListArr[index], hashOptions).then(() => {
        if (index < userListArr.length - 1) {
            return serialImportUsers(projectId, hashOptions, userListArr, index + 1);
        }
    });
}
exports.serialImportUsers = serialImportUsers;
