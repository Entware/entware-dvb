#
# Copyright (C) 2018 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=tvheadend_ndms
PKG_VERSION:=4.2.6
PKG_RELEASE:=7

PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=42e737f28f511c53e7321774085c8761af41371a
# This is stable git version...
# PKG_SOURCE_VERSION:=1a0262f5870e4fabd6b9c70a7bf2ebe420bc956e
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-$(PKG_SOURCE_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/tvheadend/tvheadend.git
PKG_MIRROR_HASH:=b297e444e0985b7536ca46bf6b2b8c86c622d94a9846ecf30f34c5fe079645da

PKG_LICENSE:=GPL-3.0
PKG_LICENSE_FILES:=LICENSE.md

PKG_FIXUP:=autoreconf

PKG_BUILD_FLAGS:=no-mips16

SHORT_GIT_VER:=$(shell echo $(PKG_SOURCE_VERSION) | cut -b -7)

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/tvheadend_ndms
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Tvheadend is a TV streaming server for Linux
  DEPENDS:=+libopenssl +zlib $(ICONV_DEPENDS) \
	+TVHEADEND_NDMS_AVAHI_SUPPORT:libavahi-client \
	+TVHEADEND_NDMS_LINUXDVB_CA_SUPPORT:libdvbapi \
	+TVHEADEND_NDMS_LINUXDVB_CA_SUPPORT:libdvben50221 \
	+TVHEADEND_NDMS_LINUXDVB_CA_SUPPORT:libucsi
  CONFLICTS:=tvheadend
  URL:=https://tvheadend.org
ifneq (,$(filter aarch64 mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/tvheadend_ndms/description
  Tvheadend is a TV streaming server and recorder for Linux, FreeBSD and Android
  supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV, SAT>IP and HDHomeRun as input sources.
  .
  Tvheadend offers the HTTP (VLC, MPlayer), HTSP (Kodi, Movian) and SAT>IP streaming.
endef

define Package/tvheadend_ndms/config
  menu "Configuration"
  depends on PACKAGE_tvheadend_ndms
  source "$(SOURCE)/Config.in"
  endmenu
endef

ifeq ($(CONFIG_GCC_USE_VERSION_8),y)
TARGET_CFLAGS += -Wno-error=array-bounds
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_CWC_SUPPORT),)
CONFIGURE_ARGS += --disable-cwc
endif

ifeq ($(CONFIG_TVHEADEND_NDMS_LINUXDVB_SUPPORT),)
CONFIGURE_ARGS += --disable-linuxdvb
endif

ifneq ($(CONFIG_TVHEADEND_NDMS_LINUXDVB_CA_SUPPORT),)
CONFIGURE_ARGS += --enable-dvben50221
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
