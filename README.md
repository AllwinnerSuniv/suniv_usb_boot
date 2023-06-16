<h1 align="center">
    Suniv USB Boot
</h1>

## Well

This firmware used to booting up device though usb (sunxi-fel)

This routine used to do things like:
```
1) Write Uboot Kernel Rootfs into memory and start
2) in kernel, simulate SPI NAND as a usb mass storage device
   so you can come to the pc side, use `dd` command to program the flash
```

## Version info
| routine | version |
| ------- | ------- |
| u-boot | [v2018.01](https://github.com/Lichee-Pi/u-boot) |
| kernel | [6.3.7-stable](https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.3.7.tar.xz) |
| buildroot | [v2023.2](https://buildroot.org/downloads/buildroot-2023.02.tar.gz) |

## Dirs
| Dir | define |
| ------- | ------- |
| configs | defconfig for uboot, kernel and buildroot |
| backups | original firmware collected from internet |
| overlays | for buildroot overlay, some scripts and kenrel modules |

## Build

if you want develop things based on this project

Get toolchain
```
wget http://releases.linaro.org/components/toolchain/binaries/7.2-2017.11/arm-linux-gnueabi/gcc-linaro-7.2.1-2017.11-x86_64_arm-linux-gnueabi.tar.xz
```


```
1) downlaod things in version info title
2) use configs i was provided in configs/ dir
```

i'll give more infomation about this, but not for now.

## Memory Usage
```
# free -h
              total        used        free      shared  buff/cache   available
Mem:          26.9M        4.0M       15.2M        8.0K        7.7M        4.3M
Swap:             0           0           0
```

## Suggestion

When you program the flash, you better split the file into servral pieces, like 128MB to 16 x 8MB like this:
```
# A 8MB window loop
# 1 block = 512 byte
sudo dd if=firmware.bin of=/dev/sda skip=0 count=16384
sudo dd if=firmware.bin of=/dev/sda skip=16384 count=37268
```
a full dd write may cause OOM problem because the kernel `buff/cache` feature.

## Booting log
```
U-Boot SPL 2018.01ninjar-lite-ga9729b3-dirty (Jun 16 2023 - 04:00:35)
DRAM: 32 MiB
Trying to boot from FEL


U-Boot 2018.01ninjar-lite-ga9729b3-dirty (Jun 16 2023 - 04:00:35 +0000) Allwinner Technology

CPU:   Allwinner F Series (SUNIV)
Model: Lichee Pi Nano
DRAM:  32 MiB
MMC:   SUNXI SD/MMC: 0
SF: unrecognized JEDEC id bytes: 00, ef, aa
*** Warning - spi_flash_probe_bus_cs() failed, using default environment

In:    serial@1c25000
Out:   serial@1c25000
Err:   serial@1c25000
Net:   No ethernet found.
starting USB...
No controllers found
Hit any key to stop autoboot:  0 
## Loading init Ramdisk from Legacy Image at 80d00000 ...
   Image Name:   
   Image Type:   ARM Linux RAMDisk Image (uncompressed)
   Data Size:    1982255 Bytes = 1.9 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 80c00000
   Booting using the fdt blob at 0x80c00000
   Loading Ramdisk to 8151c000, end 816fff2f ... OK
   Loading Device Tree to 81517000, end 8151bb6d ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 6.3.7-ninjar-lite (developer@lunarpc) (arm-linux-gnueabi-gcc (Lin3
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] OF: fdt: Machine model: Lichee Pi Nano
[    0.000000] Memory policy: Data cache writeback
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000080000000-0x0000000081ffffff]
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x0000000081ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x0000000081ffffff]
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 8128
[    0.000000] Kernel command line: console=ttyS0,115200 panic=5 rootwait root=/dev/ram0 rdiniM
[    0.000000] Unknown kernel command line parameters "earlyprintk", will be passed to user sp.
[    0.000000] Dentry cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    0.000000] Inode-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 24552K/32768K available (3072K kernel code, 534K rwdata, 876K rodata, 1)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000008] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000115] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635s
[    0.000709] Console: colour dummy device 80x30
[    0.000852] Calibrating delay loop... 346.52 BogoMIPS (lpj=1732608)
[    0.060196] pid_max: default: 32768 minimum: 301
[    0.060493] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.060551] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.061980] CPU: Testing write buffer coherency: ok
[    0.065596] Setting up static identity map for 0x80100000 - 0x8010003c
[    0.067348] devtmpfs: initialized
[    0.071735] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 191s
[    0.071813] futex hash table entries: 256 (order: -1, 3072 bytes, linear)
[    0.072036] pinctrl core: initialized pinctrl subsystem
[    0.074361] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.090506] usbcore: registered new interface driver usbfs
[    0.090638] usbcore: registered new interface driver hub
[    0.090767] usbcore: registered new device driver usb
[    0.091651] clocksource: Switched to clocksource timer
[    0.128063] NetWinder Floating Point Emulator V0.97 (double precision)
[    0.129722] Initialise system trusted keyrings
[    0.131305] Unpacking initramfs...
[    0.143608] workingset: timestamp_bits=30 max_order=13 bucket_order=0
[    0.328587] Key type asymmetric registered
[    0.328629] Asymmetric key parser 'x509' registered
[    0.328809] io scheduler mq-deadline registered
[    0.328840] io scheduler kyber registered
[    0.875756] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    0.889301] Loading compiled-in X.509 certificates
[    0.915119] gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic alloc.
[    0.924192] suniv-f1c100s-pinctrl 1c20800.pinctrl: initialized sunXi PIO driver
[    0.925460] suniv-f1c100s-pinctrl 1c20800.pinctrl: supply vcc-pe not found, using dummy regr
[    0.942232] printk: console [ttyS0] disabled
[    0.962558] 1c25000.serial: ttyS0 at MMIO 0x1c25000 (irq = 116, base_baud = 6250000) is a 1A
[    0.962717] printk: console [ttyS0] enabled
[    1.388810] Freeing initrd memory: 1936K
[    1.393973] suniv-f1c100s-pinctrl 1c20800.pinctrl: supply vcc-pc not found, using dummy regr
[    1.403807] sun6i-spi 1c05000.spi: Failed to request TX DMA channel
[    1.410119] sun6i-spi 1c05000.spi: Failed to request RX DMA channel
[    1.418845] spi-nand spi0.0: Winbond SPI NAND was found.
[    1.424298] spi-nand spi0.0: 128 MiB, block size: 128 KiB, page size: 2048, OOB size: 64
[    1.437477] suniv-f1c100s-pinctrl 1c20800.pinctrl: supply vcc-pd not found, using dummy regr
[    1.450098] usb_phy_generic usb_phy_generic.0.auto: dummy supplies not allowed for exclusivs
[    1.460610] musb-hdrc musb-hdrc.1.auto: MUSB HDRC host driver
[    1.466595] musb-hdrc musb-hdrc.1.auto: new USB bus registered, assigned bus number 1
[    1.477409] hub 1-0:1.0: USB hub found
[    1.481352] hub 1-0:1.0: 1 port detected
[    1.493512] Freeing unused kernel image (initmem) memory: 1024K
[    1.499632] Run /linuxrc as init process
setting up min_free_kbytes to 8192
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Starting network: ip: socket: Function not implemented
ip: socket: Function not implemented
FAIL
Starting modprobe g_mass_storage: [    1.900604] Mass Storage Function, version: 2009/09/11
[    1.905904] LUN: removable file: (no medium)
[    1.910482] mtdblock: MTD device 'spi0.0' is NAND, please consider using UBI block devices .
[    1.919707] LUN: removable file: /dev/mtdblock0
[    1.924335] Number of LUNs=1
[    1.928356] g_mass_storage gadget.0: Mass Storage Gadget, version: 2009/09/11
[    1.935654] g_mass_storage gadget.0: userspace failed to provide iSerialNumber
[    1.942970] g_mass_storage gadget.0: g_mass_storage ready
OK
enable led trigger for MTD activity

Welcome to NINJAR system
ninjar login: [    4.841899] random: crng init done

```


<h2 align="center">
    Present by <a href="https://embeddedboys.github.io/">embeddedboys</a>
</h2>