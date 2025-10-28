# This script is meant to be sourced.
# It's not for directly running.

# shellcheck shell=bash

# In case some dirs does not exists
v mkdir -p $XDG_BIN_HOME $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME/icons

# `--delete' for rsync to make sure that
# original dotfiles and new ones in the SAME DIRECTORY
# (eg. in ~/.config/hypr) won't be mixed together

# MISC (For dots/.config/* but not quickshell, not fish, not Hyprland, not fontconfig)

# [Link folders]
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SOURCE_DIR="$SCRIPT_DIR/dots/.config"
DEST_DIR="$HOME/.config"
mkdir -p "$DEST_DIR"
rm -rf "$HOME/.cache/config_bak"
mkdir -p "$HOME/.cache/config_bak"
for source_path in "$SOURCE_DIR"/*; do
    if [ ! -e "$source_path" ]; then
        continue
    fi
    item_name=$(basename "$source_path")
    dest_path="$DEST_DIR/$item_name"
    if [ -e "$dest_path" ] || [ -L "$dest_path" ]; then
        mv "$dest_path" "$HOME/.cache/config_bak/$item_name.bak"
    fi
    ln -s "$source_path" "$DEST_DIR"
done

# some foldes (eg. .local/bin) should be processed separately to avoid `--delete' for rsync,
# since the files here come from different places, not only about one program.
# v rsync -av "dots/.local/bin/" "$XDG_BIN_HOME" # No longer needed since scripts are no longer in ~/.local/bin
v cp -f "dots/.local/share/icons/illogical-impulse.svg" "${XDG_DATA_HOME}"/icons/illogical-impulse.svg
