#!/bin/bash
echo "START: Symlinking dotfiles"
ln -s $HOME/.dotfiles/zsh/.zshenv  ~/.zshenv
echo "END:   Symlinking dotfiles"
