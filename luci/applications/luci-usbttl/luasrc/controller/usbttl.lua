--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.usbttl", package.seeall)


function index()
	local fs = require "nixio.fs"
	if fs.access("/etc/config/usbttl") then
		entry({"admin", "services","usbttl"}, cbi("usbttl"), "USB-TTL", 4)
		end
	
end

