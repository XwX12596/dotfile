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

# exec
fcitx5 -d &
picom -D 2 &
xlayoutdisplay -d 144
HDMI=`xrandr | grep -E 'HDMI' | awk -F' ' '{ print $2 }'`
DP1=`xrandr | grep -E 'DP-1' | awk -F' ' '{ print $2 }'`
if [[ HDMI -eq 'connected' ]]; then
  EXT-on HDMI
elif [[ DP1 -eq 'connected' ]]; then
  EXT-on DP-1
fi
systemctl --user import-environment DISPLAY
clipmenud&
while true; do 
  feh --bg-fill --no-fehbg --randomize ~/Media/wallpaper/
  sleep 120
done &
exec slstatus &
exec dwm
