#!/bin/bash

# This script is used to boot device though USB

#if [ "$(whoami)" != "root"  ]; then
#    echo "this scrpit need to be run as root"
#    exit -1
#fi


loop=9
for loop in {9..0..1}
do
    echo "[ $loop ] waiting for fel mode online ..."
    sudo sunxi-fel ver >> /dev/null 2>&1
    if [ "$?" == "0"  ]; then
        echo "device detected!"
        break
    else
        sleep 0.5
    fi
done

if [ $loop -eq 0  ]; then
    echo "can't find any device in fel mode! exiting..."
    exit -1
fi

echo "pushing things though usb ..."
sudo sunxi-fel -p uboot u-boot-sunxi-with-spl.bin \
    write 0x80008000 zImage \
    write 0x80C00000 suniv-f1c100s-licheepi-nano.dtb \
    write 0x80D00000 rootfs.cpio.uboot

echo "done. waiting for autoboot ..."

exit $?
