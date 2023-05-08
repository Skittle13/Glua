-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\prop_spawn\\cl_prop_spawn.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
hook.Add("SpawnMenuOpen", "MG_PropSpawn_Restrict", function()
	if !LocalPlayer():IsAdmin() then
		return false
	end
end)

hook.Add("CanProperty", "MG_PropSpawn_Function", function()
	if !LocalPlayer():IsAdmin() then
		return false
	end
	return true
end)