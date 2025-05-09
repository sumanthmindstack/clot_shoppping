"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.addAdditionalAccount = exports.logout = exports.getAccessToken = exports.haveValidTokens = exports.isExpired = exports.loggedIn = exports.findAccountByEmail = exports.loginGithub = exports.loginGoogle = exports.setGlobalDefaultAccount = exports.setProjectAccount = exports.loginAdditionalAccount = exports.selectAccount = exports.setRefreshToken = exports.setActiveAccount = exports.getAllAccounts = exports.getAdditionalAccounts = exports.getProjectDefaultAccount = exports.getGlobalDefaultAccount = void 0;
const clc = require("colorette");
const FormData = require("form-data");
const http = require("http");
const jwt = require("jsonwebtoken");
const opn = require("open");
const portfinder = require("portfinder");
const url = require("url");
const apiv2 = require("./apiv2");
const configstore_1 = require("./configstore");
const error_1 = require("./error");
const utils = require("./utils");
const logger_1 = require("./logger");
const prompt_1 = require("./prompt");
const scopes = require("./scopes");
const defaultCredentials_1 = require("./defaultCredentials");
const uuid_1 = require("uuid");
const crypto_1 = require("crypto");
const track_1 = require("./track");
const api_1 = require("./api");
const templates_1 = require("./templates");
const requireAuth_1 = require("./requireAuth");
portfinder.setBasePort(9005);
function getGlobalDefaultAccount() {
    const user = configstore_1.configstore.get("user");
    const tokens = configstore_1.configstore.get("tokens");
    if (!user || !tokens) {
        return undefined;
    }
    return {
        user,
        tokens,
    };
}
exports.getGlobalDefaultAccount = getGlobalDefaultAccount;
function getProjectDefaultAccount(projectDir) {
    if (!projectDir) {
        return getGlobalDefaultAccount();
    }
    const activeAccounts = configstore_1.configstore.get("activeAccounts") || {};
    const email = activeAccounts[projectDir];
    if (!email) {
        return getGlobalDefaultAccount();
    }
    const allAccounts = getAllAccounts();
    return allAccounts.find((a) => a.user.email === email);
}
exports.getProjectDefaultAccount = getProjectDefaultAccount;
function getAdditionalAccounts() {
    return configstore_1.configstore.get("additionalAccounts") || [];
}
exports.getAdditionalAccounts = getAdditionalAccounts;
function getAllAccounts() {
    const res = [];
    const defaultUser = getGlobalDefaultAccount();
    if (defaultUser) {
        res.push(defaultUser);
    }
    res.push(...getAdditionalAccounts());
    return res;
}
exports.getAllAccounts = getAllAccounts;
function setActiveAccount(options, account) {
    if (account.tokens.refresh_token) {
        setRefreshToken(account.tokens.refresh_token);
    }
    options.user = account.user;
    options.tokens = account.tokens;
}
exports.setActiveAccount = setActiveAccount;
function setRefreshToken(token) {
    apiv2.setRefreshToken(token);
}
exports.setRefreshToken = setRefreshToken;
function selectAccount(account, projectRoot) {
    const defaultUser = getProjectDefaultAccount(projectRoot);
    if (!account) {
        return defaultUser;
    }
    if (!defaultUser) {
        throw new error_1.FirebaseError(`Account ${account} not found, have you run "firebase login"?`);
    }
    const matchingAccount = getAllAccounts().find((a) => a.user.email === account);
    if (matchingAccount) {
        return matchingAccount;
    }
    throw new error_1.FirebaseError(`Account ${account} not found, run "firebase login:list" to see existing accounts or "firebase login:add" to add a new one`);
}
exports.selectAccount = selectAccount;
async function loginAdditionalAccount(useLocalhost, email) {
    const result = await loginGoogle(useLocalhost, email);
    if (typeof result.user === "string") {
        throw new error_1.FirebaseError("Failed to parse auth response, see debug log.");
    }
    const resultEmail = result.user.email;
    if (email && resultEmail !== email) {
        utils.logWarning(`Chosen account ${resultEmail} does not match account hint ${email}`);
    }
    const allAccounts = getAllAccounts();
    const newAccount = {
        user: result.user,
        tokens: result.tokens,
    };
    const existingAccount = allAccounts.find((a) => a.user.email === resultEmail);
    if (existingAccount) {
        utils.logWarning(`Already logged in as ${resultEmail}.`);
        updateAccount(newAccount);
    }
    else {
        addAdditionalAccount(newAccount);
    }
    return newAccount;
}
exports.loginAdditionalAccount = loginAdditionalAccount;
function setProjectAccount(projectDir, email) {
    logger_1.logger.debug(`setProjectAccount(${projectDir}, ${email})`);
    const activeAccounts = configstore_1.configstore.get("activeAccounts") || {};
    activeAccounts[projectDir] = email;
    configstore_1.configstore.set("activeAccounts", activeAccounts);
}
exports.setProjectAccount = setProjectAccount;
function setGlobalDefaultAccount(account) {
    configstore_1.configstore.set("user", account.user);
    configstore_1.configstore.set("tokens", account.tokens);
    const additionalAccounts = getAdditionalAccounts();
    const index = additionalAccounts.findIndex((a) => a.user.email === account.user.email);
    if (index >= 0) {
        additionalAccounts.splice(index, 1);
        configstore_1.configstore.set("additionalAccounts", additionalAccounts);
    }
}
exports.setGlobalDefaultAccount = setGlobalDefaultAccount;
function open(url) {
    opn(url).catch((err) => {
        logger_1.logger.debug("Unable to open URL: " + err.stack);
    });
}
function invalidCredentialError() {
    const message = "Authentication Error: Your credentials are no longer valid. Please run " +
        clc.bold("firebase login --reauth") +
        "\n\n" +
        "For CI servers and headless environments, generate a new token with " +
        clc.bold("firebase login:ci");
    logger_1.logger.error(message);
    return new error_1.FirebaseError(message, { exit: 1 });
}
const FIFTEEN_MINUTES_IN_MS = 15 * 60 * 1000;
const SCOPES = [
    scopes.EMAIL,
    scopes.OPENID,
    scopes.CLOUD_PROJECTS_READONLY,
    scopes.FIREBASE_PLATFORM,
    scopes.CLOUD_PLATFORM,
];
const _nonce = Math.floor(Math.random() * (2 << 29) + 1).toString();
const getPort = portfinder.getPortPromise;
let lastAccessToken;
function getCallbackUrl(port) {
    if (typeof port === "undefined") {
        return "urn:ietf:wg:oauth:2.0:oob";
    }
    return `http://localhost:${port}`;
}
function queryParamString(args) {
    const tokens = [];
    for (const [key, value] of Object.entries(args)) {
        if (typeof value === "string") {
            tokens.push(key + "=" + encodeURIComponent(value));
        }
    }
    return tokens.join("&");
}
function getLoginUrl(callbackUrl, userHint) {
    return ((0, api_1.authOrigin)() +
        "/o/oauth2/auth?" +
        queryParamString({
            client_id: (0, api_1.clientId)(),
            scope: SCOPES.join(" "),
            response_type: "code",
            state: _nonce,
            redirect_uri: callbackUrl,
            login_hint: userHint,
        }));
}
async function getTokensFromAuthorizationCode(code, callbackUrl, verifier) {
    const params = {
        code: code,
        client_id: (0, api_1.clientId)(),
        client_secret: (0, api_1.clientSecret)(),
        redirect_uri: callbackUrl,
        grant_type: "authorization_code",
    };
    if (verifier) {
        params["code_verifier"] = verifier;
    }
    let res;
    try {
        const client = new apiv2.Client({ urlPrefix: (0, api_1.authOrigin)(), auth: false });
        const form = new FormData();
        for (const [k, v] of Object.entries(params)) {
            form.append(k, v);
        }
        res = await client.request({
            method: "POST",
            path: "/o/oauth2/token",
            body: form,
            headers: form.getHeaders(),
            skipLog: { body: true, queryParams: true, resBody: true },
        });
    }
    catch (err) {
        if (err instanceof Error) {
            logger_1.logger.debug("Token Fetch Error:", err.stack || "");
        }
        else {
            logger_1.logger.debug("Token Fetch Error");
        }
        throw invalidCredentialError();
    }
    if (!res.body.access_token && !res.body.refresh_token) {
        logger_1.logger.debug("Token Fetch Error:", res.status, res.body);
        throw invalidCredentialError();
    }
    lastAccessToken = Object.assign({
        expires_at: Date.now() + res.body.expires_in * 1000,
    }, res.body);
    return lastAccessToken;
}
const GITHUB_SCOPES = ["read:user", "repo", "public_repo"];
function getGithubLoginUrl(callbackUrl) {
    return ((0, api_1.githubOrigin)() +
        "/login/oauth/authorize?" +
        queryParamString({
            client_id: (0, api_1.githubClientId)(),
            state: _nonce,
            redirect_uri: callbackUrl,
            scope: GITHUB_SCOPES.join(" "),
        }));
}
async function getGithubTokensFromAuthorizationCode(code, callbackUrl) {
    const client = new apiv2.Client({ urlPrefix: (0, api_1.githubOrigin)(), auth: false });
    const data = {
        client_id: (0, api_1.githubClientId)(),
        client_secret: (0, api_1.githubClientSecret)(),
        code,
        redirect_uri: callbackUrl,
        state: _nonce,
    };
    const form = new FormData();
    for (const [k, v] of Object.entries(data)) {
        form.append(k, v);
    }
    const headers = form.getHeaders();
    headers.accept = "application/json";
    const res = await client.request({
        method: "POST",
        path: "/login/oauth/access_token",
        body: form,
        headers,
    });
    return res.body.access_token;
}
function respondHtml(req, res, statusCode, html) {
    res.writeHead(statusCode, {
        "Content-Length": html.length,
        "Content-Type": "text/html",
    });
    res.end(html);
    req.socket.destroy();
}
function urlsafeBase64(base64string) {
    return base64string.replace(/\+/g, "-").replace(/=+$/, "").replace(/\//g, "_");
}
async function loginRemotely() {
    var _a;
    const authProxyClient = new apiv2.Client({
        urlPrefix: (0, api_1.authProxyOrigin)(),
        auth: false,
    });
    const sessionId = (0, uuid_1.v4)();
    const codeVerifier = (0, crypto_1.randomBytes)(32).toString("hex");
    const codeChallenge = urlsafeBase64((0, crypto_1.createHash)("sha256").update(codeVerifier).digest("base64"));
    const attestToken = (_a = (await authProxyClient.post("/attest", {
        session_id: sessionId,
    })).body) === null || _a === void 0 ? void 0 : _a.token;
    const loginUrl = `${(0, api_1.authProxyOrigin)()}/login?code_challenge=${codeChallenge}&session=${sessionId}&attest=${attestToken}`;
    logger_1.logger.info();
    logger_1.logger.info("To sign in to the Firebase CLI:");
    logger_1.logger.info();
    logger_1.logger.info("1. Take note of your session ID:");
    logger_1.logger.info();
    logger_1.logger.info(`   ${clc.bold(sessionId.substring(0, 5).toUpperCase())}`);
    logger_1.logger.info();
    logger_1.logger.info("2. Visit the URL below on any device and follow the instructions to get your code:");
    logger_1.logger.info();
    logger_1.logger.info(`   ${loginUrl}`);
    logger_1.logger.info();
    logger_1.logger.info("3. Paste or enter the authorization code below once you have it:");
    logger_1.logger.info();
    const code = await (0, prompt_1.promptOnce)({
        type: "input",
        message: "Enter authorization code:",
    });
    try {
        const tokens = await getTokensFromAuthorizationCode(code, `${(0, api_1.authProxyOrigin)()}/complete`, codeVerifier);
        void (0, track_1.trackGA4)("login", { method: "google_remote" });
        return {
            user: jwt.decode(tokens.id_token, { json: true }),
            tokens: tokens,
            scopes: SCOPES,
        };
    }
    catch (e) {
        throw new error_1.FirebaseError("Unable to authenticate using the provided code. Please try again.");
    }
}
async function loginWithLocalhostGoogle(port, userHint) {
    const callbackUrl = getCallbackUrl(port);
    const authUrl = getLoginUrl(callbackUrl, userHint);
    const successHtml = await (0, templates_1.readTemplate)("loginSuccess.html");
    const tokens = await loginWithLocalhost(port, callbackUrl, authUrl, successHtml, getTokensFromAuthorizationCode);
    void (0, track_1.trackGA4)("login", { method: "google_localhost" });
    return {
        user: jwt.decode(tokens.id_token, { json: true }),
        tokens: tokens,
        scopes: tokens.scopes,
    };
}
async function loginWithLocalhostGitHub(port) {
    const callbackUrl = getCallbackUrl(port);
    const authUrl = getGithubLoginUrl(callbackUrl);
    const successHtml = await (0, templates_1.readTemplate)("loginSuccessGithub.html");
    const tokens = await loginWithLocalhost(port, callbackUrl, authUrl, successHtml, getGithubTokensFromAuthorizationCode);
    void (0, track_1.trackGA4)("login", { method: "github_localhost" });
    return tokens;
}
async function loginWithLocalhost(port, callbackUrl, authUrl, successHtml, getTokens) {
    return new Promise((resolve, reject) => {
        const server = http.createServer(async (req, res) => {
            const query = url.parse(`${req.url}`, true).query || {};
            const queryState = query.state;
            const queryCode = query.code;
            if (queryState !== _nonce || typeof queryCode !== "string") {
                const html = await (0, templates_1.readTemplate)("loginFailure.html");
                respondHtml(req, res, 400, html);
                reject(new error_1.FirebaseError("Unexpected error while logging in"));
                server.close();
                return;
            }
            try {
                const tokens = await getTokens(queryCode, callbackUrl);
                respondHtml(req, res, 200, successHtml);
                resolve(tokens);
            }
            catch (err) {
                const html = await (0, templates_1.readTemplate)("loginFailure.html");
                respondHtml(req, res, 400, html);
                reject(err);
            }
            server.close();
            return;
        });
        server.listen(port, () => {
            logger_1.logger.info();
            logger_1.logger.info("Visit this URL on this device to log in:");
            logger_1.logger.info(clc.bold(clc.underline(authUrl)));
            logger_1.logger.info();
            logger_1.logger.info("Waiting for authentication...");
            open(authUrl);
        });
        server.on("error", (err) => {
            reject(err);
        });
    });
}
async function loginGoogle(localhost, userHint) {
    if (localhost) {
        try {
            const port = await getPort();
            return await loginWithLocalhostGoogle(port, userHint);
        }
        catch (_a) {
            return await loginRemotely();
        }
    }
    return await loginRemotely();
}
exports.loginGoogle = loginGoogle;
async function loginGithub() {
    const port = await getPort();
    return loginWithLocalhostGitHub(port);
}
exports.loginGithub = loginGithub;
function findAccountByEmail(email) {
    return getAllAccounts().find((a) => a.user.email === email);
}
exports.findAccountByEmail = findAccountByEmail;
function loggedIn() {
    return !!lastAccessToken;
}
exports.loggedIn = loggedIn;
function isExpired(tokens) {
    const hasExpiration = (p) => !!p.expires_at;
    if (hasExpiration(tokens)) {
        return !(tokens && tokens.expires_at && tokens.expires_at > Date.now());
    }
    else {
        return !tokens;
    }
}
exports.isExpired = isExpired;
function haveValidTokens(refreshToken, authScopes) {
    var _a;
    if (!(lastAccessToken === null || lastAccessToken === void 0 ? void 0 : lastAccessToken.access_token)) {
        const tokens = configstore_1.configstore.get("tokens");
        if (refreshToken === (tokens === null || tokens === void 0 ? void 0 : tokens.refresh_token)) {
            lastAccessToken = tokens;
        }
    }
    const hasTokens = !!(lastAccessToken === null || lastAccessToken === void 0 ? void 0 : lastAccessToken.access_token);
    const oldScopesJSON = JSON.stringify(((_a = lastAccessToken === null || lastAccessToken === void 0 ? void 0 : lastAccessToken.scopes) === null || _a === void 0 ? void 0 : _a.sort()) || []);
    const newScopesJSON = JSON.stringify(authScopes.sort());
    const hasSameScopes = oldScopesJSON === newScopesJSON;
    const expired = ((lastAccessToken === null || lastAccessToken === void 0 ? void 0 : lastAccessToken.expires_at) || 0) < Date.now() + FIFTEEN_MINUTES_IN_MS;
    const valid = hasTokens && hasSameScopes && !expired;
    if (hasTokens) {
        logger_1.logger.debug(`Checked if tokens are valid: ${valid}, expires at: ${lastAccessToken === null || lastAccessToken === void 0 ? void 0 : lastAccessToken.expires_at}`);
    }
    else {
        logger_1.logger.debug("No OAuth tokens found");
    }
    return valid;
}
exports.haveValidTokens = haveValidTokens;
function deleteAccount(account) {
    const defaultAccount = getGlobalDefaultAccount();
    if (account.user.email === (defaultAccount === null || defaultAccount === void 0 ? void 0 : defaultAccount.user.email)) {
        configstore_1.configstore.delete("user");
        configstore_1.configstore.delete("tokens");
        configstore_1.configstore.delete("usage");
        configstore_1.configstore.delete("analytics-uuid");
    }
    const additionalAccounts = getAdditionalAccounts();
    const remainingAccounts = additionalAccounts.filter((a) => a.user.email !== account.user.email);
    configstore_1.configstore.set("additionalAccounts", remainingAccounts);
    const activeAccounts = configstore_1.configstore.get("activeAccounts") || {};
    for (const [projectDir, projectAccount] of Object.entries(activeAccounts)) {
        if (projectAccount === account.user.email) {
            delete activeAccounts[projectDir];
        }
    }
    configstore_1.configstore.set("activeAccounts", activeAccounts);
}
function updateAccount(account) {
    const defaultAccount = getGlobalDefaultAccount();
    if (account.user.email === (defaultAccount === null || defaultAccount === void 0 ? void 0 : defaultAccount.user.email)) {
        configstore_1.configstore.set("user", account.user);
        configstore_1.configstore.set("tokens", account.tokens);
    }
    const additionalAccounts = getAdditionalAccounts();
    const accountIndex = additionalAccounts.findIndex((a) => a.user.email === account.user.email);
    if (accountIndex >= 0) {
        additionalAccounts.splice(accountIndex, 1, account);
        configstore_1.configstore.set("additionalAccounts", additionalAccounts);
    }
}
function findAccountByRefreshToken(refreshToken) {
    return getAllAccounts().find((a) => a.tokens.refresh_token === refreshToken);
}
function logoutCurrentSession(refreshToken) {
    const account = findAccountByRefreshToken(refreshToken);
    if (!account) {
        return;
    }
    (0, defaultCredentials_1.clearCredentials)(account);
    deleteAccount(account);
}
async function refreshTokens(refreshToken, authScopes) {
    var _a, _b;
    logger_1.logger.debug("> refreshing access token with scopes:", JSON.stringify(authScopes));
    try {
        const client = new apiv2.Client({ urlPrefix: (0, api_1.googleOrigin)(), auth: false });
        const data = {
            refresh_token: refreshToken,
            client_id: (0, api_1.clientId)(),
            client_secret: (0, api_1.clientSecret)(),
            grant_type: "refresh_token",
            scope: (authScopes || []).join(" "),
        };
        const form = new FormData();
        for (const [k, v] of Object.entries(data)) {
            form.append(k, v);
        }
        const res = await client.request({
            method: "POST",
            path: "/oauth2/v3/token",
            body: form,
            headers: form.getHeaders(),
            skipLog: { body: true, queryParams: true, resBody: true },
            resolveOnHTTPError: true,
        });
        const forceReauthErrs = [
            { error: "invalid_grant", error_subtype: "invalid_rapt" },
        ];
        const matches = (a, b) => {
            return a.error === b.error && a.error_subtype === b.error_subtype;
        };
        if (forceReauthErrs.some((a) => matches(a, res.body))) {
            throw invalidCredentialError();
        }
        if (res.status === 401 || res.status === 400) {
            return { access_token: refreshToken };
        }
        if (typeof res.body.access_token !== "string") {
            throw invalidCredentialError();
        }
        lastAccessToken = Object.assign({
            expires_at: Date.now() + res.body.expires_in * 1000,
            refresh_token: refreshToken,
            scopes: authScopes,
        }, res.body);
        const account = findAccountByRefreshToken(refreshToken);
        if (account && lastAccessToken) {
            account.tokens = lastAccessToken;
            updateAccount(account);
        }
        return lastAccessToken;
    }
    catch (err) {
        if (((_b = (_a = err === null || err === void 0 ? void 0 : err.context) === null || _a === void 0 ? void 0 : _a.body) === null || _b === void 0 ? void 0 : _b.error) === "invalid_scope") {
            throw new error_1.FirebaseError("This command requires new authorization scopes not granted to your current session. Please run " +
                clc.bold("firebase login --reauth") +
                "\n\n" +
                "For CI servers and headless environments, generate a new token with " +
                clc.bold("firebase login:ci"), { exit: 1 });
        }
        throw invalidCredentialError();
    }
}
async function getAccessToken(refreshToken, authScopes) {
    if (haveValidTokens(refreshToken, authScopes) && lastAccessToken) {
        return lastAccessToken;
    }
    if (refreshToken) {
        return refreshTokens(refreshToken, authScopes);
    }
    else {
        try {
            return (0, requireAuth_1.refreshAuth)();
        }
        catch (err) {
            logger_1.logger.debug(`Unable to refresh token: ${(0, error_1.getErrMsg)(err)}`);
        }
        throw new error_1.FirebaseError("Unable to getAccessToken");
    }
}
exports.getAccessToken = getAccessToken;
async function logout(refreshToken) {
    if ((lastAccessToken === null || lastAccessToken === void 0 ? void 0 : lastAccessToken.refresh_token) === refreshToken) {
        lastAccessToken = undefined;
    }
    logoutCurrentSession(refreshToken);
    try {
        const client = new apiv2.Client({ urlPrefix: (0, api_1.authOrigin)(), auth: false });
        await client.get("/o/oauth2/revoke", { queryParams: { token: refreshToken } });
    }
    catch (thrown) {
        const err = thrown instanceof Error ? thrown : new Error(thrown);
        throw new error_1.FirebaseError("Authentication Error.", {
            exit: 1,
            original: err,
        });
    }
}
exports.logout = logout;
function addAdditionalAccount(account) {
    const additionalAccounts = getAdditionalAccounts();
    additionalAccounts.push(account);
    configstore_1.configstore.set("additionalAccounts", additionalAccounts);
}
exports.addAdditionalAccount = addAdditionalAccount;
