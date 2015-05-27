--[[
LuCI - Lua Configuration Interface
youku for KOS
$Id$
]]--
local jq = "<script src='http://lib.sinaapp.com/js/jquery/1.7.2/jquery.min.js'></script>"
local ajax = "<script>setInterval(function(){$.get('/cgi-bin/luci/ykspd',function(s){if(1 == s.success){$('#ykspd').html(s.data)}},'json')},3000)</script>"
local kosqd = luci.http.formvalue("cbi.apply")
local opsn = luci.sys.exec("echo $(uci get -q youku.youku.opsn)||tr -d '\n'")
local macsn=luci.sys.exec("echo 2115$(cat /sys/class/net/br-lan/address|tr -d ':'|md5sum |tr -dc [0-9]|cut -c 0-12)")
local button = ""
local sudu = luci.sys.exec("/lib/spd")
local running = (luci.sys.call("pidof ikuacc > /dev/null") == 0)
local run = (luci.sys.call("pidof youkudome > /dev/null") == 0)
local bdsn=luci.sys.exec("getykbdlink 0000$(uci get -q youku.youku.opsn)|sed -e's/&/&amp;/g'")
local bdzt=luci.sys.exec("wget -O - http://pcdnapi.youku.com/pcdn/user/check_bindinfo?pid=0000$(uci get -q youku.youku.opsn)|grep 'name'|cut -d '\"' -f 16")
bd_button = "<input type=\"button\" value=\" " .. translate("绑定优酷帐号") .. " \" onclick=\"window.open('" .. bdsn .. "')\"/>"
today=luci.sys.exec("wget -O - 'http://pcdnapi.youku.com/pcdn/credit/summary?callback=?&pid=0000'$(uci get -q youku.youku.opsn)|cut -d '\"' -f 20")
lastday=luci.sys.exec("wget -O - 'http://pcdnapi.youku.com/pcdn/credit/summary?callback=?&pid=0000'$(uci get -q youku.youku.opsn)|cut -d '\"' -f 16")
total=luci.sys.exec("wget -O - 'http://pcdnapi.youku.com/pcdn/credit/summary?callback=?&pid=0000'$(uci get -q youku.youku.opsn)|cut -d '\"' -f 12")

if running  then
m = Map("youku", translate("优酷路由宝"), "<p style='text-align:left'>"..translate("路由宝正在工作中....").."<br></br>"..translate("WAN口速率 <span id='ykspd'>")..sudu.."</span></p>")
else
if run then
m = Map("youku", translate("优酷路由宝"), translate("<span id='ykspd'>路由宝正在启动中...."))
else
m = Map("youku", translate("优酷路由宝"), translate("<span id='ykspd'>路由宝已停止工作....</span>"))
end
end
s = m:section(TypedSection, "youku", translate("路由宝<a href=\"http://yjb.youku.com\" target=\"_blank\">  点击进入官方金币平台>></a>"..jq..ajax))

o = s:option(DummyValue,"","<p style='text-align:left'><strong>"..translate("序列号sn:").."</strong>".."<font color='green'> <strong>" ..opsn.."</strong></font></br><strong>"..translate("绑定状态: ").."</strong>".."<font color='green'> <strong>" ..bdzt.."</strong></font></br><strong>"..translate("今日收益: ").."</strong>".."<font color='green'> <strong>" ..today.."</strong></font></br><strong>"..translate("昨日收益: ").."</strong>".."<font color='green'> <strong>" ..lastday.."</strong></font></br><strong>"..translate("总计收益: ").."</strong>".."<font color='green'> <strong>" ..total.."</strong></br></font><strong>"..translate("绑定S/N: ").."</strong>".."<font color='green'> <strong>" ..bd_button.."</strong></br></font></p>")

s.anonymous = true
o = s:option(Flag, "enable", translate("是否启用矿机"))
o.rmempty = false

o = s:option(Value, "opsn", translate("SN"),translate("填写自己路由宝背后的SN"))

o = s:option(ListValue, "wkmod", translate("挖矿模式"))
o:value("0", translate("激进模式：赚取收益优先"))
o:value("2", translate("平衡模式：赚钱上网兼顾"))
o:value("3", translate("保守模式：上网体验优先"))

o = s:option(Value, "cqboot", translate("定时重启"), translate("定时重启，可以自定义重启时间，例：3点重启就输入0300即可，5点半重启就输入0530即可."))
o:value("", translate("不重启"))
o:value("0100", translate("1点整重启"))
o:value("0245", translate("2点45重启"))
o:value("0300", translate("3点重启"))
o = s:option(Flag, "ikrebot", translate("只重启矿机"), translate("勾选表示只重启挖矿程序，不勾选则重启路由器。"))

o = s:option(Value, "pathmeta", translate("meta文件夹目录"), translate("meta文件目录不会占用太多空间"))
o:value("/mnt/sda1", translate("/mnt/sda1"))

s2 = m:section(TypedSection, "path", translate("缓存文件"),
	translate("请在“系统-挂载点”里把磁盘挂载到/mnt目录下，缓存的大小是按1000MB=1GB算的，如7GB的剩余空间就填写7000"))

s2.template  = "cbi/tblsection"
s2.sortable  = true
s2.anonymous = true
s2.addremove = true

pth = s2:option(Value, "path", translate("缓存文件路径"))
local p_user
for _, p_user in luci.util.vspairs(luci.util.split(luci.sys.exec("df|grep '/mnt/'|awk '{print$6}'"))) do
	pth:value(p_user)
end

o = s2:option(Value, "pathhc", translate("缓存目录大小限制"))
o:value("", translate("保持默认"))
o:value("1000", translate("1GB缓存"))
o:value("2000", translate("2GB缓存"))
o:value("7000", translate("7GB缓存"))
o:value("14000", translate("14GB缓存"))
o:value("28000", translate("28GB缓存"))
o:value("56000", translate("56GB缓存"))

return m

