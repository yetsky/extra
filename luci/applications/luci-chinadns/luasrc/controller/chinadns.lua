--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.chinadns", package.seeall)

function index()

	if not nixio.fs.access("/etc/config/chinadns") then
		return
	end
	
	local page
	page = node("admin", "gfw")
	page.target = firstchild()
	page.title = _("ÌÝ×Ó")
	page.order  = 64

	page = entry({"admin", "gfw", "chinadns"}, cbi("chinadns"), _("chinadns"), 5)
	page.i18n = "chinadns"
	page.dependent = true
end