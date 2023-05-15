////////////////////////////////////////
//         Maax´s Libary (MLIB)       //
//          Coded by: Maax            //
//                                    //
//      Version: v1.0 (Workshop)      //
//                                    //
//      You are not permitted to      //
//        reupload this Script!       //
//                                    //
////////////////////////////////////////

local PANEL = {}


function PANEL:Init()
	self:SetText("")
	self:SetColor(Color(255,0,0))
	self:SetColorHoverd(Color(230,0,0))
	self:SetFont("MLIB.Button")
	self:SetTextColor(Color(255,255,255))
	self:SetContentAlignment(5)
	self:SetGradient(false)
	self:SetTextColor(color_white)

	self.ButtonAlpha = 255

	self.SetText = function(self, text)
		self._sText = text
	end
	self.GetText = function(self)
		return self._sText
	end
end

function PANEL:SizeToContentsX(padding)
	if padding == nil then padding = 0
	end
	surface.SetFont(self:GetFont())
	local tw = surface.GetTextSize(self:GetText())

	self:SetWide(tw + padding)
end

function PANEL:IsGradient()
	return self._bUniform
end

function PANEL:SetGradient(bBool)
	self._bUniform = bBool
end

function PANEL:SetColor(color)
	self.Color = color
end

function PANEL:SetColorHoverd(color)
	self.ColorHoverd = color
end

function PANEL:SetTextColor(color)
	self.ColorText = color
end

function PANEL:RoundFromTallness()
	self:SetRoundness(self:GetTall())
end

function PANEL:SetContentAlignment(iInteger)
	self._iHorizontalAlignment = (iInteger - 1) % 3
	self._iVerticalAlignment = (iInteger == 5 or iInteger == 6 or iInteger == 4) and 1 or (iInteger == 1 or iInteger == 2 or iInteger == 3) and 4 or 3

	self._bTopAligned = self._iVerticalAlignment == 3
	self._bBottomAligned = self._iVerticalAlignment == 4

	self._bLeftAligned = self._iHorizontalAlignment == 0
	self._bRightAligned = self._iHorizontalAlignment == 2
end

function PANEL:Paint(w, h)

				draw.RoundedBox(4, 0,0, w,h,self.Color)
        if self:IsHovered() then
               draw.RoundedBox(4, 0,0, w,h,self.ColorHoverd)
        end


	draw.SimpleText(self:GetText(), self:GetFont(),self:GetWide() / 2,self:GetTall() / 2,self.ColorText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("MLIB.Button", PANEL, "DButton")
