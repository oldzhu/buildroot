Aspeed AST2500 EVB

Introduction
============

The AST2500 EVB is an evaluation board for the AST2500 SoC, most
commonly used as a Server Management Processor. It includes an 800MHz
ARM11 processor with DDR3 or DDR4 SDRAM (up to 1GB), SPI flash memory
devices for BMC and host firmwares and numerous controllers to drive
the server board.

  https://www.aspeedtech.com/server_ast2500/

How to build it
===============

Configure buildroot:

  $ make aspeed_ast2500evb_defconfig

Compile everything and build the rootfs image:

  $ make

Result of the build
===================

After building, the output/images directory contains:

  output/images/
    ├── aspeed-ast2500-evb.dtb
    ├── flash.img
    ├── image.itb
    ├── rootfs.cpio
    ├── rootfs.cpio.xz
    ├── rootfs.tar
    ├── u-boot.bin
    └── zImage

Flashing the image
==================

To update the contents of the first flash device, copy flash.img :

  $ flashcp flash.img /dev/mtd0

or simply the boot loader:

  $ flashcp u-boot.bin /dev/mtd1

Preparing the board
===================

 * Connect a serial line to the board
 * Power-up the board

Booting the board
=================

The AST2500 EVB boots from the SPI flash device directly and loads a
first bootloader (usually U-Boot). U-Boot will attempt to load a Linux
kernel from the same flash device by default but other storage could
be used.

 * from U-Boot

   The FIT image image.itb can be used to boot the board from U-Boot
   using tftp

 * with QEMU

   $ qemu-system-arm -M ast2500-evb \
	-drive file=output/images/flash.img,format=raw,if=mtd \
	-nographic

   $ qemu-system-arm -M ast2500-evb \
	-kernel output/images/zImage \
	-initrd output/images/rootfs.cpio \
	-dtb output/images/aspeed-ast2500-evb.dtb \
	-nographic
