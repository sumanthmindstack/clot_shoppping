"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const chai_1 = require("chai");
const util = require("./util");
describe("IndexNameParsing", () => {
    it("should parse an index name correctly", () => {
        const name = "/projects/myproject/databases/(default)/collectionGroups/collection/indexes/abc123/";
        (0, chai_1.expect)(util.parseIndexName(name)).to.eql({
            projectId: "myproject",
            databaseId: "(default)",
            collectionGroupId: "collection",
            indexId: "abc123",
        });
    });
    it("should parse a field name correctly", () => {
        const name = "/projects/myproject/databases/(default)/collectionGroups/collection/fields/abc123/";
        (0, chai_1.expect)(util.parseFieldName(name)).to.eql({
            projectId: "myproject",
            databaseId: "(default)",
            collectionGroupId: "collection",
            fieldPath: "abc123",
        });
    });
    it("should parse an index name from a named database correctly", () => {
        const name = "/projects/myproject/databases/named-db/collectionGroups/collection/indexes/abc123/";
        (0, chai_1.expect)(util.parseIndexName(name)).to.eql({
            projectId: "myproject",
            databaseId: "named-db",
            collectionGroupId: "collection",
            indexId: "abc123",
        });
    });
    it("should parse a field name from a named database correctly", () => {
        const name = "/projects/myproject/databases/named-db/collectionGroups/collection/fields/abc123/";
        (0, chai_1.expect)(util.parseFieldName(name)).to.eql({
            projectId: "myproject",
            databaseId: "named-db",
            collectionGroupId: "collection",
            fieldPath: "abc123",
        });
    });
});
