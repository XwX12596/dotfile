#!/bin/bash
sudo tunctl -t tap1 -u xwx
sudo ifconfig tap1 192.168.12.1 up
sudo iptables -A FORWARD -i tap1 -o enp0s31f6 -j ACCEPT
sudo iptables -A FORWARD -i enp0s31f6 -o tap1 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o enp0s31f6 -s 192.168.12.0/24 -j MASQUERADE
qemu-system-x86_64 -m 8G \
  -machine q35 -device intel-iommu,caching-mode=on \
  -cpu host,hv_relaxed,hv_spinlocks=0x1fff,hv_vapic,hv_time -smp 8 \
  -device vfio-pci,host=01:00.0 \
  -device virtio-vga-gl -display gtk,gl=on \
  -device virtio-net,netdev=network1 \
  -netdev tap,id=network1,ifname=tap1,script=no,downscript=no,vhost=on \
  -device qemu-xhci,id=xhci \
  -usb -device usb-tablet \
  -device usb-host,bus=xhci.0,vendorid=0x1a86,productid=0x7523 \
  -device usb-host,bus=xhci.0,vendorid=0x045e,productid=0x0b12 \
  -device usb-host,bus=xhci.0,vendorid=0x0079,productid=0x181c \
  -audiodev pipewire,id=snd0 \
  -device ich9-intel-hda \
  -device hda-output,audiodev=snd0 \
  -drive if=pflash,format=raw,file=/home/xwx/Media/VM/OVMF.fd \
  --enable-kvm -boot order=c \
  /home/xwx/Media/VM/win10

# remote-viewer spice://localhost:3001

sh /usr/local/bin/qemu-clear.sh

  #
  # -vga qxl -device virtio-serial-pci \
  # -spice port=3001,disable-ticketing=on \
  # -device virtserialport,chardev=spice1,name=com.redhat.spice.1 \
  # -chardev spicevmc,id=spice1,name=vdagent \
  # -audiodev id=alsa,driver=alsa \
  # -device usb-host,bus=xhci.0,vendorid=0x17ef,productid=0x6104 \
  # -device usb-host,bus=xhci.0,vendorid=0x045e,productid=0x0b12 \
  # -audiodev alsa,id=snd0 \
  # -device ich9-intel-hda \
  # -device hda-duplex,audiodev=snd0 \
  #
