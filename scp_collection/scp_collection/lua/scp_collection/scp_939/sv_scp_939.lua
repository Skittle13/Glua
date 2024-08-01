util.AddNetworkString("SCP_939_LAYEGG")
util.AddNetworkString("939_SendDoorOpen")

SCP_Collection_SCP_939 = {}
SCP_Collection_SCP_939_Think = {}
net.Receive("SCP_939_LAYEGG",function(len,ply)
    if not (ply:Frags() >= 5) then return end
    local pos = ply:GetPos()
    if IsValid(SCP_Collection_SCP_939[ply:SteamID()]) then
        SCP_Collection_SCP_939[ply:SteamID()]:Remove()
    end
    
    SCP_Collection_SCP_939[ply:SteamID()] = ents.Create("939egg")
    SCP_Collection_SCP_939[ply:SteamID()]:SetPos( ply:GetPos() )
    SCP_Collection_SCP_939[ply:SteamID()]:Spawn()

    ply:SetFrags(0)
end)

hook.Add("PlayerSpawn","Spawn-At-EGG",function(victim, transition )
    if IsValid(SCP_Collection_SCP_939[victim:SteamID()]) then
        timer.Simple(0.1,function()
            victim:SetPos(SCP_Collection_SCP_939[victim:SteamID()]:GetPos())
            SCP_Collection_SCP_939_Think[victim] = {CurTime(),victim:GetModelScale()}
            timer.Simple(0.1,function()
                SCP_Collection_SCP_939[victim:SteamID()]:Remove()
            end)
        end)
    end
end)

hook.Add("OnPlayerChangedTeam","Destroy-on-job-change",function(ply,team)
    ply:SetFrags(0)
    if IsValid(SCP_Collection_SCP_939[ply:SteamID()]) then
        SCP_Collection_SCP_939[ply:SteamID()]:Remove()
        SCP_Collection_SCP_939[ply:SteamID()] = nil
    end
end)

hook.Add("Think","Think-SCP-939",function()
        for i,v in pairs(SCP_Collection_SCP_939_Think) do
            local value = (CurTime()-v[1]) / 15
            local cvalue = math.Clamp(value,.5,v[2])
            local cvalue = cvalue * 1
            
            i:SetModelScale(cvalue,0.00001)
        end
end)

function GetPlayersWith939()
    local to_return = {}
    for i,v in pairs(player.GetAll()) do
        if v:HasWeapon("scp_939") then
            table.insert(to_return,v)
        end
    end
    return to_return
end
    
hook.Add( "PlayerUse", "939_SendDoorOpen", function( ply, ent )
    if ent:GetClass() == "func_door" or ent:GetClass() == "func_button" or ent:GetClass() == "prop_door_rotating" then

    local to_return = {}
    for i,v in pairs(ents.FindInSphere(ent:GetPos(),50)) do
        if v:GetClass() == "prop_dynamic" then table.insert(to_return,v) end
    end

    net.Start("939_SendDoorOpen")
    net.WriteTable(to_return)
    net.Send(GetPlayersWith939())
    end
end)