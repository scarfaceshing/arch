#!/bin/sh

umount -A --recursive /mnt
swapoff -a
wipefs --all --force /dev/sda

sgdisk -Z /dev/sda
sgdisk -a 2048 -o /dev/sda

sgdisk -n 1::+512M --typecode=1:ef00 --change-name=1:'BOOT' /dev/sda
# sgdisk -n 2::-0 --typecode=2:8300 --change-name=2:'ROOT' /dev/sda -- pc bonbon desktop
sgdisk -n 2::-0 --typecode=2:8304 --change-name=2:'ROOT' /dev/sda

mkfs.fat -F32 /dev/sda1
mkfs.ext4 /dev/sda2

mount /dev/sda2 /mnt

mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi