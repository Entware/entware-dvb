#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=libdvbcsa
PKG_VERSION:=1.1.0
PKG_RELEASE:=1a

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://download.videolan.org/pub/videolan/libdvbcsa/$(PKG_VERSION)/
PKG_MD5SUM:=478ab1ca56ca58d2667da6ce22f74e39

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/libdvbcsa
  SECTION:=libs
  CATEGORY:=Libraries
  TITLE:=libdvbcsa
  URL:=http://www.videolan.org/developers/libdvbcsa.html
  MENU:=1
ifneq (,$(filter mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/libdvbcsa/description
 libdvbcsa is a free implementation of the DVB Common Scrambling
 Algorithm - DVB/CSA - with encryption and decryption capabilities
endef

define Build/Configure
	$(call Build/Configure/Default)
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include/dvbcsa
	$(CP) $(PKG_INSTALL_DIR)/opt/include/dvbcsa/*.h $(1)/opt/include/dvbcsa/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/libdvbcsa.{a,so*} $(1)/opt/lib/
endef

define Package/libdvbcsa/install
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_BUILD_DIR)/src/.libs/libdvbcsa.so* $(1)/opt/lib/
endef

define Package/libdvbcsa/postinst
#!/bin/sh
ldconfig
endef

$(eval $(call BuildPackage,libdvbcsa))
