#!/bin/bash

umount /home/xwx/Media/VM/share*
sudo iptables -D FORWARD -i tap0 -j ACCEPT
sudo iptables -D FORWARD -o tap0 -j ACCEPT
sudo iptables -D FORWARD -i tap1 -j ACCEPT
sudo iptables -D FORWARD -o tap1 -j ACCEPT
sudo iptables -t nat -D POSTROUTING -s 192.168.12.0/24 -j MASQUERADE
sudo tunctl -d tap0
sudo tunctl -d tap1
