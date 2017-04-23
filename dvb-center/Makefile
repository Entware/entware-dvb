#
# Copyright (C) 2016 Entware
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dvb-center
PKG_VERSION:=0.1
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/dvb-center
	SECTION:=dvb
	CATEGORY:=keendev
	DEPENDS:=+kmod_ndms +minisatip +xupnpd +scan-s2
	TITLE:=configs and scripts files for dvb-center
   ifeq ($(ARCH),mips)
	PKGARCH:=keenbe-3x
      else
	PKGARCH:=keenle-3x
   endif
endef

define Package/dvb-center/description
	It`s a metapackage to install config and scripts files
	on ZyXEL Keenetic routers with NDMS v2
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/dvb-center/install
	$(INSTALL_DIR) $(1)/opt/etc/default/usb_services/dvb
	$(INSTALL_DIR) $(1)/opt/etc/ndm/usb.d
	$(INSTALL_BIN) ./files/002-dvb.sh $(1)/opt/etc/ndm/usb.d/
endef

define Package/dvb-center/postinst
#!/bin/sh
ln -sfn /opt/etc/init.d/S59minisatip /opt/etc/default/usb_services/dvb/S59minisatip
endef

$(eval $(call BuildPackage,dvb-center))
