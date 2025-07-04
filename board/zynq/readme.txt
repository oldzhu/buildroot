This is the Buildroot support for Zynq boards.  Zynq boards are available from
Xilinx and some third party vendors, but the build procedure is very similar.

Currently, four boards are natively supported by Buildroot:
 - Xilinx ZC702 board (zynq_zc702_defconfig)
 - Xilinx ZC706 board (zynq_zc706_defconfig)
 - Avnet ZedBoard (zynq_zed_defconfig)
 - Avnet MicroZed (zynq_microzed_defconfig)

Steps to create a working system for a Zynq board:

1) Configuration (do one of the following)
    make zynq_zc702_defconfig     (ZC702)
    make zynq_zc706_defconfig     (ZC706)
    make zynq_zed_defconfig       (Zedboard)
    make zynq_microzed_defconfig  (MicroZed)
2) make
3) All needed files will be available in the output/images directory.
   The sdcard.img file is a complete bootable image ready to be written
   on the boot medium. To install it, simply copy the image to an SD
   card:

       # dd if=output/images/sdcard.img of=/dev/sdX

   Where 'sdX' is the device node of the uSD.
4) boot your board

You can alter the booting procedure by creating a file uEnv.txt
in the root of the SD card. It is a plain text file in format
<key>=<value> one per line:

kernel_image=myimage
modeboot=myboot
myboot=...

References:
 - ZC702 information including schematics, reference designs, and manuals are
   available from
   https://www.xilinx.com/products/boards-and-kits/ek-z7-zc702-g.html

 - ZC706 information including schematics, reference designs, and manuals are
   available from
   http://www.xilinx.com/products/boards-and-kits/ek-z7-zc706-g.html.

 - Zedboard/Microzed information including schematics, reference designs, and
   manuals are available from http://www.zedboard.org .

Support for other boards:

If you want to build a system for other boards based on the same SoC
(for ex. Digilent Zybo board), and the board is already supported by
the upstream kernel and U-Boot, you simply need to change the
following Buildroot options:

 - Kernel Device Tree file name (BR2_LINUX_KERNEL_INTREE_DTS_NAME)
 - U-Boot (BR2_TARGET_UBOOT_CUSTOM_MAKEOPTS="DEVICE_TREE=<dts file name>")

Custom ps7_init_gpl.c/h support:

To generate a working boot.bin image, ps7_init_gpl.c/h are required in
the U-Boot source tree. Without those files, boot.bin will be built
successfully but it will not be functional at all. Those files are
output from the Xilinx tools, but for convenience, U-Boot includes the
default ps7_init_gpl.c/h of popular boards. Those files may need to be
updated for any programmable logic or DDR customizations which impact
ps7_init (clock/pin setup & mapping/AXI bridge setup/etc). See
board/xilinx/zynq/ directory of U-Boot for natively supported ps7_init
files. If the ps7_init files for your board are not found in U-Boot,
you need to add them by yourself.

1) Start with a defconfig supported by Buildroot (e.g. Zedboard)
    make zynq_zed_defconfig

2) make uboot-menuconfig
    Visit the following menu and enable CONFIG_XILINX_PS_INIT_FILE

    ARM architecture  --->
       [*] Zynq/ZynqMP PS init file(s) location

3) Copy ps7_init_gpl.c/h generated by the Xilinx Vivado tools into
   output/build/uboot-custom/board/xilinx/zynq/custom_hw_platform/

4) make

Note: The files in step 3 will need to be re-copied after cleaning the
output directory and at this time, there is no way to save them as
part of the buildroot configuration, except as a U-Boot patch.
