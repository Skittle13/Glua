local scrw = ScrW()
local scrh = ScrH()

local x = scrw / 2
local y = scrh * 0.09

surface.CreateFont("InfoHudFont", {font = "Roboto", size = 20, weight = 800})

local ply, default_team

timer.Simple(0, function()
	default_team = GAMEMODE.DefaultTeam  -- Beitritsberuf Team
end)

local function DrawJoinJob()
	ply = ply or LocalPlayer()
	if ply:Team() != default_team then return end
	draw.SimpleTextOutlined("Du bist im Anfangsjob, drücke F4, um den Beruf zu wechseln.", "InfoHudFont", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
end
hook.Add("HUDPaint", "NG_JoinJob", DrawJoinJob)

local function DrawCSSMount()
	if !IsMounted("cstrike") and !util.IsValidModel("models/props/cs_assault/money.mdl") then
		draw.SimpleTextOutlined("Der Server benutzt Objekte aus CSS, installiere es, um ohne Fehler spielen zu können.", "InfoHudFont", x, y + 35, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, color_black)
	else
		hook.Remove("HUDPaint", "NG_CSSMount")
	end
end
hook.Add("HUDPaint", "NG_CSSMount", DrawCSSMount)