#!/usr/bin/env bash

selection="Lock
Suspend
Suspend & Lock
Shutdown"

selected=$(echo "$selection" | rofi -i -show -dmenu)

if [[ "$selected" == "Lock" ]]; then
    hyprlock
elif [[ "$selected" == "Suspend" ]]; then
    systemctl suspend
elif [[ "$selected" == "Suspend & Lock" ]]; then
    hyprlock &
    systemctl suspend
elif [[ "$selected" == "Shutdown" ]]; then
    systemctl poweroff
fi
