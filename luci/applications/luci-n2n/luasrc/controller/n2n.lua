--[[
N2N Luci configuration page.Made by 981213
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
