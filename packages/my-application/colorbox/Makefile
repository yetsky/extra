include $(TOPDIR)/rules.mk

PKG_NAME:=colorbox
PKG_VERSION:=v1.0.7.15315
PKG_RELEASE=$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/colorbox
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=My Application
  TITLE:= colorbox
  MAINTAINER:= yetsky <yetsky@gmail.com>
endef

define Package/colorbox/description
	This package contains ColorBox module.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/colorbox/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,colorbox))