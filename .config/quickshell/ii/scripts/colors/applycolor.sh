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

apply_qt &
apply_term &

# Firmino
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

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/nchat/color.conf
	done

	# Udate file
	mkdir -p "$XDG_CONFIG_HOME"/nchat
	cp "$CACHE_DIR"/user/generated/nchat/color.conf "$XDG_CONFIG_HOME"/nchat/color.conf
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
	cp "$CONFIG_DIR/scripts/colors/templates/neovim/base16.lua" "$CACHE_DIR"/user/generated/neovim/base16.lua

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/neovim/base16.lua
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/neovim/base16.lua "$XDG_CONFIG_HOME"/astronvim_v4/lua/plugins/base16.lua
}

apply_sherlock() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/sherlock
	cp "$CONFIG_DIR/scripts/colors/templates/sherlock/theme.css" "$CACHE_DIR"/user/generated/sherlock/theme.css

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/sherlock/theme.css
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/sherlock/theme.css "$XDG_CONFIG_HOME"/sherlock/theme.css
}

apply_kitty &
apply_nchat &
apply_sddm &
apply_neovim &
apply_sherlock &
