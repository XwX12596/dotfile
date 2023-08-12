rm -f ./config/*
rm -rf mpv/ nvim/
cp ~/.liverc config/
cp ~/.xinitrc config/
cp ~/.Xmodmap config/
cp ~/.Xresources config/
cp ~/.zshrc config/
cp -r ~/.config/mpv/ ./
cp -r ~/.config/nvim/ ./
