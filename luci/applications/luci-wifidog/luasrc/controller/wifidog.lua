--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.wifidog", package.seeall)


function index()
	local fs = require "nixio.fs"
	if fs.access("/usr/bin/wifidog") then
		entry({"admin", "services","wifidog"}, cbi("wifidog"), "WEB认证配置", 4)
		end
	
end

