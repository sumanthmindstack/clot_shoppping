"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getBackupSchedule = exports.listBackupSchedules = exports.getBackup = exports.listBackups = exports.deleteBackupSchedule = exports.deleteBackup = exports.updateBackupSchedule = exports.createBackupSchedule = exports.deleteDocuments = exports.deleteDocument = exports.listCollectionIds = exports.getDatabase = exports.DayOfWeek = void 0;
const api_1 = require("../api");
const apiv2_1 = require("../apiv2");
const logger_1 = require("../logger");
const proto_1 = require("./proto");
const error_1 = require("../error");
const prodOnlyClient = new apiv2_1.Client({
    auth: true,
    apiVersion: "v1",
    urlPrefix: (0, api_1.firestoreOrigin)(),
});
const emuOrProdClient = new apiv2_1.Client({
    auth: true,
    apiVersion: "v1",
    urlPrefix: (0, api_1.firestoreOriginOrEmulator)(),
});
var DayOfWeek;
(function (DayOfWeek) {
    DayOfWeek["MONDAY"] = "MONDAY";
    DayOfWeek["TUEDAY"] = "TUESDAY";
    DayOfWeek["WEDNESDAY"] = "WEDNESDAY";
    DayOfWeek["THURSDAY"] = "THURSDAY";
    DayOfWeek["FRIDAY"] = "FRIDAY";
    DayOfWeek["SATURDAY"] = "SATURDAY";
    DayOfWeek["SUNDAY"] = "SUNDAY";
})(DayOfWeek = exports.DayOfWeek || (exports.DayOfWeek = {}));
async function getDatabase(project, database, allowEmulator = false) {
    const apiClient = allowEmulator ? emuOrProdClient : prodOnlyClient;
    const url = `projects/${project}/databases/${database}`;
    try {
        const resp = await apiClient.get(url);
        return resp.body;
    }
    catch (err) {
        logger_1.logger.info(`There was an error retrieving the Firestore database. Currently, the database id is set to ${database}, make sure it exists.`);
        throw err;
    }
}
exports.getDatabase = getDatabase;
function listCollectionIds(project, allowEmulator = false) {
    const apiClient = allowEmulator ? emuOrProdClient : prodOnlyClient;
    const url = "projects/" + project + "/databases/(default)/documents:listCollectionIds";
    const data = {
        pageSize: 2147483647,
    };
    return apiClient.post(url, data).then((res) => {
        return res.body.collectionIds || [];
    });
}
exports.listCollectionIds = listCollectionIds;
async function deleteDocument(doc, allowEmulator = false) {
    const apiClient = allowEmulator ? emuOrProdClient : prodOnlyClient;
    return apiClient.delete(doc.name);
}
exports.deleteDocument = deleteDocument;
async function deleteDocuments(project, docs, allowEmulator = false) {
    const apiClient = allowEmulator ? emuOrProdClient : prodOnlyClient;
    const url = "projects/" + project + "/databases/(default)/documents:commit";
    const writes = docs.map((doc) => {
        return { delete: doc.name };
    });
    const data = { writes };
    const res = await apiClient.post(url, data, {
        retries: 10,
        retryCodes: [429, 409, 503],
        retryMaxTimeout: 20 * 1000,
    });
    return res.body.writeResults.length;
}
exports.deleteDocuments = deleteDocuments;
async function createBackupSchedule(project, databaseId, retention, dailyRecurrence, weeklyRecurrence) {
    const url = `projects/${project}/databases/${databaseId}/backupSchedules`;
    const data = {
        retention: (0, proto_1.durationFromSeconds)(retention),
        dailyRecurrence,
        weeklyRecurrence,
    };
    (0, proto_1.assertOneOf)("BackupSchedule", data, "recurrence", "dailyRecurrence", "weeklyRecurrence");
    const res = await prodOnlyClient.post(url, data);
    return res.body;
}
exports.createBackupSchedule = createBackupSchedule;
async function updateBackupSchedule(backupScheduleName, retention) {
    const data = {
        retention: (0, proto_1.durationFromSeconds)(retention),
    };
    const res = await prodOnlyClient.patch(backupScheduleName, data);
    return res.body;
}
exports.updateBackupSchedule = updateBackupSchedule;
async function deleteBackup(backupName) {
    await prodOnlyClient.delete(backupName);
}
exports.deleteBackup = deleteBackup;
async function deleteBackupSchedule(backupScheduleName) {
    await prodOnlyClient.delete(backupScheduleName);
}
exports.deleteBackupSchedule = deleteBackupSchedule;
async function listBackups(project, location) {
    const url = `/projects/${project}/locations/${location}/backups`;
    const res = await prodOnlyClient.get(url);
    return res.body;
}
exports.listBackups = listBackups;
async function getBackup(backupName) {
    const res = await prodOnlyClient.get(backupName);
    const backup = res.body;
    if (!backup) {
        throw new error_1.FirebaseError("Not found");
    }
    return backup;
}
exports.getBackup = getBackup;
async function listBackupSchedules(project, database) {
    const url = `/projects/${project}/databases/${database}/backupSchedules`;
    const res = await prodOnlyClient.get(url);
    const backupSchedules = res.body.backupSchedules;
    if (!backupSchedules) {
        return [];
    }
    return backupSchedules;
}
exports.listBackupSchedules = listBackupSchedules;
async function getBackupSchedule(backupScheduleName) {
    const res = await prodOnlyClient.get(backupScheduleName);
    const backupSchedule = res.body;
    if (!backupSchedule) {
        throw new error_1.FirebaseError("Not found");
    }
    return backupSchedule;
}
exports.getBackupSchedule = getBackupSchedule;
