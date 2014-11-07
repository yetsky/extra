module("luci.controller.colorbox", package.seeall)

function index()
	        entry({"admin","colorbox"}, cbi("colorbox"),"ColorBox", 63)
end
