#!/usr/bin/env bash
user1="$(id -u -n)"
#Dependencies
sudo pacman --noconfirm -Sy sbcl stack nitrogen fd zsh xorg-xset xloadimage lightdm-gtk-greeter git emacs ripgrep tar clang xmonad xmonad-contrib xmobar stalonetray xcompmgr rofi termite xorg-server compton

#Emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom -y install
cp -r .doom.d/* ~/.doom.d/
~/.emacs.d/bin/doom -y sync

# XMonad
mkdir ~/.xmonad/
cp -r .xmonad/* ~/.xmonad
xmonad --recompile

mkdir ~/.zsh/
git clone https://github.com/sindresorhus/pure.git ~/.zsh/pure

#Random configs
cp onedark.rasi ~/onedark.rasi
sudo cp lightdm.conf /etc/lightdm/lightdm.conf
#Add to autologin
sudo sed -i '120s/.*/autologin-user='$user1'/' /etc/lightdm/lightdm.conf
mkdir -p ~/.config/termite/
cp config ~/.config/termite/config
cp .xsession ~/.xsession
sudo chmod +x ~/.xsession
sudo gpasswd -a $user1 autologin
mkdir ~/Downloads/
cp *.xpm ~/Downloads/

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# ZSH STUFF
cp .zsh_history ~/.zsh_history
cp .zshrc ~/.zshrc

#add lightdm to system startup, add emacs-server to system startup
sudo systemctl enable lightdm
sudo /etc/init.d/dbus &
su $user1 systemctl --user enable emacs
sudo usermod --shell /usr/bin/zsh $user1
#use nitrogen to set wallpaper
cp night.jpg ~/Downloads/night.jpg
mkdir -p ~/.config/nitrogen
cp bg-saved.cfg ~/.config/nitrogen/bg-saved.cfg
#echo "Enter location of background image, use \/ instead of /"
#read bg
#sed -i '2s/.*/file='$bg'/' ~/.config/nitrogen/bg-saved.cfg
