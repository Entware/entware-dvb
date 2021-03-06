#
# Copyright (C) 2012-2018 NDM Systems, McMCC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kmod_ndms
PKG_VERSION:=24
PKG_RELEASE:=5a

PKG_SOURCE:=kmod-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://www.kernel.org/pub/linux/utils/kernel/kmod/
PKG_HASH:=610b8d1df172acc39a4fdf1eaa47a57b04873c82f32152e7a62e29b6ff9cb397

include $(INCLUDE_DIR)/package.mk

define Package/kmod_ndms
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Linux kernel module handling (Build static)
  URL:=https://www.kernel.org/pub/linux/utils/kernel/kmod/
  DEPENDS=+libusb-compat +dvb-firmware
  CONFLICTS:=kmod
ifneq (,$(filter mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/kmod_ndms/description
Linux kernel module handling
 kmod is a set of tools to handle common tasks with Linux kernel modules like
 insert, remove, list, check properties, resolve dependencies and aliases.
endef

KMOD_BINARIES:= depmod insmod lsmod modinfo modprobe rmmod

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	tar xvfJ $(DL_DIR)/$(PKG_SOURCE) --strip-components=1 -C $(PKG_BUILD_DIR)
	$(CP) ./files/usbdev_get_class.c $(PKG_BUILD_DIR)/
	$(CP) ./files/Makefile.static $(PKG_BUILD_DIR)/
	$(Build/Patch)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) -f Makefile.static \
		CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) -I./ -include config.h -DSYSCONFDIR="\\\"/opt/etc"\\\" -lc -lgcc_eh"
	$(TARGET_CC) $(TARGET_CFLAGS) -I $(STAGING_DIR)/opt/include/ -L $(STAGING_DIR)/opt/lib/ \
		-s -o $(PKG_BUILD_DIR)/usbdev_get_class $(PKG_BUILD_DIR)/usbdev_get_class.c $(TARGET_LDFLAGS) -lusb -lusb-1.0
endef

define Package/kmod_ndms/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S00kmod_config $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_BUILD_DIR)/usbdev_get_class $(1)/opt/sbin
	$(CP) $(PKG_BUILD_DIR)/kmod $(1)/opt/sbin/kmod_ndms
	$(INSTALL_DIR) $(1)/opt/etc/ndm/usb.d
	$(INSTALL_BIN) ./files/000-kmod_loader.sh $(1)/opt/etc/ndm/usb.d/
	$(INSTALL_DIR) $(1)/opt/etc/default

	for a in $(KMOD_BINARIES); do \
		ln -sf kmod_ndms $(1)/opt/sbin/$$$$a ; \
	done
endef

define Package/kmod_ndms/postinst
#!/bin/sh
/opt/etc/init.d/S00kmod_config
endef

$(eval $(call BuildPackage,kmod_ndms))
