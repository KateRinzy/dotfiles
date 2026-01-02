#!/usr/bin/env bash
xrandr \
    --output DP-0 --off --output DP-1 --off \
    --output DP-2 --off --output DP-3 --off \
    --output HDMI-0 --primary --mode 1920x1080 --pos 2560x0 --rate 119 --rotate normal \
    --output DP-4 --mode 2560x1600 --pos 0x0 --rotate normal
