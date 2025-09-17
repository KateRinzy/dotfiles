#!/usr/bin/bash

# kitty --class="kittynvimscratch" nvim $HOME/personal/zxcv.md
#
if [ "$1" == "zxcv" ]; then
    kitty nvim $HOME/Documents/zxcv.md
else
    if [ "$1" == "faire" ]; then
        kitty nvim $HOME/Documents/notes/todo.md
    fi
fi
