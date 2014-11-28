--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.ser2net", package.seeall)

function index()

	local page
	page = node("admin", "opapp")
	page.target = firstchild()
	page.title = _("应用")
	page.order  = 65

	page = entry({"admin", "opapp", "ser2net"}, cbi("ser2net"), _("Ser2net"), 2)
	page.dependent = true
end
