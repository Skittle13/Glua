local playerMeta = FindMetaTable("Player")

function playerMeta:HuntedBySCP096()
    return self:GetNWBool("spotted_096", false)
end

net.Receive("SCP096_Heartbeat", function()
    for _, ply in ipairs(player.GetAll()) do
        if not ply then return end
        if not ply:HuntedBySCP096() then continue end
        ply:EmitSound("scp096/heartbeat.mp3")
    end
end)