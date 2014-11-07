OpenWrt-Extra
=============

整理来自nanpuyue的extra packages for OpenWrt 增加了些packages

Add "src-git extra https://github.com/yetsky/extra.git" to feeds.conf.default.

```bash
./scripts/feeds update -a
./scripts/feeds install -a
```

the list of packages:
* luci-aria2
* luci-macvlan
* luci-macvlan-multiwan
* luci-mjpg-streamer
* luci-wifidog
* dnscrypt-proxy
* shadowsocks-libev
* webui-aria2
* wifidog
* yaaw