SWEP.PrintName = "SCP-096"
SWEP.ViewModelFOV = 56
SWEP.ViewModel = Model("models/weapons/v_arms_scp096.mdl")
SWEP.WorldModel = "models/gibs/hgibs.mdl"
SWEP.DrawWeaponInfoBox = true
SWEP.Instructions = "Left click to Attack."
SWEP.Author = "Leonheart"
SWEP.Spawnable = true
SWEP.Primary.Damage = 80
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Delay = 0.6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Automatic = false
SWEP.Secondary.Delay = 2
SWEP.Slot = 0
SWEP.SlotPos = 40
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.SCP096 = true
SWEP.SpeedMultAdd = 1.9
local reg = debug.getregistry()
local GetTable = reg.Entity.GetTable

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "Active")
    self:NetworkVar("Float", 0, "BecomeAggressive")
end

function SWEP:Initialize()
    self:SetDeploySpeed(1)
    self:SetHoldType("melee")
    self:DrawShadow(false)
end

function SWEP:Deploy()
    return true
end

function SWEP:Holster(wep)
    if not wep:IsValid() then return true end

    return false
end

function SWEP:StartSounds(typ)
    self:StopSounds()
    local t = typ == 3 and "scp_096_freak" or typ == 2 and "scp_096_scream" or typ == 1 and "scp_096_cry" or "scp_096_cry"
    local ply = self:GetOwner()
    ply.SCP096_Sound = t
    ply:EmitSound(t, 70)
    ply.Type = typ or 1
end

function SWEP:DebugSounds(typ, ply)
    ply = ply or self:GetOwner()

    if not ply.SCP096_Sound or ply.Type ~= typ then
        self:StartSounds(typ or self.Type or 1)
    end
end

function SWEP:StopSounds()
    local ply = self:GetOwner()

    if ply.SCP096_Sound then
        ply:StopSound(ply.SCP096_Sound)
    end
end

function SWEP:OnRemove()
    local ply = self:GetOwner()

    if ply.SCP096_Sound then
        ply:StopSound(ply.SCP096_Sound)
    end
end

function SWEP:Think()
    local tb = GetTable(self)
    local dt = tb.dt
    if not dt then return end
    local ply = self:GetOwner()
    if ply == NULL then return end

    if SERVER then
        if dt.Active then
            self:DebugSounds(2, ply)
        elseif dt.BecomeAggressive > 0 then
            self:DebugSounds(3, ply)
        else
            self:DebugSounds(1, ply)
        end
    end

    local become_agg = dt.BecomeAggressive

    if become_agg > 0 and CurTime() > become_agg then
        dt.BecomeAggressive = 0
        dt.Active = true

        if SERVER then
            ply:ApplySpeed(tostring(self.SpeedMultAdd), true)
            net.Start("SCP096_DrawRedScreen")
            net.WriteBool(true)
            net.Send(ply)
        end
    end
end

function SWEP:PrimaryAttack()
    if not IsValid(self:GetOwner()) or not self:GetActive() then return end
    self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:EmitSound("mg_scprp/scp096/attack" .. math.random(1, 3) .. ".wav")
    local vm = self:GetOwner():GetViewModel()

    if IsValid(vm) then
        vm:SetPlaybackRate(1.5)
    end

    self:DetectEntity(self:GetOwner())
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
    self:GetOwner():ViewPunch(Angle(-5, 5, 0))
end

function SWEP:DetectEntity(ply)
    local startPos = ply:GetShootPos()
    local endPos = startPos + ply:GetAimVector() * 100

    local traceResult = util.TraceLine({
        start = startPos,
        endpos = endPos,
        filter = function(ent)
            return ent ~= ply and ent:IsWorld() == false
        end
    })

    if traceResult.Hit then
        util.Decal("Blood", ply:GetShootPos() - ply:GetAimVector(), ply:GetShootPos() + ply:EyeAngles():Forward() * 100 + ply:GetAimVector(), ply)

        if SERVER then
            self:Damage(ply, traceResult.Entity)
        end
    else
        return nil
    end
end

if CLIENT then
    SWEP.MoveToPos = Vector(0, 0, 5)
    SWEP.LastMultiX = 0
    SWEP.LastSysTime = 0

    function SWEP:GetViewModelPosition(pos, ang)
        pos = pos - ang:Up() * 6
        local sys_time = SysTime()
        local multx
        local active = self:GetActive()

        if active then
            multx = (self.LastMultiX == 1 and 1) or Lerp((sys_time - self.LastSysTime) * 15, self.LastMultiX, 1)
        else
            multx = (self.LastMultiX == 0 and 0) or Lerp((sys_time - self.LastSysTime) * 15, self.LastMultiX, 0)
        end

        self.LastSysTime = sys_time

        if self.MoveToPos then
            local Offset = self.MoveToPos
            pos = pos + Offset.x * ang:Right() * multx
            pos = pos + Offset.y * ang:Forward() * multx
            pos = pos + Offset.z * ang:Up() * multx
            self.LastMultiX = multx
        end

        return pos, ang
    end
end

local SCPActivity = {}
SCPActivity[1] = {} -- Angry
SCPActivity[1][ACT_MP_WALK] = ACT_HL2MP_RUN
SCPActivity[1][ACT_MP_RUN] = ACT_HL2MP_RUN
SCPActivity[1][ACT_MP_STAND_IDLE] = ACT_IDLE_ANGRY
SCPActivity[1][ACT_MP_JUMP] = ACT_HL2MP_JUMP
SCPActivity[1][ACT_MP_ATTACK_STAND_PRIMARYFIRE] = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE
SCPActivity[2] = {} -- Getting angry
SCPActivity[2][ACT_MP_STAND_IDLE] = ACT_IDLE_AGITATED
SCPActivity[3] = {} -- Normal
SCPActivity[3][ACT_MP_RUN] = ACT_HL2MP_WALK
SCPActivity[3][ACT_MP_JUMP] = ACT_HL2MP_IDLE

function SWEP:TranslateActivity(act)
    local tb = GetTable(self)
    local dt = tb.dt

    if SCPActivity[1][act] and self:GetActive() then
        return SCPActivity[1][act]
    elseif SCPActivity[2][act] and dt.BecomeAggressive > 0 then
        return SCPActivity[2][act]
    elseif SCPActivity[3][act] then
        return SCPActivity[3][act]
    else
        return -1
    end
end