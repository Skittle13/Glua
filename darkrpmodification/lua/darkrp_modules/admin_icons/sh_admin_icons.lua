-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\admin_icons\\sh_admin_icons.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local meta = FindMetaTable("Player")
if SERVER then
	util.AddNetworkString("HUD_OverrideGodmode")

	local oldGodEnable = meta.GodEnable
	function meta:GodEnable()
		net.Start("HUD_OverrideGodmode")
			net.WriteBool(true)
		net.Send(self)
		oldGodEnable(self)
	end

	local oldGodDisable = meta.GodDisable
	function meta:GodDisable()
		net.Start("HUD_OverrideGodmode")
			net.WriteBool(false)
		net.Send(self)
		oldGodDisable(self)
	end
else
	local godmode_active = false

	net.Receive("HUD_OverrideGodmode", function()
		godmode_active = net.ReadBool()
	end)

	function meta:HasGodMode()
		return godmode_active
	end
end