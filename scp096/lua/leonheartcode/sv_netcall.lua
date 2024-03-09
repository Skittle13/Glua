local function PlayerIsLookingAtHead(ply, target)
    if not target:IsValid() then return end
    if not target:GetActiveWeapon():IsValid() then return end
    local weapon = target:GetActiveWeapon()
    if not weapon:IsValid() then return end

    if not target:GetNWBool("freaking_out", false) then
        if weapon:GetClass() == "weapon_scp096" then
            target:SetNWBool("freaking_out", true)
            target:EmitSound("scp096/freak.wav")
            net.Start("SCP096_DrawRedScreen")
            net.WriteBool(true)
            net.Send(target)

            timer.Simple(8, function()
                target:SetNWBool("freaking_out", false)
                ply:SetNWBool("spotted_096", true)
            end)

            weapon:SetBecomeAggressive(CurTime() + 8)
        end
    else
        ply:SetNWBool("spotted_096", true)
    end
end

hook.Add("PlayerSpawn", "PlayerSpawnSCP096KEK", function(ply)
    if ply:Team() ~= TEAM_SCP096 then return end

    timer.Simple(1, function()
        ply:SCP096ApplySpawnSpeed()
    end)
end)

hook.Add("PlayerDeath", "PlayerDeathSCP096KEK", function(victim, inflictor, attacker)
    if attacker:IsWorld() then return end

    if attacker:Team() == TEAM_SCP096 and victim:GetNWBool("spotted_096", false) then
        victim:SetNWBool("spotted_096", false)
        attacker:GetActiveWeapon():SetActive(false)
    end

    if victim:Team() == TEAM_SCP096 then
        for _, ply in ipairs(player.GetAll()) do
            ply:SetNWBool("spotted_096", false)
        end

        attacker:SCP096ApplySpawnSpeed()
        net.Start("SCP096_DrawRedScreen")
        net.WriteBool(false)
        net.Send(attacker)
    end
end)

hook.Add("Think", "CheckPlayerLookingAtHead", function()
    for _, ply in ipairs(player.GetAll()) do
        local trace = util.TraceLine({
            start = ply:GetShootPos(),
            endpos = ply:GetShootPos() + ply:GetAimVector() * 100,
            filter = ply
        })

        if not ply:Alive() then continue end

        if trace.Entity and trace.Entity:IsPlayer() and trace.HitGroup == HITGROUP_HEAD and ply ~= trace.Entity then
            PlayerIsLookingAtHead(ply, trace.Entity)
        end
    end
end)

util.AddNetworkString("SCP096_DrawRedScreen")
util.AddNetworkString("SCP096_PlaySound")
util.AddNetworkString("SCP096_Heartbeat")

timer.Create("checkscp096", 15, 0, function()
    net.Start("SCP096_Heartbeat")
    net.Broadcast()
end)