#!/bin/sh

echo "\nPrepare your sd card, you need 2 partitions :"
echo "	- A small bootable one with at least 10Mb in FAT"
echo "	- a bigger one for the rootfs, use the filesystem you want"
echo "Use gparted or any similar tool, umount your newly created partitions and give to this script the /dev/sdX paths : "

echo "\n Warning : an error could damage your PC partitions, take your responsabilities"
echo "please enter the boot partition : "
read BOOT_PARTITION_PATH

if [ -b "$BOOT_PARTITION_PATH" ]
then
	echo "$BOOT_PARTITION_PATH found."
else
	echo "$BOOT_PARTITION_PATH not found."
	exit 1
fi



echo "\nplease enter the rootfs partition : "
read ROOTFS_PARTITION_PATH

if [ -b "$ROOTFS_PARTITION_PATH" ]
then
	echo "$ROOTFS_PARTITION_PATH found."
else
	echo "$ROOTFS_PARTITION_PATH not found."
	exit 1
fi

#create tmp folders
mkdir board/opensono/tmp
MNT_BOOT_PATH=board/opensono/tmp/boot
MNT_ROOTFS_PATH=board/opensono/tmp/rootfs

mkdir $MNT_BOOT_PATH
mkdir $MNT_ROOTFS_PATH

sudo mount $BOOT_PARTITION_PATH $MNT_BOOT_PATH
sudo mount $ROOTFS_PARTITION_PATH $MNT_ROOTFS_PATH

sudo rm $MNT_BOOT_PATH/* -rf
sudo rm $MNT_ROOTFS_PATH/* -rf


sudo cp -r output/images/rpi-firmware/*  $MNT_BOOT_PATH
sudo cp output/images/zImage $MNT_BOOT_PATH
sudo tar xf output/images/rootfs.tar -C $MNT_ROOTFS_PATH

sync

sudo umount $MNT_ROOTFS_PATH
sudo umount $MNT_BOOT_PATH

rm -rf board/opensono/tmp

