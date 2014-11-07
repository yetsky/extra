require "luci.sys"
local fs=require "nixio.fs"
local uci=require "luci.model.uci".cursor()
local has_colorbox=luci.sys.exec("uci get colorbox.@status[0].sn")
 
local colorbox_config=fs.access("/etc/config/colorbox")
local colorbox_enabled=luci.sys.init.enabled("colorbox")

if not( colorbox_config and colorbox_enabled) then
	sf=SimpleForm("colorbox", translate("Welcome to ColorBox"), "")
	sf.reset = false
	sf.submit = false
		
	se=sf:section(SimpleSection, "", "<font color='red'>"..translate("ColorBox is not running. Please <strong>Start</strong> ColorBox first.").."</font>")
	se.addremove=false                                
	se.anonymous=true	
			
	--start colorbox
	start = se:option(Button, "Start", translate("Start"))
	start.title=translate("Start ColorBox")
	start.inputtitle=translate("Start")
	start.inputstyle="apply"
	start.write = function(self, section)
		luci.sys.init.enable("colorbox")
		luci.sys.call("/etc/init.d/colorbox start >/dev/null")
		luci.sys.call("sleep 2")
		luci.http.redirect(luci.dispatcher.build_url("admin/colorbox"))
	end

	return sf
end

if luci.sys.exec("uci get colorbox.@camera_setting[0]") == "" then
        luci.sys.exec("uci add colorbox camera_setting")
end

--[[
Create status list of router
The list contains register flag, password, serial number
]]--

local uci_status=""
local uci_name=""
local uci_sn=""
local uci_button=""
local uci_tips=""

if has_colorbox~="" then
	uci_status="&nbsp;&nbsp;<font color='green'>" ..translate("Router Registered") .."</font>"
	uci_tips="The router is <strong>Registered</strong>, you can access this router via mobile phone app with the <em>Nickname or SN</em> displayed below."
	uci_button="&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"button\" value=\" " .. translate("Download mobile phone app") .. " \" onclick=\"window.open('http://colorbox.w-sharer.com')\"/>"
	uci_name=luci.sys.exec("uci get colorbox.@status[0].name")
	uci_sn=luci.sys.exec("uci get colorbox.@status[0].sn")
else
	uci_status="&nbsp;&nbsp;<font color='red'>" ..translate("Router Unregistered") .."</font>"
	uci_tips="The router is <strong>Unregistered</strong>, check your router connection and make sure its network is configured correctly, please."
	uci_button=""
end

m = Map("colorbox", translate("ColorBox Information"), translate("List registration information of Colorbox."));
register=m:section(TypedSection,"status", translate("Status: ") ..uci_status, translate(uci_tips)..uci_button)
register.addremove=false
register.anonymous=true
if has_colorbox then
	if (uci_sn~="") then
		sn=register:option(DummyValue,"","<p style='text-align:left'><strong>&nbsp;&nbsp;" ..translate("SN: ") .."</strong>" .."<font color='green' size='4'> <strong>"..uci_sn.."</strong></font></p>", translate("The serial number of router is assigned by our server and can't be edited."))
		if (uci_name~="") then
			name=register:option(DummyValue,"","<p style='text-align:left'><strong>"..translate("Nick: ").."</strong>".."<font color='green' size='4'> <strong>" ..uci_name.."</strong></font></p>", translate("The nickname of router can be edited via mobile phone app."))
		else
			name=register:option(DummyValue,"","<p style='text-align:left'><strong>"..translate("Nick: ").."</strong>".."<font color='green' size='4'> <strong>" ..translate("no nick set").."</strong></font></p>", translate("The nickname of router can be edited via mobile phone app."))
		end	
	end
	usb=m:section(TypedSection,"camera_setting", translate("USB Camera Settings"))
	usb.addremove=false
	usb.anonymous=true
	camera = usb:option(Flag, "force_yuyv", translate("FORCE YUYV MODE:"), translate("Some camera needs to be set to YUYV mode, e.g. Microsof HD5000, Logitech C270."))
	camera.rmempty = false
end

--[[
Set ColorBox password
]]--

f=SimpleForm("colorbox", translate("ColorBox password"), translate("Set the administrator password for accessing this router via mobile phone app. The new password will be encrypted and not be displayed on <em>ColorBox Information</em>."))
f.reset=false

s=f:section(TypedSection, "_dummy", "")
s.addremove=false                                
s.anonymous=true  

key=s:option(Value,"pass",translate("Password"))

function s.cfgsections()
        return { "_key" }                                                       
end

function f.handle(self, state, data)                                                                                             
        if state == FORM_VALID then
                local key_value=key:formvalue("_key")
                if key_value and #key_value > 0 then
                        local key_md5=luci.sys.exec("echo -n %s | md5sum" % key_value):match("^([^%s]+)")
                        luci.sys.call("uci set colorbox.@status[0].pw=%s & > /dev/null" % key_value)
                        luci.sys.call("uci set colorbox.@status[0].md5=%s & > /dev/null" % key_md5)
                        luci.sys.call("uci commit & > /dev/null")
                        f.message=translate("Password successfully changed!")
                        
                        if luci.sys.call("pidof tools > /dev/null") == 0 then
                                luci.sys.call("/etc/init.d/colorbox restart & > /dev/null")
                        end
                end
        end
        luci.sys.call("uci commit & > /dev/null")                                                                                                             
        return true                                                                                                              
end

return m,f
