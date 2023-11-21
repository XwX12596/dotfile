#!/bin/bash

umount /home/xwx/Media/VM/share*
sudo tunctl -d tap0
sudo tunctl -d tap1
sudo iptables -t nat -D POSTROUTING -o enp0s31f6 -s 192.168.12.0/24 -j MASQUERADE
