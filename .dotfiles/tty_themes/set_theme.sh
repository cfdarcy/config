#!/bin/bash
colours=()
while IFS= read -r line; do
  colours+=("$line")
done < "$HOME/.dotfiles/tty_themes/$1" 

for i in {0..15}; do echo -ne "\x1b]4;${i};${colours[${i}]}\x07"; done
echo -ne "\x1b]10;${colours[16]}\x07" 
echo -ne "\x1b]11;${colours[17]}\x07" 

echo "$1" > $HOME/.dotfiles/tty_themes/current.txt
echo "$1" system palette set!
