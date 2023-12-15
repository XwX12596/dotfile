#!/bin/bash

VM_path='/home/xwx/Media/VM/'
sudo tunctl -t tap0 -u xwx > /dev/null
sudo ifconfig tap0 192.168.12.1 up
sudo iptables -A FORWARD -i tap0 -j ACCEPT
sudo iptables -A FORWARD -o tap0 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 192.168.12.0/24 -j MASQUERADE
qemu-system-x86_64 -m 8G \
  -machine q35 -device intel-iommu,caching-mode=on \
  -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -smp $(nproc) \
  -device vfio-pci,host=01:00.0 \
  -device virtio-net,netdev=network0 \
  -netdev tap,id=network0,ifname=tap0,script=no,downscript=no,vhost=on \
  -audiodev pipewire,id=snd0 \
  -device ich9-intel-hda \
  -device hda-output,audiodev=snd0 \
  -device virtio-vga-gl -display gtk,gl=on \
  --enable-kvm -boot order=c \
  -drive if=pflash,format=raw,file=${VM_path}OVMF.fd \
  ${VM_path}ubuntu
 
# remote-viewer spice://localhost:3000

sh /usr/local/bin/qemu-clear.sh
  # -vga qxl -device virtio-serial-pci \
  # -spice port=3000,disable-ticketing=on \
  # -device virtserialport,chardev=spice0,name=com.redhat.spice.0 \
  # -chardev spicevmc,id=spice0,name=vdagent \
  # -device virtio-vga-gl -display gtk,gl=on \

