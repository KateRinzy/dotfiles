#!/usr/bin/env bash

FORCE_DISABLE_LAPTOP=false
FORCE_DISABLE_MONITOR=false

LAPTOPNAME="eDP-1"
MONITORNAME="HDMI-A-1"

has_monitor() {
    hyprctl monitors -j | jq -e --arg name "$1" \
        '.[] | select(.name == $name)' >/dev/null
}

LAPTOP=$(has_monitor "$LAPTOPNAME" && echo true || echo false)
MONITOR=$(has_monitor "$MONITORNAME" && echo true || echo false)

$FORCE_DISABLE_LAPTOP && LAPTOP=false
$FORCE_DISABLE_MONITOR && MONITOR=false

echo -e "gotten:"
echo -e "\tLAPTOP: $LAPTOP ($LAPTOPNAME)"
echo -e "\tMONITOR: $MONITOR ($MONITORNAME)"

laptop() {
    waybar \
        -c "$HOME/.config/waybar/laptop/config.jsonc" \
        -s "$HOME/.config/waybar/laptop/style.css" &
}

monitor() {
    waybar \
        -c "$HOME/.config/waybar/monitorv2/config.jsonc" \
        -s "$HOME/.config/waybar/monitorv2/style.css" &
}

start-bars() {
    if $LAPTOP; then laptop; fi
    if $MONITOR; then monitor; fi
}

# start-uniform() {
#     waybar \
#         -c "$HOME/.config/waybar/uniform/config.jsonc" \
#         -s "$HOME/.config/waybar/uniform/style.css" &
# }

pkill waybar
start-bars
