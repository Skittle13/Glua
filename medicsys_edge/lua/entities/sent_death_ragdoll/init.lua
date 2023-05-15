AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

util.AddNetworkString("Unconscious.SendInfo")
util.AddNetworkString("Ragdoll.RemoveSound")

function ENT:Initialize()
	self:SetModel( "models/hunter/triangles/025x025.mdl" )
	self:PhysicsInit( SOLID_NONE )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
end

function ENT:SpawnFunction( pl, trace, class )
	local ent = ents.Create( class )
	ent:SetPos( trace.HitPos + trace.HitNormal * 16 )
	ent:Spawn()
	local dmg = DamageInfo()
	dmg:SetAttacker(pl)
	dmg:SetDamage(1000)
	ent:SetPlayer(pl, true, pl:GetVelocity(), dmg)

	return ent
end

function ENT:ReturnWeapons()
    local ply = self:GetOwner()
    local tb = self:GetTable()
    if tb.Weapons and ply:Alive() then
        for k,v in pairs(tb.Weapons) do
            local wep = ply:Give(k, true)
            if (IsValid(wep)) then
                wep:SetClip1(v.clip1)
                wep:SetClip2(v.clip2)
                ply:SetAmmo(v.ammo, wep:GetPrimaryAmmoType())
                ply:SetAmmo(v.ammo2, wep:GetSecondaryAmmoType())
            end
        end
    end
end

ENT.NoLoop = false
function ENT:OnRemove()
	local owner = self:GetOwner()
	local tb = self:GetTable()

	if (IsValid(owner) and !tb.NoLoop) then

		tb.NoLoop = true
			
		owner:SetDSP(0)
		owner:SetNW2Bool("IsRagdoll", false)
		owner:Spectate(OBS_MODE_NONE)
		owner:AllowFlashlight(true)
		owner:UnSpectate()

		if !tb.IsDeath then
			owner:Spawn()
			owner:SetModel(tb.Model)
			owner:SetPos(self:GetPos())
			owner:SetHealth(tb.HealthF)
		else
			if (IsValid(owner)) then
				local dmg = tb.dmg or DamageInfo()
				if !IsValid(dmg.attacker) then
					dmg.attacker = owner
				end
				owner:StripWeapons()
				hook.Run("PlayerDeath", owner, dmg.attacker, dmg.attacker)
				owner:Spawn()
			end
		end

		if IsValid(tb.Ragdoll) then
			tb.Ragdoll:Remove()
		end		
	end
end

function ENT:SetPlayer(ply, isdeath, vel, dmg, time, isdead)

	if (!IsValid(ply)) then return end

	if (ply:InVehicle()) then
		ply:ExitVehicle()
	end

	local tb = self:GetTable()
		
	tb.IsDead = isdead

	ply:SetBleeding(0)
	ply:AllowFlashlight(false)

	tb.HealthF = (isdeath and !MedConfig.PersistHealth) and 1 or ply:Health()
	tb.Gender = ply.Gender
	tb.IsDeath = isdeath
	tb.Model = ply:GetModel()
	tb.Ragdoll = ents.Create("prop_ragdoll")
	tb.Ragdoll:SetPos(ply:GetPos())
	tb.Ragdoll:SetAngles(Angle(0,ply:GetAngles().y))

	local model, cancel = hook.Run("MedicSys_SetModel", ply)
	tb.Ragdoll:SetModel(ply:GetModel())

	--Bodygroups fix
	local bodyGroups = ply:GetBodyGroups()
	self:SetBodyGroups(bodyGroups)
	tb.Ragdoll:SetSkin(ply:GetSkin())

	tb.Ragdoll:Spawn()

	if cancel then
		tb.Ragdoll:SetNoDraw(true)
	end

	tb.Ragdoll._Health = MedConfig.RagdollHealth
	tb.Ragdoll._Health2 = 100000
	tb.Ragdoll.PlayerOwn = ply
	tb.Ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	tb.Ragdoll:SetNW2Bool("IsPlayerRagdoll", true)

	tb.Ragdoll.DeathRagdoll = self
	self:SetRagdoll(tb.Ragdoll)

	ply:SetNW2Bool("IsRagdoll", true)
	ply:SetNW2Entity("RagdollEntity", tb.Ragdoll)

	self:SetOwner(ply)
	self:SetParent(tb.Ragdoll)
	self:SetLocalPos(Vector(0,0,0))

	tb.Weapons = {}
	tb.dmg = dmg

	if true then
		ply:SetHealth(5)
		local tbl = {
			attacker = dmg:GetAttacker(),
			damage = dmg:GetDamage()
		}
		tb.dmg = tbl
	end
		
	tb.Ragdoll:SetNW2Bool("IsRagdoll", true)
	tb.Ragdoll:SetNW2Bool("KnockedOff", false)

	self:SetWakeUp(CurTime() + (true and MedConfig.DeathCountdown or MedConfig.UnconsciousCD))
	self:SetRespawn(CurTime() + (true and MedConfig.DeathCountdown or MedConfig.UnconsciousCD))

	if time then
		self:SetWakeUp(CurTime() + time)
		self:SetRespawn(CurTime() + time)
	end

	net.Start("Unconscious.SendInfo")
	net.WriteBool(true)
	net.WriteFloat(self:GetWakeUp())
	net.Send(ply)

	tb.Weapons = {}
	for k,v in pairs(ply:GetWeapons()) do
		tb.Weapons[v:GetClass()] = {
			clip1 = v:Clip1(),
			clip2 = v:Clip2(),
			ammo = ply:GetAmmoCount(v:GetPrimaryAmmoType()),
			ammo2 = ply:GetAmmoCount(v:GetSecondaryAmmoType()),
		}
	end

	local num = tb.Ragdoll:GetPhysicsObjectCount() - 1
	for i = 0, num do
		local bone = tb.Ragdoll:GetPhysicsObjectNum(i)
		if IsValid(bone) then
			local pos, ang = ply:GetBonePosition(tb.Ragdoll:TranslatePhysBoneToBone(i))
			if pos and ang then
				bone:SetPos(pos)
				bone:SetAngles(ang)
			end
			bone:ApplyForceCenter(vel * 10)
		end
	end

	ply:Spectate( OBS_MODE_CHASE )
	ply:SpectateEntity(tb.Ragdoll)
end

function ENT:Think()
	local owner = self:GetOwner()
	local tb = self:GetTable()

	if !IsValid(owner) then
		self:Remove()
		return
	end

	if !IsValid(tb.Ragdoll) || !IsValid(owner) then
		self:Remove()
		return
	end

	if CurTime() > tb.dt.WakeUp then
		tb.dt.IsDead = true
	end

	if tb.dt.IsDead then
		if !tb.Ragdoll:GetNW2Bool("RagdollDeath") then
			tb.Ragdoll:SetNW2Bool("RagdollDeath", true)
		end
		return
	end

	if(!tb.NextMoaning) then tb.NextMoaning = CurTime() + math.random(1.5, 7.5) end
	if tb.Gender and tb.NextMoaning < CurTime() then
		tb.NextMoaning = CurTime() + math.random(1.5, 7.5)
		tb.Ragdoll:EmitSound("vo/npc/" .. (tb.Gender == 1 and "male" or "female") .. "01/moan0" .. math.random(1,5) .. ".wav")
	end
end