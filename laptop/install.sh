#!/usr/bin/env bash

#Dependencies
sudo pacman --noconfirm -Sy fd zsh xorg-xset xloadimage lightdm-gtk-greeter git emacs ripgrep tar clang xmonad xmonad-contrib xmobar stalonetray xcompmgr rofi termite xorg-server compton

#Emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom -y install
cp -r .doom.d/* "~/.doom.d/"
~/.emacs.d/bin/doom -y sync

# XMonad
mkdir ~/.xmonad
cp -r .xmonad/* "~/.xmonad"

# ZSH STUFF
cp .zsh_history "~/.zsh_history"
cp .zshrc "~/.zshrc"

mkdir ~/.zsh/
git clone https://github.com/sindresorhus/pure.git ~/.zsh/pure

#Random configs
cp onedark.rasi ~/onedark.rasi
sudo cp lightdm.conf /etc/lightdm/lightdm.conf
mkdir -p ~/.config/termite/
cp config ~/.config/termite/config
cp .xsession ~/.xsession
sudo gpasswd bobby autologin
mkdir ~/Downloads/
cp *.xpm ~/Downloads/

#this quits the script so it needs to go at the end
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
