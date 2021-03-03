#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=scan-s2
PKG_VERSION:=1.0
PKG_RELEASE:=5

PKG_SOURCE_VERSION:=06a32606d2bccc52664e6fa1cff68d8874342202
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/crazycat69/scan-s2
PKG_MIRROR_HASH:=skip
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

TAR_OPTIONS += --exclude='dump-m3u.o'

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/scan-s2
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=scan-s2 channels scanning tool for the Linux DVB S2 API
  DEPENDS:=$(ICONV_DEPENDS)
  URL:=https://github.com/crazycat69/scan-s2
ifneq (,$(filter mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/scan-s2/description
  The scan-s2 utilty can be used to scan channels on currently locked (by szap-s2 utility) channel or
  by specifying frequencies list that will be scanned one after another.
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS) $(ICONV_CFLAGS) $(ICONV_LDFLAGS)" CLIB="$(TARGET_LDFLAGS) -liconv"
endef

define Package/scan-s2/install
	$(INSTALL_DIR) $(1)/opt/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/scan-s2 $(1)/opt/usr/bin/
	$(INSTALL_DIR) $(1)/opt/share/dtv-scan-tables
	$(CP) ./files/* $(1)/opt/share/dtv-scan-tables/
endef

$(eval $(call BuildPackage,scan-s2))
