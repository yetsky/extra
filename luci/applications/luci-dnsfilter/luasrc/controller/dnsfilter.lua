--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.dnsfilter", package.seeall)

function index()

	if not nixio.fs.access("/etc/config/dnsfilter") then
		return
	end
	
	local page
	page = node("admin", "gfw")
	page.target = firstchild()
	page.title = _("ÌÝ×Ó")
	page.order  = 64

	page = entry({"admin", "gfw", "dnsfilter"}, cbi("dnsfilter"), _("dnsfilter"), 6)
	page.i18n = "dnsfilter"
	page.dependent = true
end