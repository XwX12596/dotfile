export LANG=zh_CN.UTF-8
export GTK_IM_MODULE DEFAULT=fcitx
export QT_IM_MODULE  DEFAULT=fcitx
export XMODIFIERS    DEFAULT=\@im=fcitx
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xrdb -merge ~/.Xresources
fcitx5 -d &
exec slstatus &
exec dwm
