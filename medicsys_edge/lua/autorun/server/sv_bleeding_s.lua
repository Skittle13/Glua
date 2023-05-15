
resource.AddWorkshop("1438545068")

hook.Add("PlayerTick", "MedicSys_Bleeding", function(ply)
    if (!MedConfig.EnableBleeding) then return end
    if (ply:IsBleeding() and !ply:IsKnocked() and ply:Alive()) then
        if ((ply.nextbleeding or 0) < CurTime()) then
            local bleed_dmg = math.min(1, ply:GetBleeding() / 5)
            ply:TakeDamage(bleed_dmg, ply.BleedingOwner, ply.BleedingOwner)
            ply.nextbleeding = CurTime() + math.random(MedConfig.BleedingInterval[1],MedConfig.BleedingInterval[2])
            ply:AddBleeding(-bleed_dmg)
            if (MedConfig.BleedingDecals) then
                util.Decal( "Blood", ply:GetPos(), Vector(0,0,-64), ply )
            end
        end
    end
end)

hook.Add("OnPlayerChangedTeam", "MedicSys_BleedingTeamChange", function(ply, oldTeam, newTeam)
    if ply:IsBleeding() then
        ply:SetBleeding(0)
    end
end)
