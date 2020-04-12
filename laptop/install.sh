#!/usr/bin/env bash

#Dependencies
sudo pacman -Sy xorg-xset xloadimage lightdm-gtk-greeter git emacs ripgrep tar clang xmonad xmonad-contrib xmobar stalonetray xcompmgr rofi termite xorg-server compton

#Emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
cp -r .doom.d "$HOME/.doom.d/"
~/.emacs.d/bin/doom sync

# XMonad
cp -r .xmonad "$HOME/.xmonad"

# ZSH STUFF
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp .zsh_history "$HOME/.zsh_history"
cp .zshrc "$HOME/.zshrc"

mkdir -p ~/.zsh
git clone https://github.com/sindresorhus/pure.git .zsh/pure

#Random configs
cp onedark.rasi ~/onedark.rasi
cp lightdm.conf /etc/lightdm/lightdm.conf
mkdir -p ~/.config/termite/
cp config ~/.config/termite/config
cp .xsession ~/.xsession
gpasswd bobby autologin
