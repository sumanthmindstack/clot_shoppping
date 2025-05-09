"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.registerHandlers = void 0;
const url_1 = require("url");
const operations_1 = require("./operations");
const errors_1 = require("./errors");
const widget_ui_1 = require("./widget_ui");
function registerHandlers(app, getProjectStateByApiKey) {
    app.get(`/emulator/action`, (req, res) => {
        const { mode, oobCode, continueUrl, apiKey, tenantId } = req.query;
        if (!apiKey) {
            return res.status(400).json({
                authEmulator: {
                    error: "missing apiKey query parameter",
                    instructions: `Please modify the URL to specify an apiKey, such as ...&apiKey=YOUR_API_KEY`,
                },
            });
        }
        if (!oobCode) {
            return res.status(400).json({
                authEmulator: {
                    error: "missing oobCode query parameter",
                    instructions: `Please modify the URL to specify an oobCode, such as ...&oobCode=YOUR_OOB_CODE`,
                },
            });
        }
        const state = getProjectStateByApiKey(apiKey, tenantId);
        switch (mode) {
            case "recoverEmail": {
                const oob = state.validateOobCode(oobCode);
                const RETRY_INSTRUCTIONS = "If you're trying to test the reverting email flow, try changing the email again to generate a new link.";
                if ((oob === null || oob === void 0 ? void 0 : oob.requestType) !== "RECOVER_EMAIL") {
                    return res.status(400).json({
                        authEmulator: {
                            error: `Requested mode does not match the OOB code provided.`,
                            instructions: RETRY_INSTRUCTIONS,
                        },
                    });
                }
                try {
                    const resp = (0, operations_1.setAccountInfoImpl)(state, {
                        oobCode,
                    });
                    const email = resp.email;
                    return res.status(200).json({
                        authEmulator: { success: `The email has been successfully reset.`, email },
                    });
                }
                catch (e) {
                    if (e instanceof errors_1.NotImplementedError ||
                        (e instanceof errors_1.BadRequestError && e.message === "INVALID_OOB_CODE")) {
                        return res.status(400).json({
                            authEmulator: {
                                error: `Your request to revert your email has expired or the link has already been used.`,
                                instructions: RETRY_INSTRUCTIONS,
                            },
                        });
                    }
                    else {
                        throw e;
                    }
                }
            }
            case "resetPassword": {
                const oob = state.validateOobCode(oobCode);
                if ((oob === null || oob === void 0 ? void 0 : oob.requestType) !== "PASSWORD_RESET") {
                    return res.status(400).json({
                        authEmulator: {
                            error: `Your request to reset your password has expired or the link has already been used.`,
                            instructions: `Try resetting your password again.`,
                        },
                    });
                }
                if (!req.query.newPassword) {
                    return res.status(400).json({
                        authEmulator: {
                            error: "missing newPassword query parameter",
                            instructions: `To reset the password for ${oob.email}, send an HTTP GET request to the following URL.`,
                            instructions2: "You may use a web browser or any HTTP client, such as curl.",
                            urlTemplate: `${oob.oobLink}&newPassword=NEW_PASSWORD_HERE`,
                        },
                    });
                }
                else if (req.query.newPassword === "NEW_PASSWORD_HERE") {
                    return res.status(400).json({
                        authEmulator: {
                            error: "newPassword must be something other than 'NEW_PASSWORD_HERE'",
                            instructions: "The string 'NEW_PASSWORD_HERE' is just a placeholder.",
                            instructions2: "Please change the URL to specify a new password instead.",
                            urlTemplate: `${oob.oobLink}&newPassword=NEW_PASSWORD_HERE`,
                        },
                    });
                }
                const { email } = (0, operations_1.resetPassword)(state, {
                    oobCode,
                    newPassword: req.query.newPassword,
                });
                if (continueUrl) {
                    return res.redirect(303, continueUrl);
                }
                else {
                    return res.status(200).json({
                        authEmulator: { success: `The password has been successfully updated.`, email },
                    });
                }
            }
            case "verifyEmail": {
                try {
                    const { email } = (0, operations_1.setAccountInfoImpl)(state, { oobCode });
                    if (continueUrl) {
                        return res.redirect(303, continueUrl);
                    }
                    else {
                        return res.status(200).json({
                            authEmulator: { success: `The email has been successfully verified.`, email },
                        });
                    }
                }
                catch (e) {
                    if (e instanceof errors_1.NotImplementedError ||
                        (e instanceof errors_1.BadRequestError && e.message === "INVALID_OOB_CODE")) {
                        return res.status(400).json({
                            authEmulator: {
                                error: `Your request to verify your email has expired or the link has already been used.`,
                                instructions: `Try verifying your email again.`,
                            },
                        });
                    }
                    else {
                        throw e;
                    }
                }
            }
            case "verifyAndChangeEmail": {
                try {
                    const { newEmail } = (0, operations_1.setAccountInfoImpl)(state, { oobCode });
                    if (continueUrl) {
                        return res.redirect(303, continueUrl);
                    }
                    else {
                        return res.status(200).json({
                            authEmulator: { success: `The email has been successfully changed.`, newEmail },
                        });
                    }
                }
                catch (e) {
                    if (e instanceof errors_1.NotImplementedError ||
                        (e instanceof errors_1.BadRequestError && e.message === "INVALID_OOB_CODE")) {
                        return res.status(400).json({
                            authEmulator: {
                                error: `Your request to change your email has expired or the link has already been used.`,
                                instructions: `Try changing your email again.`,
                            },
                        });
                    }
                    else {
                        throw e;
                    }
                }
            }
            case "signIn": {
                if (!continueUrl) {
                    return res.status(400).json({
                        authEmulator: {
                            error: "Missing continueUrl query parameter",
                            instructions: `To sign in, append &continueUrl=YOUR_APP_URL to the link.`,
                        },
                    });
                }
                const redirectTo = new url_1.URL(continueUrl);
                for (const name of Object.keys(req.query)) {
                    if (name !== "continueUrl") {
                        const query = req.query[name];
                        if (typeof query === "string") {
                            redirectTo.searchParams.set(name, query);
                        }
                    }
                }
                return res.redirect(303, redirectTo.toString());
            }
            default:
                return res.status(400).json({ authEmulator: { error: "Invalid mode" } });
        }
    });
    app.get(`/emulator/auth/handler`, (req, res) => {
        res.set("Content-Type", "text/html; charset=utf-8");
        const apiKey = req.query.apiKey;
        const providerId = req.query.providerId;
        const tenantId = (req.query.tenantId || req.query.tid);
        if (!apiKey || !providerId) {
            return res.status(400).json({
                authEmulator: {
                    error: "missing apiKey or providerId query parameters",
                },
            });
        }
        const state = getProjectStateByApiKey(apiKey, tenantId);
        const providerInfos = state.listProviderInfosByProviderId(providerId);
        const options = providerInfos
            .map((info) => `<li class="js-reuse-account mdc-list-item mdc-ripple-upgraded" tabindex="0" data-id-token="${encodeURIComponent(createFakeClaims(info))}">
          <span class="mdc-list-item__ripple"></span>
          ${info.photoUrl
            ? `
            <span class="mdc-list-item__graphic profile-photo" style="background-image: url('${info.photoUrl}')"></span>`
            : `
            <span class="mdc-list-item__graphic material-icons" aria-hidden=true>person</span>`}
          <span class="mdc-list-item__text"><span class="mdc-list-item__primary-text">${info.displayName || "(No display name)"}</span>
          <span class="mdc-list-item__secondary-text fallback-secondary-text" id="reuse-email">${info.email || ""}</span>
      </li>`)
            .join("\n");
        res.end(widget_ui_1.WIDGET_UI.replace(widget_ui_1.PROVIDERS_LIST_PLACEHOLDER, options));
    });
    app.get(`/emulator/auth/iframe`, (req, res) => {
        res.set("Content-Type", "text/html; charset=utf-8");
        res.end(`<!DOCTYPE html>
<meta charset="utf-8">
<title>Auth Emulator Helper Iframe</title>
<script>
  // TODO: Support older browsers where URLSearchParams is not available.
  var query = new URLSearchParams(location.search);
  var apiKey = query.get('apiKey');
  var appName = query.get('appName');
  if (!apiKey || !appName) {
    alert('Auth Emulator Internal Error: Missing query params apiKey or appName for iframe.');
  }
  var storageKey = apiKey + ':' + appName;

  var parentContainer = null;

  window.addEventListener('message', function (e) {
    if (typeof e.data === 'object' && e.data.eventType === 'sendAuthEvent') {
      if (!e.data.data.storageKey === storageKey) {
        return alert('Auth Emulator Internal Error: Received request with mismatching storageKey');
      }
      var authEvent = e.data.data.authEvent;
      if (parentContainer) {
        sendAuthEvent(authEvent);
      } else {
        // Store it first, and initFrameMessaging() below will pick it up.
        sessionStorage['firebase:redirectEvent:' + storageKey] =
            JSON.stringify(authEvent);
      }
    }
  });

  function initFrameMessaging() {
    parentContainer = gapi.iframes.getContext().getParentIframe();
    parentContainer.register('webStorageSupport', function() {
      // We must reply to this event, or the JS SDK will not continue with the
      // popup flow. Web storage support is not actually needed though.
      return { status: 'ACK', webStorageSupport: true };
    }, gapi.iframes.CROSS_ORIGIN_IFRAMES_FILTER);

    var authEvent = null;
    var storedEvent = sessionStorage['firebase:redirectEvent:' + storageKey];
    if (storedEvent) {
      try {
        authEvent = JSON.parse(storedEvent);
      } catch (_) {
        return alert('Auth Emulator Internal Error: Invalid stored event.');
      }
    }
    sendAuthEvent(authEvent);
    delete sessionStorage['firebase:redirectEvent:' + storageKey];
  }

  function sendAuthEvent(authEvent) {
    parentContainer.send('authEvent', {
      type: 'authEvent',
      authEvent: authEvent || { type: 'unknown', error: { code: 'auth/no-auth-event' } },
    }, function(responses) {
      if (!responses || !responses.length ||
          responses[responses.length - 1].status !== 'ACK') {
        return alert("Auth Emulator Internal Error: Sending authEvent failed.");
      }
    }, gapi.iframes.CROSS_ORIGIN_IFRAMES_FILTER);
  }

  window.gapi_onload = function () {
    gapi.load('gapi.iframes', {
      callback: initFrameMessaging,
      timeout: 10000,
      ontimeout: function () {
        return alert("Auth Emulator Internal Error: Error loading gapi.iframe! Please check your Internet connection.");
      },
    });
  }
</script>
<script src="https://apis.google.com/js/api.js"></script>
`);
    });
}
exports.registerHandlers = registerHandlers;
function createFakeClaims(info) {
    const claims = {
        sub: info.rawId,
        iss: "",
        aud: "",
        exp: 0,
        iat: 0,
        name: info.displayName,
        screen_name: info.screenName,
        email: info.email,
        email_verified: true,
        picture: info.photoUrl,
    };
    return JSON.stringify(claims);
}
