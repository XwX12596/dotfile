#!/bin/bash

VM_path='/home/xwx/Media/VM/'
VM_img='win10'
sudo tunctl -t tap1 -u xwx
sudo ifconfig tap1 192.168.13.1 up
sudo iptables -A FORWARD -i tap1 -j ACCEPT
sudo iptables -A FORWARD -o tap1 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 192.168.13.0/24 -j MASQUERADE

qemu-system-x86_64 -m 8G \
  --enable-kvm -machine q35 -device intel-iommu,caching-mode=on \
  -cpu host -smp 16 \
  -drive if=pflash,format=raw,file=${VM_path}/OVMF/OVMF-${VM_img}.fd \
  -device virtio-net,netdev=network1 \
  -netdev tap,id=network1,ifname=tap1,script=no,downscript=no,vhost=on \
  -device qemu-xhci,id=xhci \
  -usb -device usb-tablet \
  -device usb-host,bus=xhci.0,vendorid=0xf182,productid=0x0003 \
  -audiodev pipewire,id=snd0 \
  -device ich9-intel-hda \
  -device hda-output,audiodev=snd0 \
  -device virtio-vga-gl -display gtk,gl=on \
  -boot order=c \
  ${VM_path}${VM_img}

# remote-viewer spice://localhost:3001

umount /home/xwx/Media/VM/share-win
sudo iptables -D FORWARD -i tap1 -j ACCEPT
sudo iptables -D FORWARD -o tap1 -j ACCEPT
sudo iptables -t nat -D POSTROUTING -s 192.168.13.0/24 -j MASQUERADE
sudo tunctl -d tap1
# sh /usr/local/bin/qemu-clear.sh 2> /dev/null

  # -vga qxl -device virtio-serial-pci \
  # -spice port=3001,disable-ticketing=on \
  # -device virtserialport,chardev=spice0,name=com.redhat.spice.0 \
  # -chardev spicevmc,id=spice0,name=vdagent \
  #
  # -device usb-host,bus=xhci.0,vendorid=0x258a,productid=0x0049 \
  # -device usb-host,bus=xhci.0,vendorid=0x05ac,productid=0x0256 \
  # -device usb-host,bus=xhci.0,vendorid=0xf182,productid=0x0003 \
  # -device usb-host,bus=xhci.0,vendorid=0x18d1,productid=0x4ee7 \
  # f182:0003
  # -device vfio-pci,host=01:00.0 \
