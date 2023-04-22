#!/bin/bash
sudo mkdir -p /usr/local/share/fonts

fonts=( 
"CascadiaCode"
"FiraCode" 
# "Go-Mono" 
# "Hack" 
# "Inconsolata" 
# "Iosevka" 
"JetBrainsMono" 
# "Mononoki" 
# "RobotoMono" 
# "SourceCodePro" 
# "Meslo"
# "Noto"
)

for font in ${fonts[@]}
do
    wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$font.zip
    sudo unzip $font.zip -d /usr/local/share/fonts/$font/
    rm $font.zip
done
