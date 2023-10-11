#!/bin/bash

sudo tunctl -t tap0 -u xwx
sudo ifconfig tap0 192.168.12.1 up
sudo iptables -A FORWARD -i tap0 -o enp0s31f6 -j ACCEPT
sudo iptables -A FORWARD -i enp0s31f6 -o tap0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o enp0s31f6 -s 192.168.12.0/24 -j MASQUERADE
mount $HOME/Windows/Media
sudo qemu-system-x86_64 -m 4G \
  -net nic,macaddr=52:54:00:12:34:56 \
  -net tap,ifname=tap0,script=no,downscript=no \
  --nographic --enable-kvm -boot order=c \
  /home/xwx/Windows/Media/ubuntu &
