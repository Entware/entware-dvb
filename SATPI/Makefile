#
# Copyright (C) 2017 NDM Systems, McMCC
#

include $(TOPDIR)/rules.mk

PKG_NAME:=SATPI
PKG_VERSION:=1.5.191
PKG_SOURCE_VERSION:=HEAD
PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/Barracuda09/SATPI.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/SATPI
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:= SatIP server for Linux
  DEPENDS:=+libstdcpp +librt +libpthread +libatomic +SATPI_DVBCSA_SUPPORT:libdvbcsa
  URL:=https://github.com/catalinii/minisatip
endef

define Package/SATPI/description
  SATIP server for linux, suitable for running on an Raspberry Pi, BeagleBone or any other linux box.
  Currently supporting DVB-S, DVB-S2, DVB-T/T2 and DVB-C.
endef

define Package/SATPI/config
  source "$(SOURCE)/Config.in"
endef


ifeq ($(CONFIG_SATPI_DVBCSA_SUPPORT),y)
  CONFIG = "LIBDVBCSA=yes"
endif

define Build/Compile
	$(MAKE) $(CONFIG) -C $(PKG_BUILD_DIR) \
                CXX="$(TARGET_CXX)" INCLUDES="-I./include -I$(STAGING_DIR)/opt/include/" LDFLAGS="-L$(STAGING_DIR)/opt/lib/ -pthread -lrt -latomic -ldvbcsa"
endef

define Package/SATPI/install
	$(INSTALL_DIR) $(1)/opt/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/satpi $(1)/opt/usr/sbin/
	$(INSTALL_DIR) $(1)/opt/share/satpi
	$(CP) $(PKG_BUILD_DIR)/web $(1)/opt/share/satpi
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(CP) ./files/S59satpi $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,SATPI))
