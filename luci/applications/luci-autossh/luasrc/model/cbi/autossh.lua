--[[
	QQ:76888484
	http://yetsky.taobao.com/
]]--

--local sys = require "luci.sys"
local fs = require "nixio.fs"
--local uci = require "luci.model.uci".cursor()
--local wan_ifname = luci.util.exec("uci get network.wan.ifname")
--local lan_ifname = luci.util.exec("uci get network.lan.ifname")
m = Map("autossh", "SSH-SOCKS5通道设置",
	translate("没事翻翻墙 ，锻炼一下身体！"))

s = m:section(TypedSection, "autossh", "设置")
s.anonymous = true

s:option(Flag, "enabled", "启用")

server = s:option(Value, "server", "服务器IP","SSH远程服务器IP地址")
server:depends("pattern","1")
server.default = "192.168.1.10"
server.datatype = ipaddr
server.optional = false

port = s:option(Value, "port", "端口","SSH服务器端口默认22")
port:depends("pattern","1")
port.default = "22"
port.datatype = "range(0,65535)"
port.optional = false

name = s:option(Value, "name","用户名","SSH服务器用户名")
name.optional = false

password = s:option(Value, "password","密码","SSH服务器密码")
password.password = true

local_addr = s:option(Value, "server", "监听地址","本地SOCKS5监听地址默认0.0.0.0")
local_addr:depends("pattern","1")
local_addr.default = "0.0.0.0"
local_addr.datatype = ipaddr
local_addr.optional = false

port = s:option(Value, "port", "本地端口","本地SOCKS5监听端口默认7070")
port:depends("pattern","1")
port.default = "7070"
port.datatype = "range(0,65535)"
port.optional = false

ssh = s:option(Value, "ssh","SSH命令")
ssh.optional = false

gatetime = s:option(Value, "gatetime","gatetime")
gatetime.optional = false

monitorport = s:option(Value, "monitorport","monitorport")
monitorport.optional = false

poll = s:option(Value, "poll","poll")
poll.optional = false

return m