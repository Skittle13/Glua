include("shared.lua")

local mat = CreateMaterial("mg_scp096_heartbeat", "UnlitGeneric", {
    ["$basetexture"] = "sprites/light_glow02",
    ["$ignorez"] = 1,
    ["$additive"] = 1,
    ["$translucent"] = 1,
    ["$vertexcolor"] = 1,
    ["$vertexalpha"] = 1,
})

function SWEP:DrawHUD()
    local tb = self:GetTable()
    local dt = tb.dt
    if not dt then return end

    for _, ply in ipairs(player.GetAll()) do
        if ply == LocalPlayer() then continue end

        if ply:HuntedBySCP096() then
            local chestPos = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Spine1"))
            local pos = chestPos:ToScreen()
            surface.SetDrawColor(255, 0, 0, 255)
            surface.SetMaterial(mat)
            local size = 128
            surface.DrawTexturedRect(pos.x - size / 2, pos.y - size / 2, size, size)
        end
    end
end