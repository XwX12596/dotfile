#!/bin/bash
# fcitx5
export LANG=zh_CN.UTF-8
export GTK_IM_MODULE DEFAULT=fcitx
export QT_IM_MODULE  DEFAULT=fcitx
export XMODIFIERS    DEFAULT=\@im=fcitx

# CapsLock&Escape
xmodmap ~/.Xmodmap

# ChangeTouchpadAction
devid=$(xinput | grep "Touchpad" | awk {'print $6'}| awk -F= {'print $2'})
propidTap=`xinput list-props ${devid} | grep "libinput Tapping Enabled (" | awk -F" " {'print $4'}`
propidScroll=`xinput list-props ${devid} | grep "libinput Natural Scrolling Enabled (" | awk -F" " {'print $5'}`
propidTap=${propidTap:1:3}
propidScroll=${propidScroll:1:3}
xinput set-prop ${devid} ${propidTap} 1
xinput set-prop ${devid} ${propidScroll} 1

# dpi
xrdb -merge ~/.Xresources

# execj
fcitx5 -d &
# picom -D 2 &
# int-off
systemctl --user import-environment DISPLAY
clipmenud&
while true; do 
  feh --bg-fill --no-fehbg --randomize ~/Media/Picture/wallpaper/wallpaper
  sleep 120
done &
exec slstatus &
int-off
exec dwm
