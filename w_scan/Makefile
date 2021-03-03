#
# Copyright (C) 2017 NDM Systems, McMCC
#
# XXX w_scan-20210218 (20170107 compile fix + repackage, no update)

include $(TOPDIR)/rules.mk

PKG_NAME:=w_scan
PKG_VERSION:=20210218
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=https://www.gen2vdr.de/wirbel/w_scan_cpp
PKG_HASH:=75d7447ebeddfb9ce251f32a93f23190ed46dca44f5b701f2af11e1787b9eb08

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/w_scan
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=w_scan performs frequency scans for DVB and ATSC.
  DEPENDS:=$(ICONV_DEPENDS)
  URL:=https://www.gen2vdr.de/wirbel/w_scan_cpp/index2.html
ifneq (,$(filter mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
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
