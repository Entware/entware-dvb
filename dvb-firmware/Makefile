#
# Copyright (C) 2017 McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dvb-firmware
PKG_VERSION:=1.0
PKG_RELEASE:=6

include $(INCLUDE_DIR)/package.mk

define Package/dvb-firmware
  SECTION:=firmware
  CATEGORY:=Firmware
  TITLE:=megapack
ifneq (,$(filter aarch64 mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/dvb-firmware/description
  dvb-firmware is specialised software that is both specific to some hardware
  and also integral for its proper functioning.
endef

Build/Configure:=:
Build/Compile:=:

define Package/dvb-firmware/install
	$(INSTALL_DIR) $(1)/opt/lib/firmware
	$(CP) ./files/* $(1)/opt/lib/firmware
endef

$(eval $(call BuildPackage,dvb-firmware))
