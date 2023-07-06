#!/bin/bash

UBOOT_OFFSET=0
DTB_OFFSET=1024
KERNEL_OFFSET=1152
ROOTFS_OFFSET=5248

rm ninjar-lite-spinand-img.bin
dd if=u-boot-sunxi-with-spl-spinand.bin of=ninjar-lite-spinand-img.bin bs=1K conv=notrunc
dd if=suniv-f1c100s-licheepi-nano.dtb of=ninjar-lite-spinand-img.bin bs=1K seek=${DTB_OFFSET} conv=notrunc
dd if=zImage of=ninjar-lite-spinand-img.bin bs=1K seek=${KERNEL_OFFSET} conv=notrunc
#dd if=rootfs.ubifs of=ninjar-lite-spinand-img.bin bs=1K seek=${ROOTFS_OFFSET} conv=notrunc
dd if=rootfs.jffs2 of=ninjar-lite-spinand-img.bin bs=1K seek=${ROOTFS_OFFSET} conv=notrunc
