-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\theme\\cl_mg_theme.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local use_font = system.IsWindows() and "Tahoma" or "Verdana"
surface.CreateFont("MG_Theme_Close", {font = use_font, size = 13, weight = 1000})

surface.CreateFont("MG_Theme_ScrollbarButtons", {font = "Arial", size = 8, weight = 500})

MG_Theme = MG_Theme or {}

MG_Theme.Theme = {
	Frame = {},
	Button = {},
	ListView = {},
	DMenu = {},
	TextEntry = {},
	ComboBox = {},
	ScrollBar = {},
	MenuBar = {},
	ColorPatterns = {},
	CustomColorPattern = false,
}

local Theme = MG_Theme.Theme

Theme.PrimaryColor = {215, 85, 80}
Theme.DangerColor = {255, 60, 60}
Theme.WarningColor = {235, 235, 35}
Theme.SuccessColor = {40, 190, 85}
Theme.AdminColor = {255, 60, 60}
Theme.UserColor = {45, 175, 230}

function Theme:CreateColorPattern(name, tbl) -- Add custom color patterns, needs to be tables, not colors (It does override the above specified colors)
	Theme.ColorPatterns[name] = tbl

	--[[Example:
	MG_Theme.Theme.CreateColorPattern("example", {
		PrimaryColor = {255, 255, 255},
		DangerColor = {255, 0, 0},
	})
	]]
end

function Theme:ApplyColorPattern(name, menu) -- Applys a color pattern, until the specific menu element is removed
	Theme.CustomColorPattern = name

	if menu then
		local oldRemove = menu.OnRemove
		menu.OnRemove = function(self)
			if oldRemove then
				oldRemove(self)
			end

			Theme.CustomColorPattern = false
		end
	end
end

function Theme:GetCustomColor(self, typ, alpha)
	typ = typ.."Color"

	if Theme.CustomColorPattern and Theme.ColorPatterns[Theme.CustomColorPattern] and Theme.ColorPatterns[Theme.CustomColorPattern][typ] then
		return Theme:GetColor(Theme.ColorPatterns[Theme.CustomColorPattern][typ], alpha)
	end
end

function Theme:GetColor(color, alpha)
	return Color(color[1], color[2], color[3], alpha or color[4] or 255)
end

function Theme:GetPrimaryColor(alpha, self)
	return Theme:GetCustomColor(self, "Primary", alpha) or Theme:GetColor(Theme.PrimaryColor, alpha)
end

function Theme:GetDangerColor(alpha, self)
	return Theme:GetCustomColor(self, "Danger", alpha) or Theme:GetColor(Theme.DangerColor, alpha)
end

function Theme:GetWarningColor(alpha, self)
	return Theme:GetCustomColor(self, "Warning", alpha) or Theme:GetColor(Theme.WarningColor, alpha)
end

function Theme:GetSuccessColor(alpha, self)
	return Theme:GetCustomColor(self, "Success", alpha) or Theme:GetColor(Theme.SuccessColor, alpha)
end

function Theme:GetAdminColor(alpha, self)
	return Theme:GetCustomColor(self, "Admin", alpha) or Theme:GetColor(Theme.AdminColor, alpha)
end

function Theme:GetUserColor(alpha, self)
	return Theme:GetCustomColor(self, "User", alpha) or Theme:GetColor(Theme.UserColor, alpha)
end

local tStatus = {
	Theme:GetSuccessColor(),
	Theme:GetWarningColor(),
	Theme:GetDangerColor()
}

function Theme:GetStatusColor(status)
	if tStatus[status] then
		return tStatus[status]
	end

	return Theme:GetPrimaryColor()
end

timer.Simple(0, function()
	function DListView_Line:SetColumnColor(icol, ccol)
		self.ColumnColors = self.ColumnColors or {}
		self.ColumnColors[icol] = ccol
	end
end)

Theme.Frame.Paint = function(s, w, h)
	if s.m_bBackgroundBlur then
		Derma_DrawBackgroundBlur(s, s.m_fCreateTime)
	end

	draw.RoundedBox(0, 0, 0, w, 24, Color(30, 30, 30, 255))
	draw.RoundedBox(0, 0, 23, w, 1, Theme:GetPrimaryColor(nil, s))
	draw.RoundedBox(0, 0, 24, w, h - 24, s.NoBG and Color(50, 50, 50, 255) or Color(50, 50, 50, 240))
end

Theme.Frame.Setup = function(frame, noBG, noClose)
	frame.NoBG = noBg and true or nil
	frame.Paint = Theme.Frame.Paint
	frame.PaintOver = function()
	end

	frame:ShowCloseButton(false)

	if !noClose then
		local closeButton = vgui.Create("DButton", frame)
		frame.CloseButton = closeButton

		closeButton:SetText("")
		closeButton:SetPos(frame:GetWide() - 35, 0)
		closeButton:SetSize(35, 23)
		closeButton.Paint = function(s, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 255))
			local color = Color(150, 150, 150)
			if s:IsHovered() then
				color = color_white
				draw.RoundedBox(0, 0, 0, w, h, s.DangerColor or Theme:GetDangerColor())
			end
			draw.SimpleText("r", "Marlett", w / 2, h / 2, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		closeButton.DoClick = function()
			frame:Remove()
			surface.PlaySound("ui/buttonclick.wav")
		end

		local oldPerformLayout = frame.PerformLayout
		frame.PerformLayout = function(s)
			if oldPerformLayout then
				oldPerformLayout(s)
			end

			closeButton:SetPos(frame:GetWide() - 35, 0)
		end
	end
end
Theme.Frame.SetupTheme = Theme.Frame.Setup

Theme.ListView.Paint = function(s, w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
end

Theme.ListView.Setup = function(list)
	list.Paint = Theme.ListView.Paint
	list:SetHeaderHeight(25)
	list:SetDataHeight(25)
	for _, v in pairs(list.Lines) do
		for i, c in pairs(v.Columns) do
			function c:UpdateColours()
				local parent = self:GetParent()
				if (parent.ColumnColors and parent.ColumnColors[i]) then
					return self:SetColor(parent.ColumnColors[i])
				end
				if parent:IsSelected() then
					self:SetColor(color_white)
				else
					self:SetColor(Color(200, 200, 200))
				end
			end
			c:SetContentAlignment(5)
		end

	    function v:Paint(w, h)
	    	if self:IsSelected() then
	    		return draw.RoundedBox(0, 0, 0, w, list:GetDataHeight(), Theme:GetPrimaryColor(100, self))
			end
	    	if self.BackgroundColor then
	    		return draw.RoundedBox(0, 0, 0, w, list:GetDataHeight(), self.BackgroundColor)
	    	end
	    	if self:IsHovered() then
	    		return draw.RoundedBox(0, 0, 0, w, list:GetDataHeight(), Color(100, 100, 100, 200))
	    	end
		    draw.RoundedBox(0, 0, 0, w, list:GetDataHeight(), Color(45, 45, 45))
		    draw.RoundedBox(0, 0, 0, w, 1, Color(35, 35, 35))
	    end
	end
	for _, v in pairs(list.Columns) do
	    function v.Header:Paint(w, h)
	    	if self:IsHovered() then
	    		self:SetTextColor(Theme:GetPrimaryColor(nil, self))
	    		return draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20, 255))
	    	end
	    	self:SetTextColor(Color(150, 150, 150))
	        draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25, 255))
	    end
	end
	Theme.ScrollBar.Setup(list.VBar)
end
Theme.ListView.SetupTheme = Theme.ListView.Setup

Theme.DMenu.Setup = function(menu)
	menu.Paint = Theme.DMenu.Paint
	menu.fAddOption = menu.AddOption
	menu.fAddSubMenu = menu.AddSubMenu

	function menu:AddOption(...)
		local opt = menu:fAddOption(...)
		opt.Paint = Theme.DMenu.OptionPaint

		return opt
	end

	function menu:AddSubMenu(...)
		local submenu, parent = menu:fAddSubMenu(...)
		parent.Paint = Theme.DMenu.OptionPaint

		return submenu, parent
	end

	local scroll = menu:GetVBar()
	if IsValid(scroll) then
		Theme.ScrollBar.SetupTheme(scroll)
	end
end
Theme.DMenu.SetupTheme = Theme.DMenu.Setup

Theme.DMenu.Paint = function(s, w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
	draw.RoundedBox(0, 2, 2, w - 4, h - 4, Color(30, 30, 30))
end

Theme.DMenu.AddOption = function(menu, ...)
	local option = menu:AddOption(...)
	option.Paint = Theme.DMenu.OptionPaint
	return option
end

Theme.DMenu.AddSubMenu = function(menu, ...)
	local submenu, parent = menu:AddSubMenu(...)
	parent.Paint = Theme.DMenu.OptionPaint
	return submenu, parent
end

Theme.DMenu.OptionPaint = function(s, w, h)
	if s:IsHovered() then
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 1))
		draw.RoundedBox(0, 2, 2, w - 4, h- 4, Color(255, 255, 255, 1))
		s:SetTextColor(Theme:GetPrimaryColor(nil, s))
	else
		s:SetTextColor(Color(100, 100, 100))
	end
end

Theme.Button.Paint = function(s, w, h)
	if !s.OldColor and !s:IsHovered() then
		s.OldColor = s:GetTextColor()
	end

	local drawColor1 = Color(60, 60, 60)
	local drawColor2 = Color(35, 35, 35)

	local disabled = s:GetDisabled()
	if disabled then
		drawColor1.r = drawColor1.r + 15
		drawColor2.r = drawColor2.r + 15
	end

	draw.RoundedBox(0, 0, 0, w, h, drawColor1)
	draw.RoundedBox(0, 2, 2, w - 4, h - 4, drawColor2)

	if disabled then return end

	if s:IsHovered() then
		draw.RoundedBox(0, 0, 0, w, h, Color(150, 150, 150, 5))
		if !s.AddHovered then
			s:SetTextColor(color_white)
			s.AddHovered = true
		end
	else
		if s.OldColor then
			s:SetTextColor(s.OldColor)
		end
		s.AddHovered = false
	end
end 

Theme.Button.Setup = function(button) 
	button.Paint = Theme.Button.Paint
	button:SetTextColor(Color(150, 150, 150))
end
Theme.Button.SetupTheme = Theme.Button.Setup

Theme.TextEntry.Setup = function(text)
	text.Paint = Theme.TextEntry.Paint
end
Theme.TextEntry.SetupTheme = Theme.TextEntry.Setup

Theme.TextEntry.Paint = function(s, w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(45, 45, 45, 230))
	draw.RoundedBox(0, 2, 2, w - 4, h - 4, Color(35, 35, 35, 230))

	if s.GetPlaceholderText and s.GetPlaceholderColor and s:GetPlaceholderText() and string.Trim(s:GetPlaceholderText()) != "" and s:GetPlaceholderColor() and (!s:GetText() or s:GetText() == "") then
		local oldText = s:GetText()
		local str = s:GetPlaceholderText()

		s:SetText(str)
		s:DrawTextEntryText(s:GetPlaceholderColor(), color_black, color_white)
		s:SetText(oldText)
		return
	end

	s:DrawTextEntryText(Color(255, 255, 255, 100), Color(0, 0, 0, 0), color_white)
end

Theme.ComboBox.Setup = function(combo)
	Theme.Button.SetupTheme(combo)

	function combo:DoClick()
		if self:IsMenuOpen() then
			return self:CloseMenu()
		end

		self:OpenMenu()
		if IsValid(self.Menu) then
			self.Menu.Paint = Theme.DMenu.Paint
			local options = self.Menu:GetCanvas():GetChildren()
			for _, opt in ipairs(options) do
				opt.Paint = Theme.DMenu.OptionPaint
			end
		end
	end
end
Theme.ComboBox.SetupTheme = Theme.ComboBox.Setup

Theme.ScrollBar.Setup = function(scroll)
	function scroll:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(35, 35, 35))
	end

	function scroll.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
		draw.RoundedBox(0, 0, h - 1, w, 1, Color(50, 50, 50))

		draw.DrawText("▲", "MG_Theme_ScrollbarButtons", w / 2 - 4, h / 2 - 5, color_white)
	end

	function scroll.btnDown:Paint(w,h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
		draw.RoundedBox(0, 0, 0, w, 1, Color(50, 50, 50))

		draw.DrawText("▼", "MG_Theme_ScrollbarButtons", w / 2 - 4, h / 2 - 5, color_white)
	end

	function scroll.btnGrip:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(25, 25, 25))
	end
end
Theme.ScrollBar.SetupTheme = Theme.ScrollBar.Setup

Theme.MenuBar.Paint = function(s, w, h)
	draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30))
	draw.RoundedBox(0, 0, h - 1, w, 1, Color(80, 80, 80))
end

Theme.MenuBar.Setup = function(bar)
	bar.Paint = Theme.MenuBar.Paint
	for _, menu in pairs(bar.Menus) do
		menu.Paint = Theme.DMenu.Paint
	end
end
Theme.MenuBar.SetupTheme = Theme.MenuBar.Setup

timer.Simple(0, function()
	function Derma_Message(strText, strTitle, strButtonText)
		local Window = vgui.Create("DFrame")
		Window:SetTitle(strTitle)
		Window:SetDraggable(false)
		Window:ShowCloseButton(false)
		Window:SetBackgroundBlur(true)
		Window:SetDrawOnTop(true)

		Theme.Frame.SetupTheme(Window, true)

		local InnerPanel = vgui.Create("Panel", Window)

		local Text = vgui.Create("DLabel", InnerPanel)
		Text:SetText(strText)
		Text:SizeToContents()
		Text:SetContentAlignment(5)
		Text:SetTextColor(color_white)

		local ButtonPanel = vgui.Create("DPanel", Window)
		ButtonPanel:SetTall(30)
		ButtonPanel:SetPaintBackground(false)

		local Button = vgui.Create("DButton", ButtonPanel)
		Button:SetText(strButtonText or "OK")
		Button:SizeToContents()
		Button:SetTall(20)
		Button:SetWide(Button:GetWide() + 20)
		Button:SetPos(5, 5)
		Button.DoClick = function()
			Window:Close()

			surface.PlaySound("ui/buttonclick.wav")
		end
		
		Theme.Button.SetupTheme(Button)

		ButtonPanel:SetWide(Button:GetWide() + 10)

		local w, h = Text:GetSize()

		Window:SetSize(w + 50, h + 25 + 45 + 10)
		Window:Center()

		InnerPanel:StretchToParent(5, 25, 5, 45)

		Text:StretchToParent(5, 5, 5, 5)

		ButtonPanel:CenterHorizontal()
		ButtonPanel:AlignBottom(8)

		Window:MakePopup()
		Window:DoModal()

		return Window
	end

	function Derma_Query(strText, strTitle, ...)
		local Window = vgui.Create("DFrame")
		Window:SetTitle(strTitle)
		Window:SetDraggable(false)
		Window:ShowCloseButton(false)
		Window:SetBackgroundBlur(true)
		Window:SetDrawOnTop(true)

		Theme.Frame.SetupTheme(Window, true)

		local InnerPanel = vgui.Create("DPanel", Window)
		InnerPanel:SetPaintBackground(false)

		local Text = vgui.Create("DLabel", InnerPanel)
		Text:SetText(strText)
		Text:SizeToContents()
		Text:SetContentAlignment(5)
		Text:SetTextColor(color_white)

		local ButtonPanel = vgui.Create("DPanel", Window)
		ButtonPanel:SetTall(30)
		ButtonPanel:SetPaintBackground(false)

		-- Loop through all the options and create buttons for them.
		local NumOptions = 0
		local x = 5

		for k=1, 8, 2 do
			local Text = select(k, ...)
			if Text == nil then break end

			local Func = select(k + 1, ...) or function() end

			local Button = vgui.Create("DButton", ButtonPanel)
			Button:SetText(Text)
			Button:SizeToContents()
			Button:SetTall(20)
			Button:SetWide(Button:GetWide() + 20)
			Button.DoClick = function()
				Window:Close()
				Func()

				surface.PlaySound("ui/buttonclick.wav")
			end
			Button:SetPos(x, 5)

			Theme.Button.SetupTheme(Button)

			x = x + Button:GetWide() + 5

			ButtonPanel:SetWide(x)
			NumOptions = NumOptions + 1
		end

		local w, h = Text:GetSize()

		w = math.max(w, ButtonPanel:GetWide())

		Window:SetSize(w + 50, h + 25 + 45 + 10)
		Window:Center()

		InnerPanel:StretchToParent(5, 25, 5, 45)

		Text:StretchToParent(5, 5, 5, 5)

		ButtonPanel:CenterHorizontal()
		ButtonPanel:AlignBottom(8)

		Window:MakePopup()
		Window:DoModal()

		if (NumOptions == 0) then
			Window:Close()
			Error("Derma_Query: Created query with no options!")
			return nil
		end

		return Window
	end

	function Derma_StringRequest(strTitle, strText, strDefaultText, fnEnter, fnCancel, strButtonText, strButtonCancelText)
		local Window = vgui.Create("DFrame")
		Window:SetTitle(strTitle)
		Window:SetDraggable(false)
		Window:ShowCloseButton(false)
		Window:SetBackgroundBlur(true)
		Window:SetDrawOnTop(true)

		Theme.Frame.SetupTheme(Window, true)

		local InnerPanel = vgui.Create("DPanel", Window)
		InnerPanel:SetPaintBackground(false)

		local Text = vgui.Create("DLabel", InnerPanel)
		Text:SetText(strText)
		Text:SizeToContents()
		Text:SetContentAlignment(5)
		Text:SetTextColor(color_white)

		local TextEntry = vgui.Create("DTextEntry", InnerPanel)
		TextEntry:SetText(strDefaultText or "")
		TextEntry.OnEnter = function()
			Window:Close()
			fnEnter(TextEntry:GetValue())
		end

		Theme.TextEntry.SetupTheme(TextEntry)

		local ButtonPanel = vgui.Create("DPanel", Window)
		ButtonPanel:SetTall(30)
		ButtonPanel:SetPaintBackground(false)

		local Button = vgui.Create("DButton", ButtonPanel)
		Button:SetText(strButtonText or "OK")
		Button:SizeToContents()
		Button:SetTall(20)
		Button:SetWide(Button:GetWide() + 20)
		Button:SetPos(5, 5)
		Button.DoClick = function()
			Window:Close()
			fnEnter(TextEntry:GetValue())

			surface.PlaySound("ui/buttonclick.wav")
		end

		Theme.Button.SetupTheme(Button)

		local ButtonCancel = vgui.Create("DButton", ButtonPanel)
		ButtonCancel:SetText(strButtonCancelText or "Abbrechen")
		ButtonCancel:SizeToContents()
		ButtonCancel:SetTall(20)
		ButtonCancel:SetWide(Button:GetWide() + 20)
		ButtonCancel:SetPos(5, 5)
		ButtonCancel.DoClick = function()
			Window:Close()
			if fnCancel then
				fnCancel(TextEntry:GetValue())
			end

			surface.PlaySound("ui/buttonclick.wav")
		end
		ButtonCancel:MoveRightOf(Button, 5)

		ButtonPanel:SetWide(Button:GetWide() + 5 + ButtonCancel:GetWide() + 10)

		Theme.Button.SetupTheme(ButtonCancel)

		local w, h = Text:GetSize()
		w = math.max(w, 400)

		Window:SetSize(w + 50, h + 25 + 75 + 10)
		Window:Center()

		InnerPanel:StretchToParent(5, 25, 5, 45)

		Text:StretchToParent(5, 5, 5, 35)

		TextEntry:StretchToParent(5, nil, 5, nil)
		TextEntry:AlignBottom(5)

		TextEntry:RequestFocus()
		TextEntry:SelectAllText(true)

		ButtonPanel:CenterHorizontal()
		ButtonPanel:AlignBottom(8)

		Window:MakePopup()
		Window:DoModal()

		return Window
	end
end)