local bleed = surface.GetTextureID("ggui/bleed")
local ply

local bleedrisk = {
    [100] = MedConfig.Translatables.Bleed_1,
    [50] = MedConfig.Translatables.Bleed_2,
    [25] = MedConfig.Translatables.Bleed_3
}

hook.Add("HUDPaint", "Medic.Bleeding", function()
    if (!MedConfig.WoundsEnabled) then return end
    ply = ply or LocalPlayer()
    if (ply:IsBleeding()) then
        if (MedConfig.BleedOverlay) then
            surface.SetDrawColor(255, 0, 0,10 + math.cos(RealTime() * 2) * 5)
            surface.DrawRect(0,0,ScrW(),ScrH())
        end
        surface.SetTexture(bleed)
        surface.SetDrawColor(255, 255, 255)
        surface.DrawTexturedRectRotated(64, ScrH() / 2, 128 * MedConfig.BleedScale, 128 * MedConfig.BleedScale, 0)
        local alp = math.abs(math.cos(RealTime() * 4) * 75)
        local str = MedConfig.Translatables.Bleed_4
        local i = 1
        for k,v in pairs(bleedrisk) do
            if (k < ply:GetBleeding()) then
                str = MedConfig.Translatables["Bleed_" .. i]
            end
            i = i + 1
        end
        draw.SimpleText(str .. " " .. MedConfig.Translatables.Bleed, "BEBAS_Model", 64, ScrH() / 2 + 92, Color(255,125 - alp,125 - alp, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end)
    
hook.Add( "GetMotionBlurValues", "Medic.Damage", function( h, v, f, r )
    if (!MedConfig.WoundsEnabled) then return end
    ply = ply or LocalPlayer()

    if ply._hurtBlur then
        if !ply:Alive() then
            ply._hurtBlur = nil
        end
        local blur = ply._hurtBlur
        return blur, blur, blur, blur
    end
end)

net.Receive("Medic.UpdateBodyState", function()
    ply = ply or LocalPlayer()

    local hitgroup = net.ReadInt(4)
    local damage = net.ReadFloat()

    if (!ply._bodyState) then
        ply._bodyState = {
            head = 100,
            arms = 100,
            chest = 100,
            legs = 100
        }
    end

    if ( hitgroup == HITGROUP_HEAD ) then
        ply = ply or LocalPlayer()
		ply:GetBodyState().head = math.max(ply:GetBodyState().head - damage, 0)
        if ply:GetBodyState().head < 5 then
            ply._hurtBlur = damage / 20
            timer.Remove("NG_DamageSystem_RemoveBlur")
            timer.Create("NG_DamageSystem_RemoveBlur", math.random(7, 10), 1, function()
                ply._hurtBlur = nil
            end)
        end
 	elseif (hitgroup == HITGROUP_CHEST) then
		ply:GetBodyState().chest = math.max(ply:GetBodyState().chest - damage, 0)
    elseif (hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM) then
		ply:GetBodyState().arms = math.max(ply:GetBodyState().arms - damage, 0)
    elseif (hitgroup == HITGROUP_LEFTLEG or hitgroup == HITGROUP_RIGHTLEG) then
		ply:GetBodyState().legs = math.max(ply:GetBodyState().legs - damage, 0)
	end
end)
