--[[
--Shadowsocks Client configuration page. Made by 981213
--
]]--

local fs = require "nixio.fs"

m = Map("macvlan", translate("Create virtual WAN interfaces"),
        translatef("Here you can create some virtual WAN interfaces with MACVLAN driver."))

s = m:section(TypedSection, "macvlan", translate(" "))
s.anonymous = true

switch = s:option(Flag, "enabled", translate("Enable"))
switch.rmempty = false

wannum = s:option(Value, "wannum", translate("Number of virtual WAN"))
wannum.datatype = "range(0,200)"
wannum.optional = false

pppnum = s:option(Value, "pppnum", translate("Number of PPP diag"))
pppnum.datatype = "range(0,200)"
pppnum.optional = false

local apply = luci.http.formvalue("cbi.apply")
if apply then
	os.execute('/bin/genwancfg &')
end

return m


