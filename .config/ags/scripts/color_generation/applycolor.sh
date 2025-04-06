#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_HOME="${XDG_HOME:-$HOME}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
CONFIG_DIR="$XDG_CONFIG_HOME/ags"
CACHE_DIR="$XDG_CACHE_HOME/ags"
STATE_DIR="$XDG_STATE_HOME/ags"

term_alpha=100 #Set this to < 100 make all your terminals transparent
# sleep 0 # idk i wanted some delay or colors dont get applied properly
if [ ! -d "$CACHE_DIR"/user/generated ]; then
  mkdir -p "$CACHE_DIR"/user/generated
fi
cd "$CONFIG_DIR" || exit

colornames=''
colorstrings=''
colorlist=()
colorvalues=()

# wallpath=$(swww query | head -1 | awk -F 'image: ' '{print $2}')
# wallpath_png="$CACHE_DIR/user/generated/hypr/lockscreen.png"
# convert "$wallpath" "$wallpath_png"
# wallpath_png=$(echo "$wallpath_png" | sed 's/\//\\\//g')
# wallpath_png=$(sed 's/\//\\\\\//g' <<< "$wallpath_png")

transparentize() {
  local hex="$1"
  local alpha="$2"
  local red green blue

  red=$((16#${hex:1:2}))
  green=$((16#${hex:3:2}))
  blue=$((16#${hex:5:2}))

  printf 'rgba(%d, %d, %d, %.2f)\n' "$red" "$green" "$blue" "$alpha"
}

get_light_dark() {
  lightdark=""
  if [ ! -f "$STATE_DIR/user/colormode.txt" ]; then
    echo "" >"$STATE_DIR/user/colormode.txt"
  else
    lightdark=$(sed -n '1p' "$STATE_DIR/user/colormode.txt")
  fi
  echo "$lightdark"
}

apply_fuzzel() {
  # Check if template exists
  if [ ! -f "scripts/templates/fuzzel/fuzzel.ini" ]; then
    echo "Template file not found for Fuzzel. Skipping that."
    return
  fi
  # Copy template
  mkdir -p "$CACHE_DIR"/user/generated/fuzzel
  cp "scripts/templates/fuzzel/fuzzel.ini" "$CACHE_DIR"/user/generated/fuzzel/fuzzel.ini
  # Apply colors
  for i in "${!colorlist[@]}"; do
    sed -i "s/{{ ${colorlist[$i]} }}/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/fuzzel/fuzzel.ini
  done

  cp "$CACHE_DIR"/user/generated/fuzzel/fuzzel.ini "$XDG_CONFIG_HOME"/fuzzel/fuzzel.ini
}

apply_term() {
  # Check if terminal escape sequence template exists
  if [ ! -f "scripts/templates/terminal/sequences.txt" ]; then
    echo "Template file not found for Terminal. Skipping that."
    return
  fi
  # Copy template
  mkdir -p "$CACHE_DIR"/user/generated/terminal
  cp "scripts/templates/terminal/sequences.txt" "$CACHE_DIR"/user/generated/terminal/sequences.txt
  # Apply colors
  for i in "${!colorlist[@]}"; do
    sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/terminal/sequences.txt
  done

  sed -i "s/\$alpha/$term_alpha/g" "$CACHE_DIR/user/generated/terminal/sequences.txt"

  for file in /dev/pts/*; do
    if [[ $file =~ ^/dev/pts/[0-9]+$ ]]; then
      cat "$CACHE_DIR"/user/generated/terminal/sequences.txt >"$file"
    fi
  done
}

apply_hyprland() {
  # Check if template exists
  if [ ! -f "scripts/templates/hypr/hyprland/colors.conf" ]; then
    echo "Template file not found for Hyprland colors. Skipping that."
    return
  fi
  # Copy template
  mkdir -p "$CACHE_DIR"/user/generated/hypr/hyprland
  cp "scripts/templates/hypr/hyprland/colors.conf" "$CACHE_DIR"/user/generated/hypr/hyprland/colors.conf
  # Apply colors
  for i in "${!colorlist[@]}"; do
    sed -i "s/{{ ${colorlist[$i]} }}/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/hypr/hyprland/colors.conf
  done

  cp "$CACHE_DIR"/user/generated/hypr/hyprland/colors.conf "$XDG_CONFIG_HOME"/hypr/hyprland/colors.conf
}

apply_hyprlock() {
  # Check if template exists
  if [ ! -f "scripts/templates/hypr/hyprlock.conf" ]; then
    echo "Template file not found for hyprlock. Skipping that."
    return
  fi
  # Copy template
  mkdir -p "$CACHE_DIR"/user/generated/hypr/
  cp "scripts/templates/hypr/hyprlock.conf" "$CACHE_DIR"/user/generated/hypr/hyprlock.conf
  # Apply colors
  # sed -i "s/{{ SWWW_WALL }}/${wallpath_png}/g" "$CACHE_DIR"/user/generated/hypr/hyprlock.conf
  for i in "${!colorlist[@]}"; do
    sed -i "s/{{ ${colorlist[$i]} }}/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/hypr/hyprlock.conf
  done

  cp "$CACHE_DIR"/user/generated/hypr/hyprlock.conf "$XDG_CONFIG_HOME"/hypr/hyprlock.conf
}

apply_ags_sourceview() {
  # Check if template file exists
  if [ ! -f "scripts/templates/ags/sourceviewtheme.xml" ]; then
    echo "Template file not found for ags sourceview. Skipping that."
    return
  fi
  # Copy template
  mkdir -p "$CACHE_DIR"/user/generated/ags
  cp "scripts/templates/ags/sourceviewtheme.xml" "$CACHE_DIR"/user/generated/ags/sourceviewtheme.xml
  cp "scripts/templates/ags/sourceviewtheme-light.xml" "$CACHE_DIR"/user/generated/ags/sourceviewtheme-light.xml
  # Apply colors
  for i in "${!colorlist[@]}"; do
    sed -i "s/{{ ${colorlist[$i]} }}/#${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/ags/sourceviewtheme.xml
    sed -i "s/{{ ${colorlist[$i]} }}/#${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/ags/sourceviewtheme-light.xml
  done

  cp "$CACHE_DIR"/user/generated/ags/sourceviewtheme.xml "$XDG_CONFIG_HOME"/ags/assets/themes/sourceviewtheme.xml
  cp "$CACHE_DIR"/user/generated/ags/sourceviewtheme-light.xml "$XDG_CONFIG_HOME"/ags/assets/themes/sourceviewtheme-light.xml
}

apply_lightdark() {
  lightdark=$(get_light_dark)
  if [ "$lightdark" = "light" ]; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  else
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  fi
}

apply_gtk() { # Using gradience-cli
  usegradience=$(sed -n '4p' "$STATE_DIR/user/colormode.txt")
  if [[ "$usegradience" = "nogradience" ]]; then
    rm "$XDG_CONFIG_HOME/gtk-3.0/gtk.css"
    rm "$XDG_CONFIG_HOME/gtk-4.0/gtk.css"
    return
  fi

  # Copy template
  mkdir -p "$CACHE_DIR"/user/generated/gradience
  cp "scripts/templates/gradience/preset.json" "$CACHE_DIR"/user/generated/gradience/preset.json

  # Apply colors
  for i in "${!colorlist[@]}"; do
    sed -i "s/{{ ${colorlist[$i]} }}/${colorvalues[$i]}/g" "$CACHE_DIR"/user/generated/gradience/preset.json
  done

  mkdir -p "$XDG_CONFIG_HOME/presets" # create gradience presets folder
  source $(eval echo $ILLOGICAL_IMPULSE_VIRTUAL_ENV)/bin/activate
  gradience-cli apply -p "$CACHE_DIR"/user/generated/gradience/preset.json --gtk both
  deactivate

  # And set GTK theme manually as Gradience defaults to light adw-gtk3
  # (which is unreadable when broken when you use dark mode)
  lightdark=$(get_light_dark)
  if [ "$lightdark" = "light" ]; then
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
  else
    gsettings set org.gnome.desktop.interface gtk-theme adw-gtk3-dark
  fi
}

apply_ags() {
  agsv1 run-js "handleStyles(false);"
  agsv1 run-js 'openColorScheme.value = true; Utils.timeout(2000, () => openColorScheme.value = false);'
}

apply_qt() {
  sh "$CONFIG_DIR/scripts/kvantum/materialQT.sh"          # generate kvantum theme
  python "$CONFIG_DIR/scripts/kvantum/changeAdwColors.py" # apply config colors
}

apply_kitty() {
	if ! which kitty &>/dev/null; then
		echo "Kitty is not installed. Skipping that."
		return
	fi

	# Check if scripts/templates/kitty/dots-hyprland.conf exists
	if [ ! -f "scripts/templates/kitty/dots-hyprland.conf" ]; then
		echo "Template file not found for kitty. Skipping that."
		return
	fi

	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/kitty
	cp "scripts/templates/kitty/dots-hyprland.conf" "$CACHE_DIR"/user/generated/kitty/dots-hyprland.conf

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/kitty/dots-hyprland.conf
	done

	# Make sure that kitty.conf has 'include current-theme.conf' in it
	mkdir -p "$XDG_CONFIG_HOME"/kitty
	cp "$CACHE_DIR"/user/generated/kitty/dots-hyprland.conf "$XDG_CONFIG_HOME"/kitty/kitty.conf

	# Reload theme in all open kitty terminals
	kill -SIGUSR1 $(pgrep kitty)
}

apply_nchat() {
	if ! which nchat &>/dev/null; then
		echo "NChat is not installed. Skipping that."
		return
	fi

	# Check if scripts/templates/nchat/color.conf exists
	if [ ! -f "scripts/templates/nchat/color.conf" ]; then
		echo "Template file not found for NChat. Skipping that."
		return
	fi

	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/nchat
	cp "scripts/templates/nchat/color.conf" "$CACHE_DIR"/user/generated/nchat/color.conf

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/nchat/color.conf
	done

	# Udate file
	mkdir -p "$XDG_CONFIG_HOME"/nchat
	cp "$CACHE_DIR"/user/generated/nchat/color.conf "$XDG_CONFIG_HOME"/nchat/color.conf
}

apply_foliate() {
	if ! which foliate &>/dev/null; then
		echo "Foliate is not installed. Skipping that."
		return
	fi

	# Check if scripts/templates/com.github.johnfactotum.Foliate/themes/dots.json
	if [ ! -f "scripts/templates/foliate/dots.json" ]; then
		echo "Template file not found for Foliate. Skipping that."
		return
	fi

	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/foliate
	cp "scripts/templates/foliate/dots.json" "$CACHE_DIR"/user/generated/foliate/dots.json

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/foliate/dots.json
	done

	# Udate file
	mkdir -p "$XDG_CONFIG_HOME"/com.github.johnfactotum.Foliate
	mkdir -p "$XDG_CONFIG_HOME"/com.github.johnfactotum.Foliate/themes
	cp "$CACHE_DIR"/user/generated/foliate/dots.json "$XDG_CONFIG_HOME"/com.github.johnfactotum.Foliate/themes/dots.json
}

apply_sddm() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/sddm
	cp "scripts/templates/sddm/theme.conf" "$CACHE_DIR"/user/generated/sddm/theme.conf

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
	cp "scripts/templates/neovim/base16.lua" "$CACHE_DIR"/user/generated/neovim/base16.lua

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/neovim/base16.lua
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/neovim/base16.lua "$XDG_CONFIG_HOME"/astronvim_v4/lua/plugins/base16.lua
}

apply_zen() {
	# Copy template
	mkdir -p "$CACHE_DIR"/user/generated/zen
	cp "scripts/templates/zen/userChrome.css" "$CACHE_DIR"/user/generated/zen/userChrome.css
	cp "scripts/templates/zen/userContent.css" "$CACHE_DIR"/user/generated/zen/userContent.css

	# Apply colors
	for i in "${!colorlist[@]}"; do
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/zen/userChrome.css
		sed -i "s/${colorlist[$i]} #/${colorvalues[$i]#\#}/g" "$CACHE_DIR"/user/generated/zen/userContent.css
	done

	# Udate file
	cp "$CACHE_DIR"/user/generated/zen/userChrome.css "$XDG_HOME"'/.zen/fmpaicry.Default (release)/chrome/userChrome.css'
	cp "$CACHE_DIR"/user/generated/zen/userContent.css "$XDG_HOME"'/.zen/fmpaicry.Default (release)/chrome/userContent.css'
}

colornames=$(cat $STATE_DIR/scss/_material.scss | cut -d: -f1)
colorstrings=$(cat $STATE_DIR/scss/_material.scss | cut -d: -f2 | cut -d ' ' -f2 | cut -d ";" -f1)
IFS=$'\n'
colorlist=($colornames)     # Array of color names
colorvalues=($colorstrings) # Array of color values

apply_ags &
apply_ags_sourceview &
apply_hyprland &
apply_hyprlock &
apply_lightdark &
apply_gtk &
apply_qt &
apply_fuzzel &
apply_nchat &
apply_kitty &
apply_foliate &
apply_sddm &
apply_neovim &
apply_term &
apply_zen
