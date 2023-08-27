#
# Copyright (C) 2012-2018 NDM Systems, McMCC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=kmod_ndms
PKG_VERSION:=30
PKG_RELEASE:=1

PKG_SOURCE:=kmod-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=@KERNEL/linux/utils/kernel/kmod
PKG_HASH:=f897dd72698dc6ac1ef03255cd0a5734ad932318e4adbaebc7338ef2f5202f9f

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK:=$(HOST_TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xJf $(DL_DIR)/$(PKG_SOURCE)

define Package/kmod_ndms
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Linux kernel module handling (Build static)
  URL:=https://www.kernel.org/pub/linux/utils/kernel/kmod/
  DEPENDS:=+libusb-compat
  CONFLICTS:=kmod
ifneq (,$(filter aarch64 mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
  ALTERNATIVES:= \
	200:/opt/sbin/depmod:/opt/sbin/kmod_ndms \
	200:/opt/sbin/insmod:/opt/sbin/kmod_ndms \
	200:/opt/sbin/lsmod:/opt/sbin/kmod_ndms \
	200:/opt/sbin/modinfo:/opt/sbin/kmod_ndms \
	200:/opt/sbin/modprobe:/opt/sbin/kmod_ndms \
	200:/opt/sbin/rmmod:/opt/sbin/kmod_ndms
endef

define Package/kmod_ndms/description
 Linux kernel module handling.
 kmod is a set of tools to handle common tasks with Linux kernel modules like
 insert, remove, list, check properties, resolve dependencies and aliases.
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
endef

$(eval $(call BuildPackage,kmod_ndms))
