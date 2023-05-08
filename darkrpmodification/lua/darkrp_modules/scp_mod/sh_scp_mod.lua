-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\scp_mod\\sh_scp_mod.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- Hazmat Suit-Funktionalität

local hazmats = {
	-- Main
	["models/player/cod_ghost/hazmatchik/hazmat_pm.mdl"] = true, -- CT
}

local reg = debug.getregistry()
local GetModel = reg.Entity.GetModel

function MG_HasHazmatSuit(ply)
	return hazmats[GetModel(ply)] and true or false
end

-- Überprüfung für ein SCP, welches potenziell gefährlich ist

function MG_IsActiveSCP(ply)
	local job_tbl = ply:getJobTable()

	if job_tbl and job_tbl.scp then
		local wep = ply:GetActiveWeapon()
		local wep_tbl = wep:GetTable()
		if !wep_tbl then
			return false
		end

		if job_tbl.scp.breach and (!wep_tbl.SCP1048 or wep:GetMutated()) and (!wep_tbl.SCP096 or wep:GetActive()) then
			return true
		end
	end

	return false
end