#!/bin/bash

sudo tunctl -t tap1 -u xwx
sudo ifconfig tap1 192.168.12.1 up
sudo iptables -A FORWARD -i tap1 -o enp0s31f6 -j ACCEPT
sudo iptables -A FORWARD -i enp0s31f6 -o tap1 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o enp0s31f6 -s 192.168.12.0/24 -j MASQUERADE
mount $HOME/Windows/Media
sudo qemu-system-x86_64 -m 8G \
  -usb -device usb-tablet \
  -device qemu-xhci,id=xhci \
  -device usb-host,bus=xhci.0,vendorid=0x1a86,productid=0x7523 \
  -net nic,macaddr=52:54:00:12:34:67 \
  -net tap,ifname=tap1,script=no,downscript=no \
  --enable-kvm -boot order=c \
  /home/xwx/Windows/Media/win10 &
