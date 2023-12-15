#!/bin/bash

VM_path='/home/xwx/Media/VM/'
sudo tunctl -t tap1 -u xwx
sudo ifconfig tap1 192.168.12.1 up
sudo iptables -A FORWARD -i tap1 -j ACCEPT
sudo iptables -A FORWARD -o tap1 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 192.168.12.0/24 -j MASQUERADE
swtpm socket --tpm2 --tpmstate dir=${VM_path}/mytpm --ctrl type=unixio,path=${VM_path}/mytpm/swtpm-sock -d

qemu-system-x86_64 -m 8G \
  -machine q35,smm=on -device intel-iommu,caching-mode=on \
  -cpu host -smp 16 \
  -drive if=pflash,format=raw,readonly=on,file=/usr/share/edk2-ovmf/x64/OVMF_CODE.secboot.fd \
  -drive if=pflash,format=raw,file=${VM_path}/OVMF_VARS.fd \
  -tpmdev emulator,id=tpm0,chardev=chrtpm \
  -device tpm-tis,tpmdev=tpm0 \
  -chardev socket,id=chrtpm,path=${VM_path}/mytpm/swtpm-sock \
  -device virtio-vga-gl -display gtk,gl=on \
  -device virtio-net,netdev=network1 \
  -netdev tap,id=network1,ifname=tap1,script=no,downscript=no,vhost=on \
  -device qemu-xhci,id=xhci \
  -device usb-host,bus=xhci.0,vendorid=0x045e,productid=0x0b12 \
  -usb -device usb-tablet \
  -audiodev pipewire,id=snd0 \
  -device ich9-intel-hda \
  -device hda-output,audiodev=snd0 \
  --enable-kvm -boot order=c \
  ${VM_path}win11

sh /usr/local/bin/qemu-clear.sh 2> /dev/null

  # -device vfio-pci,host=01:00.0 \
