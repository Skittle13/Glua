-- "addons\\scp_f4menu\\lua\\mg_f4\\vgui\\cl_mg_f4category.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
------------------ Categories
local PANEL = {}

function PANEL:Init()
	self.Name 		= ""
	self.Children 	= {}
	self.Col 		= mg_f4.Color

	self:Dock(TOP)
end

local color1, color2 = Color(31, 31, 31), Color(200, 200, 200)
function PANEL:Paint(w, h)
	draw.RoundedBox(4, 5, 5, self:GetParent():GetWide() - 7, h - 5, color1)
	draw.SimpleText(self.Name, "mg_f4Title", 10, 5, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	draw.RoundedBox(2, 10, 37, self:GetParent():GetWide() - 20, 2, self.Col)
end

function PANEL:GetName()
	return self.Name
end

function PANEL:SetName(str)
	self.Name = str
end

function PANEL:AddChild(child)
	if not IsValid(child) then return end
	child:SetParent(self)
	table.insert(self.Children, child)
end

function PANEL:PerformLayout()
	local wide = (self:GetParent():GetWide() - 15)

	local BarW, BarH = (wide / 2) - 6, 70
	local countx, county = 10, 45

	for k, v in ipairs(self.Children) do --I guess it's kinda like text-wrapping but with vgui right?
		if countx >= wide then 
			countx = 10
			county = county + BarH + 5
		end

		v:SetPos(countx, county)
		v:SetSize(BarW, BarH)

		countx = countx + BarW + 5
	end
	self:SizeToChildren(false, true)
	self:SetTall(self:GetTall() + 5)
end

vgui.Register("mg_f4Category", PANEL, "DPanel")