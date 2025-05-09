"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getServiceAccount = exports.listBuckets = exports.getBucket = exports.deleteObject = exports.uploadObject = exports.upload = exports.getDefaultBucket = void 0;
const path = require("path");
const clc = require("colorette");
const api_1 = require("../api");
const apiv2_1 = require("../apiv2");
const error_1 = require("../error");
const logger_1 = require("../logger");
const ensureApiEnabled_1 = require("../ensureApiEnabled");
async function getDefaultBucket(projectId) {
    var _a;
    await (0, ensureApiEnabled_1.ensure)(projectId, (0, api_1.firebaseStorageOrigin)(), "storage", false);
    try {
        const localAPIClient = new apiv2_1.Client({
            urlPrefix: (0, api_1.firebaseStorageOrigin)(),
            apiVersion: "v1alpha",
        });
        const response = await localAPIClient.get(`/projects/${projectId}/defaultBucket`);
        if (!((_a = response.body) === null || _a === void 0 ? void 0 : _a.bucket.name)) {
            logger_1.logger.debug("Default storage bucket is undefined.");
            throw new error_1.FirebaseError("Your project is being set up. Please wait a minute before deploying again.");
        }
        return response.body.bucket.name.split("/").pop();
    }
    catch (err) {
        if ((err === null || err === void 0 ? void 0 : err.status) === 404) {
            throw new error_1.FirebaseError(`Firebase Storage has not been set up on project '${clc.bold(projectId)}'. Go to https://console.firebase.google.com/project/${projectId}/storage and click 'Get Started' to set up Firebase Storage.`);
        }
        logger_1.logger.info("\n\nUnexpected error when fetching default storage bucket.");
        throw err;
    }
}
exports.getDefaultBucket = getDefaultBucket;
async function upload(source, uploadUrl, extraHeaders, ignoreQuotaProject) {
    const url = new URL(uploadUrl);
    const localAPIClient = new apiv2_1.Client({ urlPrefix: url.origin, auth: false });
    const res = await localAPIClient.request({
        method: "PUT",
        path: url.pathname,
        queryParams: url.searchParams,
        responseType: "xml",
        headers: Object.assign({ "content-type": "application/zip" }, extraHeaders),
        body: source.stream,
        skipLog: { resBody: true },
        ignoreQuotaProject,
    });
    return {
        generation: res.response.headers.get("x-goog-generation"),
    };
}
exports.upload = upload;
async function uploadObject(source, bucketName) {
    if (path.extname(source.file) !== ".zip") {
        throw new error_1.FirebaseError(`Expected a file name ending in .zip, got ${source.file}`);
    }
    const localAPIClient = new apiv2_1.Client({ urlPrefix: (0, api_1.storageOrigin)() });
    const location = `/${bucketName}/${path.basename(source.file)}`;
    const res = await localAPIClient.request({
        method: "PUT",
        path: location,
        headers: {
            "Content-Type": "application/zip",
            "x-goog-content-length-range": "0,123289600",
        },
        body: source.stream,
    });
    return {
        bucket: bucketName,
        object: path.basename(source.file),
        generation: res.response.headers.get("x-goog-generation"),
    };
}
exports.uploadObject = uploadObject;
function deleteObject(location) {
    const localAPIClient = new apiv2_1.Client({ urlPrefix: (0, api_1.storageOrigin)() });
    return localAPIClient.delete(location);
}
exports.deleteObject = deleteObject;
async function getBucket(bucketName) {
    try {
        const localAPIClient = new apiv2_1.Client({ urlPrefix: (0, api_1.storageOrigin)() });
        const result = await localAPIClient.get(`/storage/v1/b/${bucketName}`);
        return result.body;
    }
    catch (err) {
        logger_1.logger.debug(err);
        throw new error_1.FirebaseError("Failed to obtain the storage bucket", {
            original: err,
        });
    }
}
exports.getBucket = getBucket;
async function listBuckets(projectId) {
    try {
        const localAPIClient = new apiv2_1.Client({ urlPrefix: (0, api_1.storageOrigin)() });
        const result = await localAPIClient.get(`/storage/v1/b?project=${projectId}`);
        return result.body.items.map((bucket) => bucket.name);
    }
    catch (err) {
        logger_1.logger.debug(err);
        throw new error_1.FirebaseError("Failed to read the storage buckets", {
            original: err,
        });
    }
}
exports.listBuckets = listBuckets;
async function getServiceAccount(projectId) {
    try {
        const localAPIClient = new apiv2_1.Client({ urlPrefix: (0, api_1.storageOrigin)() });
        const response = await localAPIClient.get(`/storage/v1/projects/${projectId}/serviceAccount`);
        return response.body;
    }
    catch (err) {
        logger_1.logger.debug(err);
        throw new error_1.FirebaseError("Failed to obtain the Cloud Storage service agent", {
            original: err,
        });
    }
}
exports.getServiceAccount = getServiceAccount;
