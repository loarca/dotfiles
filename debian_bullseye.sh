#!/bin/bash

# This shell script autoinstalls every component needed for my setup/rice

# Update system
sudo apt update && sudo apt upgrade -y

# window manager
sudo apt install -y xserver-xorg xinit
sudo apt install -y libpangocairo-1.0-0
sudo apt install -y python3-pip python3-xcffib python3-cairocffi
pip install qtile

sudo apt install -y firefox-esr
# install login manager
# window compositor
# fonts & nerd fonts
# install neovim (and perhaps lunarvim as well? we'll see)
# install zsh/fish
# get and install dotfiles


# list of files to include in dotfiles so far
# /usr/share/zsessions/qtile.desktop

# nice-to-have tools
sudo apt install neofetch
