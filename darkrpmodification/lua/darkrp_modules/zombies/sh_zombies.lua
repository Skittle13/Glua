-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\zombies\\sh_zombies.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local zombies = {}
local hooks_added = false
local function Forbidden(ply)
	if ply:GetMGVar("Zombie", false) then
		return false
	end
end

local function Disconnect(ply)
	zombies[ply] = nil
	if table.IsEmpty(zombies) and hooks_added then
		hooks_added = false
		hook.Remove("MG_MedicSys.BodyOptions", "MG_Zombie_Restrict")
		hook.Remove("MG_MedicSys.FunctionWithPlayer", "MG_Zombie_Restrict")
		hook.Remove("Cuffs_CanDoAction", "MG_Zombie_Restrict")
		hook.Remove("MG_SCP096_BagRemoval", "MG_Zombie_Restrict")
		hook.Remove("PlayerDisconnected", "MG_Zombie_Restrict")
	end
end

hook.Add("mg_vars_update", "MG_Zombie_Restrict_SH", function(ply, name, new, old)
	if name == "Zombie" and new != old then
		if new == true then
			zombies[ply] = true
			if !hooks_added then
				hooks_added = true
				hook.Add("MG_MedicSys.BodyOptions", "MG_Zombie_Restrict", Forbidden)
				hook.Add("MG_MedicSys.FunctionWithPlayer", "MG_Zombie_Restrict", Forbidden)
				hook.Add("Cuffs_CanDoAction", "MG_Zombie_Restrict", Forbidden)
				hook.Add("MG_SCP096_BagRemoval", "MG_Zombie_Restrict", Forbidden)
				hook.Add("PlayerDisconnected", "MG_Zombie_Restrict", Disconnect)
			end
		else
			zombies[ply] = nil
			if table.IsEmpty(zombies) and hooks_added then
				hooks_added = false
				hook.Remove("MG_MedicSys.BodyOptions", "MG_Zombie_Restrict")
				hook.Remove("MG_MedicSys.FunctionWithPlayer", "MG_Zombie_Restrict")
				hook.Remove("Cuffs_CanDoAction", "MG_Zombie_Restrict")
				hook.Remove("MG_SCP096_BagRemoval", "MG_Zombie_Restrict")
				hook.Remove("PlayerDisconnected", "MG_Zombie_Restrict")
			end
		end
	end
end)