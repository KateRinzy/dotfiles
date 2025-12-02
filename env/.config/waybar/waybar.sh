#!/usr/bin/env bash

LAPTOP=false
MONITOR=true

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

start-uniform() {
    waybar \
        -c "$HOME/.config/waybar/uniform/config.jsonc" \
        -s "$HOME/.config/waybar/uniform/style.css" &
}

pkill waybar || start-bars
