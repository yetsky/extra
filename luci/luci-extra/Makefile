include $(TOPDIR)/rules.mk

LUCI_TOPDIR=..

PKG_NAME:=luci-extra
PKG_RELEASE:=1

PKG_BUILD_PARALLEL:=0

PKG_VERSION:=$(shell $(LUCI_TOPDIR)/build/mkrevision.sh 2>/dev/null || echo unknown)

PKG_BUILD_DEPENDS:=$(if $(STAGING_DIR_ROOT),lua/host)
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)
PKG_INSTALL_DIR:=$(PKG_BUILD_DIR)/ipkg-install
PKG_USE_MIPS16:=0

LUA_TARGET:=compile
LUCI_CFLAGS:=
LUCI_BUILD_PACKAGES:=
LUCI_SELECTED_MODULES:=

ifeq ($(BOARD),brcm-2.4)
  MAKE_FLAGS += CRAP="1"
endif

### Templates ###
define Package/luci/install/template
	$(CP) -a $(PKG_BUILD_DIR)/$(2)/dist/* $(1)/ -R
	$(CP) -a $(PKG_BUILD_DIR)/$(2)/ipkg/* $(1)/CONTROL/ 2>/dev/null || true
endef

### Protocols ###
define protocol
  define Package/luci-proto-$(1)
    SECTION:=luci
    CATEGORY:=LuCI
    TITLE:=LuCI - Lua Configuration Interface
    URL:=http://luci.subsignal.org/
    MAINTAINER:=LuCI Development Team <luci@lists.subsignal.org>
    SUBMENU:=6. Protocols
    TITLE:=$(if $(2),$(2),LuCI $(1) protocol support)
    DEPENDS:=$(3)
  endef

  define Package/luci-proto-$(1)/install
	$(call Package/luci/install/template,$$(1),protocols/$(1))
  endef

  ifneq ($(CONFIG_PACKAGE_luci-proto-$(1)),)
    LUCI_SELECTED_MODULES+=protocols/$(1)
  endif

  LUCI_BUILD_PACKAGES += luci-proto-$(1)
endef

$(eval $(call protocol,openconnect-ra,Support for OpenConnect VPN,+openconnect))
$(eval $(call protocol,shadowvpn,Support for ShadowVPN,+ShadowVPN))

### Applications ###
define application
  define Package/luci-app-$(1)
    SECTION:=luci
    CATEGORY:=LuCI
    TITLE:=LuCI - Lua Configuration Interface
    URL:=https://github.com/yetsky/extra
    MAINTAINER:=BuleSky <yetsky@gmail.com>
    PKGARCH:=all
    SUBMENU:=3. Applications
    TITLE:=$(if $(2),$(2),LuCI $(1) application)
	DEPENDS:=$(3)
  endef

  define Package/luci-app-$(1)/install
	$(call Package/luci/install/template,$$(1),applications/luci-$(1))
  endef

  ifneq ($(CONFIG_PACKAGE_luci-app-$(1)),)
    LUCI_SELECTED_MODULES+=applications/luci-$(1)
  endif

  LUCI_BUILD_PACKAGES += luci-app-$(1)
endef

define Package/luci-app-aria2/conffiles
/etc/config/aria2
endef


	
$(eval $(call application,wifidog,LuCI Support for the wifidog,\
    +PACKAGE_luci-app-wifidog:wifidog))


$(eval $(call application,aria2,LuCI Support for Aria2,\
	+PACKAGE_luci-app-aria2:aria2 \
	+PACKAGE_luci-app-aria2:yaaw))

$(eval $(call application,shadowsocks,LuCI Support for shadowsocks,\
	+PACKAGE_luci-app-shadowsocks:shadowsocks-libev \
	+PACKAGE_luci-app-shadowsocks:kmod-ipt-nat \
	+PACKAGE_luci-app-shadowsocks:kmod-ipt-nat-extra \
	+PACKAGE_luci-app-shadowsocks:kmod-ipt-ipset \
	+PACKAGE_luci-app-shadowsocks:ipset \
	+PACKAGE_luci-app-shadowsocks:resolveip \
	+PACKAGE_luci-app-shadowsocks:ChinaDNS))

$(eval $(call application,redsocks2,LuCI Support for redsocks2,\
	+PACKAGE_luci-app-redsocks2:redsocks2 \
	+PACKAGE_luci-app-redsocks2:kmod-ipt-nat \
	+PACKAGE_luci-app-redsocks2:kmod-ipt-nat-extra \
	+PACKAGE_luci-app-redsocks2:kmod-ipt-ipset \
	+PACKAGE_luci-app-redsocks2:ipset \
	+PACKAGE_luci-app-shadowsocks:resolveip))

$(eval $(call application,ser2net,ser2net - Serial to network module,\
	+PACKAGE_luci-app-ser2net:ser2net))

$(eval $(call application,chinadns,LuCI Support for ChinaDNS,\
	+PACKAGE_luci-app-chinadns:ChinaDNS))

$(eval $(call application,dnsfilter,DNS-Filter LuCI configuration module,\
	+PACKAGE_luci-app-dnsfilter:libc \
	+PACKAGE_luci-app-dnsfilter:bash \
	+PACKAGE_luci-app-dnsfilter:screen \
	+PACKAGE_luci-app-dnsfilter:wget))
	
$(eval $(call application,mwan3,LuCI support for the MWAN3 multiwan hotplug script,\
	+PACKAGE_luci-app-mwan3:mwan3 \
	+PACKAGE_luci-app-mwan3:luci-mod-admin-full \
	+PACKAGE_luci-app-mwan3:luci-app-firewall \
	+PACKAGE_luci-app-mwan3:luci-lib-nixio))
	
$(eval $(call application,ip-qos,LuCI support for ip-qos,\
	+PACKAGE_luci-app-ip-qos:libc \
	+PACKAGE_luci-app-ip-qos:tc \
	+PACKAGE_luci-app-ip-qos:iptables-mod-conntrack-extra \
	+PACKAGE_luci-app-ip-qos:iptables-mod-filter \
	+PACKAGE_luci-app-ip-qos:iptables-mod-ipopt \
	+PACKAGE_luci-app-ip-qos:iptables-mod-nat-extra \
	+PACKAGE_luci-app-ip-qos:kmod-sched \
	+PACKAGE_luci-app-ip-qos:iptables-mod-iprange))

$(eval $(call application,macvlan-multiwan,LuCI Support for macvlan with multiwan,\
	+PACKAGE_luci-app-macvlan-multiwan:kmod-macvlan))

$(eval $(call application,macvlan,LuCI Support for macvlan,\
	+PACKAGE_luci-app-macvlan:kmod-macvlan))

$(eval $(call application,usbttl,LuCI Support for Usb-TTL,\
	+PACKAGE_luci-app-usbttl:usbttl))
	
$(eval $(call application,autossh,LuCI Support for Autossh,\
	+PACKAGE_luci-app-ip-qos:autossh \
	+PACKAGE_luci-app-ip-qos:openssh-client))

	
$(eval $(call application,xunlei,LuCI Support for xware web UI,\
	+PACKAGE_luci-app-xunlei:xunlei))
	
$(eval $(call application,mjpg-streamer,mjpg streamer luci page,\
	+PACKAGE_luci-app-mjpg-streamer:mjpg-streamer))
	
$(eval $(call application,n2n,n2n luci page,\
	+PACKAGE_luci-app-n2n:n2n \
	+PACKAGE_luci-app-n2n:n2n_v2))

$(eval $(call application,webshell,webshell configuration module,\
	 +PACKAGE_luci-app-webshell))
	 
$(eval $(call application,cpulimit,CPULIMIT configuration module,\
	 +PACKAGE_luci-app-cpulimit:cpulimit))
	 
$(eval $(call application,vsftpd,FTP Server,\
	+PACKAGE_luci-app-vsftpd:vsftpd-pam))
	
### Compile ###
PKG_CONFIG_DEPENDS=$(patsubst %,CONFIG_PACKAGE_%,$(LUCI_BUILD_PACKAGES))

include $(INCLUDE_DIR)/package.mk

define Build/Prepare
	@if [ ! -x $(LUCI_TOPDIR)/build/mkrevision.sh ]; then \
		echo "*** Repository layout changed!" >&2; \
		echo "*** Please change the LuCI url in feeds.conf to http://svn.luci.subsignal.org/luci/trunk and reinstall the feed with" >&2; \
		echo "*** ./scripts/feeds update luci; ./scripts/feeds install -a -p luci" >&2; \
		exit 1; \
	fi
	mkdir -p $(PKG_BUILD_DIR)
	$(TAR) c -C $(LUCI_TOPDIR) . \
		--exclude=.pc --exclude=.svn --exclude=.git \
		--exclude='boa-0*' --exclude='*.o' --exclude='*.so' \
		--exclude=dist | \
			tar x -C $(PKG_BUILD_DIR)/
	$(call Build/Prepare/Default)
endef

define Build/Configure
endef

MAKE_FLAGS += \
	MODULES="$(LUCI_SELECTED_MODULES)" \
	LUA_TARGET="$(LUA_TARGET)" \
	LUA_SHLIBS="-llua -lm -ldl -lcrypt" \
	CFLAGS="$(TARGET_CFLAGS) $(LUCI_CFLAGS) -I$(STAGING_DIR)/usr/include" \
	LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib" \
	NIXIO_TLS="$(NIXIO_TLS)" OS="Linux"


$(foreach b,$(LUCI_BUILD_PACKAGES),$(eval $(call BuildPackage,$(b))))
