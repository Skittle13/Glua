local playerMeta = FindMetaTable("Player")
local WalkSpeed = 160
local RunSpeed = 240

function playerMeta:ApplySpeed(amount, bool)
    if bool then
        self:SetWalkSpeed(WalkSpeed * tonumber(amount))
        self:SetRunSpeed(RunSpeed * tonumber(amount))
    else
        self:SetWalkSpeed(WalkSpeed)
        self:SetRunSpeed(RunSpeed)
    end
end

function playerMeta:SCP096ApplySpawnSpeed()
    self:SetWalkSpeed(WalkSpeed * 0.5)
    self:SetRunSpeed(RunSpeed * 0.5)
end