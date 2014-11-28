--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.autossh", package.seeall)

function index()
	local fs = require "nixio.fs"
	if not nixio.fs.access("/etc/config/autossh") then
		return
	end

	local page
	page = node("admin", "gfw")
	page.target = firstchild()
	page.title = _("ÌÝ×Ó")
	page.order  = 64

	page = entry({"admin", "gfw", "autossh"}, cbi("autossh"), _("SSH-SOCKS5"), 1)
	page.dependent = true
end
