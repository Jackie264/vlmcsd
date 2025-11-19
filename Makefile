# SPDX-License-Identifier: GPL-3.0-only
#
# Copyright (C) 2025 OneNAS-space

include $(TOPDIR)/rules.mk

PKG_NAME:=vlmcsd
PKG_RELEASE:=10

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/tfslabs/vlmcsd.git
PKG_SOURCE_DATE:=2025-08-19
PKG_SOURCE_VERSION:=47773d62750a0c0e9e0d9734aa5772ca1a27d53d
PKG_MIRROR_HASH:=bc2360c2fdaf2666428c4a9bba59c21e37dccc507908f609033901766fb44f69

PKG_LICENSE:=MIT
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Jackie264 <OneNAS-space>

PKG_BUILD_PARALLEL:=1

include $(INCLUDE_DIR)/package.mk

define Package/vlmcsd
  SECTION:=net
  CATEGORY:=Network
  TITLE:=A KMS Emulator in C
  URL:=https://github.com/tfslabs/vlmcsd
  DEPENDS:=+libpthread
  USERID:=vlmcsd:vlmcsd
endef

define Package/vlmcsd/description
  KMS Emulator in C (currently runs on Linux including Android, FreeBSD,
  Solaris, Minix, Mac OS, iOS, Windows with or without Cygwin)
endef

define Package/vlmcsd/conffiles
/etc/config/vlmcsd
/etc/vlmcsd.ini
endef

MAKE_FLAGS += \
	CC="$(TARGET_CC_NOCACHE)" \
	VLMCSD_VERSION="$(PKG_VERSION)"

define Package/vlmcsd/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bin/vlmcsd $(1)/usr/bin/vlmcsd

	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_BIN) ./files/vlmcsd.ini $(1)/etc/vlmcsd.ini
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_BIN) ./files/vlmcsd.conf $(1)/etc/config/vlmcsd
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/vlmcsd.init $(1)/etc/init.d/vlmcsd
endef

$(eval $(call BuildPackage,vlmcsd))
