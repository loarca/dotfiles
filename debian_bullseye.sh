#!/bin/bash

# This shell script autoinstalls every component needed for my setup/rice

# cd into home dir
#cd ~

# Update system
sudo apt update && sudo apt upgrade -y

# essentials
sudo apt install -y intel-microcode zsh wget curl git htop gzip unzip build-essential desktop-file-utils command-not-found

# rust / rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"

# letfwm - window manager
sudo apt install -y xorg xserver-xorg x11-xserver-utils libx11-6 libxinerama1
cargo install leftwm
sudo mkdir -p /usr/share/xsessions
sudo cp ./leftwm.desktop /usr/share/xsessions/
sudo ln -s ~/.cargo/bin/leftwm /usr/bin/leftwm
xdg-user-dirs-update

# display manager
sudo apt install -y lightdm
sudo systemctl enable lightdm

# pipewire (and pulseaudio interface)
sudo apt install -y wireplumber
systemctl --user --now enable wireplumber.service
sudo apt install -y pipewire-pulse

# alacritty terminal
sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
git clone https://github.com/alacritty/alacritty.git
cd ./alacritty
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

# node / volta
curl https://get.volta.sh | bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
volta install node
volta install yarn

# go
wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
rm https://go.dev/dl/go1.19.1.linux-amd64.tar.gz

# window compositor
# fonts, nerd fonts & emojis
sudo apt install -y fonts-recommended ttf-mscorefonts-installer fonts-arphic-uming fonts-wqy-zenhei fonts-unfonts-core
./nerd_fonts.sh
cp -r .config/fontconfig ~/.config/
fc-cache -fv

# install sheldon (shell plugin manager)
cargo install sheldon
chsh -s $(which zsh)

# get and install dotfiles
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
# add the following to the .zshrc or .profile
export PF_INFO="ascii title os host kernel shell editor wm uptime pkgs memory palette"

# hyperfine
cargo install hyperfine

# list of files to include in dotfiles so far

# ~/Pictures/wallpapers (maybe? idk)
# ~/.config/{leftwm,spaceship.zsh}
# ~/.sheldon/plugins.toml
# ~/.zshrc
# ~/.gitconfig
# zsh autocompletion files

# nice-to-have tools
sudo apt install -y exa neofetch fzf firefox-esr

sudo apt autoremove -y
