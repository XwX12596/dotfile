#!/bin/bash

VM_path='/home/xwx/Media/VM/'
VM_img='arch'
net_addr='192.168.14'
sudo ip tuntap add dev tap-${VM_img} mode tap
sudo ifconfig tap-arch ${net_addr}.1 up
sudo iptables -A FORWARD -i tap-${VM_img} -j ACCEPT
sudo iptables -A FORWARD -o tap-${VM_img} -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s ${net_addr}.0/24 -j MASQUERADE

qemu-system-x86_64 -m 8G \
  -machine q35,smm=on \
  -cpu host -smp 16 \
  -drive if=pflash,format=raw,file=${VM_path}OVMF/OVMF-${VM_img}.fd \
  -device virtio-net,netdev=network-${VM_img} \
  -netdev tap,id=network-${VM_img},ifname=tap-${VM_img},script=no,downscript=no,vhost=on \
  -device qemu-xhci,id=xhci \
  -usb -device usb-tablet \
  -vga qxl -device virtio-serial-pci \
  -spice port=3001,disable-ticketing=on \
  -device virtserialport,chardev=spice0,name=com.redhat.spice.0 \
  -chardev spicevmc,id=spice0,name=vdagent \
  --enable-kvm -boot order=d \
  ${VM_path}${VM_img} &

remote-viewer spice://localhost:3001
# umount /home/xwx/Media/VM/share-lin
sudo iptables -A FORWARD -i tap-${VM_img} -j ACCEPT
sudo iptables -A FORWARD -o tap-${VM_img} -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s ${net_addr}.0/24 -j MASQUERADE
sudo iptables -t nat -D POSTROUTING -s ${net_addr}.0/24 -j MASQUERADE
sudo ip tuntap del dev tap-${VM_img} mode tap

