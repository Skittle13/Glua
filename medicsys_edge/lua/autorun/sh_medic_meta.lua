
local p = FindMetaTable("Player")

if SERVER then
    util.AddNetworkString("Notification.Send")
end

if !DarkRP then

DarkRP = {}

function DarkRP.notify(players, type, seconds, text)
    if SERVER then
        net.Start("Notification.Send")
        net.WriteInt(type, 4)
        net.WriteInt(seconds, 8)
        net.WriteString(text)
        net.Send(players)
    else
        notification.AddLegacy(text, type, seconds)
    end
end

net.Receive("Notification.Send", function()
    local type = net.ReadInt(4)
    local secs = net.ReadInt(8)
    local text = net.ReadString()
    DarkRP.notify(LocalPlayer(), type, secs, text)
end)

end

function p:IsKnocked()
    return self:SetNW2Bool("IsRagdoll", false)
end

function p:SetKnocked(b)
    self:SetNW2Bool("IsRagdoll", b)
end

function p:IsBleeding()
    return self:GetBleeding() > 0
end

function p:GetBleeding()
    return self:GetNW2Int("Bleeding", 0)
end

function p:AddBleeding(f)
    self:SetNW2Int("Bleeding", math.Clamp(self:GetBleeding() + f, 0, MedConfig.MaxBleeding))
end

function p:SetBleeding(f)
    self:SetNW2Int("Bleeding", f)
end

function p:GetBodyState()
    return self._bodyState or {
        head = 100,
        arms = 100,
        chest = 100,
        legs = 100
    }
end

function p:SetupBodyState()
    self._bodyState = {
        head = 100,
        arms = 100,
        chest = 100,
        legs = 100
    }
    if SERVER then
        net.Start("Bodystate.Reboot")
        net.Send(self)
    end
end

net.Receive("Bodystate.Reboot", function()
    if IsValid(LocalPlayer()) then
        LocalPlayer():SetupBodyState()
    end
end)
hook.Add("EntityFireBullets", "BodyState.Aim", function(ent, data)
    if (!ent:IsPlayer()) then return end
    if (!MedConfig.WoundsEnabled) then return end
    if !IsFirstTimePredicted() then return end
    local power = 1 - (ent:GetBodyState().arms / 100)
    local randomSeedX = util.SharedRandom("BulletRandomX", power, power, CurTime()) * MedConfig.AimMagnitude
    local randomSeedY = util.SharedRandom("BulletRandomY", power, power, CurTime()) * MedConfig.AimMagnitude
    data.Spread = Vector(randomSeedX, randomSeedY, 0) / 4
    return true
end)

hook.Add("Move","BodyState.Movement", function(ply, mv)
    if (!MedConfig.WoundsEnabled) then return end
    local bodystate = ply:GetBodyState()
    local magnitude = MedConfig.LegsMagnitude
    if bodystate.legs < 100 and !ply:InVehicle() and ply:IsOnGround() then
        local percent = (1 - magnitude) + (bodystate.legs / 100) * magnitude
        mv:SetMaxSpeed(mv:GetMaxSpeed() * math.max(0.2, percent))
        mv:SetMaxClientSpeed(mv:GetMaxSpeed() * math.max(0.2, percent))
    end
end)
