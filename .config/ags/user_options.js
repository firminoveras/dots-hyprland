
const userConfigOptions = {
    // For every option, see ~/.config/ags/modules/.configuration/user_options.js
    // (vscode users ctrl+click this: file://./modules/.configuration/user_options.js)
    // (vim users: `:vsp` to split window, move cursor to this path, press `gf`. `Ctrl-w` twice to switch between)
    //   options listed in this file will override the default ones in the above file
    // Here's an example
    'keybinds': {
        'sidebar': {
            'pin': "Ctrl+p",
            'nextTab': "Ctrl+Page_Down",
            'prevTab': "Ctrl+Page_Up",
        },
    },
    'workspaces':{
        'shown': 5
    },
    'overview': {
        'scale': 0.12, // Relative to screen size
        'numOfRows': 1,
        'numOfCols': 5,
        'wsNumScale': 0.09,
        'wsNumMarginScale': 0.07,
    },
    'weather': {
        'city': "imaculada",
        'preferredUnit': "C", // Either C or F
    },
}

export default userConfigOptions;
