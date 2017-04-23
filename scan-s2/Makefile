#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=scan-s2
PKG_VERSION:=1.0
PKG_RELEASE:=2
PKG_SOURCE_VERSION:=default
PKG_SOURCE_PROTO:=hg
PKG_SOURCE_URL:=https://bitbucket.org/CrazyCat/scan-s2
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/nls.mk
include $(INCLUDE_DIR)/package.mk

define Package/scan-s2
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=scan-s2 channels scanning tool for the Linux DVB S2 API
  DEPENDS:=+libiconv-full
  URL:=https://bitbucket.org/CrazyCat/scan-s2
endef

define Package/scan-s2/description
  The scan-s2 utilty can be used to scan channels on currently locked (by szap-s2 utility) channel or
  by specifying frequencies list that will be scanned one after another.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) $(ICONV_CFLAGS) $(ICONV_LDFLAGS)" CLIB="-liconv"
endef

define Package/scan-s2/install
	$(INSTALL_DIR) $(1)/opt/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scan-s2 $(1)/opt/usr/bin/
	$(INSTALL_DIR) $(1)/opt/share/dtv-scan-tables
	$(CP) ./files/* $(1)/opt/share/dtv-scan-tables/
endef

$(eval $(call BuildPackage,scan-s2))
