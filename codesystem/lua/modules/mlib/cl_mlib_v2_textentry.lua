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


MLIB:CreateFont( "MLIB.Textentry" , 30 )

local PANEL = {}

AccessorFunc(PANEL, "m_backgroundColor", "BackgroundColor")
AccessorFunc(PANEL, "m_rounded", "Rounded")
AccessorFunc(PANEL, "m_placeholder", "Placeholder")
AccessorFunc(PANEL, "m_textColor", "TextColor")
AccessorFunc(PANEL, "m_placeholderColor", "PlaceholderColor")
AccessorFunc(PANEL, "m_iconColor", "IconColor")

function PANEL:Init()
	self:SetBackgroundColor(Color(45,45,45))
	self:SetRounded(6)
	self:SetPlaceholder("")
	self:SetTextColor(Color(205, 205, 205))
	self:SetPlaceholderColor(Color(120, 120, 120))
	self:SetIconColor(self:GetTextColor())

	self.textentry = vgui.Create("DTextEntry", self)
	self.textentry:Dock(FILL)
	self.textentry:DockMargin(8, 8, 8, 8)
	self.textentry:SetFont("MLIB.Textentry")
	self.textentry:SetDrawLanguageID(false)
	self.textentry.Paint = function(pnl, w, h)
		local col = self:GetTextColor()

		pnl:DrawTextEntryText(col, col, col)

		if (#pnl:GetText() == 0) then
			draw.SimpleText(self:GetPlaceholder() or "", pnl:GetFont(), 3, pnl:IsMultiline() and 8 or h / 2, self:GetPlaceholderColor(), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end
	self.textentry.OnValueChange = function(pnl, text)
		self:OnValueChange(text)
	end
end

function PANEL:SetNumeric(bool)
	self.textentry:SetNumeric(true)end
function PANEL:GetNumeric()
	return self.textentry:GetNumeric()end
function PANEL:SetUpdateOnType(bool)
	self.textentry:SetUpdateOnType(true)end
function PANEL:GetUpdateOnType()
	return self.textentry:GetUpdateOnType()end
function PANEL:OnValueChanged() end

function PANEL:SetFont(str)
	self.textentry:SetFont(str)
end


function PANEL:GetText()
	return self.textentry:GetText()
end

function PANEL:SetMultiLine(state)
	self:SetMultiline(state)
	self.textentry:SetMultiline(state)
end

function PANEL:PerformLayout(w, h)
	if IsValid(self.icon) then
		self.icon:SetWide(self.icon:GetTall())
	end
end

function PANEL:OnMousePressed()
	self.textentry:RequestFocus()
end

function PANEL:Paint(w, h)
        surface.SetDrawColor(Color(50,50,50,200))
		surface.DrawRect(0,0,w,h)

		surface.SetDrawColor(Color(255,255,255,50))
		surface.DrawOutlinedRect(0,0,w,h)
end

vgui.Register("MLIB.TextEntryV2", PANEL)
