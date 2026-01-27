#!/usr/bin/env bash

selection="Suspend & Lock
Suspend
Shutdown"

selected=$(echo "$selection" | rofi -i -show -dmenu)

if [[ "$selected" == "Suspend" ]]; then
    systemctl suspend
elif [[ "$selected" == "Suspend & Lock" ]]; then
    hyprlock &
    systemctl suspend
elif [[ "$selected" == "Shutdown" ]]; then
    systemctl poweroff
fi
