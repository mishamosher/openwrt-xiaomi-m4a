#
# Copyright (C) 2009-2010 Jo-Philipp Wich <xm@subsignal.org>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#


include $(TOPDIR)/rules.mk

PKG_NAME:=nvram-mtk
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_CONFIG:=NVRAM_MTD_NAME
PKG_CONFIG_DEPENDS:=$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),CONFIG_$(c)))


include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/nvram-mtk
  SECTION:=utils
  CATEGORY:=Base system
  TITLE:=Userspace port of the Mediatek NVRAM manipulation tool
  DEPENDS:=@TARGET_ramips +libc
  MENU:=1
endef

define Package/nvram-mtk/description
  This package contains an utility to manipulate NVRAM on Mediatek based devices.
endef

define Package/nvram-mtk/config
	source "$(SOURCE)/config.in"
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
	$(CP) ./src/* $(PKG_BUILD_DIR)/
endef

TARGET_CFLAGS += \
	-I$(LINUX_DIR)/arch/mips/include\
	-I$(LINUX_DIR)/drivers/char\
	-I$(LINUX_DIR)/include\
	$(foreach c, $(PKG_KCONFIG),$(if $(CONFIG_$c),-DCONFIG_$(c)))
MAKE_FLAGS += \
        CFLAGS="$(TARGET_CFLAGS)"


define Package/nvram-mtk/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/nvram $(1)/usr/bin
endef


$(eval $(call BuildPackage,nvram-mtk))

