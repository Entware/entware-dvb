#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=w_scan
PKG_VERSION:=20161022
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://wirbel.htpc-forum.de/w_scan
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
PKG_MD5SUM:=57aa860b4c9e6aa480ca6eb0504bd4f5

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/w_scan
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=w_scan performs frequency scans for DVB and ATSC.
  DEPENDS:=+libiconv-full
  URL:=http://wirbel.htpc-forum.de/w_scan/index_en.html
endef

TARGET_LDFLAGS += \
	-liconv

define Package/w_scan/description
  w_scan is a small command line utility used to perform frequency scans for DVB and ATSC transmissions.
endef

define Package/w_scan/install
	$(INSTALL_DIR) $(1)/opt/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/w_scan $(1)/opt/usr/bin/
endef

$(eval $(call BuildPackage,w_scan))
