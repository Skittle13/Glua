--[[
    An die Developer bitte bearbeitet diese Datei nur mit Erlaubnis.
    MfG Austria7
]]--
util.AddNetworkString("Medic.UpdateBodyState")
util.AddNetworkString("Bodystate.Reboot")
util.AddNetworkString("MedicSys_Respawn")

net.Receive("MedicSys_Respawn", function(_, ply)
    if !ply:IsKnocked() then return end

    local rag = ply:GetNW2Entity("RagdollEntity")
    if !IsValid(rag) then return end
    
    local real_ent = rag.DeathRagdoll
    if (real_ent:GetWakeUp() != 0 and real_ent:GetRespawn() < CurTime()) then
        if hook.Run("MedicSys_CanRespawn", real_ent) == false then return end
        hook.Run("PlayerDeathFinal", ply)
        real_ent:Remove()
    end
end)

local pmeta = FindMetaTable("Player")
function pmeta:Kill()
    local dmginfo = DamageInfo()
    dmginfo:SetDamage(0)
    self:TurnIntoRagdoll(true, self:GetVelocity(), dmginfo)
end

local sounds = {{},{}}
for i,gender in pairs({"male01", "female01"}) do
    for k = 1, 2 do
        table.insert(sounds[i], "vo/npc/"..gender.."/ow0" .. k .. ".wav")
    end
    for k = 1, 9 do
        table.insert(sounds[i], "vo/npc/"..gender.."/pain0" .. k .. ".wav")
    end
end

local helpSounds = {{},{}}

for i,gender in pairs({"male01", "female01"}) do
    table.insert(helpSounds[i], "vo/npc/"..gender.."/uhoh.wav")
    table.insert(helpSounds[i], "vo/npc/"..gender.."/ohno.wav")
    table.insert(helpSounds[i], "vo/npc/"..gender.."/help01.wav")
    table.insert(helpSounds[i], "vo/npc/"..gender.."/overhere01.wav")
    for k = 1, 2 do
        table.insert(helpSounds[i], "vo/npc/"..gender.."/no0" .. k .. ".wav")
        table.insert(helpSounds[i], "vo/npc/"..gender.."/upthere0" .. k .. ".wav")
        table.insert(helpSounds[i], "vo/npc/"..gender.."/startle0" .. k .. ".wav")
    end
end

hook.Add("PlayerSpawnObject", "MedicSys_DisableSpawn", function(ply)
    local can = ply:GetNW2Bool("IsRagdoll", false)
    if (can) then
        return false
    end
end)

hook.Add("CanPickupWeapon", "MedicSys_DisablePickup", function(ply)
    local can = ply:IsKnocked()
    if (can) then
        return false
    end
end)

hook.Add("PlayerCanPickupWeapon", "MedicSys_DisablePickup", function(ply)
    local can = ply:IsKnocked()
    if (can) then
        return false
    end
end)

local maxDist = 150 ^ 2
hook.Add("KeyPress", "MedicSys_KeyPress", function(ply, key)
    if ply:Alive() and !ply:IsKnocked() and key == IN_RELOAD then
        local target = ply:GetEyeTrace().Entity
        if IsValid(target) and target:GetNW2Bool("IsRagdoll",false) and ply:GetPos():DistToSqr(target:GetPos()) < maxDist then
            if !target.DeathRagdoll then return end
            if target.DeathRagdoll:GetIsDead() then return end
            if !target:GetNW2Bool("Stabilized") then
                hook.Call("MedicSys_Stabilized", nil, ply, target.PlayerOwn)
                target:SetNW2Bool("Stabilized", true)
                target.DeathRagdoll:SetWakeUp(CurTime() + (60*3))
                target:EmitSound("npc/barnacle/barnacle_bark1.wav")
            end
        end
    end
end)

local NG_MedicSys_HitBones = {
    ["ValveBiped.Bip01_Head"] = HITGROUP_HEAD, --Head
    ["ValveBiped.Bip01_Head1"] = HITGROUP_HEAD, --Head
    ["ValveBiped.Bip01_Neck1"] = HITGROUP_HEAD, --Head
    ["ValveBiped.Bip01_Spine1"] = HITGROUP_CHEST, --Chest
    ["ValveBiped.Bip01_Spine2"] = HITGROUP_CHEST, --Chest
    ["ValveBiped.Bip01_Spine3"] = HITGROUP_CHEST, --Chest
    ["ValveBiped.Bip01_Spine4"] = HITGROUP_CHEST, --Chest
    ["ValveBiped.Bip01_L_UpperArm"] = HITGROUP_LEFTARM, --Arms
    ["ValveBiped.Bip01_L_Forearm"] = HITGROUP_LEFTARM, --Arms
    ["ValveBiped.Bip01_L_Hand"] = HITGROUP_LEFTARM, --Arms
    ["ValveBiped.Bip01_R_UpperArm"] = HITGROUP_RIGHTARM, --Arms
    ["ValveBiped.Bip01_R_Forearm"] = HITGROUP_RIGHTARM, --Arms
    ["ValveBiped.Bip01_R_Hand"] = HITGROUP_RIGHTARM, --Arms
    ["ValveBiped.Bip01_L_Thigh"] = HITGROUP_LEFTLEG, --Legs
    ["ValveBiped.Bip01_L_Calf"] = HITGROUP_LEFTLEG, --Legs
    ["ValveBiped.Bip01_L_Foot"] = HITGROUP_LEFTLEG, --Legs
    ["ValveBiped.Bip01_R_Thigh"] = HITGROUP_RIGHTLEG, --Legs
    ["ValveBiped.Bip01_R_Calf"] = HITGROUP_RIGHTLEG, --Legs
    ["ValveBiped.Bip01_R_Foot"] = HITGROUP_RIGHTLEG, --Legs
}

local NG_MedicSys_DamageScale = {
    [HITGROUP_GENERIC] = 0.8,
    [HITGROUP_HEAD] = 1,
    [HITGROUP_CHEST] = 0.9,
    [HITGROUP_LEFTARM] = 0.5,
    [HITGROUP_RIGHTARM] = 0.5,
    [HITGROUP_LEFTLEG] = 0.5,
    [HITGROUP_RIGHTLEG] = 0.5
}

local reg = debug.getregistry()
local DistToSqr = reg.Vector.DistToSqr
local LookupBone = reg.Entity.LookupBone
local GetBonePosition = reg.Entity.GetBonePosition

function MedicSys_GetHitGroup(ply, dmginfo)
    local HitPos = dmginfo:GetDamagePosition()
    local accurateHit = HITGROUP_CHEST
    local accurateHitPoint = math.huge

    for bone, hitgroup in pairs(NG_MedicSys_HitBones) do
        local lookupBone = LookupBone(ply, bone)
        if not lookupBone then continue end

        local BonePos = GetBonePosition(ply, lookupBone)
        local hitDiff = DistToSqr(HitPos, BonePos)

        if hitDiff < accurateHitPoint then
            accurateHitPoint = hitDiff
            accurateHit = hitgroup
        end
    end

    return accurateHit
end

local function ResolveDamage(ent, veh, dmg)
   
    local speed = veh:GetVelocity():Length()

    if (speed < 150) then return end

    if (speed < 275) then 
        ent:SetHealth(ent:Health() * 0.75)
        ent:TurnIntoRagdoll(false, veh:GetVelocity())
        return true
    end
    if (speed < 400) then 
        ent:SetHealth(ent:Health() * 0.25)
        ent:TurnIntoRagdoll(false, veh:GetVelocity())
        return true
    end

    if !dmg then
        dmg = DamageInfo()
        dmg:SetAttacker(veh)
        dmg:SetDamage(9999)
    end

    ent:TurnIntoRagdoll(true, veh:GetVelocity(), dmg)

end

hook.Add( "PlayerCanHearPlayersVoice", "MedicSys_DisallowSpeak", function( lisener, talker )
    if(talker:IsKnocked() or lisener:IsKnocked()) then return false end
end )

local function DamagePlayer(ply, dmginfo)
    if ply:HasGodMode() then return end
    ply.MedicSys_DamageInfo = dmginfo

    local damage = dmginfo:GetDamage()
    local hitgroup = MedicSys_GetHitGroup(ply, dmginfo)

    if dmginfo:IsBulletDamage() or dmginfo:IsExplosionDamage() then
        dmginfo:ScaleDamage(NG_MedicSys_DamageScale[hitgroup] or 0.8)
    end

    if math.random(0, 100) <= 40 and MedConfig.WoundsEnabled and !ply:getJobTable().notBleeding then
        local addbleeding = hook.Run("MedicSys_AddBleeding", ply, dmginfo)
        if addbleeding == nil or addbleeding == true then
            ply:AddBleeding(dmginfo:GetDamage() * MedConfig.BleedingExtra)
            ply.BleedingOwner = dmginfo:GetAttacker() or ply
        
            local bodystate = ply:GetBodyState()
            if dmginfo:IsFallDamage() then
                bodystate.legs = math.max(bodystate.legs - damage, 0)
            else
                if hitgroup == HITGROUP_HEAD then
                    bodystate.head = math.max(bodystate.head - damage, 0)
                elseif hitgroup == HITGROUP_CHEST then
                    bodystate.chest = math.max(bodystate.chest - damage, 0)
                elseif hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM then
                    bodystate.arms = math.max(bodystate.arms - damage, 0)
                elseif hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG then
                    bodystate.legs = math.max(bodystate.legs - damage, 0)
                end
            end

            net.Start("Medic.UpdateBodyState")
                net.WriteInt(hitgroup, 4)
                net.WriteFloat(dmginfo:GetDamage())
            net.Send(ply)
        end
    end

    local attacker = dmginfo:GetAttacker()
    if IsValid(attacker) and attacker:IsVehicle() then
        ResolveDamage(ent, attacker, dmginfo)
    end
end

local function DamageRagdoll(ent, dmginfo)
    local attacker = dmginfo:GetAttacker()
    local damage = dmginfo:GetDamage()

    local death_body = ent.DeathRagdoll
    local dt = death_body.dt

    local ent_tb = ent:GetTable()

    if dmginfo:IsBulletDamage() or (IsValid(attacker) and attacker:IsPlayer()) then
        ent_tb._Health = (ent_tb._Health or MedConfig.RagdollHealth) - damage
        if ent_tb._Health <= 0 and !dt.IsDead then
            hook.Call("MedicSys_RagdollFinish", nil, ent_tb.PlayerOwn, dmginfo)
            dt.IsDead = true
        end
    else
        ent_tb._Health2 = (ent_tb._Health2 or 100000) - damage
        if ent_tb._Health2 <= 0 and !dt.IsDead then
            hook.Call("MedicSys_RagdollFinish", nil, ent_tb.PlayerOwn, dmginfo)
            dt.IsDead = true
        end
    end

    if ent_tb._Health <= -10000 or ent_tb._Health2 <= -10000 then
        ent:EmitSound("physics/flesh/flesh_bloody_break.wav")
        local ed = EffectData()
        ed:SetOrigin(ent:GetPos())
        util.Effect("deathbody_effect", ed, true, true)
        death_body:Remove()
    end
end

hook.Add("EntityTakeDamage", "MedicSys_HandleDamage", function(ent, dmginfo)
    if ent:IsPlayer() then
        DamagePlayer(ent, dmginfo)
    else
        if ent.DeathRagdoll and MedConfig.RagdollDamage then
            DamageRagdoll(ent, dmginfo)
        end
    end
end)

hook.Add("PlayerHurt", "MedicSys_OverrideDeath", function(ply, attacker, health_remaining)
    if health_remaining <= 0.5 then
        local dmginfo = ply.MedicSys_DamageInfo or DamageInfo()
        if dmginfo:GetDamageType() == DMG_DISSOLVE then return end

        ply:SetHealth(1)
        local velocity = hook.Run("MedicSys_DeathVelocity", ply, dmginfo)
        local vector = Vector(0,0,0)
        if velocity then
            vector = velocity
        end
        ply:TurnIntoRagdoll(true, vector, dmginfo)

        ply.MedicSys_DamageInfo = nil
    end
end)

hook.Add("PlayerSpawn", "MedicSys_PlayerSpawn", function(ply)
    ply:SetNW2Bool("IsRagdoll", false)
    ply:SetBleeding(0)
    ply.Gender = nil
    ply.Finishing = false
    ply._IsDead = false
    ply:SetupBodyState()
    
    local death_body = ply.DeathBody
    if death_body and IsValid(death_body) then
        death_body:Remove()
    end

    net.Start("Ragdoll.RemoveSound")
    net.Send(ply)

    timer.Simple(5, function()
        if not IsValid(ply) then return end
        local has, _ = string.find( ply:GetModel(), "female" )
        ply.Gender = (has != nil or MedConfig.ExtraFemales[ply:GetModel()]) and 2 or 1
    end)
end)

    hook.Add( "PlayerDisconnected", "MedicSys_DisconnectRagdoll", function(ply)
        ply:SetNW2Bool("IsRagdoll", false)
        for k,v in pairs(ents.FindByClass("sent_death_ragdoll")) do
            if v:GetOwner() == ply then
                v.NoLoop = true
                v.Ragdoll:Remove()
                v:Remove()
            end
        end
    end)

hook.Add("PlayerDeath", "MedicSys_RemoveRagdoll", function(ply)
    if (MedConfig.EnableRagdoll) then
        ply:SetNW2Bool("IsRagdoll", false)
        for k,v in pairs(ents.FindByClass("sent_death_ragdoll")) do
            if v:GetOwner() == ply and !v.DONTREMOVE then
                v.NoLoop = true
                v:Remove()
            end
        end
    elseif (MedConfig.EnableDeathScreen) then
        ply._wakeIn = CurTime() + MedConfig.DeathCountdown
        ply:SetKnocked(true)
        ply:SetNW2Entity("RagdollEntity", ply:GetRagdollEntity())

        net.Start("Unconscious.SendInfo")
        net.WriteBool(true)
        net.WriteFloat(ply._wakeIn)
        net.Send(ply)
    end
end)

hook.Add("PlayerDeathThink", "MedicSys_AllowSpawn", function(ply)
    if (!MedConfig.EnableRagdoll and MedConfig.EnableDeathScreen) then
        if !ply:IsKnocked() then
            ply._wakeIn = CurTime() + MedConfig.DeathCountdown
            ply:SetKnocked(true)
            ply:SetNW2Entity("RagdollEntity", ply:GetRagdollEntity())
        end

        if (ply:IsKnocked()) then
            return ply._wakeIn < CurTime()
        end
    end
end)

hook.Add("PlayerDeathSound", "MedicSys_RemoveDeathSound", function()
    return true
end)

local function SetSubPhysMotionEnabled(ent, enable)
   if not IsValid(ent) then return end

   for i=0, ent:GetPhysicsObjectCount()-1 do
      local subphys = ent:GetPhysicsObjectNum(i)
      if IsValid(subphys) then
         subphys:EnableMotion(enable)
         if enable then
            subphys:Wake()
         end
      end
   end
end

hook.Add("CanPlayerSuicide", "MedicSys_DisallowSuicide", function(ply)
    if MedConfig.DisallowSuicide then
        return false
    end
end)

hook.Add("PlayerShouldTakeDamage", "MedicSys_VehicleDamage", function(ent, dmg)
    if (dmg:IsVehicle()) then
        ResolveDamage(ent, dmg)
        return false
    end
end)

