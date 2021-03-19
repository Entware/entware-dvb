#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=minisatip_ndms
PKG_VERSION:=0.7
PKG_RELEASE:=1a

PKG_SOURCE_VERSION:=cea9e4deee1062c492bcef2fa7967468ec8c908d
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=git://github.com/catalinii/minisatip.git
PKG_MIRROR_HASH:=47cf242bb20fc688a6f6cf9b80720c6eb14e34de49ff9c42b71604593ee93bd2
PKG_SOURCE:=minisatip-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=minisatip-$(PKG_VERSION)

PKG_BUILD_DIR:=$(BUILD_DIR)/minisatip-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

DEP_CAS:=+libdvben50221 +libdvbapi +libucsi +ci-plus-sert

define Package/minisatip_ndms
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:= MiniSatIP server for Linux
  DEPENDS:=+librt +libpthread +MINISATIP_NDMS_DVBAES_SUPPORT:libopenssl +MINISATIP_NDMS_DVBCSA_SUPPORT:libdvbcsa +MINISATIP_NDMS_DVBCA_SUPPORT:$(DEP_CAS)
  URL:=https://github.com/catalinii/minisatip
  PROVIDES:=minisatip
ifneq (,$(filter mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/minisatip_ndms/description
  Minisatip is a multi-threaded satip server version 1.2 that runs under Linux
  and it was tested with DVB-S, DVB-S2, DVB-T, DVB-T2, DVB-C, DVB-C2, ATSC and
  ISDB-T cards.
endef

define Package/minisatip_ndms/config
  source "$(SOURCE)/Config.in"
endef

CONFIGURE_ARGS += \
	--disable-netceiver

ifeq ($(CONFIG_MINISATIP_NDMS_DVBCSA_SUPPORT),)
  CONFIGURE_ARGS += \
	--disable-dvbcsa
endif

ifeq ($(CONFIG_MINISATIP_NDMS_DVBCA_SUPPORT),)
  CONFIGURE_ARGS += \
	--disable-dvbca
endif

ifeq ($(CONFIG_MINISATIP_NDMS_DVBAES_SUPPORT),)
  CONFIGURE_ARGS += \
	--disable-dvbaes
endif

ifeq ($(CONFIG_MINISATIP_NDMS_CLIENT_SUPPORT),)
  CONFIGURE_ARGS += \
	--disable-satipc
endif

TARGET_CFLAGS += -pthread

define Package/minisatip_ndms/postinst
#!/bin/sh
ln -sfn /opt/etc/init.d/S54minisatip /opt/etc/default/usb_services/dvb/S54minisatip
endef

define Package/minisatip_ndms/postrm
#!/bin/sh
rm -rf /opt/etc/default/usb_services/dvb/S54minisatip
endef

define Package/minisatip_ndms/install
	$(INSTALL_DIR) $(1)/opt/etc/default/usb_services/dvb
	$(INSTALL_DIR) $(1)/opt/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/minisatip $(1)/opt/usr/sbin/
	$(INSTALL_DIR) $(1)/opt/share/minisatip
	$(CP) $(PKG_BUILD_DIR)/html $(1)/opt/share/minisatip
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(CP) ./files/S54minisatip $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,minisatip_ndms))
