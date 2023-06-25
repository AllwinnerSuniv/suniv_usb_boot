#!/bin/bash

rm ninjar-lite-spinand-img.bin
dd if=u-boot-sunxi-with-spl-spinand.bin of=ninjar-lite-spinand-img.bin bs=1K conv=notrunc
#dd if=uboot-with-spl-spinand.bin of=ninjar-lite-spinand-img.bin bs=1K conv=notrunc
dd if=suniv-f1c100s-licheepi-nano.dtb of=ninjar-lite-spinand-img.bin bs=1K seek=1024 conv=notrunc
dd if=zImage of=ninjar-lite-spinand-img.bin bs=1K seek=1088 conv=notrunc
