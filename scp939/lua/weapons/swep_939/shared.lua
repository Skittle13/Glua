
SWEP.PrintName = "SCP-939"
SWEP.Author = "Skittle"
SWEP.Category = "SCP:RP | SWEPs"
SWEP.Instructions = "LMB: um alles zu töten was in deinen Weg kommt!"
SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.HoldType = "normal"
SWEP.WorldModel = ""
SWEP.ViewModel = ""
SWEP.DrawCrosshair = false

SWEP.DMG = 45
SWEP.HD = 85
SWEP.HR= 500

function SWEP:Initialize()
    self:SetHoldType("normal")

    if SERVER then 
        hook.Add("EntityEmitSound", self, self.EntityEmitSound)
    end 

    if (self.Owner == LocalPlayer()) then
		hook.Add("RenderScreenspaceEffects", self, self.RenderScreenspaceEffects)
		hook.Add("PreDrawHalos", self, self.PreDrawHalos)
	end

    self.BaseClass.Initialize(self)
end 

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextPrimaryAttack")
end


function SWEP:Holster()
    self:SetNextPrimaryAttack(0)
    return true
end 

function SWEP:PrimaryAttack()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
end 

function SWEP:SecondaryAttack()
end 

local SCPAnim = {}
SCPAnim[ ACT_MP_JUMP ] = ACT_HL2MP_JUMP_MELEE
SCPAnim[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] = ACT_GMOD_GESTURE_RANGE_ZOMBIE
SCPAnim[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] = ACT_GMOD_GESTURE_RANGE_ZOMBIE
SCPAnim[ ACT_RANGE_ATTACK1 ] = ACT_GMOD_GESTURE_RANGE_ZOMBIE

function SWEP:TranslateActivity(act)
    if SCPAnim[act] != nil then
        return SCPAnim[act]
    end

    return -1
end

function TraceAttack(tbl)
    local tr = util.TraceLine({
        start = tbl.start,
        endpos = tbl.endpos,
        filter = tbl.filter,
        mask = MASK_SHOT_HULL
    })

    if !IsValid(tr.Entity) then
        tr = util.TraceHull({
            start = tbl.start,
            endpos = tbl.endpos,
            filter = tbl.filter,
            mins = tbl.mins or Vector(-10, -10, -8),
            maxs = tbl.maxs or Vector(10, 10, 8),
            mask = MASK_SHOT_HULL
        })
    end

    return tr
end
