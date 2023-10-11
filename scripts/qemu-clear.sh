#!/bin/bash

sudo tunctl -d tap0
sudo iptables -D FORWARD -i tap0 -o enp0s31f6 -j ACCEPT
sudo iptables -D FORWARD -i enp0s31f6 -o tap0 -j ACCEPT
sudo iptables -t nat -D POSTROUTING -o enp0s31f6 -s 192.168.12.0/24 -j MASQUERADE
mount $HOME/Windows/Media
