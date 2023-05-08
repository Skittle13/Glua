-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\doorsetup\\sh_doorsetup.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MG_DoorCrackTime = {
	["default"] = 25,
	
	["rp_mg_area14_v6"] = {
		["lockdown_containment_door_lcz2"] = 45,
		["lockdown_containment_door_lcz1"] = 45,
		["lockdown_containment_door_r2"] = 45,
		["lockdown_containment_door_l2"] = 45,

		["schutzbunker_starwarsdoor_1"] = 180,
		["schutzbunker_starwarsdoor_2"] = 180,
		["shelter_containment_door_r"] = 180,
		["shelter_containment_door_l"] = 180,
	},

	["rp_mg_site05_v4"] = {
		-- LCZ/HCZ blastdoor
		["lockdown_blastdoor_hcz_l"] = 45,
		["lockdown_blastdoor_hcz_r"] = 45,
		["lockdown_blastdoor_hcz_l2"] = 45,
		["lockdown_blastdoor_hcz_r2"] = 45,

		["schutzbunker_starwarsdoor_1"] = 180,
		["schutzbunker_starwarsdoor_2"] = 180,
		["shelter_containment_door_r"] = 180,
		["shelter_containment_door_l"] = 180,
	},

	["rp_mg_site85_v2"] = {
		["bunker_door_oben_2"] = 180,
		["bunker_door_oben_1"] = 180,
	},

}

hook.Add("lockpickTime", "MG_Doors_LockpickTime", function(ply, ent)
	local door_tbl = MG_DoorCrackTime[string.lower(game.GetMap())]
	local lockpicktime = door_tbl and (ent.GetName and door_tbl[ent:GetName()] or ent.MapCreationID and door_tbl[ent:MapCreationID()]) or MG_DoorCrackTime["default"]

	lockpicktime = hook.Run("lockpickTimeOverride", ply, ent, lockpicktime) or lockpicktime

	return lockpicktime
end, HOOK_MONITOR_LOW or 2)