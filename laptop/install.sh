#!/usr/bin/env bash

#Dependencies
#sudo pacman -Sy git emacs ripgrep tar fd-find clang xmonad xmonad-contrib xmobar stalonetray xcompmgr rofi

#Emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d=
~/.emacs.d/bin/doom install
cp -r .doom.d "$HOME/.doom.d/"
~/.emacs.d/bin/doom sync

# XMonad
#cp -r .xmonad "$HOME/.xmonad"

# ZSH STUFF
#sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#cp .zsh_history "$HOME/.zsh_history"
#cp .zshrc "$HOME/.zshrc"


mkdir -p ~/.zsh
git clone https://github.com/sindresorhus/pure.git .zsh/pure
