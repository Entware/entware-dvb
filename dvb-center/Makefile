#
# Copyright (C) 2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dvb-center
PKG_VERSION:=0.2
PKG_RELEASE:=4

include $(INCLUDE_DIR)/package.mk

define Package/dvb-center
  SECTION:=dvb
  CATEGORY:=keendev
  DEPENDS:=+dvb-firmware +kmod_ndms +minisatip_ndms +scan-s2 +tvheadend_ndms +xupnpd
  TITLE:=configs and scripts files for dvb-center
ifneq (,$(filter aarch64 mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/dvb-center/description
  It's a metapackage to install config and scripts files
  on Keenetic routers with NDMS v2+.
endef

Build/Configure:=:
Build/Compile:=:

define Package/dvb-center/install
	$(INSTALL_DIR) $(1)/opt/etc/default/usb_services/dvb
	$(INSTALL_DIR) $(1)/opt/etc/ndm/usb.d
	$(INSTALL_BIN) ./files/002-dvb.sh $(1)/opt/etc/ndm/usb.d/
endef

define Package/dvb-center/postinst
#!/bin/sh

/opt/etc/init.d/S00kmod_config
endef

$(eval $(call BuildPackage,dvb-center))
