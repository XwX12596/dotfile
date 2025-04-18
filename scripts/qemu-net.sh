#!/bin/bash

net_addr='192.168.14'
sudo ip tuntap add dev tap-arch mod tap
sudo ifconfig tap-arch ${net_addr}.1 up
sudo iptables -A FORWARD -i tap-install -j ACCEPT
sudo iptables -A FORWARD -o tap-install -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s ${net_addr}.0/24 -j MASQUERADE
