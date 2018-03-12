#
# Copyright (C) 2018 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tvheadend_ndms
PKG_VERSION:=4.2.5
PKG_RELEASE:=1

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=8973d48e59b2c134aafec78de0c14756d6b15e8b
# This is stable git version...
# PKG_SOURCE_VERSION:=1a0262f5870e4fabd6b9c70a7bf2ebe420bc956e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/tvheadend/tvheadend.git
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE.md

PKG_FIXUP:=autoreconf

PKG_USE_MIPS16:=0

SHORT_GIT_VER:=$(shell echo $(PKG_SOURCE_VERSION) | cut -b -7)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/tvheadend_ndms
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Tvheadend is a TV streaming server for Linux
  DEPENDS:=+libopenssl +librt +zlib +TVHEADEND_NDMS_AVAHI_SUPPORT:libavahi-client $(ICONV_DEPENDS)
  CONFLICTS:=tvheadend
  URL:=https://tvheadend.org
endef

define Package/tvheadend_ndms/description
  Tvheadend is a TV streaming server and recorder for Linux, FreeBSD and Android
  supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV, SAT>IP and HDHomeRun as input sources.

  Tvheadend offers the HTTP (VLC, MPlayer), HTSP (Kodi, Movian) and SAT>IP streaming.
endef

define Package/tvheadend_ndms/config
  menu "Configuration"
  depends on PACKAGE_tvheadend_ndms
  source "$(SOURCE)/Config.in"
  endmenu
endef

ifeq ($(CONFIG_GCC_USE_VERSION_6_3_0)$(CONFIG_GCC_USE_VERSION_7_3_0),y)
TARGET_CFLAGS+=-Wno-error=misleading-indentation
endif

ifeq ($(CONFIG_GCC_USE_VERSION_7_3_0),y)
TARGET_CFLAGS+=-Wno-error=format-truncation -Wno-error=pointer-compare
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_CWC_SUPPORT),)
  CONFIGURE_ARGS += --disable-cwc
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_LINUXDVB_SUPPORT),)
  CONFIGURE_ARGS += --disable-linuxdvb
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_DVBSCAN_SUPPORT),)
  CONFIGURE_ARGS += --disable-dvbscan
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_AVAHI_SUPPORT),)
  CONFIGURE_ARGS += --disable-avahi
else
  CONFIGURE_ARGS += --enable-avahi
endif

CONFIGURE_ARGS += \
	--arch=$(ARCH) \
	--disable-dbus_1 \
	--disable-libav \
	--disable-uriparser \
	--enable-bundle

define Build/Prepare
	$(call Build/Prepare/Default)
	echo 'Tvheadend $(shell echo $(PKG_VERSION)~$(SHORT_GIT_VER)-NDMS-$(PKG_RELEASE))' \
		> $(PKG_BUILD_DIR)/debian/changelog
endef

define Package/conffiles
/opt/etc/config/tvheadend
endef

define Package/tvheadend_ndms/postinst
#!/bin/sh
ln -sfn /opt/etc/init.d/S58tvheadend /opt/etc/default/usb_services/dvb/S58tvheadend
endef

define Package/tvheadend_ndms/postrm
#!/bin/sh
rm -rf /opt/etc/default/usb_services/dvb/S58tvheadend
endef

define Package/tvheadend_ndms/install
	$(INSTALL_DIR) $(1)/opt/etc/default/usb_services/dvb
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/tvheadend.init $(1)/opt/etc/init.d/S58tvheadend

	$(INSTALL_DIR) $(1)/opt/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build.linux/tvheadend $(1)/opt/usr/sbin/
	$(INSTALL_BIN) ./files/tv_grab_ru  $(1)/opt/usr/sbin/
	$(INSTALL_DIR) $(1)/opt/share/tvheadend/data/dvb-scan/dvb-t
	$(CP) ./files/ru-all_dvb* $(1)/opt/share/tvheadend/data/dvb-scan/dvb-t/
endef

$(eval $(call BuildPackage,tvheadend_ndms))
