NG_Lib = NG_Lib or {}
NG_Lib.InvisEntities = NG_Lib.InvisEntities or {}

-- Net Messages

util.AddNetworkString("North_AlcoholEffect")

-- Schild Schaden

local NG_Shield_Ents = {
	["bs_dshield"] = true,
	["bs_hshield"] = true,
	["bs_rshield"] = true,
	["bs_shield"] = true,
}

function North_TakeShieldDamage(tr, damage)
	if not IsValid(tr.Entity) then return false end
	if NG_Shield_Ents[tr.Entity:GetClass()] then
		tr.Entity:TakeDamage(damage or math.random( 1000, 1200 ))
		tr.Entity:EmitSound("physics/metal/metal_box_break1.wav")
		return true
	end
end

-- Deathscreen umgehen beim Job ändern

timer.Simple(0, function()
	GAMEMODE.Config.instantjob = true
end)

-- Stats des Spielers anpassen

local function NG_ApplySpeeds(ply, job_tbl)
	GAMEMODE:SetPlayerSpeed(ply, job_tbl.walkspeed or GAMEMODE.Config.walkspeed, job_tbl.runspeed or GAMEMODE.Config.runspeed)
	ply:SetJumpPower(job_tbl.jumppower or 200)
end

local reg = debug.getregistry()
local SetHealth = reg.Entity.SetHealth
local SetMaxHealth = reg.Entity.SetMaxHealth
local SetArmor = reg.Player.SetArmor
local AllowFlashlight = reg.Player.AllowFlashlight

timer.Simple(0, function()
	for k, v in ipairs(RPExtraTeams) do
		v.PlayerSpawn = function(ply)
			local job_tbl = ply:getJobTable()
			
			-- Leben / Rüstung

			if job_tbl.health then
				local health = job_tbl.health
				SetHealth(ply, health)
				SetMaxHealth(ply, health)
			end

			if job_tbl.maxhealth then
				SetMaxHealth(ply, job_tbl.maxhealth)
			end

			if job_tbl.armor then
				SetArmor(ply, job_tbl.armor)
			end

			-- Taschenlampe

			if job_tbl.noflashlight then
				AllowFlashlight(ply, false)
			end

			-- Geschwindigkeit

			NG_ApplySpeeds(ply, job_tbl)

			hook.Call("NG_ApplySpeeds", nil, ply)
		end
	end
end)

-- Geschwindigkeit des Spielers anpassen/speichern

local reg = debug.getregistry()
local GetTable = reg.Entity.GetTable

hook.Add("NG_ApplySpeeds", "NG_Lib_ApplySpeeds", function(ply)
	local tb = GetTable(ply)
	tb.NG_Lib_WalkSpeed = ply:GetWalkSpeed()
	tb.NG_Lib_RunSpeed = ply:GetRunSpeed()
	tb.NG_Lib_SlowWalkSpeed = ply:GetSlowWalkSpeed()
	tb.NG_Lib_JumpPower = ply:GetJumpPower()
end)

function NG_MultiplySpeed(ply, walkspeed, runspeed, slowwalkspeed)
	if !IsValid(ply) then return end

	local tb = ply:GetTable()

	if tb.NG_Lib_Tazed then return end
	if !tb.NG_Lib_WalkSpeed or !tb.NG_Lib_RunSpeed then return end
	
	GAMEMODE:SetPlayerSpeed(ply, tb.NG_Lib_WalkSpeed * walkspeed, tb.NG_Lib_RunSpeed * runspeed)
	ply:SetSlowWalkSpeed(slowwalkspeed and tb.NG_Lib_SlowWalkSpeed * slowwalkspeed or tb.NG_Lib_SlowWalkSpeed)
end

-- Benutzen von Türen / Entities verbieten

hook.Add( "PlayerUse", "NG_RestrictUse", function(ply, ent)
	if ply:getJobTable().noUse then
        return false
	end
end )

-- Hülle des Spielers anpassen

local reg = debug.getregistry()
local GetTeam = reg.Player.Team

util.AddNetworkString("North_SetHull")

NG_Lib.HullSize = {
	mins = Vector(-16, -16, 0),
	maxs = Vector(16, 16, 72)
}

local job_hullsize = {}

hook.Add("PlayerSpawn", "NG_ChangeHullSize", function(ply)
	timer.Simple(0.1, function()
		if !IsValid(ply) then return end
		local job = GetTeam(ply)
		if job_hullsize[job] then
			local hullsize = job_hullsize[job]
			ply:SetHull(hullsize.mins, hullsize.maxs)
			net.Start("North_SetHull")
				net.WriteEntity(ply)
				net.WriteVector(hullsize.mins)
				net.WriteVector(hullsize.maxs)
			net.Send(ply)
		else
			local hullsize = NG_Lib.HullSize
			ply:SetHull(hullsize.mins, hullsize.maxs)
			net.Start("North_SetHull")
				net.WriteEntity(ply)
				net.WriteVector(hullsize.mins)
				net.WriteVector(hullsize.maxs)
			net.Send(ply)
		end
	end)
end)

-- Viewoffset des Spielers anpassen

NG_Lib.ViewOffset = 64

local job_viewoffsets = {}

hook.Add("OnPlayerChangedTeam", "NG_ChangeViewOffset", function(ply, before, after)
	if job_viewoffsets[after] then
		ply:SetViewOffset(Vector(0, 0, job_viewoffsets[after]))
	else
		if job_viewoffsets[before] then
			ply:SetViewOffset(Vector(0, 0, NG_Lib.ViewOffset))
		end
	end
end)

-- Cooler Effekt und Direkter Tod

local effect_inflictor = {}

local skeleton_inflictor = {}

hook.Add("MedicSys_PlayerDeath", "NG_Lib_Death", function(ply, dmg)
	local inflictor = dmg:GetInflictor()
	local dtype = dmg:GetDamageType()
	if IsValid(inflictor) then
		if effect_inflictor[inflictor:GetClass()] or dtype == DMG_ENERGYBEAM then
			local ed = EffectData()
			ed:SetOrigin(ply:LocalToWorld(ply:OBBCenter()))
			util.Effect(skeleton_inflictor[inflictor:GetClass()] and "devour_effect" or "deathbody_effect", ed, true, true)
			ply.MedicSys_InstantDeath = true
			ply:EmitSound("physics/flesh/flesh_squishy_impact_hard3.wav")

			for i = 1, 10 do
				util.Decal("Blood", ply:GetPos() + Vector(math.random(-10, 10), math.random(-10, 10), 0), Vector(0,0,-64), ply)
			end

			if (skeleton_inflictor[inflictor:GetClass()] or dtype == DMG_ENERGYBEAM) and !ply:getJobTable().scp then
				ply:SetModel("models/player/skeleton.mdl")
				ply:SetSkin(math.random(0, 2))
			end
		end
	end
end)

-- Fesseln verbieten

local disallowed_teams = {}

local reg = debug.getregistry()
local GetTeam = reg.Player.Team

hook.Add("Cuffs_StartCuff", "NG_Restrict", function(ply, ent, isleash)
	if !IsValid(ply) or !IsValid(ent) then return end
	if ent:HasGodMode() then return false end
	local job = GetTeam(ent)
	local disallowed = disallowed_teams[job]
	if disallowed then
		local func = disallowed[3]
		if func then
			if func(ply, ent, isleash) == false then
				DarkRP.notify(ply, NOTIFY_ERROR, 5, disallowed[1])
				return false
			end
		end
		if !isleash and disallowed[2] then
			DarkRP.notify(ply, NOTIFY_ERROR, 5, disallowed[1])
			return false
		end
	end
end)

-- Respawnen verbieten

hook.Add("MedicSys_CanRespawn", "NG_MedicSys_CanRespawn", function(vent)
	local rag = vent:GetParent()
	if rag then
		if rag.IsInfected then
			return false
		end
	end
end)

-- Sprays verbieten

hook.Add("PlayerSpray", "NG_Disallow_Spray", function(ply)
	return true
end)

-- Hinsetzen verbieten

hook.Add("OnPlayerSit", "NG_SitRestrict", function(ply)
	if ply:HasWeapon("weapon_handcuffed") then return false end
	if ply:getJobTable().disallowSit then return false end
end)

-- AFK verbieten wenn man tot ist

hook.Add("canGoAFK", "NG_Lib_CanGoAFK", function(ply)
	if ply:IsKnocked() then
		return false
	end
end)

-- Refund System

hook.Add("MedicSys_PlayerDeath", "NG_RefundSystem", function(ply)
	local savedWepClasses = {}
	for k, v in pairs(ply:GetWeapons()) do
		savedWepClasses[#savedWepClasses + 1] = v:GetClass()
	end
	ply.RefundWeapons = savedWepClasses
end)