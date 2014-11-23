--[[
	QQ:76888484
	http://yetsky.taobao.com/
]]--

--local sys = require "luci.sys"
local fs = require "nixio.fs"
--local uci = require "luci.model.uci".cursor()
--local wan_ifname = luci.util.exec("uci get network.wan.ifname")
--local lan_ifname = luci.util.exec("uci get network.lan.ifname")


m = Map("autossh", "SSH-SOCKS5通道设置","没事翻翻墙 ，锻炼一下身体！<br>第一次连接一个新的SSH由于无法保存服务器指纹文件，脚本会出错。<br>解决方法很简单，先手动进路由的SSH打命令连接一次就可以了。“ssh ip -p 端口” 输入yes即可。")

local running=(luci.sys.call("pidof autossh > /dev/null") == 0)

s = m:section(TypedSection, "autossh", "设置")
s.anonymous = true

if running then	
s:option(Flag, "enabled", "启用","已运行")
else
s:option(Flag, "enabled", "启用","未运行")
end

server = s:option(Value, "server", "服务器IP","SSH远程服务器IP地址")
server.default = "192.168.1.10"
server.datatype = ipaddr
server.optional = false

port = s:option(Value, "port", "端口","SSH服务器端口默认22")
port.default = "22"
port.datatype = "range(0,65535)"
port.optional = false

name = s:option(Value, "name","用户名","SSH服务器用户名")
name.optional = false

password = s:option(Value, "password","密码","SSH服务器密码")
password.password = true

local_addr = s:option(Value, "local_addr", "监听地址","本地SOCKS5监听地址默认0.0.0.0")
local_addr.default = "0.0.0.0"
local_addr.datatype = ipaddr
local_addr.optional = false

local_port = s:option(Value, "local_port", "本地端口","本地SOCKS5监听端口默认7070")
local_port.default = "7070"
local_port.datatype = "range(0,65535)"
local_port.optional = false

ssh = s:option(Value, "ssh","SSH命令")
ssh.optional = false

gatetime = s:option(Value, "gatetime","gatetime")
gatetime.optional = false

monitorport = s:option(Value, "monitorport","monitorport")
monitorport.optional = false

poll = s:option(Value, "poll","poll")
poll.optional = false

return m