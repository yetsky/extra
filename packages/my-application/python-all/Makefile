include $(TOPDIR)/rules.mk

PKG_NAME:=python-all
PKG_VERSION:=2.7.8
PKG_RELEASE=$(PKG_SOURCE_VERSION)

include $(INCLUDE_DIR)/package.mk

define Package/python-all
  SECTION:=utils
  CATEGORY:=Utilities
  SUBMENU:=My Application
  TITLE:= Python-all
  MAINTAINER:= yetsky <yetsky@gmail.com>
endef

define Package/python-all/description
	python-all.
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/python-all/install
    $(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,python-all))