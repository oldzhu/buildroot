################################################################################
#
# re2
#
################################################################################

RE2_VERSION = 2024-07-02
RE2_SITE = $(call github,google,re2,$(RE2_VERSION))
RE2_LICENSE = BSD-3-Clause
RE2_LICENSE_FILES = LICENSE
RE2_INSTALL_STAGING = YES
RE2_DEPENDENCIES = libabseil-cpp

define RE2_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		-C $(@D) $(if $(BR2_STATIC_LIBS),static)
endef

define RE2_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR="$(STAGING_DIR)" prefix=/usr -C $(@D) \
		$(if $(BR2_STATIC_LIBS),static-install,install)
endef

define RE2_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) \
		DESTDIR="$(TARGET_DIR)" prefix=/usr -C $(@D) \
		$(if $(BR2_STATIC_LIBS),static-install,install)
endef

define HOST_RE2_BUILD_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		-C $(@D)
endef

define HOST_RE2_INSTALL_CMDS
	$(HOST_MAKE_ENV) $(MAKE) $(HOST_CONFIGURE_OPTS) \
		-C $(@D) DESTDIR="$(HOST_DIR)" prefix=/usr install
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
