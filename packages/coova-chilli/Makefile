#
# Copyright (C) 2007-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=coova-chilli
PKG_VERSION:=1.3.0
PKG_RELEASE:=5

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://ap.coova.org/chilli
PKG_MD5SUM:=dc0037e3cdebcb60508081b4e42e984a

PKG_INSTALL:=1

PKG_CONFIG_DEPENDS := \
  COOVACHILLI_MINIPORTAL \
  COOVACHILLI_REDIR \
  COOVACHILLI_USERAGENT \
  COOVACHILLI_DNSLOG \
  COOVACHILLI_UAMDOMAINFILE \
  COOVACHILLI_LARGELIMITS \
  COOVACHILLI_NOSSL \
  COOVACHILLI_MATRIXSSL \
  COOVACHILLI_CYASSL \
  COOVACHILLI_OPENSSL \
  COOVACHILLI_BINSTATUSFILE \
  COOVACHILLI_PROXY \
  COOVACHILLI_MINICONFIG \
  COOVACHILLI_LAYER3 \
  COOVACHILLI_DISABLE_LEAKYBUCKET \
  COOVACHILLI_RTMON \
  COOVACHILLI_CURL

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/kernel.mk

define Package/coova-chilli
  SUBMENU:=Captive Portals
  SECTION:=net
  CATEGORY:=Network
  DEPENDS:=+kmod-tun +librt +COOVACHILLI_MINIPORTAL:haserl +COOVACHILLI_MATRIXSSL:libmatrixssl +COOVACHILLI_CYASSL:libcyassl +COOVACHILLI_OPENSSL:libopenssl +COOVACHILLI_CURL:libcurl
  TITLE:=Wireless LAN HotSpot controller (Coova Chilli Version)
  URL:=http://www.coova.org/CoovaChilli
  MAINTAINER:=Imre Kaloz <kaloz@openwrt.org>
  MENU:=1
endef

define Package/coova-chilli/description
	CoovaChilli is an open source access controller for wireless LAN
	access points and is based on ChilliSpot. It is used for authenticating
	users of a wireless (or wired) LAN. It supports web based login (UAM)
	which is today's standard for public HotSpots and it supports Wireless
	Protected Access (WPA) which is the standard of the future.
	Authentication, authorization and accounting (AAA) is handled by your
	favorite radius server.
endef

define Package/coova-chilli/config
  source "$(SOURCE)/Config.in"
endef

define KernelPackage/coova
  URL:=http://www.coova.org/CoovaChilli
  SUBMENU:=Network Support
  DEPENDS:=+coova-chilli
  TITLE:=Coova kernel module
  FILES:=$(PKG_BUILD_DIR)/src/linux/xt_coova.$(LINUX_KMOD_SUFFIX)
  AUTOLOAD:=$(call AutoLoad,90,coova)
endef

define KernelPackage/coova/description
	Kernel module for CoovaChilli
endef

DISABLE_NLS=

TARGET_CFLAGS += $(FPIC) \

CONFIGURE_VARS += \
       KERNEL_DIR="$(LINUX_DIR)"

MAKE_FLAGS += \
       KERNEL_DIR="$(LINUX_DIR)"

MAKE_INSTALL_FLAGS += \
       KERNEL_DIR="$(LINUX_DIR)" \
       INSTALL_MOD_PATH="$(PKG_INSTALL_DIR)"

define Build/Configure
	$(call Build/Configure/Default, \
	$(if $(CONFIG_COOVACHILLI_REDIR),--enable,--disable)-chilliredir \
	$(if $(CONFIG_COOVACHILLI_DNSLOG),--enable,--disable)-dnslog \
	$(if $(CONFIG_COOVACHILLI_MINIPORTAL),--enable,--disable)-miniportal \
	$(if $(CONFIG_COOVACHILLI_USERAGENT),--enable,--disable)-useragent \
	$(if $(CONFIG_COOVACHILLI_LARGELIMITS),--enable,--disable)-largelimits \
	$(if $(CONFIG_COOVACHILLI_UAMDOMAINFILE),--enable,--disable)-uamdomainfile \
	$(if $(CONFIG_COOVACHILLI_MATRIXSSL),--with,--without)-matrixssl \
	$(if $(CONFIG_COOVACHILLI_CYASSL),--with,--without)-cyassl \
	$(if $(CONFIG_COOVACHILLI_OPENSSL),--with,--without)-openssl \
	$(if $(CONFIG_COOVACHILLI_BINSTATUSFILE),--enable,--disable)-binstatusfile \
	$(if $(CONFIG_COOVACHILLI_PROXY),--enable,--disable)-chilliproxy \
	$(if $(CONFIG_COOVACHILLI_MINICONFIG),--enable,--disable)-miniconfig \
	$(if $(CONFIG_COOVACHILLI_LAYER3),--enable,--disable)-layer3 \
	$(if $(CONFIG_COOVACHILLI_DISABLE_LEAKYBUCKET),--disable-leakybucket,) \
	$(if $(CONFIG_COOVACHILLI_RTMON),--enable-rtmon,) \
	$(if $(CONFIG_COOVACHILLI_CURL),--with-curl) \
	$(if $(CONFIG_PACKAGE_kmod-coova),--with-nfcoova,) \
	)
endef

define Package/coova-chilli/conffiles
/etc/chilli.conf
endef

define Package/coova-chilli/install
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_CONF) $(PKG_INSTALL_DIR)/etc/chilli.conf $(1)/etc/
	$(INSTALL_DIR) $(1)/etc/chilli
	$(CP) -R $(PKG_INSTALL_DIR)/etc/chilli/* $(1)/etc/chilli/
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_DATA) ./files/chilli.hotplug $(1)/etc/hotplug.d/iface/30-chilli
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/chilli* $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib*.so.* $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/etc/init.d
	$(CP) files/chilli.init $(1)/etc/init.d/chilli
	$(INSTALL_DIR) $(1)/lib/firewall
	$(CP) files/chilli.firewall $(1)/lib/firewall/chilli.sh
endef

define KernelPackage/coova/install
	$(INSTALL_DIR) $(1)/usr/lib/iptables
	$(CP) $(PKG_BUILD_DIR)/src/linux/lib*.so $(1)/usr/lib/iptables/
endef

$(eval $(call BuildPackage,coova-chilli))
$(eval $(call KernelPackage,coova))
