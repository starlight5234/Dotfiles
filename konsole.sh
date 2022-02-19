#!/bin/sh

sudo apt install konsole zsh wget tmux -y

KDIR="$HOME/.local/share/konsole"

[ -d "$KDIR" ] && cp -a -- "$KDIR" "$KDIR-$(date +"%m-%d-%y-%r")"
rm -rf KDIR

cp -r $(pwd)/konsole/* $KDIR/
