--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.n2n", package.seeall)

function index()

	if not nixio.fs.access("/etc/config/n2n") then
		return
	end
	
	local page
	page = node("admin", "gfw")
	page.target = firstchild()
	page.title = _("梯子")
	page.order  = 64

	page = entry({"admin", "gfw", "n2n"}, cbi("n2n"), _("N2N VPN"), 4)
	page.i18n = "n2n"
	page.dependent = true
end
