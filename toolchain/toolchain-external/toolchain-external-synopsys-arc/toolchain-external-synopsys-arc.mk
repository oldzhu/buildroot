################################################################################
#
# toolchain-external-synopsys-arc
#
################################################################################

TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_VERSION = 2024.06
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_SITE = https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/releases/download/arc-$(TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_VERSION)-release

ifeq ($(BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC700),y)
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_CORE = arc700
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_LIBC = uclibc
else ifeq ($(BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARCHS_UCLIBC),y)
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_CORE = archs
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_LIBC = uclibc
else ifeq ($(BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARCHS_GLIBC),y)
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_CORE = archs
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_LIBC = glibc
endif

ifeq ($(BR2_arcle),y)
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_ENDIANESS = le
else
TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_ENDIANESS = be
endif

TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_SOURCE = arc_gnu_$(TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_VERSION)_prebuilt_$(TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_LIBC)_$(TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_ENDIANESS)_$(TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC_CORE)_linux_install.tar.bz2

$(eval $(toolchain-external-package))
