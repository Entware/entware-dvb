#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=minisatip
PKG_VERSION:=0.7
PKG_SOURCE_VERSION:=$(PKG_VERSION)
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/catalinii/minisatip.git
PKG_SOURCE:=$(PKG_NAME).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/minisatip
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:= MiniSatIP server for Linux
  DEPENDS:=+librt +libpthread +MINISATIP_DVBAES_SUPPORT:libopenssl +MINISATIP_DVBCSA_SUPPORT:libdvbcsa
  URL:=https://github.com/catalinii/minisatip
endef

define Package/minisatip/description
  Minisatip is a multi-threaded satip server version 1.2 that runs under Linux
  and it was tested with DVB-S, DVB-S2, DVB-T, DVB-T2, DVB-C, DVB-C2, ATSC and
  ISDB-T cards.
endef

define Package/minisatip/config
  source "$(SOURCE)/Config.in"
endef

CONFIGURE_ARGS += \
	--disable-netceiver \
	--disable-dvbca

ifeq ($(CONFIG_MINISATIP_DVBCSA_SUPPORT),)
  CONFIGURE_ARGS += \
	--disable-dvbcsa
endif

ifeq ($(CONFIG_MINISATIP_DVBAES_SUPPORT),)
  CONFIGURE_ARGS += \
	--disable-dvbaes
endif

ifeq ($(CONFIG_MINISATIP_CLIENT_SUPPORT),)
  CONFIGURE_ARGS += \
	--disable-satipc
endif

TARGET_CFLAGS += -pthread

define Package/minisatip/install
	$(INSTALL_DIR) $(1)/opt/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/minisatip $(1)/opt/usr/sbin/
	$(INSTALL_DIR) $(1)/opt/share/minisatip
	$(CP) $(PKG_BUILD_DIR)/html $(1)/opt/share/minisatip
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(CP) ./files/S59minisatip $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,minisatip))
