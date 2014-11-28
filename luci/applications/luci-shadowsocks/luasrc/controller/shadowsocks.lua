--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.shadowsocks", package.seeall)

function index()

	if not nixio.fs.access("/etc/config/shadowsocks") then
		return
	end
	
	local page
	page = node("admin", "gfw")
	page.target = firstchild()
	page.title = _("ÌÝ×Ó")
	page.order  = 64

	page = entry({"admin", "gfw", "shadowsocks"}, cbi("shadowsocks"), _("shadowsocks"), 3)
	page.i18n = "shadowsocks"
	page.dependent = true
end
