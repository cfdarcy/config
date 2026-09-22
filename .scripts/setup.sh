#!/bin/bash
links=(
        "$HOME/.dotfiles/zsh/.zshenv  $HOME/.zshenv"
        "$HOME/.dotfiles/vim/.vimrc  $HOME/.vimrc"
)
for l in ${links[@]};do
        echo linking "$l" 
        #ln -s "$l"
done

# Source dotfiles
dotfiles=(
        "$HOME/.zshenv"
        "$ZDOTDIR/.zshrc"
        "$HOME/.vimrc"
)
for df in ${dotfiles[@]};do
    echo sourcing "$df"
    source "$df"
done
