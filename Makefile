include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/version.mk

PKG_NAME:=wav500-images
PKG_VERSION:=1
PKG_RELEASE:=2
PKG_LICENSE:=GPL-2.0

PKG_MAINTAINER:=paldier <paldier@hotmail.com>
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

#k3c: must have my special daughter board
#k3ca1: all hardware version without easymesh
 WAVE_TARGET:=k3c
ifeq ($(CONFIG_TARGET_intel_mips_xrx500_DEVICE_PHICOMM_K3CA1),y)
 WAVE_TARGET:=k3ca1
endif
ifeq ($(CONFIG_TARGET_intel_mips_xrx500_DEVICE_ASUS_BLUECAVE),y)
 WAVE_TARGET:=bluecave
endif
ifeq ($(CONFIG_TARGET_intel_mips_xrx500_DEVICE_PHICOMM_K3C),y)
 WAVE_TARGET:=k3c
endif

include $(INCLUDE_DIR)/package.mk

define Package/wav500-images
  SECTION:=utils
  CATEGORY:=Lantiq
  TITLE:=Wav500 WiFi driver images
  DEPENDS:=@TARGET_lantiq_xrx500 @PACKAGE_kmod-iwlwav-driver-uci
endef

define Package/$(PKG_NAME)/description
Wav500 WiFi driver images
endef

define Build/Prepare
endef

define Build/Compile
endef

define Package/wav500-images/install
	$(INSTALL_DIR) -p $(1)/lib/firmware
	$(INSTALL_BIN) ./files/$(WAVE_TARGET)/lib/firmware/* $(1)/lib/firmware/
ifeq ($(CONFIG_TARGET_intel_mips_xrx500_DEVICE_PHICOMM_K3CA1),y)
	$(INSTALL_DIR) -p $(1)/lib/netifd
	$(INSTALL_DIR) -p $(1)/lib/netifd/wireless
	$(INSTALL_DIR) -p $(1)/lib/wifi
	$(INSTALL_DIR) -p $(1)/opt/intel/wave/scripts/
	$(INSTALL_DIR) -p $(1)/opt/intel/wave/db/
	$(INSTALL_BIN) ./files/$(WAVE_TARGET)/lib/netifd/* $(1)/lib/netifd/
	$(INSTALL_BIN) ./files/$(WAVE_TARGET)/lib/netifd/wireless/* $(1)/lib/netifd/wireless/
	$(INSTALL_BIN) ./files/$(WAVE_TARGET)/lib/wifi/* $(1)/lib/wifi/
	$(INSTALL_BIN) ./files/$(WAVE_TARGET)/opt/intel/wave/scripts/* $(1)/opt/intel/wave/scripts/
	$(INSTALL_BIN) ./files/$(WAVE_TARGET)/opt/intel/wave/db/* $(1)/opt/intel/wave/db/
endif
endef

$(eval $(call BuildPackage,wav500-images))
