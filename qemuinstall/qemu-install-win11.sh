#!/bin/bash

VM_path='/home/xwx/Media/VM/'
sudo tunctl -t tap2 -u xwx
sudo ifconfig tap2 192.168.12.1 up
sudo iptables -A FORWARD -i tap2 -j ACCEPT
sudo iptables -A FORWARD -o tap2 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 192.168.12.0/24 -j MASQUERADE

qemu-system-x86_64 -m 8G \
  -machine q35,smm=on \
  -cpu host -smp 16 \
  -device vfio-pci,host=01:00.0 \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.secboot.fd \
  -drive if=pflash,format=raw,file=${VM_path}/OVMF_VARS.fd \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -device tpm-tis,tpmdev=tpm0 \
  -chardev socket,id=chrtpm,path=${VM_path}/mytpm/swtpm-sock \
  -device virtio-net,netdev=network1 \
  -netdev tap,id=network1,ifname=tap2,script=no,downscript=no,vhost=on \
  -device qemu-xhci,id=xhci \
  -usb -device usb-tablet \
  --enable-kvm -boot order=d \
  --cdrom ${VM_path}ISO/Win11_22H2_Chinese_Simplified_x64v2.iso \
  ${VM_path}win11

sh /usr/local/bin/qemu-clear.sh
