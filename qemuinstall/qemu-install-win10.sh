#!/bin/bash

VM_path='/home/xwx/Code/VM/'
install_ISO='win10.ISO'
VM_img='win10'
net_addr='192.168.14'
sudo ip tuntap add dev tap-install mode tap
sudo ifconfig tap-install ${net_addr}.1 up
sudo iptables -A FORWARD -i tap-install -j ACCEPT
sudo iptables -A FORWARD -o tap-install -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s ${net_addr}.0/24 -j MASQUERADE

qemu-system-x86_64 -m 8G \
  -machine q35,smm=on \
  -cpu host -smp 16 \
  --cdrom ${VM_path}ISO/${install_ISO} \
  -drive index=0,if=pflash,format=raw,file=${VM_path}OVMF-${VM_img}.fd \
  -device virtio-net,netdev=network1 \
  -netdev tap,id=network1,ifname=tap-install,script=no,downscript=no,vhost=on \
  -device qemu-xhci,id=xhci \
  -usb -device usb-tablet \
  -vga qxl -device virtio-serial-pci \
  -spice port=3001,disable-ticketing=on \
  -device virtserialport,chardev=spice0,name=com.redhat.spice.0 \
  -chardev spicevmc,id=spice0,name=vdagent \
  --enable-kvm -boot order=d \
  ${VM_path}${VM_img}

# remote-viewer spice://localhost:3001
umount /home/xwx/VM/share-win
sudo iptables -D FORWARD -i tap-install -j ACCEPT
sudo iptables -D FORWARD -o tap-install -j ACCEPT
sudo iptables -t nat -D POSTROUTING -s ${net_addr}.0/24 -j MASQUERADE
sudo ip tuntap del dev tap-install mode tap
  # -drive media=cdrom,index=1,file=${VM_path}ISO/${install_ISO} \
  # -drive media=cdrom,index=2,file=${VM_path}ISO/virtio-win.iso \
