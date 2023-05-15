
local blur = Material("pp/blurscreen")
local function DrawBlurRect(x, y, w, h, power)
	local X, Y = 0,0

	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)

	for i = 1, 5 do
		blur:SetFloat("$blur", (i / 3) * (5 * power))
		blur:Recompute()

		render.UpdateScreenEffectTexture()

		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

local tab = {
	["$pp_colour_brightness"] = -0.04,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1
}

hook.Add("CreateMove", "MedicSys_DisallowMove", function(cmd)
    local p = LocalPlayer()
    if (p:IsKnocked()) then
        cmd:ClearMovement()
        cmd:ClearButtons()
        return true
    end
end)

local x_0 = 0
local GM_Dragging = nil
local e_amount = 0
local e_enabled = false
local help = surface.GetTextureID("ggui/death")
hook.Add("PostDrawTranslucentRenderables", "MedicSys_ShowCSRagdolls", function()
    if (!MedConfig.EnableRagdoll) then
        for k,v in pairs(player.GetAll()) do
            local rag = v:GetRagdollEntity()
            if IsValid(rag) then
                local pos = rag:GetPos() + Vector(0,0,25)
                local ang = EyeAngles()
                ang:RotateAroundAxis(ang:Forward(), 90)
                ang:RotateAroundAxis(ang:Right(), 90)
                cam.Start3D2D(pos, ang, 0.1 + math.cos(RealTime() * 6) * 0.007)
                    surface.SetDrawColor(color_white)
                    surface.SetTexture(help)
                    surface.DrawTexturedRectRotated(0, 0, 256, 256, 0)
                cam.End3D2D()
            end
        end
    end    
end)

local maxDist = 150 ^ 2
local LastSpacePress = 0

local ragdoll_ent

hook.Add("RenderScreenspaceEffects","MedicSys_ScreenspaceEffects", function()
    local p = LocalPlayer()
    if (p:IsKnocked()) and IsValid(ragdoll_ent) then
        local time = (p._RemainingKnock or 0) - CurTime()
        local power = math.min(1 - (time / (MedConfig.DeathCountdown)), 1)
        if p._isKnocked then 
            math.min(1 - (time / MedConfig.UnconsciousCD), 1)
        end
        if (!p._isKnocked) then
            tab["$pp_colour_brightness"] = -power ^ 1.2
        else
            tab["$pp_colour_brightness"] = -0.04
        end
        tab["$pp_colour_colour"] = (1-power)
        DrawColorModify(tab)
    end
end)

local death_color = Color(5, 5, 5, 240)
local ply
local function DeathHud()
    ply = ply or LocalPlayer()
    if IsValid(ragdoll_ent) then
        DrawBlurRect(0,0,ScrW(), ScrH(), 2)
        surface.SetDrawColor(death_color)
        surface.DrawRect(0, 0, ScrW(), ScrH())

        local replace, header, info = hook.Call("MedicSys_RenderDeathInfo", nil, ply, ragdoll_ent)
        
        local customHeader = "Du kannst in " .. (string.FormattedTime(ragdoll_ent:GetRespawn() - CurTime(), "%02i:%02i")) .. " wieder respawnen."
        local customInfo = "Du bist gestorben"
        
        if replace then
            customHeader = header or ""
            customInfo = info or ""
        else
            if CurTime() > ragdoll_ent:GetRespawn() then
                customHeader = ""
            end
        end

        local w = ScrW() / 2
        local h = ScrH() / 2 - 8

        if ragdoll_ent:GetWakeUp() != ragdoll_ent:GetRespawn() and !ragdoll_ent:GetIsDead() then
            draw.SimpleText(customHeader, "MedicSys_DeathInfo", w, h - 16, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Du verblutest in " .. (string.FormattedTime(ragdoll_ent:GetWakeUp() - CurTime(), "%02i:%02i")), "BEBAS_Model", w, h, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText(customHeader, "MedicSys_DeathInfo", w, h, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        if(ragdoll_ent:GetIsDead() or info) then
            draw.SimpleText(customInfo, "MedicSys_DeathInfo", w, h + 16, color_red, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        if CurTime() > ragdoll_ent:GetRespawn() then
            draw.SimpleText("Benutze die Leertaste um zu respawnen.", "MedicSys_DeathInfo", w, h - 16, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            if input.IsKeyDown(KEY_SPACE) and CurTime() - LastSpacePress > 0.2 and !vgui.CursorVisible() then
                LastSpacePress = CurTime()
                net.Start("MedicSys_Respawn")
                net.SendToServer()
            end
        end
    else
        hook.Remove("HUDPaint", "MedicSys_DeathHud")
    end
end

local ply
hook.Add("NetworkEntityCreated", "MedicSys_SyncRagdoll", function(ent)
    ply = ply or LocalPlayer()
    if ent:GetClass() == "sent_death_ragdoll" then
        local owner = ent:GetOwner()
        if owner == ply then
            ragdoll_ent = ent
            hook.Add("HUDPaint", "MedicSys_DeathHud", DeathHud)
        end
        owner.DeathBody = ent
    end
end)

timer.Simple(0, function()
    local ply
    hook.Add("HUDPaintBackground", "MedicSys_DefaultDeath", function()
        ply = ply or LocalPlayer()
        if !ply:Alive() then
            local w = ScrW() / 2
            local h = ScrH() / 2 - 8

            draw.SimpleText("Du bist gestorben", "MedicSys_DeathInfo", w, h + 16, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Benutze die Leertaste um zu respawnen.", "MedicSys_DeathInfo", w, h - 16, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end)
end)

local ply
hook.Add("HUDPaint", "MedicSys_RenderHud", function()
    ply = ply or LocalPlayer()
    local target = ply:GetEyeTrace().Entity
    if (IsValid(target) and !target:IsPlayer() and !ply:IsKnocked() and target:GetNW2Bool("IsRagdoll",false) and ply:GetPos():DistToSqr(target:GetPos()) < maxDist) then
        draw.SimpleTextOutlined("[" .. (input.LookupBinding(IN_USE) or "E"):upper() .. "] zum Tragen", "BEBAS_Model", ScrW() / 2, ScrH() / 2.2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
        if !target:GetNW2Bool("Stabilized") and !target:GetNW2Bool("RagdollDeath") then
            draw.SimpleTextOutlined("[" .. (input.LookupBinding(IN_RELOAD) or "R"):upper() .. "] zum Stabilisieren", "BEBAS_Model", ScrW() / 2, ScrH() / 2.13, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255))
        end
    end

    if (GM_Dragging and IsValid(GM_Dragging.ent)) then
        local bone = GM_Dragging.ent:TranslatePhysBoneToBone(GM_Dragging.bone)
        local bonePos, boneAng = GM_Dragging.ent:GetBonePosition(bone)
        local pos = bonePos:ToScreen()
        surface.SetDrawColor(color_white)
        surface.DrawLine(pos.x, pos.y, ScrW() / 2, ScrH() / 2)
    end
end)

hook.Add("PlayerBindPress", "SetGM_Dragging", function(ply, bind, pressed)
    if (!MedConfig.AllowGM_Dragging) then return end
    if ply:IsSprinting() then return end
    local target = ply:GetEyeTrace().Entity
    if (IsValid(target) and !ply:IsKnocked() and (target:GetNW2Bool("IsRagdoll",false) or target:GetClass() == "prop_ragdoll") and bind == "+use") then
            if(ply:GetNWInt("DragPlayerGMNext", 0) < CurTime()) then
                net.Start("Ragdoll.StartGM_Dragging")
                net.WriteEntity(target)
                net.SendToServer()
            end
    end
end)

net.Receive("Ragdoll.SendDrag", function()
    local ent = net.ReadEntity()
    local bone = net.ReadInt(8)
    if IsValid(ent) then
        GM_Dragging = {
            ent = ent,
            bone = bone
        }
    else
        GM_Dragging = nil
    end
end)

net.Receive("Unconscious.SendInfo", function()
	local b = net.ReadBool()
	local wp = net.ReadFloat()
	local ply = LocalPlayer()
	ply._RemainingKnock = wp
	ply._isKnocked = !b

	if (b) then
		ply.heart_looping = ply:StartLoopingSound("heart_bacon_loop")
	end

    e_enabled = false
    e_amount = 0
end)

net.Receive("Ragdoll.RemoveSound", function()
	LocalPlayer():StopLoopingSound(LocalPlayer().heart_looping or 0)
end)
