--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.mjpg-streamer", package.seeall)

function index()
	local fs = require "nixio.fs"
	if not nixio.fs.access("/etc/config/mjpg-streamer") then
		return
	end

	local page
	page = node("admin", "opapp")
	page.target = firstchild()
	page.title = _("”¶”√")
	page.order  = 65

	page = entry({"admin", "opapp", "mjpg-streamer"}, cbi("mjpg-streamer"), _("mjpg-streamer"), 3)
	page.i18n = "mjpg-streamer"
	page.dependent = true
end
