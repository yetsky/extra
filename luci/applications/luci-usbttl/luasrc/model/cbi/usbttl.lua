--[[
	QQ:76888484
	http://yetsky.taobao.com/
]]--

--local sys = require "luci.sys"
local fs = require "nixio.fs"
--local uci = require "luci.model.uci".cursor()
--local wan_ifname = luci.util.exec("uci get network.wan.ifname")
--local lan_ifname = luci.util.exec("uci get network.lan.ifname")
m = Map("usbttl", "USB-TTL设置",
	translate("可以设置USB-TTL工作在Client、Server模式方便中继穿透串口，可选TCP或者UDP通道"))


s = m:section(TypedSection, "usbttl", "设置")
s.anonymous = true

s:option(Flag, "enabled", "启用")

s:option(Flag, "guardian", "进程守护")

device = s:option(Value, "device", "设备")
device.rmempty = false
for dev in nixio.fs.glob("/dev/ttyUSB[0-9]") do
	device:value(nixio.fs.basename(dev))
end

pattern = s:option(ListValue, "pattern", "工作模式")
pattern:value("0","Server模式")
pattern:value("1","Client模式")

tcp = s:option(ListValue, "tcp", "通讯类型")
tcp:value("0","TCP模式")
tcp:value("1","UDP模式")

baud = s:option(Value, "baud", "波特率","设置串口的波特率")
baud.optional = false

remote_server = s:option(Value, "remote_server","远端IP","工作在客户端模式下填写远端地址")
remote_server:depends("pattern","1")
remote_server.default = "192.168.1.10"
remote_server.datatype = ipaddr
remote_server.optional = false

remote_port = s:option(Value, "remote_port", "远端端口","工作在客户端模式下填写远端端口号")
remote_port:depends("pattern","1")
remote_port.default = "4321"
remote_port.datatype = "range(0,65535)"
remote_port.optional = false

local_port = s:option(Value, "local_port", "本地端口","工作在服务端模式下填写本地端口号")
local_port:depends("pattern","0")
local_port.default = "1234"
local_port.datatype = "range(0,65535)"
local_port.optional = false

return m