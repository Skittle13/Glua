-- "addons\\scp_darkrpmod\\lua\\autorun\\client\\cl_timer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local current_time = 0
local timer_started = false
local reversed = false

local function StartTimer()
	timer_started = true
	timer.Create("timer_start", 1, 0, function()
		current_time = reversed and math.max(0, current_time - 1) or current_time + 1
	end)
end

local function StopTimer()
	timer_started = false
	timer.Remove("timer_start")
end

local function ResetTimer()
	current_time = 0
end

local function SetTimer(num)
	current_time = num
end

local function ReverseTimer()
	reversed = !reversed
end

concommand.Add("timer_start", function()
	StartTimer()
end)

concommand.Add("timer_stop", function()
	StopTimer()
end)

concommand.Add("timer_reset", function()
	ResetTimer()
end)

surface.CreateFont("timer_font", {font = "BebasNeue", size = 22, weight = 500, blursize = 0, scanlines = 0, antialias = true})

local material = Material("icon16/time.png")
local function DrawTimer()
	surface.SetMaterial(material)
	surface.SetDrawColor(color_white)
	local scrw, scrh = ScrW(), ScrH()
	local y = scrh - 360
	surface.DrawTexturedRect(scrw - 40, y, 18, 18)
	draw.SimpleTextOutlined(string.ToMinutesSeconds(current_time), "timer_font", scrw - 75, y - 2, reversed and current_time <= 0 and Color(255, 0, 0, 255) or color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
end

hook.Add("OnPlayerChat", "timer_commands", function(ply, text)
	local txt = string.lower(text)
	if (txt == "/starttimer" or txt == "/stoptimer" or txt == "/resettimer" or string.sub(txt, 1, 9) == "/settimer" or txt == "/revtimer") then
		if ply != LocalPlayer() then return true end
		if txt == "/starttimer" then
			StartTimer()
			ply:ChatPrint("Timer gestartet. Beende den Timer mittels \"/stoptimer\".")
			hook.Add("HUDPaint", "timer_draw", DrawTimer)
		elseif txt == "/stoptimer" then
			StopTimer()
			ply:ChatPrint("Timer gestoppt.")
			hook.Remove("HUDPaint", "timer_draw")
		elseif txt == "/resettimer" then
			ResetTimer()
			ply:ChatPrint("Timer zurückgesetzt.")
		elseif string.sub(txt, 1, 9) == "/settimer" then
			local num = tonumber(string.sub(txt, 11, #txt))
			if num then
				SetTimer(num)
				ply:ChatPrint("Timer auf "..string.ToMinutesSeconds(num).." gesetzt.")
			else
				ply:ChatPrint("Du musst eine gültige Zahl angeben!")
			end
		else
			ReverseTimer()
			ply:ChatPrint("Timer zählt nun "..(reversed and "rückwärts" or "vorwärts")..".")
		end
		return true
	end
end)