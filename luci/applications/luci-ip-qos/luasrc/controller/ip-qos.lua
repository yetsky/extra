--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.ip-qos", package.seeall)


function index()
	local fs = require "nixio.fs"
	if fs.access("/usr/bin/ip-qos") then
		entry({"admin", "network","ip-qos"}, cbi("ip-qos"), "单IP限速", 4)
		end
	
end

