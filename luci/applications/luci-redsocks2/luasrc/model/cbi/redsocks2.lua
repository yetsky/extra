--[[
RA-MOD
]]--

local fs = require "nixio.fs"

local running=(luci.sys.call("pidof redsocks2 > /dev/null") == 0)
if running then	
	m = Map("redsocks2", translate("redsocks2"), translate("redsocks2 is running"))
else
	m = Map("redsocks2", translate("redsocks2"), translate("redsocks2 is not running"))
end

s = m:section(TypedSection, "redsocks2", "")
s.anonymous = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

localport = s:option(Value, "localport", translate("Local Port"))
localport.optional = false
localport.datatype = "range(0,65535)"

gfwlist_enable = s:option(Flag, "gfwlist_enabled", "启用GFW列表","勾选使用GFWlist列表,否则全局TCP代理或者自动判断,不启用会导致部分QOS失效")
gfwlist_enable.default = false

autoproxy = s:option(Flag, "autoproxy", translate("AutoProxy"),"开启先直接访问访问超时走代理访问,建议勾选GFWlist选项关闭此选项")
autoproxy.rmempty = false

timeout = s:option(Value, "timeout", translate("Timeout"),'开启自动判断后超过时间自动走代理访问')
timeout.optional = false

proxyip = s:option(Value, "proxyip", translate("Proxy IP"))
proxyip.optional = false

proxyport = s:option(Value, "proxyport", translate("Proxy Port"))
proxyport.optional = false
proxyport.datatype = "range(0,65535)"

proxytype = s:option(ListValue, "proxytype", translate("Proxy Type"))
proxytype:value("direct")
proxytype:value("socks4")
proxytype:value("socks5")
proxytype:value("http-connect")
proxytype:value("http-relay")

blacklist_enable = s:option(Flag, "blacklist_enabled", translate("Bypass Lan IP"),"支持IP或者1.1.1.0/16")
blacklist_enable.default = false

blacklist = s:option(TextValue, "blacklist", " ", "")
blacklist.template = "cbi/tvalue"
blacklist.size = 30
blacklist.rows = 10
blacklist.wrap = "off"
blacklist:depends("blacklist_enabled", 1)

function blacklist.cfgvalue(self, section)
	return fs.readfile("/etc/ipset/blacklist") or ""
end
function blacklist.write(self, section, value)
	if value then
		value = value:gsub("\r\n?", "\n")
		fs.writefile("/tmp/blacklist", value)
		fs.mkdirr("/etc/ipset")
		if (fs.access("/etc/ipset/blacklist") ~= true or luci.sys.call("cmp -s /tmp/blacklist /etc/ipset/blacklist") == 1) then
			fs.writefile("/etc/ipset/blacklist", value)
		end
		fs.remove("/tmp/blacklist")
	end
end

whitelist_enable = s:option(Flag, "whitelist_enabled", translate("Bypass IP Whitelist"),"支持IP或者1.1.1.0/16")
whitelist_enable.default = false

whitelist = s:option(TextValue, "whitelist", " ", "")
whitelist.template = "cbi/tvalue"
whitelist.size = 30
whitelist.rows = 10
whitelist.wrap = "off"
whitelist:depends("whitelist_enabled", 1)

function whitelist.cfgvalue(self, section)
	return fs.readfile("/etc/ipset/whitelist") or ""
end
function whitelist.write(self, section, value)
	if value then
		value = value:gsub("\r\n?", "\n")
		fs.writefile("/tmp/whitelist", value)
		fs.mkdirr("/etc/ipset")
		if (fs.access("/etc/ipset/whitelist") ~= true or luci.sys.call("cmp -s /tmp/whitelist /etc/ipset/whitelist") == 1) then
			fs.writefile("/etc/ipset/whitelist", value)
		end
		fs.remove("/tmp/whitelist")
	end
end

return m
