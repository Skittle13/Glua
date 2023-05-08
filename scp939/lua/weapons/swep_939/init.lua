AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local math = math
local reg = debug.getregistry()
local Visible = reg.Entity.Visible
local SetHealth = reg.Entity.SetHealth
local GetHealth = reg.Entity.Health
local GetMaxHealth = reg.Entity.GetMaxHealth

util.AddNetworkString("SCP.GetSounds")
function SWEP:EntityEmitSound(data)
	local owner = self.Owner

	local ent = data.Entity
	local ent_tb = ent:GetTable()
	local cur_time = CurTime()

	if (ent:IsPlayer() and Visible(owner, ent)) then
		if cur_time - (ent_tb.LastSound or 0) > 1.5 then
			ent_tb.LastSound = cur_time
			net.Start("SCP.GetSounds")
				net.WriteEntity(ent)
			net.Send(owner)
		end
	end
end


function SWEP:PlayerTrace(owner, cl)
	if cl then
		owner:LagCompensation(true)
	end
	local tr = TraceAttack({
		start = owner:GetShootPos(),
		endpos = owner:GetShootPos() + owner:GetAimVector() * self.HD,
		filter = owner,
		mins = Vector(-10, -10, -8),
		maxs = Vector(10, 10, 8),
	})
	if cl then
		owner:LagCompensation(false)
	end
	return tr
end

local function CreateEffect(tr)
	local edata = EffectData()
	edata:SetScale(1)
	edata:SetColor(BLOOD_COLOR_RED)
	edata:SetOrigin(tr.HitPos)
	edata:SetNormal(tr.Normal)
	util.Effect("BloodImpact", edata, true, true)
end

function SWEP:DamagePlayer(owner, tr, ent)
	CreateEffect(tr)

	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(owner)
	dmginfo:SetInflictor(self)
	dmginfo:SetDamage(self.DMG)
	dmginfo:SetDamageForce(owner:GetRight() * 4912 + owner:GetForward() * 9998)
	ent:DispatchTraceAttack(dmginfo, tr, tr.HitNormal)
	util.Decal("Blood", ent:GetPos(), Vector(0,0,-64), ent)
end

local sounds = {
	"scp/939/bite1.wav",
	"scp/939/bite3.wav"
}

function SWEP:PrimaryAttack()
	local owner = self.Owner
	self:SetNextPrimaryAttack(CurTime())
    self:SetNextPrimaryFire(CurTime() + 0.45)
    owner:EmitSound(sounds[math.random(#sounds)])
    owner:SetViewPunchAngles(Angle(2, 0, 0))
    owner:SetAnimation(PLAYER_ATTACK1)
end

function SWEP:DealDamage()
	local owner = self:GetOwner()
	local tr = self:PlayerTrace(owner, true)
	local ent = tr.Entity

	if !IsValid(ent) then return end
	if !ent:IsPlayer() or !ent:IsBot() then
        if ent:GetClass() == "prop_dynamic" and ent:GetParent() and IsValid(ent:GetParent()) and ent:GetParent():GetClass() == "func_door" then
            ent = ent:GetParent()
        end
        ent:keysUnLock()
        ent:Fire("open", "", .6)
        ent:Fire("setanimation", "open", .6)
        
        hook.Run("onDoorRamUsed", true, ply, trace)
        ply:EmitSound("ambient/materials/metal_stress"..math.random(1,5)..".wav")
	end

	if ent:IsPlayer() then
	    ent:EmitSound("physics/flesh/flesh_bloody_break.wav")
		self:DamagePlayer(owner, tr, ent)
	end

	local phys = ent:GetPhysicsObject()
	if IsValid(phys) then
		phys:ApplyForceOffset(owner:GetAimVector() * 200 * phys:GetMass(), tr.HitPos)
	end
end

function SWEP:Think()
    local meleetime = self:GetNextPrimaryAttack()

    if meleetime > 0 and CurTime() > meleetime then
    	self:DealDamage()
        self:SetNextPrimaryAttack(0)
    end

end