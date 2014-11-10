#
# Copyright (C) 2007-2012 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_BRANCH:=trunk
PKG_SOURCE_URL:=https://svn.ntop.org/svn/ntop/trunk/n2n
PKG_REV:=8570

PKG_NAME:=n2n
PKG_VERSION:=$(PKG_REV)
PKG_RELEASE:=4

PKG_SOURCE_SUBDIR:=$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_SOURCE_SUBDIR).tar.gz
PKG_SOURCE_PROTO:=svn
PKG_SOURCE_VERSION:=$(PKG_REV)

PKG_BUILD_DEPENDS:=libopenssl

include $(INCLUDE_DIR)/package.mk

define Package/n2n
  SECTION:=net
  CATEGORY:=Network
  TITLE:=VPN tunneling daemon
  URL:=http://www.ntop.org/n2n/
  SUBMENU:=VPN
  DEPENDS:=+libpthread +kmod-tun
endef

define Package/n2n_v2
  $(call Package/n2n)
  TITLE+= (v2)
  DEPENDS+= +libopenssl
endef

define Build/Compile
	$(MAKE) -C "$(PKG_BUILD_DIR)/n2n_v1" \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS)" \
		INSTALL_PROG=":"
	$(MAKE) -C "$(PKG_BUILD_DIR)/n2n_v2" \
		$(TARGET_CONFIGURE_OPTS) \
		CFLAGS="$(TARGET_CFLAGS) $(TARGET_LDFLAGS)" \
		INSTALL_PROG=":"
endef

define Package/n2n/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/n2n_v1/edge $(1)/sbin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/n2n_v1/supernode $(1)/sbin/
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/n2n_v1.config $(1)/etc/config/n2n
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/n2n_v1.init $(1)/etc/init.d/n2n
endef

define Package/n2n_v2/install
	$(INSTALL_DIR) $(1)/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/n2n_v2/edge $(1)/sbin/edge2
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/n2n_v2/supernode $(1)/sbin/supernode2
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DATA) ./files/n2n_v2.config $(1)/etc/config/n2n2
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/n2n_v2.init $(1)/etc/init.d/n2n2
endef

$(eval $(call BuildPackage,n2n))

$(eval $(call BuildPackage,n2n_v2))
