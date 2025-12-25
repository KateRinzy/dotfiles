#!/usr/bin/env bash

FORCE_DISABLE_LAPTOP=false
FORCE_DISABLE_MONITOR=false

LAPTOP_CONFIG="laptop"
MONITOR_CONFIG="monitorv2"

LAPTOPNAME="eDP-1"
MONITORNAME="HDMI-A-1"

# Detect compositor
if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
    COMPOSITOR="hyprland"
elif [ -n "$NIRI_SOCKET" ]; then
    COMPOSITOR="niri"
else
    echo "No supported compositor detected. Only Hyprland and Niri are supported."
    exit 1
fi

has_monitor() {
    if [ "$COMPOSITOR" = "hyprland" ]; then
        hyprctl monitors -j >/dev/null 2>&1 && hyprctl monitors -j | jq -e --arg name "$1" \
            '.[] | select(.name == $name)' >/dev/null
    elif [ "$COMPOSITOR" = "niri" ]; then
        niri msg --json outputs >/dev/null 2>&1 && niri msg --json outputs | jq -e --arg name "$1" \
            '.[] | select(.name == $name)' >/dev/null
    else
        return 1
    fi
}

LAPTOP=$(has_monitor "$LAPTOPNAME" && echo true || echo false)
MONITOR=$(has_monitor "$MONITORNAME" && echo true || echo false)

$FORCE_DISABLE_LAPTOP && LAPTOP=false
$FORCE_DISABLE_MONITOR && MONITOR=false

echo -e "gotten:"
echo -e "\tCOMPOSITOR: $COMPOSITOR"
echo -e "\tLAPTOP: $LAPTOP ($LAPTOPNAME)"
echo -e "\tMONITOR: $MONITOR ($MONITORNAME)"

laptop() {
    waybar \
        -c "$HOME/.config/waybar/$LAPTOP_CONFIG/config.jsonc" \
        -s "$HOME/.config/waybar/$LAPTOP_CONFIG/style.css" &
}

monitor() {
    waybar \
        -c "$HOME/.config/waybar/$MONITOR_CONFIG/config.jsonc" \
        -s "$HOME/.config/waybar/$MONITOR_CONFIG/style.css" &
}

start-bars() {
    if $LAPTOP; then laptop; fi
    if $MONITOR; then monitor; fi
}

pkill waybar || start-bars
