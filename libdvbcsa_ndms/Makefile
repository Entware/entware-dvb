#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libdvbcsa_ndms
PKG_VERSION:=1.1.0
PKG_RELEASE:=2

PKG_SOURCE:=libdvbcsa-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.videolan.org/pub/videolan/libdvbcsa/$(PKG_VERSION)/
PKG_HASH:=4db78af5cdb2641dfb1136fe3531960a477c9e3e3b6ba19a2754d046af3f456d

PKG_BUILD_DIR:=$(BUILD_DIR)/libdvbcsa-$(PKG_VERSION)

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libdvbcsa_ndms
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libdvbcsa_ndms
  URL:=http://www.videolan.org/developers/libdvbcsa.html
  MENU:=1
ifneq (,$(filter mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/libdvbcsa_ndms/description
 libdvbcsa is a free implementation of the DVB Common Scrambling
 Algorithm - DVB/CSA - with encryption and decryption capabilities
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/dvbcsa
	$(CP) $(PKG_INSTALL_DIR)/opt/include/dvbcsa/*.h $(1)/opt/include/dvbcsa/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libdvbcsa.{a,so*} $(1)/opt/lib/
endef

define Package/libdvbcsa_ndms/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/src/.libs/libdvbcsa.so* $(1)/opt/lib/
endef

define Package/libdvbcsa_ndms/postinst
#!/bin/sh
ldconfig
endef

$(eval $(call BuildPackage,libdvbcsa_ndms))
