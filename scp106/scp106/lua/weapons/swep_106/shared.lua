AddCSLuaFile()

SWEP.PrintName = "SCP-106"
SWEP.Category = "SCP:RP | SWEPs"

SWEP.Instructions = "LMB: Befördere den Spiele in die Pocket Dimension\nRMB: Erstelle Portale\n Reload: Öffne Menü"
SWEP.Author = "Skittle"

SWEP.Slot = 2
SWEP.SlotPos = 0 

SWEP.HoldType = "normal"
SWEP.Spawnable = true
SWEP.WorldModel = ""
SWEP.ViewModel = ""

SWEP.TC = 6
SWEP.PC = 8
SWEP.PLMT = 7
SWEP.TPC = 10

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "TimeForAnimation")
    self:NetworkVar("Float", 1, "PortalTimeForNextPortal")
    self:NetworkVar("Float", 2, "NextAttack")
end 

local time = CurTime()

function SWEP:Think()
    if time < self:GetTimeForAnimation() then 
        self:SetHoldType("Pistol")
    else 
        self:SetHoldType("normal")
    end
end 

local SCPAnim = {}
SCPAnim[ACT_MP_RUN] = {
    attack = ACT_HL2MP_WALK_PISTOL,
    idle = ACT_HL2MP_WALK
}

function SWEP:TranslateActivity(act)
    if SCPAnim[act] then
        if CurTime() < self:GetNextAttack() then
            return SCPAnim[act].attack
        else
            return SCPAnim[act].idle
        end
    end

    return self.BaseClass.TranslateActivity(self, act)
end 

function LPlayerTrace(tbl)
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

hook.Add("PlayerFootstep", "SCP106Footsteps", function(ply, pos)
    if !TEAM_106 then return end 
         
    if ply:Team() == TEAM_106 then 
        
        local foot = util.TraceLine({start=pos, endpos=(pos + Vector(0, 0, -128)), mask=MASK_SOLID, filter = ply})

        util.Decal("Dark", foot.HitPos + foot.HitNormal, foot.HitPos - foot.HitNormal, {ply})
    end
end)
