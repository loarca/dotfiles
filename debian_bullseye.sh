#!/bin/bash

# This shell script autoinstalls every component needed for my setup/rice

# cd into home dir
cd ~

# Update system
sudo apt update && sudo apt upgrade -y

# misc
sudo apt install -y zsh wget curl git htop build-essential

# window manager
sudo apt install -y xserver-xorg xinit
sudo apt install -y libpangocairo-1.0-0
sudo apt install -y python3-pip python3-xcffib python3-cairocffi
pip install qtile
xdg-user-dirs-update

# display manager
sudo apt install -y lightdm
sudo dpkg-reconfigure lightdm

# kitty terminal
sudo apt install -y libxcb-xkb1
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/

# neovim
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
git clone https://github.com/neovim/neovim
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install --lts

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# lunarvim? idk we'll see
bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

# window compositor
# fonts & nerd fonts
# install neovim (and perhaps lunarvim as well? we'll see)
# install zsh/fish
sudo apt install -y firefox-esr nitrogen

# get and install dotfiles
# copy ssh keys from some sort of secured vault?


# list of files to include in dotfiles so far
# /usr/share/xsessions/qtile.desktop
# ~/.gitconfig
# ~/.config/qtile/config.py
# ~/Pictures/wallpapers

# nice-to-have tools
sudo apt install -y neofetch
