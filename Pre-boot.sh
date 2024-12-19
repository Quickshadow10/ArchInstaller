#!/usr/bin/env bash

#Ask for drive to partition/edit
echo "Please enter drive to edit."
echo "Example: ${drive}"
read drive

#Ask for Hostname
echo "Please enter hostname."
read hostnm


# Inform the user about the partition removal process
echo "Removing all existing partitions on ${drive}..."

# Wipe the partition table on ${drive}
wipefs -a ${drive}
parted ${drive} --script mklabel gpt

# Confirm that all partitions have been removed
echo "All existing partitions have been removed, and GPT label is created."

# Create the partitions
echo "Creating ${drive}1 (1G)..."
parted ${drive} --script mkpart primary 1MiB 1GiB
parted ${drive} --script set 1 boot on

echo "Creating ${drive}2 (64G)..."
parted ${drive} --script mkpart primary 1GiB 65GiB

echo "Creating ${drive}3 (Remaining space)..."
parted ${drive} --script mkpart primary 65GiB 100%

# Inform the user that partitioning is complete
echo "Partitioning complete!"
parted ${drive} --script print

# Format Partitions
echo "Formatting Partitions..."
mkfs.fat -F 32 ${drive}1
mkswap ${drive}2
mkfs.ext4 ${drive}3

# Mounting Partitions
echo "Mounting Partitions..."
mount --mkdir ${drive}1 /mnt/boot
swapon ${drive}2
mount ${drive}3 /mnt
lsblk

#Installing essential packages
echo "Installing essential packages..."
pacstap -K /mnt base linux-firmware sof-firmware networkmanager nano base-devel man-db --noconfirm --needed
pacstrap -K amd-ucode --noconfirm --needed
#pacstrap -K intel-ucode --noconfirm --needed

#Configuring System
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab
echo "Changing Timezone to EST"
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/New
hwclock --systohc
sed -i 's/#en_US.UTF-8/en_Us.UTF-8' /etc/locale.gen
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
touch /etc/hostname
echo "$hostnm" >> /etc/hostname
mkinitcpio -P 
echo "Please Enter Your Root Password"
passwd

#Systemd Install
echo "Installing Bootloader: Systemd"
bootctl install --esp-path /mnt/boot
cat <<EOF > /mnt/boot/loader/entries/arch.conf
title Arch Linux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=${drive}p3 rw
EOF
cat <<EOF > /mnt/esp/loader/loader.conf
default arch.conf
timeout 4
console-mode max
editor no
EOF
arch-chroot /mnt

echo "--------------------------------------"
echo "--   SYSTEM READY FOR FIRST BOOT    --"
echo "--------------------------------------"