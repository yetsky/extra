--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.autossh", package.seeall)


function index()
	local fs = require "nixio.fs"
	if fs.access("/etc/config/autossh") then
		entry({"admin", "services","autossh"}, cbi("autossh"), "SSH-SOCKS5", 4)
		end
	
end

