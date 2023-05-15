util.AddNetworkString("HCS.Amnestic.Sending")
util.AddNetworkString("HCS.Amnestic.Swap")

net.Receive("HCS.Amnestic.Swap", function(len, ply)
    local wpn = ply:GetActiveWeapon()
    if(not IsValid(wpn) or wpn:GetClass() ~= "weapon_amnestic") then return end
    local newAmnestic = net.ReadString()

    if(!newAmnestic) then return end
    if (!HexSh.Config["src_amnestic"].AMNESTICLEVELS[newAmnestic]) then return end 

    wpn.AmnesticType = newAmnestic

    net.Start("HCS.Amnestic.Swap")
        net.WriteString(newAmnestic)
    net.Send(ply) 
end)

function AmnesticEffect(injector, target, typ)
    if target.amnested == true then return end 

    if not  string.StartWith(injector:GetActiveWeapon():GetClass(),"weapon_amnestic") then 
        return
    end

    if not IsValid(injector) or not IsValid(target) then return end
    if not injector:IsPlayer() or not target:IsPlayer() then return end
    if injector == target then return end
    
    target.amnested = true 
    timer.Simple(HexSh.Config["src_amnestic"].AMNESTICLEVELS[typ].time,function()
        target.amnested = false
    end)

    hook.Run("HexAmnestics::Injected", injector, target, typ)
    net.Start("HCS.Amnestic.Sending")
        net.WriteString(typ)
    net.Send(target)
end 