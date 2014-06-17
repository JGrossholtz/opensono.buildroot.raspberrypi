#!/bin/sh
BUILDROOT_PATH=$PWD

echo $PWD

cd ../wifi/rtl8188eu/

PATH=$PATH:$BUILDROOT_PATH/output/host/usr/bin  make -j2 ARCH=arm CROSS_COMPILE=arm-buildroot-linux-uclibcgnueabi- KSRC=$BUILDROOT_PATH/output/build/linux-*

WIFI_RTL8188_PATH=$PWD
echo $PWD
cd -


echo $PWD
#copy the module and the firmware to the rootfs
cp $WIFI_RTL8188_PATH/8188eu.ko output/target/root/
cp $WIFI_RTL8188_PATH/rtl8188eufw.bin output/target/lib/firmware/rtlwifi/

#update the wpa supplican configuration and the network config to load rtl8188eu
cp board/opensono/wpa_supplicant.conf output/target/etc/
#cp board/opensono/S40network output/target/etc/init.d/

