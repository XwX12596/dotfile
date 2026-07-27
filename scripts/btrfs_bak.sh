datetime=$(date +%Y%m%d%H%M)
device=$(findmnt -t btrfs -o SOURCE | grep -oE '/dev/nvme.n1p2' | sort -u)

sudo rsync -a --mkpath --delete /boot/ /.bootbak/$datetime/ && echo "bootbak in $datetime"
sudo mount -t btrfs -o compress=zstd $device /mnt && echo "$device mounted to /mnt"
sudo mkdir /mnt/@snapshots/$datetime && echo "/mnt/@snapshots/$datetime created"
echo "Exec cmds below"
echo "sudo btrfs sub snap /mnt/@ /mnt/@snapshots/$datetime/@"
echo "sudo btrfs sub snap /mnt/@home /mnt/@snapshots/$datetime/@home"
echo "sudo umount /mnt"

echo "That's ALL!"
