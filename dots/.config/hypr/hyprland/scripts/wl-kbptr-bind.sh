#!/bin/bash

FOCUSED=false
DOUBLE_CLICK=false
RIGHT_CLICK=false
INSERT=false
VISUAL=false
RETURN_NORMAL=false

for arg in "$@"; do
    case "$arg" in
        -f) FOCUSED=true; shift ;;
        -2) DOUBLE_CLICK=true; shift ;;
        -r) RIGHT_CLICK=true; shift ;;
        -i) INSERT=true; shift ;;
        -v) VISUAL=true; shift ;;
        -n) RETURN_NORMAL=true; shift ;;
    esac
done

click() {
    if [ "$DOUBLE_CLICK" = true ]; then
        hyprctl dispatch global quickshell:vimModeFind
        ydotool click --repeat=2 0xC0
    elif [ "$INSERT" = true ]; then
        hyprctl dispatch global quickshell:vimModeInsert
        SCRIPT_DIR=$(dirname "$0")
        NVIM_SCRIPT="$SCRIPT_DIR/nvim-wl-anywhere.sh"
        if [ ! -f "$NVIM_SCRIPT" ]; then
            echo "Erro: Script nvim-wl-anywhere.sh não encontrado em $SCRIPT_DIR" >&2
        else
            wlrctl pointer click left 
            "$NVIM_SCRIPT"
        fi
    elif [ "$VIUAL" = true ]; then
        hyprctl dispatch global quickshell:vimModeVisual
        ydotool click --repeat=2 0xC0
    elif [ "$RIGHT_CLICK" = true ]; then
        hyprctl dispatch global quickshell:vimModeFind
        wlrctl pointer click right
    else
        hyprctl dispatch global quickshell:vimModeFind
        wlrctl pointer click left
    fi
}

hyprctl dispatch submap global
if [ "$FOCUSED" = true ]; then
    REGION=$(hyprctl clients | awk -v RS= '/focusHistoryID: 0/{match($0, /size: ([^ \n]+)/, s); match($0, /at: ([^ \n]+)/, a); split(s[1], d, ","); split(a[1], c, ","); printf("%sx%s+%s+%s", d[1], d[2], c[1], c[2])}')
    if [ -n "$REGION" ]; then
        wl-kbptr -r "$REGION" && click
    else
        wl-kbptr && click
    fi
else
    wl-kbptr && click
fi

if [ "$RETURN_NORMAL" = true ]; then
    hyprctl dispatch global quickshell:vimModeNormal
    hyprctl dispatch submap VIM
else
    hyprctl dispatch global quickshell:vimModeOff
fi
