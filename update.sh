#!/bin/bash
rm -f ./config/*
rm -rf mpv/ nvim/

cp ~/.liverc config/
cp ~/.xinitrc config/
cp ~/.Xmodmap config/
cp ~/.Xresources config/
cp ~/.zshrc config/
cp ~/.config/yt-dlp/config ./config/yt-dlp.conf
cp ~/.config/kitty/kitty.conf ./config/kitty.conf
cp ~/.config/kitty/Dracula.conf ./config/Dracula.conf

cp -r ~/.config/Typora/themes/drake* ./typora/
cp -r ~/.config/mpv/ ./
cp -r ~/.config/nvim/ ./
