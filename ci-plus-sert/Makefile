#
# Copyright (C) 2015-2018 NDM Systems, McMCC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ci-plus-sert
PKG_VERSION:=dreamciplus_4.7r9
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/ci-plus-sert
  SECTION:=base
  CATEGORY:=Base system
  TITLE:=DVB CI+ certificates
  PKGARCH:=all
endef

define Package/ci-plus-sert/description
  DVB CI+ certificates for CAM modules.
endef

Build/Configure:=:
Build/Compile:=:

define Package/ci-plus-sert/install
	$(INSTALL_DIR) $(1)/opt/etc/ssl/certs
	$(CP) ./files/*.pem $(1)/opt/etc/ssl/certs/
endef

$(eval $(call BuildPackage,ci-plus-sert))
