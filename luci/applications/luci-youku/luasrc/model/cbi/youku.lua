
local fs = require "nixio.fs"

local youkudome =(luci.sys.call("pidof youkudome > /dev/null") == 0)

if youkudome then	
	m = Map("youku", translate("youku"), translate("youku is running"))
else
	m = Map("youku", translate("youku"), translate("youku is not running"))
end

youku = m:section(TypedSection, "youku", translate("Server Setting"))
youku.anonymous = true

switch = youku:option(Flag, "enable", translate("Enable"))
switch.rmempty = false


password = youku:option(Value, "opsn", translate("SN"))
password.password = true

remote_server = youku:option(Value, "remote_server", translate("Server Address"))
remote_server.datatype = ipaddr
remote_server.optional = false

o = youku:option(ListValue, "wkmod", translate("挖矿模式"))
o:value("0", translate("激进模式"))
o:value("2", translate("平衡模式"))
o:value("3", translate("保守模式"))

o = youku:option(Value, "cqboot", translate("定时重启"), translate("定时重启，可以自定义重启时间，例：3点重启就输入0300即可，5点半重启就输入0530即可."))
o:value("", translate("不重启"))
o:value("0100", translate("1点整重启"))
o:value("0245", translate("2点45重启"))
o:value("0300", translate("3点重启"))

o = youku:option(Flag, "ikrebot", translate("只重启矿机"), translate("勾选表示只重启挖矿程序，不勾选则重启路由器。"))
o = false

return m


