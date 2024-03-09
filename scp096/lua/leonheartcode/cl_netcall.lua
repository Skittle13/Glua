DarkRP = DarkRP or {}

net.Receive("SCP096_PlaySound", function()
    surface.PlaySound(net.ReadString())
end)

local blood_eff = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = 0,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 1,
    ["$pp_colour_mulr"] = 0,
    ["$pp_colour_mulg"] = 0,
    ["$pp_colour_mulb"] = 0
}

local function DrawBloodScreen()
    local wep = LocalPlayer():GetActiveWeapon()

    if not wep.SCP096 then
        hook.Remove("RenderScreenspaceEffects", "SCP096_DrawRedScreen")

        return
    end

    blood_eff["$pp_colour_addr"] = 0.5 * math.abs(math.sin(CurTime() * 6)) * 0.2
    DrawColorModify(blood_eff)
end

net.Receive("SCP096_DrawRedScreen", function()
    local bool = net.ReadBool()

    if not bool then
        hook.Remove("RenderScreenspaceEffects", "SCP096_DrawRedScreen")
    else
        hook.Add("RenderScreenspaceEffects", "SCP096_DrawRedScreen", DrawBloodScreen)
    end
end)

hook.Add("StartCommand", "StartCommand096", function(ply, cmd)
    if not LocalPlayer():GetActiveWeapon() then return end
    local wep = LocalPlayer():GetActiveWeapon()

    if wep:GetClass() == "weapon_scp096" then
        local tb = wep:GetTable()
        local dt = tb.dt
        if not dt then return end

        if dt.BecomeAggressive > 0 then
            if cmd:KeyDown(IN_WALK) then
                cmd:RemoveKey(IN_WALK)
            end

            if ply:OnGround() and cmd:KeyDown(IN_DUCK) then
                cmd:RemoveKey(IN_DUCK)
            end
        elseif cmd:KeyDown(IN_JUMP) then
            cmd:RemoveKey(IN_JUMP)
        end
    end
end)