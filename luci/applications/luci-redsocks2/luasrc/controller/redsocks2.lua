--[[
QQ:76888484
http://yetsky.taobao.com/
]]--

module("luci.controller.redsocks2", package.seeall)

function index()
	local page
	page = node("admin", "gfw")
	page.target = firstchild()
	page.title = _("梯子")
	page.order  = 64

	page = entry({"admin", "gfw", "redsocks2"}, cbi("redsocks2"), _("redsocks2"), 2)
	page.dependent = true
end
