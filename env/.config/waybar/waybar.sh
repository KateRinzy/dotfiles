#!/usr/bin/env bash

laptop() {
    waybar \
        -c "$HOME/.config/waybar/laptop/config.jsonc" \
        -s "$HOME/.config/waybar/laptop/style.css" &
}
monitor() {
    waybar \
        -c "$HOME/.config/waybar/monitor/config.jsonc" \
        -s "$HOME/.config/waybar/monitor/style.css" &
}

start-bars() {
    laptop
    monitor
}

start-uniform() {
    waybar \
        -c "$HOME/.config/waybar/uniform/config.jsonc" \
        -s "$HOME/.config/waybar/uniform/style.css" &
}

pkill waybar || start-bars
