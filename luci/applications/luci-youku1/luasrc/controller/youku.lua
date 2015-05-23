
module("luci.controller.youku", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/youku") then
		return
	end

	local page
	page = entry({"admin", "services", "youku"}, cbi("youku"), _("优酷路由宝"), 56)
	page.dependent = true
end
