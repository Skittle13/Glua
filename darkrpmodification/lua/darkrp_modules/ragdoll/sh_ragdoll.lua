-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\ragdoll\\sh_ragdoll.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
DarkRP.declareChatCommand({
	command = "sleep",
	description = "Go to sleep or wake up",
	delay = 1
})

DarkRP.declareChatCommand({
	command = "wake",
	description = "Go to sleep or wake up",
	delay = 1
})

DarkRP.declareChatCommand({
	command = "wakeup",
	description = "Go to sleep or wake up",
	delay = 1
})

hook.Add("PhysgunPickup", "Ragdoll_Restrict", function(ply, ent)
	if ent:IsRagdoll() and IsValid(ent:GetDTEntity(0)) and ent:GetDTEntity(0):IsPlayer() then
		return false
	end
end)

hook.Add("CanTool", "Ragdoll_Restrict", function(_, tr, _)
	local ent = tr.Entity
	if IsValid(ent) and ent:IsRagdoll() and IsValid(ent:GetDTEntity(0)) and ent:GetDTEntity(0):IsPlayer() then
		return false
	end
end)

hook.Add("PlayerSwitchWeapon", "Ragdoll_Restrict", function(ply, old, new)
	if (SERVER and ply.IsRagdolled) or (CLIENT and IsValid(ply.RagdollPlayer)) then
		if new != old and IsValid(new) and new:GetClass() == "weapon_tasered" or new:GetClass() == "weapon_sleeping" then return end
		return true
	end
end)

hook.Add("Cuffs_CanDoAction", "Ragdoll_Restrict", function(ply)
	if ply.IsRagdolled then
		return false
	end
end)

hook.Add("MG_SCP096_BagRemoval", "Ragdoll_Restrict", function(ply)
	if ply.IsRagdolled then
		return false
	end
end)