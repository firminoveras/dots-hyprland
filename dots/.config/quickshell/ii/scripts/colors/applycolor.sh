#!/usr/bin/env bash

QUICKSHELL_CONFIG_NAME="ii"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
CONFIG_DIR="$XDG_CONFIG_HOME/quickshell/$QUICKSHELL_CONFIG_NAME"
CACHE_DIR="$XDG_CACHE_HOME/quickshell"
STATE_DIR="$XDG_STATE_HOME/quickshell"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

term_alpha=100 #Set this to < 100 make all your terminals transparent
# sleep 0 # idk i wanted some delay or colors dont get applied properly
if [ ! -d "$STATE_DIR"/user/generated ]; then
  mkdir -p "$STATE_DIR"/user/generated
fi
cd "$CONFIG_DIR" || exit

colornames=''
colorstrings=''
colorlist=()
colorvalues=()

colornames=$(cat $STATE_DIR/user/generated/material_colors.scss | cut -d: -f1)
colorstrings=$(cat $STATE_DIR/user/generated/material_colors.scss | cut -d: -f2 | cut -d ' ' -f2 | cut -d ";" -f1)
IFS=$'\n'
colorlist=($colornames)     # Array of color names
colorvalues=($colorstrings) # Array of color values

apply_term() {
  # Check if terminal escape sequence template exists
  if [ ! -f "$SCRIPT_DIR/terminal/sequences.txt" ]; then
    echo "Template file not found for Terminal. Skipping that."
    return
  fi
  # Copy template
  mkdir -p "$STATE_DIR"/user/generated/terminal
  cp "$SCRIPT_DIR/terminal/sequences.txt" "$STATE_DIR"/user/generated/terminal/sequences.txt
  # Apply colors
  for i in "${!colorlist[@]}"; do
    sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$STATE_DIR"/user/generated/terminal/sequences.txt
  done

  sed -i "s/\$alpha/$term_alpha/g" "$STATE_DIR/user/generated/terminal/sequences.txt"

  for file in /dev/pts/*; do
    if [[ $file =~ ^/dev/pts/[0-9]+$ ]]; then
      {
      cat "$STATE_DIR"/user/generated/terminal/sequences.txt >"$file"
      } & disown || true
    fi
  done
}

apply_qt() {
  sh "$CONFIG_DIR/scripts/kvantum/materialQT.sh"          # generate kvantum theme
  python "$CONFIG_DIR/scripts/kvantum/changeAdwColors.py" # apply config colors
}

# Check if terminal theming is enabled in config
CONFIG_FILE="$XDG_CONFIG_HOME/illogical-impulse/config.json"
if [ -f "$CONFIG_FILE" ]; then
  enable_terminal=$(jq -r '.appearance.wallpaperTheming.enableTerminal' "$CONFIG_FILE")
  if [ "$enable_terminal" = "true" ]; then
    apply_term &
  fi
else
  echo "Config file not found at $CONFIG_FILE. Applying terminal theming by default."
  apply_term &
fi

# apply_qt & # Qt theming is already handled by kde-material-colors

apply_kitty() {
	if ! which kitty &>/dev/null; then
		echo "Kitty is not installed. Skipping that."
		return
	fi

	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/kitty
	cp "$CONFIG_DIR/scripts/colors/templates/kitty/kitty.conf" "$CACHE_DIR"/user/generated/kitty/kitty.conf

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/kitty/kitty.conf
	done

	# Make sure that kitty.conf has 'include current-theme.conf' in it
	mkdir -p "$XDG_CONFIG_HOME"/kitty
	cp "$CACHE_DIR"/user/generated/kitty/kitty.conf "$XDG_CONFIG_HOME"/kitty/kitty.conf

	# Reload theme in all open kitty terminals
	kill -SIGUSR1 $(pgrep kitty)
}

apply_nchat() {
	if ! which nchat &>/dev/null; then
		echo "NChat is not installed. Skipping that."
		return
	fi

	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/nchat
	cp "$CONFIG_DIR/scripts/colors/templates/nchat/color.conf" "$CACHE_DIR"/user/generated/nchat/color.conf
	cp "$CONFIG_DIR/scripts/colors/templates/nchat/usercolor.conf" "$CACHE_DIR"/user/generated/nchat/usercolor.conf

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/nchat/color.conf
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/nchat/usercolor.conf
	done

	# Udate file
	mkdir -p "$XDG_CONFIG_HOME"/nchat
	cp "$CACHE_DIR"/user/generated/nchat/color.conf "$XDG_CONFIG_HOME"/nchat/color.conf
	cp "$CACHE_DIR"/user/generated/nchat/usercolor.conf "$XDG_CONFIG_HOME"/nchat/usercolor.conf
}

apply_sddm() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/sddm
	cp "$CONFIG_DIR/scripts/colors/templates/sddm/theme.conf" "$CACHE_DIR"/user/generated/sddm/theme.conf

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/sddm/theme.conf
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/sddm/theme.conf /usr/share/sddm/themes/sdt/theme.conf
}

apply_neovim() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/neovim
	cp "$CONFIG_DIR/scripts/colors/templates/neovim/colors.lua" "$CACHE_DIR"/user/generated/neovim/colors.lua

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/neovim/colors.lua
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/neovim/colors.lua "$XDG_CONFIG_HOME"/nvim/lua/plugins/colors.lua
}

apply_kando() {
	if ! which kando &>/dev/null; then
		echo "Kando is not installed. Skipping that."
		return
	fi

	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/kando
	cp "$CONFIG_DIR/scripts/colors/templates/kando/config.json" "$CACHE_DIR"/user/generated/kando/config.json

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/kando/config.json
	done

	# Udate file
  mkdir -p "$XDG_CONFIG_HOME"/kando
	cp "$CACHE_DIR"/user/generated/kando/config.json "$XDG_CONFIG_HOME"/kando/config.json
}

apply_flameshot() {
	if ! which flameshot &>/dev/null; then
		echo "Flameshot is not installed. Skipping that."
		return
	fi
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/flameshot
	cp "$CONFIG_DIR/scripts/colors/templates/flameshot/flameshot.ini" "$CACHE_DIR"/user/generated/flameshot/flameshot.ini

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/flameshot/flameshot.ini
	done

	# Udate file
  mkdir -p "$XDG_CONFIG_HOME"/flameshot
	cp "$CACHE_DIR"/user/generated/flameshot/flameshot.ini "$XDG_CONFIG_HOME"/flameshot/flameshot.ini
}

apply_yazi() {
	if ! which yazi &>/dev/null; then
		echo "Yazi is not installed. Skipping that."
		return
	fi
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/yazi
	cp "$CONFIG_DIR/scripts/colors/templates/yazi/theme.toml" "$CACHE_DIR"/user/generated/yazi/theme.toml

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/yazi/theme.toml
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/yazi/theme.toml "$XDG_CONFIG_HOME"/yazi/theme.toml
}

apply_surfingkeys() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/surfingkeys
	cp "$CONFIG_DIR/scripts/colors/templates/surfingkeys/surfingkeys.js" "$CACHE_DIR"/user/generated/surfingkeys/surfingkeys.js

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/surfingkeys/surfingkeys.js
	done

	# Udate file
  mkdir -p "$XDG_CONFIG_HOME"/surfingkeys
	cp "$CACHE_DIR"/user/generated/surfingkeys/surfingkeys.js "$XDG_CONFIG_HOME"/surfingkeys/surfingkeys.js
}

apply_hypr() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/hypr
	cp "$CONFIG_DIR/scripts/colors/templates/hypr/colors.conf" "$CACHE_DIR"/user/generated/hypr/colors.conf

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/hypr/colors.conf
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/hypr/colors.conf "$XDG_CONFIG_HOME"/hypr/hyprland/colors.conf
}

apply_wlkbptr() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/wl-kbptr
	cp "$CONFIG_DIR/scripts/colors/templates/wl-kbptr/config" "$CACHE_DIR"/user/generated/wl-kbptr/config

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/wl-kbptr/config
	done

	# Udate file
  mkdir -p "$XDG_CONFIG_HOME"/wl-kbptr
	cp "$CACHE_DIR"/user/generated/wl-kbptr/config "$XDG_CONFIG_HOME"/wl-kbptr/config
}

apply_kitty &
apply_nchat &
apply_sddm &
apply_neovim &
apply_kando &
apply_flameshot &
apply_yazi &
apply_surfingkeys &
apply_hypr &
apply_wlkbptr &
