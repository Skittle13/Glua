surface.CreateFont("admin_icons", {font = "Arial", size = 47, weight = 0, antialias = true, shadow = false})

local local_ply, icon_offy
local invis, god, noclip = utf8.char(9201), utf8.char(9876), utf8.char(9992)
local function DrawIconHUD()
	local_ply = local_ply or LocalPlayer()
	icon_offy = 40
	if local_ply:GetNoDraw() and !local_ply:IsFrozen() then
		draw.SimpleTextOutlined(invis, "admin_icons", ScrW() - 310 + 6, icon_offy, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
		icon_offy = icon_offy + 30
	end
	if local_ply:HasGodMode() and !local_ply:IsFrozen() then
		draw.SimpleTextOutlined(god, "admin_icons", ScrW() - 310 + 7, icon_offy - 4, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
		icon_offy = icon_offy + 30
	end
	if local_ply:GetMoveType() == MOVETYPE_NOCLIP and !local_ply:IsFrozen() and !local_ply:InVehicle() then
		draw.SimpleTextOutlined(noclip, "admin_icons", ScrW() - 310, icon_offy, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, color_black)
		icon_offy = icon_offy + 30
	end
end
hook.Add("HUDPaint", "MG_AdminIcons", DrawIconHUD)