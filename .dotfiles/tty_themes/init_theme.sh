#!/bin/bash

theme=$(head -n 1 $HOME/.dotfiles/tty_themes/current.txt)
$HOME/.dotfiles/tty_themes/set_theme.sh "$theme"
clear
