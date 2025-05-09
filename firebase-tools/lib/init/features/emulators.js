"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.doSetup = void 0;
const clc = require("colorette");
const utils = require("../../utils");
const prompt_1 = require("../../prompt");
const types_1 = require("../../emulator/types");
const constants_1 = require("../../emulator/constants");
const downloadableEmulators_1 = require("../../emulator/downloadableEmulators");
const initEmulators_1 = require("../../emulator/initEmulators");
async function doSetup(setup, config) {
    var _a, _b, _c;
    const choices = types_1.ALL_SERVICE_EMULATORS.map((e) => {
        return {
            value: e,
            name: constants_1.Constants.description(e),
            checked: config && (config.has(e) || config.has(`emulators.${e}`)),
        };
    });
    const selections = {};
    await (0, prompt_1.prompt)(selections, [
        {
            type: "checkbox",
            name: "emulators",
            message: "Which Firebase emulators do you want to set up? " +
                "Press Space to select emulators, then Enter to confirm your choices.",
            choices: choices,
        },
    ]);
    if (!selections.emulators) {
        return;
    }
    setup.config.emulators = setup.config.emulators || {};
    for (const selected of selections.emulators) {
        setup.config.emulators[selected] = setup.config.emulators[selected] || {};
        const currentPort = setup.config.emulators[selected].port;
        if (currentPort) {
            utils.logBullet(`Port for ${selected} already configured: ${clc.cyan(currentPort)}`);
        }
        else {
            await (0, prompt_1.prompt)(setup.config.emulators[selected], [
                {
                    type: "number",
                    name: "port",
                    message: `Which port do you want to use for the ${clc.underline(selected)} emulator?`,
                    default: constants_1.Constants.getDefaultPort(selected),
                },
            ]);
        }
        const additionalInitFn = initEmulators_1.AdditionalInitFns[selected];
        if (additionalInitFn) {
            const additionalOptions = await additionalInitFn(config);
            if (additionalOptions) {
                setup.config.emulators[selected] = Object.assign(Object.assign({}, setup.config.emulators[selected]), additionalOptions);
            }
        }
    }
    if (selections.emulators.length) {
        const uiDesc = constants_1.Constants.description(types_1.Emulators.UI);
        if (setup.config.emulators.ui && setup.config.emulators.ui.enabled !== false) {
            const currentPort = setup.config.emulators.ui.port || "(automatic)";
            utils.logBullet(`${uiDesc} already enabled with port: ${clc.cyan(currentPort)}`);
        }
        else {
            const ui = setup.config.emulators.ui || {};
            setup.config.emulators.ui = ui;
            await (0, prompt_1.prompt)(ui, [
                {
                    name: "enabled",
                    type: "confirm",
                    message: `Would you like to enable the ${uiDesc}?`,
                    default: true,
                },
            ]);
            if (ui.enabled) {
                await (0, prompt_1.prompt)(ui, [
                    {
                        type: "input",
                        name: "port",
                        message: `Which port do you want to use for the ${clc.underline(uiDesc)} (leave empty to use any available port)?`,
                    },
                ]);
                const portNum = Number.parseInt(ui.port);
                ui.port = isNaN(portNum) ? undefined : portNum;
            }
        }
        await (0, prompt_1.prompt)(selections, [
            {
                name: "download",
                type: "confirm",
                message: "Would you like to download the emulators now?",
                default: true,
            },
        ]);
    }
    if (setup.config.emulators.singleProjectMode === undefined) {
        setup.config.emulators.singleProjectMode = true;
    }
    if (selections.download) {
        for (const selected of selections.emulators) {
            if ((0, types_1.isDownloadableEmulator)(selected)) {
                await (0, downloadableEmulators_1.downloadIfNecessary)(selected);
            }
        }
        if ((_c = (_b = (_a = setup === null || setup === void 0 ? void 0 : setup.config) === null || _a === void 0 ? void 0 : _a.emulators) === null || _b === void 0 ? void 0 : _b.ui) === null || _c === void 0 ? void 0 : _c.enabled) {
            (0, downloadableEmulators_1.downloadIfNecessary)(types_1.Emulators.UI);
        }
    }
}
exports.doSetup = doSetup;
