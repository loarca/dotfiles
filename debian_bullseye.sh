#!/bin/bash

# This shell script autoinstalls every component needed for my setup/rice

# cd into home dir
#cd ~

# Update system
sudo apt update && sudo apt upgrade -y

# essentials
sudo apt install -y intel-microcode zsh wget curl git htop build-essential fzf

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# letfwm - window manager
sudo apt install -y xorg xserver-xorg x11-xserver-utils libx11-6 libxinerama1
cargo install leftwm
sudo cp ./leftwm.desktop /usr/share/xsessions/
xdg-user-dirs-update

# display manager
sudo apt install -y lightdm
sudo systemctl enable lightdm

# kitty terminal
sudo apt install kitty

# alacritty terminal

# neovim
sudo apt install neovim

# volta
curl https://get.volta.sh | bash
volta install node
volta install yarn

# window compositor
# fonts & nerd fonts
# install oh-my-zsh or z4h or oh-my-fish
sudo apt install -y firefox-esr
# get and install dotfiles
# copy ssh keys from some sort of secured vault?


# list of files to include in dotfiles so far
# /usr/share/xsessions/leftwm.desktop
# ~/.gitconfig
# ~/.config/leftwm/config.toml
# ~/Pictures/wallpapers (maybe? idk)

# nice-to-have tools
sudo apt install -y neofetch
