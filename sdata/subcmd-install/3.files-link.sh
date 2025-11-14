# This script is meant to be sourced.
# It's not for directly running.

# shellcheck shell=bash

v mkdir -p $XDG_BIN_HOME $XDG_CACHE_HOME $XDG_CONFIG_HOME $XDG_DATA_HOME/icons

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
    printf "Link complete -> $item_name\n"
done

v cp -f "dots/.local/share/icons/illogical-impulse.svg" "${XDG_DATA_HOME}"/icons/illogical-impulse.svg
