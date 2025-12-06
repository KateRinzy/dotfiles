#!/usr/bin/env bash

# kitty --class="kittynvimscratch" nvim $HOME/personal/zxcv.md
#
if [ "$1" == "zxcv" ]; then
    kitty --class="kittynvimscratch" nvim $HOME/Documents/zxcv.typ
else
    if [ "$1" == "faire" ]; then
        kitty --class="kittynvimscratch" nvim $HOME/Documents/notes/todo.typ
    fi
fi
