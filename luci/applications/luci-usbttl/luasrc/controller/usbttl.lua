--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.usbttl", package.seeall)

function index()
	local fs = require "nixio.fs"
	if not nixio.fs.access("/etc/config/usbttl") then
		return
	end

	local page
	page = node("admin", "opapp")
	page.target = firstchild()
	page.title = _("应用")
	page.order  = 65

	page = entry({"admin", "opapp", "usbttl"}, cbi("usbttl"), _("USB-TTL"), 1)
	page.dependent = true
end
