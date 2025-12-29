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

apply_color() {
  local app_name="$1"
  local file_name="$2"
  local target_path="$3"

  local template_file="$SCRIPT_DIR/templates/$app_name/$file_name"
  local generated_dir="$STATE_DIR/user/generated/colors/$app_name"
  local generated_file="$generated_dir/$file_name"

  [ ! -f "$template_file" ] && return

  mkdir -p "$generated_dir"
  cp "$template_file" "$generated_file"

  for i in "${!colorlist[@]}"; do
    sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$generated_file"
  done

  WALLPAPER_PATH=$(cat "$STATE_DIR"/user/generated/wallpaper/path.txt | tr -d '\n')
  sed -i 's\#$image #\'"$WALLPAPER_PATH"'\g' "$generated_file"

  mkdir -p "$(dirname "$target_path")"
  cp "$generated_file" "$target_path"
}

apply_color "flameshot" "flameshot.ini" "$XDG_CONFIG_HOME/flameshot/flameshot.ini" &
apply_color "kando" "config.json" "$XDG_CONFIG_HOME/kando/config.json" &
apply_color "kitty" "colors.conf" "$XDG_CONFIG_HOME/kitty/colors.conf" &
apply_color "nchat" "color.conf" "$XDG_CONFIG_HOME/nchat/color.conf" &
apply_color "nchat" "usercolor.conf" "$XDG_CONFIG_HOME/nchat/usercolor.conf" &
apply_color "neovim" "colors.lua" "$XDG_CONFIG_HOME/nvim/lua/plugins/colors.lua" &
apply_color "sddm" "theme.conf" "/usr/share/sddm/themes/sddm-astronaut-theme/Themes/theme.conf" &
apply_color "surfingkeys" "surfingkeys.js" "$XDG_CONFIG_HOME/surfingkeys/surfingkeys.js" &
apply_color "wl-kbptr" "config" "$XDG_CONFIG_HOME/wl-kbptr/config" &
apply_color "yazi" "theme.toml" "$XDG_CONFIG_HOME/yazi/theme.toml" &
