--[[
ip-qos by:QQ76888484整理
]]--

m = Map("ip-qos", "单IP限速")

s = m:section(TypedSection, "ip-qos", "全局限速")
s.anonymous = true

s:tab("general",  "常规设置")
s:tab("template", "脚本编辑")

s:taboption("general",Flag, "enable", "启动")


s:taboption("general", Value, "down", "全局上传速度(kbit/s)","1Mib/s=8192kbit/s")
s:taboption("general", Value, "up", "全局下载速度(kbit/s)","1Mib/s=8192kbit/s")


tmpl = s:taboption("template", Value, "_tmpl","脚本", "限速脚本")

tmpl.template = "cbi/tvalue"
tmpl.rows = 20

function tmpl.cfgvalue(self, section)
	return nixio.fs.readfile("/usr/bin/ip-qos")
end

function tmpl.write(self, section, value)
	value = value:gsub("\r\n?", "\n")
	nixio.fs.writefile("//usr/bin/ip-qos", value)
end


s = m:section(TypedSection, "ip-limit", "IP限速","例如:192.168.1.20,192.168.1.128/25,不支持 192.168.1.2-192.168.1.30")
s.anonymous = true
s.addremove = true
s.sortable  = true
s.template = "cbi/tblsection"


s1 = s:option(Flag, "enable", "启动")
s1.rmempty = false
s1.enabled = "1"
s1.disabled = "0"

o = s:option(Value, "ip","IP地址")
o.rmempty = true
o.datatype = "neg(ip4addr)"
o.placeholder = translate("==请选择==")

luci.sys.net.ipv4_hints(function(ip, name)
	o:value(ip, "%s (%s)" %{ ip, name })
end)

s:option(Value, "upc", "上传保证速度(kbit/s)").rmempty = true
s:option(Value, "downc", "下载保证速度(kbit/s)").rmempty = true
s:option(Value, "upr", "上传最大速度(kbit/s)").rmempty = true
s:option(Value, "downr", "下载最大速度(kbit/s)").rmempty = true


s = m:section(TypedSection, "connlmt", "连接数限制")
s.anonymous = true
s.addremove = true
s.sortable  = true
s.template = "cbi/tblsection"


s1 = s:option(Flag, "enable", "启动")
s1.rmempty = false
s1.enabled = "1"
s1.disabled = "0"

o = s:option(Value, "ip","IP地址")
o.rmempty = true
o.datatype = "neg(ip4addr)"
o.placeholder = translate("==请选择==")

luci.sys.net.ipv4_hints(function(ip, name)
	o:value(ip, "%s (%s)" %{ ip, name })
end)

s:option(Value, "tcp", "TCP连接数").rmempty = true
s:option(Value, "udp", "UDP连接数").rmempty = true



s = m:section(TypedSection, "port_first", "端口优先","优先端口不会被打上标记进入队列，可将对延时要求高的应用放入这里。")
s.anonymous = true
s.addremove = true
s.sortable  = true
s.template = "cbi/tblsection"


s1 = s:option(Flag, "enable", "启动")
s1.rmempty = false
s1.enabled = "1"
s1.disabled = "0"

o = s:option(Value, "proto", translate("协议"))
o:value("tcp", "TCP")
o:value("udp", "UDP")
o:value("icmp", "ICMP")

s:option(Value, "port", "端口").rmempty = true


return m
