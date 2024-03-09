AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
local reg = debug.getregistry()
local GetTable = reg.Entity.GetTable

function SWEP:GetActive()
    local tb = GetTable(self)
    local dt = tb.dt
    if not dt then return false end

    return dt.Active
end

function SWEP:Damage(owner, ent)
    local damageAmount = self.Primary.Damage
    local damageInfo = DamageInfo()
    damageInfo:SetAttacker(owner)
    damageInfo:SetDamage(damageAmount)
    damageInfo:SetDamageType(DMG_SLASH)
    damageInfo:SetInflictor(self)
    ent:TakeDamageInfo(damageInfo)
end