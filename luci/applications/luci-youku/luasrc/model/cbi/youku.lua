local fs = require "nixio.fs"
local uci_sn=luci.sys.exec("echo 2115$(cat /sys/class/net/br-lan/address|tr -d ':'|md5sum |tr -dc [0-9]|cut -c 0-12)")
local yksn=luci.sys.exec("uci get youku.youku.opsn")
local button = ""
local sudu = luci.sys.exec("/lib/spd")
local running = (luci.sys.call("pidof ikuacc > /dev/null") == 0)
local run = (luci.sys.call("pidof youkudome > /dev/null") == 0)
local bdsn=luci.sys.exec("getykbdlink 0000$(uci get youku.youku.opsn)|sed -e's/&/&amp;/g'")
local bdzt=luci.sys.exec("wget -O - http://pcdnapi.youku.com/pcdn/user/check_bindinfo?pid=0000$(uci get youku.youku.opsn)|grep 'name'|cut -d '\"' -f 16")

bd_button = "<input type=\"button\" value=\" " .. translate("绑定优酷帐号") .. " \" onclick=\"window.open('" .. bdsn .. "')\"/>"
if running  then
m = Map("youku", translate("优酷路由宝"), "<p style='text-align:left'>"..translate("路由宝正在工作中....").."<br></br>"..translate("WAN口速率 ")..sudu.."</p>")
else
if run then
m = Map("youku", translate("优酷路由宝"), translate("路由宝正在启动中...."))
else
m = Map("youku", translate("优酷路由宝"), translate("路由宝已停止工作...."))
end
end
s = m:section(TypedSection, "youku", translate("路由宝<a href=\"http://yjb.youku.com\" target=\"_blank\">  点击进入官方金币平台>></a>"))
s.anonymous = true

--o = s:option(ListValue, "oksn", translate("SN途径"))
--o:value("1", translate("路由宝原版SN"))
o = s:option(DummyValue,"","<p style='text-align:left'><strong>"..translate("序列号sn: ").."</strong>".."<font color='green'> <strong>" ..yksn.."</strong><br></br></font><strong>"..translate("一键绑定: ").."</strong>".."<font color='green'> <strong>" ..bd_button.."</strong><br></br></font><strong>"..translate("绑定状态: ").."</strong>".."<font color='green'> <strong>" ..bdzt.."</strong></font></p>")
--o:depends({oksn="1"})

o = s:option(Flag, "enable", translate("是否启用路由宝"))
o.rmempty = false

o = s:option(Value, "opsn", translate("SN"),translate("填写自己路由宝背后的SN"))
--o:depends({oksn="1"})
o = s:option(ListValue, "wkmod", translate("路由宝工作模式"))
o:value("0", translate("激进模式"))
o:value("2", translate("平衡模式"))
o:value("3", translate("保守模式"))


o = s:option(Value, "pathmeta", translate("meta文件夹目录"), translate("meta文件目录不会占用太多空间"))
o:value("/mnt/sda1", translate("/mnt/sda1"))


o = s:option(Value, "path", translate("缓存目录大小限制"), translate("缓存路径:分配空间，单位M，多个路径用;隔离"))
o:value("/mnt/sda1/youku:2000", translate("/mnt/sda1/youku:2000"))


o = s:option(Value, "cqboot", translate("定时重启"), translate("定时重启，可以自定义重启时间，例：3点重启就输入0300即可，5点半重启就输入0530即可."))
o:value("", translate("不重启"))
o:value("0100", translate("1点整重启"))
o:value("0245", translate("2点45重启"))
o:value("0300", translate("3点重启"))

o = s:option(Flag, "ikrebot", translate("只重启路由宝"), translate("勾选表示只重启路由宝程序，不勾选则重启路由器。"))

return m
