#
# Copyright (C) 2018 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tvheadend_ndms_devel
PKG_VERSION:=4.3.0
PKG_RELEASE:=1

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=39a8ef2c1fdcea9ba101bac56bb94165e425d3b0
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

define Package/tvheadend_ndms_devel
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Tvheadend is a TV streaming server for Linux
  DEPENDS:=+libpcre +libopenssl +librt +zlib +libdvbcsa +TVHEADEND_NDMS_DEVEL_AVAHI_SUPPORT:libavahi-client $(ICONV_DEPENDS)
  CONFLICTS:=tvheadend
  PROVIDES:=tvheadend_ndms
  URL:=https://tvheadend.org
ifneq (,$(filter mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/tvheadend_ndms_devel/description
  Warning! This is only developers version! Not recommendation for use, not stable!

  Tvheadend is a TV streaming server and recorder for Linux, FreeBSD and Android
  supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV, SAT>IP and HDHomeRun as input sources.

  Tvheadend offers the HTTP (VLC, MPlayer), HTSP (Kodi, Movian) and SAT>IP streaming.
endef

define Package/tvheadend_ndms_devel/config
  menu "Configuration"
  depends on PACKAGE_tvheadend_ndms_devel
  source "$(SOURCE)/Config.in"
  endmenu
endef

ifeq ($(CONFIG_GCC_USE_VERSION_6_3_0)$(CONFIG_GCC_USE_VERSION_7_3_0),y)
TARGET_CFLAGS+=-Wno-error=misleading-indentation
endif

ifeq ($(CONFIG_GCC_USE_VERSION_7_3_0),y)
TARGET_CFLAGS+=-Wno-error=format-truncation -Wno-error=pointer-compare
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_DEVEL_CWC_SUPPORT),)
  CONFIGURE_ARGS += --disable-cwc
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_DEVEL_LINUXDVB_SUPPORT),)
  CONFIGURE_ARGS += --disable-linuxdvb
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_DEVEL_DVBSCAN_SUPPORT),)
  CONFIGURE_ARGS += --disable-dvbscan
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_DEVEL_AVAHI_SUPPORT),)
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

define Package/tvheadend_ndms_devel/postinst
#!/bin/sh
ln -sfn /opt/etc/init.d/S58tvheadend /opt/etc/default/usb_services/dvb/S58tvheadend
endef

define Package/tvheadend_ndms_devel/postrm
#!/bin/sh
rm -rf /opt/etc/default/usb_services/dvb/S58tvheadend
endef

define Package/tvheadend_ndms_devel/install
	$(INSTALL_DIR) $(1)/opt/etc/default/usb_services/dvb
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/tvheadend.init $(1)/opt/etc/init.d/S58tvheadend

	$(INSTALL_DIR) $(1)/opt/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/build.linux/tvheadend $(1)/opt/usr/sbin/
	$(INSTALL_BIN) ./files/tv_grab_ru  $(1)/opt/usr/sbin/
	$(INSTALL_DIR) $(1)/opt/share/tvheadend/data/dvb-scan/dvb-t
	$(CP) ./files/ru-all_dvb* $(1)/opt/share/tvheadend/data/dvb-scan/dvb-t/
endef

$(eval $(call BuildPackage,tvheadend_ndms_devel))
