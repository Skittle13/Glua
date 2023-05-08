-- "addons\\scp_f4menu\\lua\\mg_f4\\vgui\\cl_mg_f4button.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
------------------- Custom DButton
local PANEL = {}

function PANEL:Init()
	self.Text 		= self:GetText()
	self.Col 		= mg_f4.Color
	self.Disabled 	= false

	self:SetText("")
end

local color1, color2, color3, color4 = Color(41, 41, 41), Color(120, 120, 120), Color(0, 0, 0, 20), Color(255, 253, 252)
function PANEL:Paint(w, h)
	if self.Disabled then
		draw.RoundedBox(4, 0, 0, w, h, color1)
		draw.SimpleText(self.Text, "mg_f422", w / 2, h / 2, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) 
	else
		draw.RoundedBox(4, 0, 0, w, h, self.Col)
		if self:IsHovered() then
			draw.RoundedBox(4, 0, 0, w, h, color3)
		end
		draw.SimpleText(self.Text, "mg_f422", w / 2, h / 2, color4, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER) 
	end
end

vgui.Register("mg_f4Button", PANEL, "DButton")