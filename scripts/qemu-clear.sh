#!/bin/bash

# umount /home/xwx/Media/VM/share*
sudo iptables -D FORWARD -i tap-${1} -j ACCEPT
sudo iptables -D FORWARD -o tap-${1} -j ACCEPT
sudo iptables -t nat -D POSTROUTING -s 192.168.12.0/24 -j MASQUERADE
sudo ip tuntap del dev tap-install mod tap
