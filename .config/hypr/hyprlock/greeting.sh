#!/bin/bash

# Set your Username
# username="TamarindX"

# Read the username alias from hyprlock.conf
username=$(grep -oP '^\$USER\s*=\s*\K\S+' ~/.config/hypr/hyprlock.conf)

# Check if the username was successfully extracted
if [ -z "$username" ]; then
  echo "Username not found in hyprlock.conf."
  exit 1
fi

# Get the current hour
hour=$(date +%H)

# Determine the greeting based on the time
if   [ "$hour" -ge 5  ] && [ "$hour" -lt 12 ]; then
    greeting="Bom dia"
elif [ "$hour" -ge 12 ] && [ "$hour" -lt 17 ]; then
    greeting="Boa tarde"
elif [ "$hour" -ge 17 ] && [ "$hour" -lt 21 ]; then
    greeting="Boa noite"
elif [ "$hour" -ge 21 ] && [ "$hour" -lt 24 ]; then
    greeting="Boa noite"
else
    greeting="VAI DORMIR"
fi

# Output the combined text
echo -e "Olá, $username! $greeting"
