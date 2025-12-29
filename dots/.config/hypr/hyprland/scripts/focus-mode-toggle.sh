#!/bin/bash

v=$(hyprctl getoption general:gaps_in | grep -o "[0-9]\+" | head -n1)

if [ "$v" -eq 0 ]; then
    hyprctl reload
    hyprctl dispatcher global quickshell:barOpen
else
    hyprctl --batch "\
        keyword general:border_size 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword decoration:rounding 0;\
        keyword decoration:inactive_opacity 1;\
        keyword decoration:active_opacity 1"
    hyprctl dispatcher global quickshell:barClose
fi
