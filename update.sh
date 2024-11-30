#!/bin/bash
if [[ -e ~/.config/mpv ]];then
	rm -rf mpv/
	cp -r ~/.config/mpv/ ./
else
	echo NO MPV!
fi
if [[ -e ~/.config/nvim ]];then
	rm -rf nvim
	cp -r ~/.config/nvim/ ./
else
	echo NO NEOVIM!
fi

cp ~/.liverc config/liverc
cp ~/.zshrc config/zshrc
cp ~/.config/yt-dlp/config ./config/yt-dlp.conf
cp ~/.config/kitty/kitty.conf ./config/kitty.conf
cp ~/.config/kitty/Dracula.conf ./config/Dracula.conf

cp -r ~/.config/Typora/themes/drake* ./typora/
cp -r ~/Media/VM/install/ ./qemuinstall

cp ~/.xinitrc config/xinitrc
cp ~/.Xmodmap config/Xmodmap
cp ~/.Xresources config/Xresources
