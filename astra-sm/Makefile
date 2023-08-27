#
# Copyright (C) 2018 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=astra-sm
PKG_VERSION:=0.2.88
PKG_RELEASE:=5

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=450d4ec79dcb9f267784a42484fcf65b36230b78
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_URL:=https://gitlab.com/berdyansk/astra-sm.git
PKG_MIRROR_HASH:=251c2d1c0b1547fadfb7d01bfbbc8caea8d790f89a6050cb068adeabe13b2ccd

PKG_FIXUP:=autoreconf

include $(INCLUDE_DIR)/package.mk

define Package/astra-sm
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Astra SM IPTV server for Linux
  DEPENDS:=+libdvbcsa +libopenssl
  URL:=https://gitlab.com/berdyansk/astra-sm
ifneq (,$(filter aarch64 mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/astra-sm/description
  Astra is a professional software to organize Digital Broadcasting Service for TV operators
  and broadcasters, internet service providers, hotels, etc. Astra is an acronym for
  "Advanced Streaming Application".
  Astra supports many protocols and standards to receive channels from different sources.
  Received channels prepares and transmits into the IP network. Built-in scripting language (Lua)
  allow to customize business logic of the application.
endef

TARGET_CFLAGS += -I$(PKG_BUILD_DIR)/lua -pthread
TARGET_LDFLAGS += -L$(PKG_BUILD_DIR)/lua/.libs

CONFIGURE_ARGS += \
	--without-check \
	--without-ffmpeg \
	--without-libaio \
	--without-lua

define Package/astra-sm/postinst
#!/bin/sh

ln -sfn /opt/etc/init.d/S55astra /opt/etc/default/usb_services/dvb/S55astra
endef

define Package/astra-sm/postrm
#!/bin/sh

rm -rf /opt/etc/default/usb_services/dvb/S55astra
endef

define Package/astra-sm/install
	$(INSTALL_DIR) $(1)/opt/share/astra
	$(INSTALL_DIR) $(1)/opt/etc/astra/scripts
	$(CP) ./files/sat_mx1-t2mi.lua $(1)/opt/etc/astra/scripts/
	$(INSTALL_DIR) $(1)/opt/etc/default/usb_services/dvb
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/astra $(1)/opt/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/tests/t2mi_decap $(1)/opt/bin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(CP) ./files/S55astra $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,astra-sm))
