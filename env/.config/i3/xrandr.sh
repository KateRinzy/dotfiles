#!/usr/bin/env bash

xrandr \
    --output DP-0 --off --output DP-1 --off \
    --output DP-2 --off --output DP-3 --off \
    --output DP-4 --mode 2560x1600 --pos 0x0 --scale 0.8x0.8 --rate 165 --rotate normal \
    --output HDMI-0 --primary --mode 1920x1080 --pos 2048x0 --rate 119 --rotate normal
