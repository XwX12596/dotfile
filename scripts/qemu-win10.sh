#!/bin/bash
VM_path='/home/xwx/Code/VM/'
sudo ip tuntap add dev tap-win mode tap user xwx
sudo ifconfig tap-win 192.168.12.1 up
# sudo iptables -A FORWARD -i tap-win -o enp5s0 -j ACCEPT
# sudo iptables -A FORWARD -i enp5s0 -o tap-win -j ACCEPT
# sudo iptables -t nat -A POSTROUTING -o enp5s0 -s 192.168.12.0/24 -j MASQUERADE
sudo iptables -A FORWARD -i tap-win -j ACCEPT
sudo iptables -A FORWARD -o tap-win -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o enp5s0 -s 192.168.12.0/24 -j MASQUERADE
 
qemu-system-x86_64 -m 16G \
  --enable-kvm -machine q35 -device intel-iommu,caching-mode=on \
  -cpu host -smp 8 \
  -boot order=d \
  -device virtio-vga-gl -display gtk,gl=on \
  -device virtio-net,netdev=network1 \
  -netdev tap,id=network1,ifname=tap-win,script=no,downscript=no,vhost=on \
  -chardev spicevmc,id=spice1,name=vdagent \
  -device qemu-xhci,id=xhci \
  -usb -device usb-tablet \
  -audiodev pipewire,id=snd0 \
  -device ich9-intel-hda \
  -device hda-output,audiodev=snd0 \
  -drive if=pflash,format=raw,file=${VM_path}OVMF-win10.fd \
  -monitor unix:/tmp/qemu-monitor-win.sock,server,nowait \
  --cdrom ${VM_path}ISO/virtio-win.iso \
  ${VM_path}win10

# remote-viewer spice://localhost:3001
# sleep 10
# sudo mount -t cifs //192.168.12.2/Desktop ~/Code/VM/share-win -o username=xwx,password=Hh2001,uid=1000,gid=1000
# sleep 10

# echo "Press Any Key to SHUTDOWN!"
# read
bash /usr/local/bin/qemu-clear.sh win
# echo "system_powerdown" | socat - UNIX-CONNECT:/tmp/qemu-monitor-win.sock


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
  # -device virtio-vga-gl -display gtk,gl=on \
  #
  # -device virtio-vga-gl -display gtk,gl=on \
  #
  # -device usb-host,bus=xhci.0,vendorid=0x1a86,productid=0x7523 \
  # -device usb-host,bus=xhci.0,vendorid=0x045e,productid=0x0b12 \
  # -device usb-host,bus=xhci.0,vendorid=0x0079,productid=0x181c \
  # -device usb-host,bus=xhci.0,vendorid=0x258a,productid=0x0049 \
  # -device vfio-pci,host=01:00.0 \
  # --cdrom ${VM_path}ISO/virtio-win.iso \
  # -virtfs local,path=/home/xwx/,security_model=passthrough,mount_tag=hostshare \
  # -display spice-app \
  # -vga qxl \
  # -vga none -device qxl-vga,vgamem_mb=64 \
  # -device virtio-serial-pci \
  # -spice port=3001,disable-ticketing=on \
  # -device virtserialport,chardev=spice1,name=com.redhat.spice.1 \
