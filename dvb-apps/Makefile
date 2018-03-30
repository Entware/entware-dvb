#
# Copyright (C) 2006-2018 OpenWrt.org
# Copyright (C) 2015-2018 NDM Systems, McMCC
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=dvb-apps
PKG_REV:=3d43b280298c
PKG_VERSION:=r$(PKG_REV)
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.bz2
PKG_SOURCE_URL:=http://linuxtv.org/hg/dvb-apps
PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_SOURCE_PROTO:=hg

PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

define Package/dvb-apps/Default
  SECTION:=multimedia
  CATEGORY:=Multimedia
  TITLE:=Linux DVB
  URL:=http://linuxtv.org/
  SUBMENU:=dvb-apps
endef

define Package/dvb-apps/description/Default
  Linux DVB API applications and utilities.
endef


define Package/dvb-apps
  $(call Package/dvb-apps/Default)
  TITLE+= Applications
  DEPENDS+= $(DVBA_DEPENDS)
endef

define Package/dvb-apps/description
  $(call Package/dvb-apps/description/Default)
  .
  This meta-package contains only dependencies to all Linux DVB API
  applications, libraries and data.
endef

define Package/dvb-apps/install
	/bin/true
endef

#EXTRA_CFLAGS:=$(ICONV_CFLAGS)
#EXTRA_LDFLAGS:=$(ICONV_LDFLAGS)

# 1: short name
# 2: description
# 3: dependencies on other Linux DVB API libraries (short name)
# 4: dependencies on other Linux DVB API applications (short name)
# 5: dependencies on other packages
#define DvbBuildApp

#  DVBA_DEPENDS += +dvb-app-$(1)

#  define Package/dvb-app-$(1)
#    $(call Package/dvb-apps/Default)
#    TITLE+= $(2) application
#    DEPENDS+= $$(foreach p,$(3),+lib$$(p)) $$(foreach p,$(4),+dvb-app-$$(p)) $(5)
#  endef

#  define Package/dvb-app-$(1)/description
#   $(call Package/dvb-apps/description/Default)
#   .
#   This package contains the Linux DVB $(2) application.
#  endef

#  define Package/dvb-app-$(1)/install
#	$(INSTALL_DIR) $$(1)/usr/bin
#	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/$(1) $$(1)/usr/bin
#  endef

#  $$(eval $$(call BuildPackage,dvb-app-$(1)))
#endef

#$(eval $(call DvbBuildApp,atsc_epg,atsc_epg,dvbapi ucsi,,))
#$(eval $(call DvbBuildApp,av7110_loadkeys,av7110_loadkeys,,,))
#$(eval $(call DvbBuildApp,azap,azap,,,))
#$(eval $(call DvbBuildApp,czap,czap,,,))
#$(eval $(call DvbBuildApp,dib3000-watch,dib3000-watch,,,))
#$(eval $(call DvbBuildApp,dst_test,dst_test,,,))
#$(eval $(call DvbBuildApp,dvbdate,dvbdate,dvbapi ucsi,,))
#$(eval $(call DvbBuildApp,dvbnet,dvbnet,dvbapi,,))
#$(eval $(call DvbBuildApp,dvbscan,dvbscan,dvbcfg ucsi dvbsec dvbapi,,libpthread))
#$(eval $(call DvbBuildApp,dvbtraffic,dvbtraffic,dvbapi,,))
#$(eval $(call DvbBuildApp,femon,femon,dvbapi,,))
#$(eval $(call DvbBuildApp,gnutv,gnutv,dvbcfg dvben50221 ucsi dvbsec dvbapi,,libpthread))
#$(eval $(call DvbBuildApp,gotox,gotox,dvbapi dvbsec,,))
#$(eval $(call DvbBuildApp,scan,scan,,,$(ICONV_DEPENDS)))
#$(eval $(call DvbBuildApp,szap,szap,,,))
#$(eval $(call DvbBuildApp,tzap,tzap,,,))
#$(eval $(call DvbBuildApp,zap,zap,dvbcfg dvben50221 dvbsec dvbapi ucsi,,libpthread))

define Build/InstallDev
	$(INSTALL_DIR) $(1)/opt/include
	$(CP) $(PKG_INSTALL_DIR)/opt/include/lib* $(1)/opt/include/
	$(INSTALL_DIR) $(1)/opt/lib
	$(CP) $(PKG_INSTALL_DIR)/opt/lib/lib*.{a,so*} $(1)/opt/lib/
endef

# 1: short name
# 2: description
# 3: dependencies on other Linux DVB API libraries (short name)
# 4: dependencies on other packages
define DvbBuildLibrary

  DVBA_DEPENDS += +lib$(1)

  define Package/lib$(1)
    $(call Package/dvb-apps/Default)
    TITLE+= $(2) library
    DEPENDS+= $$(foreach p,$(3),+lib$$(p)) $(4)
  endef

  define Package/lib$(1)/description
   $(call Package/dvb-apps/description/Default)
   .
   This package contains the Linux DVB $(2) library.
  endef

  define Package/lib$(1)/install
	$(INSTALL_DIR) $$(1)/opt/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/lib/lib$(1).so* \
		$$(1)/opt/lib
  endef

  $$(eval $$(call BuildPackage,lib$(1)))
endef



$(eval $(call DvbBuildLibrary,dvbapi,dvbapi,,))
$(eval $(call DvbBuildLibrary,dvbcfg,dvbcfg,,))
$(eval $(call DvbBuildLibrary,dvben50221,dvben50221,,))
$(eval $(call DvbBuildLibrary,dvbsec,dvbsec,,))
$(eval $(call DvbBuildLibrary,esg,esg,,))
$(eval $(call DvbBuildLibrary,ucsi,ucsi,,))


# 1: short name
# 2: description
# 3: dependencies on other packages
#define DvbBuildTuningData

#  DVBA_DEPENDS += +dvb-tuning-$(1)

#  define Package/dvb-tuning-$(1)
#    $(call Package/dvb-apps/Default)
#    TITLE+= $(2) initial tuning data
#    DEPENDS+= $(3)
#  endef

#  define Package/dvb-tuning-$(1)/description
#   $(call Package/dvb-apps/description/Default)
#   .
#   This package contains the Linux DVB initial tuning data for $(2).
#  endef

#  define Package/dvb-tuning-$(1)/install
#	$(INSTALL_DIR) $$(1)/usr/share/dvb/$(1)
#	$(CP) $(PKG_INSTALL_DIR)/usr/share/dvb/$(1)/* \
#		$$(1)/usr/share/dvb/$(1)
#  endef

#  $$(eval $$(call BuildPackage,dvb-tuning-$(1)))
#endef

#$(eval $(call DvbBuildTuningData,atsc,ATSC,))
#$(eval $(call DvbBuildTuningData,dvb-c,DVB-C,))
#$(eval $(call DvbBuildTuningData,dvb-s,DVB-S,))
#$(eval $(call DvbBuildTuningData,dvb-t,DVB-T,))


#DVBA_DEPENDS += +dvb-keymaps-av7110

#define Package/dvb-keymaps-av7110
#  $(call Package/dvb-apps/Default)
#  TITLE+= av7110 keymaps
#endef

#define Package/dvb-keymaps-av7110/description
#  $(call Package/dvb-apps/description/Default)
#  .
#  This package contains keymaps for the av7110_loadkeys application.
#endef

#define Package/dvb-keymaps-av7110/install
#	$(INSTALL_DIR) $(1)/usr/share/dvb/av7110_loadkeys
#	$(CP) $(PKG_INSTALL_DIR)/usr/share/dvb/av7110_loadkeys/* \
#		$(1)/usr/share/dvb/av7110_loadkeys
#endef

#$(eval $(call BuildPackage,dvb-keymaps-av7110))

$(eval $(call BuildPackage,dvb-apps))
