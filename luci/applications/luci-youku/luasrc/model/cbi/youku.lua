--[[
LuCI - Lua Configuration Interface
youku for KOS
$Id$
]]--
local kosqd = luci.http.formvalue("cbi.apply")
local uci_sn=luci.sys.exec("echo 2115$(cat /sys/class/net/br-lan/address|tr -d ':'|md5sum |tr -dc [0-9]|cut -c 0-12)")
local button = ""
local sudu = luci.sys.exec("/lib/spd")
local running = (luci.sys.call("pidof ikuacc > /dev/null") == 0)
local run = (luci.sys.call("pidof youkudome > /dev/null") == 0)
local bdsn=luci.sys.exec("getykbdlink 00002115$(cat /sys/class/net/br-lan/address|tr -d ':'|md5sum |tr -dc [0-9]|cut -c 0-12)|sed -e's/&/&amp;/g'")
local bdzt=luci.sys.exec("wget -O - http://pcdnapi.youku.com/pcdn/user/check_bindinfo?pid=00002115$(cat /sys/class/net/br-lan/address|tr -d ':'|md5sum |tr -dc [0-9]|cut -c 0-12)|grep 'name'|cut -d '\"' -f 16")
bd_button = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" value=\" " .. translate("绑定优酷帐号") .. " \" onclick=\"window.open('" .. bdsn .. "')\"/>"
if running  then
m = Map("youku", translate("优酷路由宝"), "<p style='text-align:left'>"..translate("正在赚取金币").."<br></br>"..translate("WAN口速率 ")..sudu.."</p>")
else
if run then
m = Map("youku", translate("优酷路由宝"), translate("准备赚取金币中..."))
else
m = Map("youku", translate("优酷路由宝"), translate("赚取金币停止中..."))
end
end
s = m:section(TypedSection, "youku", translate("路由宝<a href=\"http://yjb.youku.com\" target=\"_blank\">  点击进入官方金币平台>></a>"))
s.anonymous = true
o = s:option(Flag, "enable", translate("是否启用矿机"))
o = s:option(ListValue, "oksn", translate("SN途径"))
o:value("0", translate("根据MAC获得SN"))
o:value("1", translate("路由宝原版SN"))
o = s:option(DummyValue,"","<p style='text-align:left'><strong>"..translate("序列号sn: ").."</strong>".."<font color='green'> <strong>" ..uci_sn.."</strong><br></br></font><strong>"..translate("一键绑定: ").."</strong>".."<font color='green'> <strong>" ..bd_button.."</strong><br></br></font><strong>"..translate("绑定状态: ").."</strong>".."<font color='green'> <strong>" ..bdzt.."</strong></font></p>", translate("这个SN根据MAC算出，MAC具有唯一性，所以这SN也具有唯一性。"))
o:depends({oksn="0"})
--o = s:option(DummyValue,"","<p style='text-align:left'><strong>"..translate("一键绑定: ").."</strong>".."<font color='green'> <strong>" ..bd_button.."</strong></font></p>", translate(""))
--o:depends({oksn="0"})

o = s:option(Value, "opsn", translate("原版SN"))
o:depends({oksn="1"})
o = s:option(ListValue, "wkmod", translate("挖矿模式"))
o:value("0", translate("激进模式"))
o:value("2", translate("平衡模式"))
o:value("3", translate("保守模式"))
pth = s:option(ListValue, "path", translate("缓存文件路径"), translate("请把磁盘挂在到/mnt目录下面"))
pth:value("", translate("-- Please choose --"))
local p_user
for _, p_user in luci.util.vspairs(luci.util.split(luci.sys.exec("df|grep '/mnt/'|awk '{print$6}'"))) do
	pth:value(p_user)
end

o = s:option(Value, "pathhc", translate("缓存目录大小限制"), translate("缓存的大小是按1000M=1G算的，如7G的剩余空间就填写7000"))
o:value("", translate("保持默认"))
o:value("7000", translate("7G缓存"))
o:value("14000", translate("14G缓存"))

o = s:option(Value, "cqboot", translate("定时重启"), translate("定时重启，可以自定义重启时间，例：3点重启就输入0300即可，5点半重启就输入0530即可."))
o:value("", translate("不重启"))
o:value("0100", translate("1点整重启"))
o:value("0245", translate("2点45重启"))
o:value("0300", translate("3点重启"))
o = s:option(Flag, "ikrebot", translate("只重启矿机"), translate("勾选表示只重启挖矿程序，不勾选则重启路由器。"))
return m
