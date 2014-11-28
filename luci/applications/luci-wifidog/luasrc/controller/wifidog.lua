--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.wifidog", package.seeall)

function index()
	local fs = require "nixio.fs"
	if not nixio.fs.access("/usr/bin/wifidog") then
		return
	end

	local page
	page = node("admin", "opapp")
	page.target = firstchild()
	page.title = _("应用")
	page.order  = 65

	page = entry({"admin", "opapp", "wifidog"}, cbi("wifidog"), _("WEB认证配置"), 4)
	page.dependent = true
end
