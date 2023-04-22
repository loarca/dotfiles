#!/bin/bash

# This shell script autoinstalls every component needed for my setup/rice

# cd into home dir
#cd ~

# Update system
sudo apt update && sudo apt upgrade -y

# essentials
sudo apt install -y intel-microcode zsh wget curl tar git htop gzip unzip build-essential libssl-dev desktop-file-utils xdg-utils command-not-found tree resolvconf

# setup dns servers
sudo echo "nameserver 1.1.1.1\nnameserver 1.0.0.1" >> /etc/resolvconf/resolv.conf.d/head
sudo resolvconf -u

# rust / rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# letfwm - window manager
sudo apt install -y xorg xserver-xorg x11-xserver-utils libx11-6 libxinerama1
cargo install leftwm --version 0.3.0
sudo mkdir -p /usr/share/xsessions
sudo cp ./leftwm.desktop /usr/share/xsessions/
sudo ln -s ~/.cargo/bin/leftwm /usr/bin/leftwm
xdg-user-dirs-update

# display manager
sudo apt install -y lightdm
sudo systemctl enable lightdm

# feh, polybar, rofi
sudo apt install -y feh polybar rofi maim

# pipewire (and pulseaudio interface)
sudo apt install -y wireplumber
systemctl --user --now enable wireplumber.service
sudo apt install -y pipewire-pulse

# alacritty terminal
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
git clone https://github.com/alacritty/alacritty.git alacritty-repo
cd ./alacritty-repo
cargo build --release
# desktop entry for alacritty
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
# man page for alacritty
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null
# terminfo for alacritty
infocmp alacritty
# zsh completions for alacritty
# TODO
cd ..

# neovim
sudo apt install -y neovim
# packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# node / volta
curl https://get.volta.sh | bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
volta install node
volta install yarn

# go
wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
rm go1.19.1.linux-amd64.tar.gz

# pip
sudo apt install -y python3-pip python3-venv

# hugo
sudo apt install -y hugo

# docker
sudo apt install -y docker.io
sudo usermod -aG docker ale

# fonts, nerd fonts & emojis
sudo apt install -y fonts-recommended ttf-mscorefonts-installer fonts-arphic-uming fonts-wqy-zenhei fonts-unfonts-core
./nerd_fonts.sh
cp -r ./fontconfig ~/.config/
fc-cache -fv

# window compositor
sudo apt install -y picom
# dunst
# map music/fn keys (keyboard drivers? idk)

# install sheldon (shell plugin manager)
cargo install sheldon
chsh -s $(which zsh)
mkdir ~/.sheldon
cp ./.sheldon/plugins.toml ~/.sheldon/
sheldon lock
cp ./spaceship.zsh ~/.config/
cp ./.zshrc ~/

# copy ssh keys from some sort of secured vault?

# freshfetch
git clone https://github.com/K4rakara/freshfetch.git
cd freshfetch
cargo build --release -vv
sudo cp ./target/release/freshfetch /usr/local/bin/
sudo chmod 755 /usr/local/bin/freshfetch
cd ../

# macchina
sudo apt install -y libgit2-dev wmctrl
cargo install macchina

# pfetch
git clone https://github.com/dylanaraps/pfetch.git
sudo install -Dm755 ./pfetch/pfetch /usr/local/bin/pfetch

# list of files to include in dotfiles so far
cp -r ./alacritty ~/.config/
cp -r ./leftwm ~/.config/
cp ./.gitconfig ~/
cp -r ./nvim ~/.config/
# ~/.config/{leftwm,spaceship.zsh,nvim}
# zsh autocompletion files
# auto start apps (chrome, discord) TODO

# nice-to-have tools
sudo apt install -y firefox-esr neofetch exa fzf ranger hyperfine

sudo apt autoremove -y

# And now, manually install the following:
# Google Chrome
# Discord
# Spotify
# Slack
# Zoom
# WhatsApp Desktop
