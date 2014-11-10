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
	page = entry({"admin", "services", "n2n"}, cbi("n2n"), _("N2N VPN"), 45)
	page.dependent = true
end
