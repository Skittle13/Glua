AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

util.AddNetworkString("TeleportToPocketDimension")
util.AddNetworkString("TeleportToPortals")

local function DoEffect(ply)
    local effect = EffectData()
    effect:SetOrigin(ply:LocalToWorld(ply:OBBCenter()))
    effect:SetEntity(ply)

    util.Effect("scp106_effect", effect, true, true)
end 

local tcooldown = SWEP.TPC

net.Receive("TeleportToPortals", function(len, ply)
    if ply:Team() != TEAM_106 then return end
    if CurTime() - (ply.SCP106_LastTeleport or 0) < tcooldown then
        DarkRP.notify(ply, NOTIFY_ERROR, 8, "Du kannst dich erst wieder in " .. math.Round(tcooldown - (CurTime() - ply.SCP106_LastTeleport)) .. " Sekunden teleportieren.")
        return
    end

    ply.SCP106LastPos = nil
    ply.SCP106_LastTeleport = CurTime()

    local portal = net.ReadEntity()
    if IsValid(portal) and portal:GetClass() == "scp106_portal" then
        DoEffect(ply)
        ply:EmitSound("ambient/levels/canals/toxic_slime_sizzle4.wav", 70)

        ply:SetPos(portal:GetPos())

        DoEffect(ply)
        ply:EmitSound("ambient/levels/canals/toxic_slime_sizzle4.wav", 70)
    end
end)

net.Receive("TeleportToPocketDimension", function(len, ply)
    if not (ply:GetActiveWeapon():GetClass() == "swep_106") then return end
    local owner = ply:GetActiveWeapon():GetOwner()
    if CurTime() - (ply.SCP106_LastTeleport or 0) < tcooldown then
        DarkRP.notify(ply, NOTIFY_ERROR, 8, "Du kannst dich erst wieder in " .. math.Round(tcooldown - (CurTime() - ply.SCP106_LastTeleport)) .. " Sekunden teleportieren.")
        return
    end

    local is_exit = net.ReadBool()
    if is_exit then 
        if not ply.SCP106LastPos then return end
        DoEffect(ply)
        SendPlayerToPocketDimension(owner, ply.SCP106LastPos) 
        ply.SCP106LastPos = nil
    else
        if ply.SCP106LastPos then return end
        DoEffect(ply)
        ply.SCP106LastPos = ply:GetPos()
        SendPlayerToPocketDimension(owner)
    end

    ply.SCP106_LastTeleport = CurTime()
    DoEffect(owner)
end)

local portals = {}

function SWEP:Deploy()
    self.Owner:SetCustomCollisionCheck(true)
    return true  
end 

function SWEP:OnRemove()
    for portal in pairs(portals) do 
        portals[portal] = nil
        SafeRemoveEntity(portal)
    end 

    self.Owner:SetCustomCollisionCheck(false)
end 


function SWEP:PlayerTrace(owner, cl)
    if cl then 
        owner:LagCompensation(true)
    end 

    local tr = LPlayerTrace({
        start = owner:GetShootPos(),
        endpos = owner:GetShootPos() + owner:GetAimVector() * 58,
        filter = owner,
    })

    if cl then 
        owner:LagCompensation(false)
    end

    return tr
end 

function SWEP:PrimaryAttack()
    local owner = self.Owner
    local tb = self:GetTable()
    local dt = tb.dt 

    self:SetNextPrimaryFire(CurTime() + 0.8)
    dt.TimeForAnimation =  CurTime() + 0.7
    local tr = self:PlayerTrace(owner, true)
    local ent = tr.Entity

    if IsValid(ent) then 
        if !ent:IsPlayer() then 
            if ent:GetClass() == "scp106_portal" then 
                self:SetNextPrimaryFire(CurTime() + tb.TC / 2)
                dt.NextAttack = CurTime() + tb.TC / 2
                SafeRemoveEntity(ent)
                return
            end 
        else 
            self:SetNextPrimaryFire(CurTime() + tb.TC)
            dt.NextAttack = CurTime() + tb.TC
            owner:EmitSound("scp/106/Laugh.ogg", 70)
            SendPlayerToPocketDimension(ent)
        end
    end 
end 

local pdelay = SWEP.PC 
local plimit = SWEP.PLMT 

function SWEP:SecondaryAttack()
    local owner = self.Owner
    local dt = self.dt 

    if CurTime() < dt.PortalTimeForNextPortal then return end

    dt.TimeForAnimation = CurTime() + 0.7
    dt.PortalTimeForNextPortal = CurTime() + pdelay
    self:SetNextSecondaryFire(CurTime() + 1)

    for portal in pairs(portals) do
        if not IsValid(portal) then 
            portals[portal] = nil
        end 
    end
    
    if table.Count(portals) >= plimit then
        DarkRP.notify(owner, NOTIFY_ERROR, 10, "Du hast deine Maximalanzahl von " .. plimit .. " Portale erreicht.")
        return
    end

    owner:EmitSound("scp/106/Laugh.ogg", 70)
    owner:EmitSound("ambient/levels/canals/toxic_slime_sizzle4.wav", 70)

    local portal = ents.Create("scp106_portal")
    portal.Creator = owner
    portal:SetPos(owner:GetShootPos())
    portal:Spawn()

    portals[portal] = true

    portal:SetGravity(0)

    local phys = portal:GetPhysicsObject()
    if IsValid(phys) then
        phys:ApplyForceOffset(owner:GetAimVector() * 500 * phys:GetMass(), owner:GetEyeTrace().HitPos)
    end
end 

local DimensionPos106 = DimensionPos106 or {}

concommand.Add( "106_dimension", function( ply )
    if not ply:IsValid() or not ply:IsSuperAdmin() then return end
    DimensionPos106[game.GetMap()] = ply:GetPos()

    if not file.Exists("scp106", "DATA") then file.CreateDir("scp106") end
    file.Write("scp106/scp_106_dimension.txt", util.TableToJSON(DimensionPos106))

    ply:PrintMessage( HUD_PRINTCONSOLE, "Dimension Pos has been saved" )
end )

function SendPlayerToPocketDimension(target, pos)
    if not IsValid(target) then return end
    if not target:Alive() then return end

    target:EmitSound("ambient/levels/canals/toxic_slime_sizzle4.wav", 70)
    DoEffect(target)
    target:EmitSound("scp/106/Corrosion"..math.random(1, 2)..".ogg", 70)

    if not IsValid(target) then return end 
    if not target:Alive() then return end

    target:SetPos(pos or DimensionPos106[game.GetMap()] or Vector(0, 0, 0))
    target:SetEyeAngles(Angle(90, math.random(0, 360), 0))
    target:EmitSound("scp/106/SinkholeFall.ogg")
    DoEffect(target)
end 

hook.Add("SCP-106.FemurActivated", "NG_106_FemurTP", function()
    for k, v in ipairs(team.GetPlayers(TEAM_106)) do
        if v.FemurProgress then return end
        v.FemurProgress = true

        timer.Simple(math.random(10, 20), function()
            for portal in pairs(portals) do
                portals[portal] = nil
                SafeRemoveEntity(portal)
            end

            if !IsValid(v) then return end
            v.FemurProgress = false
        end)
    end
end)

hook.Add("PlayerInitialSpawn", "SCP106_Loading", function()
    if file.Exists("scp106", "DATA") then 
        if file.Exists("scp106/PocketDimensionPos.txt", "DATA") then 
            DimensionPos106 = util.JSONToTable(file.Read("scp106/PocketDimensionPos.txt", "DATA"))
        end 
    end 
end)

hook.Add("PlayerShouldTakeDamage", "SCP106_DamageCheck", function(ply, attacker)
    if ply:Team() == TEAM_106 then 
        if IsValid(attacker) and attacker:GetClass() == "trigger_hurt" then return end
        return false
    end
end)