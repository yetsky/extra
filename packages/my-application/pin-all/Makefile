include $(TOPDIR)/rules.mk

PKG_NAME:=pin-all
PKG_VERSION:=1.0.0
PKG_RELEASE=$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/pin-all
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=My Application
  TITLE:= pin-all
  MAINTAINER:= yetsky <yetsky@gmail.com>
endef

define Package/pin-all/description
	pin-all.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/pin-all/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,pin-all))