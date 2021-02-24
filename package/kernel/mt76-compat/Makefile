include $(TOPDIR)/rules.mk

PKG_NAME:=mt76-compat
PKG_RELEASE=2

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_SOURCE_URL:=https://github.com/db260179/mt76
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=73e8fc1a5b35104c7aa7bf8f1263978b3137d0e3

PKG_MAINTAINER:=Felix Fietkau <nbd@nbd.name>
PKG_BUILD_PARALLEL:=1

PKG_CONFIG_DEPENDS += \
	CONFIG_PACKAGE_kmod-mt76-compat-usb \
	CONFIG_PACKAGE_kmod-mt76x02-compat-common \
	CONFIG_PACKAGE_kmod-mt76x0-compat-common \
	CONFIG_PACKAGE_kmod-mt76x0u-compat \
	CONFIG_PACKAGE_kmod-mt76x2-compat-common \
	CONFIG_PACKAGE_kmod-mt76x2-compat \
	CONFIG_PACKAGE_kmod-mt76x2u-compat \
	CONFIG_PACKAGE_kmod-mt7603-compat

STAMP_CONFIGURED_DEPENDS := $(STAGING_DIR)/usr/include/mac80211-backport/backport/autoconf.h

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/mt76-compat-default
  SUBMENU:=Wireless Drivers
  DEPENDS:= \
	+kmod-mac80211 \
	+@DRIVER_11AC_SUPPORT +@DRIVER_11N_SUPPORT +@DRIVER_11W_SUPPORT
endef

define KernelPackage/mt76-compat
  SUBMENU:=Wireless Drivers
  TITLE:=MediaTek MT76x2/MT7603 wireless driver (metapackage)
  DEPENDS:= \
	+kmod-mt76-compat-core +kmod-mt76x2-compat +kmod-mt7603-compat
endef

define KernelPackage/mt76-compat-core
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76xx wireless driver
  HIDDEN:=1
  FILES:=\
	$(PKG_BUILD_DIR)/mt76.ko
endef

define KernelPackage/mt76-compat-usb
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76xx wireless driver USB support
  DEPENDS += +kmod-usb-core +kmod-mt76-compat-core
  HIDDEN:=1
  FILES:=\
	$(PKG_BUILD_DIR)/mt76-usb.ko
endef

define KernelPackage/mt76x02-compat-usb
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x0/MT76x2 USB wireless driver common code
  DEPENDS+=+kmod-mt76-compat-usb +kmod-mt76x02-compat-common
  HIDDEN:=1
  FILES:=$(PKG_BUILD_DIR)/mt76x02-usb.ko
endef

define KernelPackage/mt76x02-compat-common
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x0/MT76x2 wireless driver common code
  DEPENDS+=+kmod-mt76-compat-core
  HIDDEN:=1
  FILES:=$(PKG_BUILD_DIR)/mt76x02-lib.ko
endef

define KernelPackage/mt76x0-compat-common
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x0 wireless driver common code
  DEPENDS+=+kmod-mt76x02-compat-common
  HIDDEN:=1
  FILES:=$(PKG_BUILD_DIR)/mt76x0/mt76x0-common.ko
endef

define KernelPackage/mt76x0e-compat
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x0E wireless driver
  DEPENDS+=@PCI_SUPPORT +kmod-mt76x0-compat-common
  FILES:=\
	$(PKG_BUILD_DIR)/mt76x0/mt76x0e.ko
  AUTOLOAD:=$(call AutoProbe,mt76x0e)
endef

define KernelPackage/mt76x0u-compat
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x0U wireless driver
  DEPENDS+=+kmod-mt76x0-compat-common +kmod-mt76x02-compat-usb
  FILES:=\
	$(PKG_BUILD_DIR)/mt76x0/mt76x0u.ko
  AUTOLOAD:=$(call AutoProbe,mt76x0u)
endef

define KernelPackage/mt76x2-compat-common
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x2 wireless driver common code
  DEPENDS+=+kmod-mt76-compat-core +kmod-mt76x02-compat-common
  HIDDEN:=1
  FILES:=$(PKG_BUILD_DIR)/mt76x2/mt76x2-common.ko
endef

define KernelPackage/mt76x2u-compat
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x2U wireless driver
  DEPENDS+=+kmod-mt76x2-compat-common +kmod-mt76x02-compat-usb
  FILES:=\
	$(PKG_BUILD_DIR)/mt76x2/mt76x2u.ko
  AUTOLOAD:=$(call AutoProbe,mt76x2u)
endef

define KernelPackage/mt76x2-compat
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT76x2 wireless driver
  DEPENDS+=@PCI_SUPPORT +kmod-mt76x2-compat-common
  FILES:=\
	$(PKG_BUILD_DIR)/mt76x2/mt76x2e.ko
  AUTOLOAD:=$(call AutoProbe,mt76x2e)
endef

define KernelPackage/mt7603-compat
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT7603 wireless driver
  DEPENDS+=@PCI_SUPPORT +kmod-mt76-compat-core
  FILES:=\
	$(PKG_BUILD_DIR)/mt7603/mt7603e.ko
  AUTOLOAD:=$(call AutoProbe,mt7603e)
endef

define KernelPackage/mt7615e-compat
  $(KernelPackage/mt76-compat-default)
  TITLE:=MediaTek MT7615 wireless driver
  DEPENDS+=@PCI_SUPPORT +kmod-mt76-compat-core
  FILES:=\
	$(PKG_BUILD_DIR)/mt7615/mt7615e.ko
  AUTOLOAD:=$(call AutoProbe,mt7615e)
endef

NOSTDINC_FLAGS = \
	-I$(PKG_BUILD_DIR) \
	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211-backport \
	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211 \
	-include backport/autoconf.h \
	-include backport/backport.h

ifdef CONFIG_PACKAGE_MAC80211_MESH
  NOSTDINC_FLAGS += -DCONFIG_MAC80211_MESH
endif

ifdef CONFIG_PACKAGE_kmod-mt76-compat-usb
  PKG_MAKE_FLAGS += CONFIG_MT76_USB=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x02-compat-common
  PKG_MAKE_FLAGS += CONFIG_MT76x02_LIB=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x02-compat-usb
  PKG_MAKE_FLAGS += CONFIG_MT76x02_USB=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x0-compat-common
  PKG_MAKE_FLAGS += CONFIG_MT76x0_COMMON=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x0e-compat
  PKG_MAKE_FLAGS += CONFIG_MT76x0E=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x0u-compat
  PKG_MAKE_FLAGS += CONFIG_MT76x0U=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x2-compat-common
  PKG_MAKE_FLAGS += CONFIG_MT76x2_COMMON=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x2-compat
  PKG_MAKE_FLAGS += CONFIG_MT76x2E=m
endif
ifdef CONFIG_PACKAGE_kmod-mt76x2u-compat
  PKG_MAKE_FLAGS += CONFIG_MT76x2U=m
endif
ifdef CONFIG_PACKAGE_kmod-mt7603-compat
  PKG_MAKE_FLAGS += CONFIG_MT7603E=m
endif
ifdef CONFIG_PACKAGE_kmod-mt7615e-compat
  PKG_MAKE_FLAGS += CONFIG_MT7615E=m
endif

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
		$(KERNEL_MAKE_FLAGS) \
		$(PKG_MAKE_FLAGS) \
		SUBDIRS="$(PKG_BUILD_DIR)" \
		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		modules
endef

define Package/kmod-mt76-compat/install
	true
endef

define KernelPackage/mt76x0-compat-common/install
	$(INSTALL_DIR) $(1)/lib/firmware/mediatek
	cp \
		$(PKG_BUILD_DIR)/firmware/mt7610e.bin \
		$(1)/lib/firmware/mediatek
endef

define KernelPackage/mt76x2-compat-common/install
	$(INSTALL_DIR) $(1)/lib/firmware
	cp \
		$(PKG_BUILD_DIR)/firmware/mt7662_rom_patch.bin \
		$(PKG_BUILD_DIR)/firmware/mt7662.bin \
		$(1)/lib/firmware
endef

define KernelPackage/mt76x0u-compat/install
	$(INSTALL_DIR) $(1)/lib/firmware/mediatek
	ln -sf mt7610e.bin $(1)/lib/firmware/mediatek/mt7610u.bin
endef

define KernelPackage/mt76x2u-compat/install
	$(INSTALL_DIR) $(1)/lib/firmware/mediatek
	ln -sf ../mt7662.bin $(1)/lib/firmware/mediatek/mt7662u.bin
	ln -sf ../mt7662_rom_patch.bin $(1)/lib/firmware/mediatek/mt7662u_rom_patch.bin
endef

define KernelPackage/mt7603-compat/install
	$(INSTALL_DIR) $(1)/lib/firmware
	cp $(if $(CONFIG_TARGET_ramips_mt76x8), \
		$(PKG_BUILD_DIR)/firmware/mt7628_e1.bin \
		$(PKG_BUILD_DIR)/firmware/mt7628_e2.bin \
		,\
		$(PKG_BUILD_DIR)/firmware/mt7603_e1.bin \
		$(PKG_BUILD_DIR)/firmware/mt7603_e2.bin \
		) \
		$(1)/lib/firmware
endef

define KernelPackage/mt7615e-compat/install
	$(INSTALL_DIR) $(1)/lib/firmware/mediatek
	cp \
		$(PKG_BUILD_DIR)/firmware/mt7615_cr4.bin \
		$(PKG_BUILD_DIR)/firmware/mt7615_n9.bin \
		$(PKG_BUILD_DIR)/firmware/mt7615_rom_patch.bin \
		$(1)/lib/firmware/mediatek
endef

$(eval $(call KernelPackage,mt76-compat-core))
$(eval $(call KernelPackage,mt76-compat-usb))
$(eval $(call KernelPackage,mt76x02-compat-usb))
$(eval $(call KernelPackage,mt76x02-compat-common))
$(eval $(call KernelPackage,mt76x0-compat-common))
$(eval $(call KernelPackage,mt76x0e-compat))
$(eval $(call KernelPackage,mt76x0u-compat))
$(eval $(call KernelPackage,mt76x2-compat-common))
$(eval $(call KernelPackage,mt76x2u-compat))
$(eval $(call KernelPackage,mt76x2-compat))
$(eval $(call KernelPackage,mt7603-compat))
$(eval $(call KernelPackage,mt7615e-compat))
$(eval $(call KernelPackage,mt76-compat))
