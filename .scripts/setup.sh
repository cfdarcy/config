#!/bin/bash
echo "START: Symlinking dotfiles"
ln -s ~/.dotfiles/.zshrc  ~/.zshrc
ln -s ~/.dotfiles/.zshenv  ~/.zshenv
echo "END:   Symlinking dotfiles"
