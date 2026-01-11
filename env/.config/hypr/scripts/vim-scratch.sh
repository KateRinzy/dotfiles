#!/usr/bin/env bash

# kitty --class="kittynvimscratch" nvim $HOME/personal/zxcv.md
#
if [ "$1" == "zxcv" ]; then
    ghostty --class="com.mitchellh.ghostty.scratch" -e nvim $HOME/notes/zxcv
else
    if [ "$1" == "faire" ]; then
        ghostty --class="com.mitchellh.ghostty.scratch" -e nvim $HOME/notes/todo
    fi
fi
