#
# Copyright (C) 2012-2017 NDM Systems, McMCC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kmod_static
PKG_VERSION:=24
PKG_RELEASE:=1

PKG_SOURCE:=kmod-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://www.kernel.org/pub/linux/utils/kernel/kmod/
PKG_MD5SUM:=08297dfb6f2b3f625f928ca3278528af

include $(INCLUDE_DIR)/package.mk

define Package/kmod_static
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Linux kernel module handling (Build static)
  URL:=https://www.kernel.org/pub/linux/utils/kernel/kmod/
  PROVIDES:=kmod
endef

define Package/kmod_static/description
Linux kernel module handling
 kmod is a set of tools to handle common tasks with Linux kernel modules like
 insert, remove, list, check properties, resolve dependencies and aliases.
endef

KMOD_BINARIES:= depmod insmod lsmod modinfo modprobe rmmod

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	tar xvfJ $(DL_DIR)/$(PKG_SOURCE) --strip-components=1 -C $(PKG_BUILD_DIR)
	$(CP) ./files/Makefile.static $(PKG_BUILD_DIR)/
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) -f Makefile.static \
		CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) -I./ -include config.h -DSYSCONFDIR="\\\"/opt/etc"\\\" -lc -lgcc_eh"
endef

define Package/kmod_static/install
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S01kmod_config $(1)/opt/etc/init.d/
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_BUILD_DIR)/kmod $(1)/opt/sbin

	for a in $(KMOD_BINARIES); do \
		ln -sf kmod $(1)/opt/sbin/$$$$a ; \
	done
endef

$(eval $(call BuildPackage,kmod_static))
