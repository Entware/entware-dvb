#
# Copyright (C) 2015-2018 NDM Systems, McMCC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$

include $(TOPDIR)/rules.mk

PKG_NAME:=oscam-emu
PKG_RELEASE:=2
PKG_SOURCE_URL:=http://www.streamboard.tv/svn/oscam/trunk
PKG_MIRROR_HASH:=10eaf05261fc47b1713edbea08b3975a0a16cd998a407bba88a2442e3f28b7bf
PKG_REV:=11420
EMU_REV:=769
PKG_VER:=2018-04-18
PKG_VERSION:=$(PKG_VER)-r$(PKG_REV)_r$(EMU_REV)

PKG_SOURCE_PROTO:=svn
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR).tar.bz2
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

# FIXME implausibly old time stamp
TAR_OPTIONS += --warning=no-timestamp

include $(INCLUDE_DIR)/package.mk

define Package/oscam-emu
  SECTION:=net
  CATEGORY:=Network
  TITLE:=Open Source Conditional Access Module (+EMU)
  URL:=http://www.streamboard.tv/oscam/wiki/BuildingOscam
  DEPENDS:=+libopenssl +libpcsclite +libusb-1.0 +ccid +pcscd
  PROVIDES:=oscam
ifneq (,$(filter aarch64 mips mipsel,$(ARCH)))
  PKGARCH:=$(BOARD)_kn
endif
endef

define Package/list-smargo-emu
  $(call Package/oscam-emu)
  TITLE:=Smargo reader support (+EMU)
  DEPENDS:=oscam-emu
  PROVIDES:=list-smargo
endef

MAKE_FLAGS += USE_LIBUSB=1 USE_PCSC=1 USE_LIBCRYPTO=1 USE_SSL=1 USE_UTF8=1 WITH_EMU=1 USE_EMU=1

ifneq ($(CONFIG_PACKAGE_list-smargo-emu),)
	MAKE_FLAGS += LIST_SMARGO_BIN=Distribution/list-smargo
endif

define Build/Prepare
	$(call Build/Prepare/Default)
	# fix "Timestamp out of range"
	$(FIND) $(PKG_BUILD_DIR) -exec touch {} +
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) $(TARGET_CONFIGURE_OPTS) CC="$(TARGET_CC)" \
		LDFLAGS="$(TARGET_CFLAGS) $(TARGET_LDFLAGS)" \
		CFLAGS="$(TARGET_CFLAGS) -I $(STAGING_DIR)/opt/include -I $(STAGING_DIR)/opt/include/PCSC" \
		OSCAM_BIN="Distribution/oscam" $(MAKE_FLAGS) SVN_REV="$(PKG_REV)" EMU_REV="$(EMU_REV)"
endef

define Package/oscam-emu/conffiles
/opt/etc/oscam/oscam.conf
/opt/etc/oscam/oscam.server
/opt/etc/oscam/oscam.user
/opt/etc/oscam/oscam.dvbapi
/opt/etc/oscam/SoftCam.Key
endef

define Package/oscam-emu/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/Distribution/oscam $(1)/opt/bin/oscam
	$(INSTALL_DIR) $(1)/opt/etc/oscam
	$(INSTALL_CONF) ./files/oscam.conf $(1)/opt/etc/oscam/
	$(INSTALL_CONF) ./files/oscam.server $(1)/opt/etc/oscam/
	$(INSTALL_CONF) ./files/oscam.user $(1)/opt/etc/oscam/
	$(INSTALL_CONF) ./files/oscam.dvbapi $(1)/opt/etc/oscam/
	$(INSTALL_CONF) ./files/SoftCam.Key $(1)/opt/etc/oscam/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/oscam.init $(1)/opt/etc/init.d/S48oscam
endef

define Package/list-smargo-emu/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/Distribution/list-smargo $(1)/opt/bin/list-smargo
endef

$(eval $(call BuildPackage,oscam-emu))
$(eval $(call BuildPackage,list-smargo-emu))
