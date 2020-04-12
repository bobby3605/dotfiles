#!/usr/bin/env bash

#Dependencies
sudo pacman -Sy zsh xorg-xset xloadimage lightdm-gtk-greeter git emacs ripgrep tar clang xmonad xmonad-contrib xmobar stalonetray xcompmgr rofi termite xorg-server compton

#Emacs
su bobby -c "git clone https://github.com/hlissner/doom-emacs ~/.emacs.d"
su bobby -c "~/.emacs.d/bin/doom install"
su bobby -c "cp -r .doom.d "$HOME/.doom.d/""
su bobby -c "~/.emacs.d/bin/doom sync"

# XMonad
su bobby -c "cp -r .xmonad "$HOME/.xmonad""

# ZSH STUFF
su bobby -c "sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)""
su bobby -c "cp .zsh_history "~/.zsh_history""
su bobby -c "cp .zshrc "~/.zshrc""

su bobby -c "mkdir -p ~/.zsh"
su bobby -c "git clone https://github.com/sindresorhus/pure.git .zsh/pure"

#Random configs
su bobby -c "cp onedark.rasi ~/onedark.rasi"
cp lightdm.conf /etc/lightdm/lightdm.conf
su bobby -c "mkdir -p ~/.config/termite/"
su bobby -c "cp config ~/.config/termite/config"
su bobby -c "cp .xsession ~/.xsession"
gpasswd bobby autologin
