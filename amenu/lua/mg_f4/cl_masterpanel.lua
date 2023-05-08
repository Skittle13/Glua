-- "addons\\scp_f4menu\\lua\\mg_f4\\cl_masterpanel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
------------------- Base panel
local PANEL = {}

function PANEL:Init()
	local tb = self:GetTable()

	local color1, color2, color3, color4, color5 = Color(237, 237, 237), Color(230, 230, 230), Color(41, 41, 41), Color(62, 62, 62), Color(200, 200, 200)

	self:SetSize(ScrW() * 0.8, ScrH() * 0.8)
	self:Center()
	self:MakePopup()
	self:ParentToHUD()

	tb.Tabs = {}
	tb.StartTime = SysTime() - 10

	tb.Banner = vgui.Create("DPanel", self)
	tb.Banner:SetSize(self:GetParent():GetWide(), 55)
	tb.Banner:Dock(TOP)
	local host_name = GetHostName()
	tb.Banner.Paint = function(this, w, h)
		if input.IsKeyDown(KEY_F1) then
			if tb.ReadyToClose then
				DarkRP.closeF4Menu()
				CloseDermaMenus()
			end
		else
			if !tb.ReadyToClose then
				tb.ReadyToClose = true
			end
		end
		draw.RoundedBox(0, 0, 0, w, h, mg_f4.Color)
		draw.SimpleText(host_name, "mg_f4Title", 5, 0, color1, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText(mg_f4.SubTitle, "mg_f4SubTitle", 5, 27, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	tb.Close = vgui.Create("mg_f4Button", tb.Banner)
	tb.Close:SetSize(80, 35)
	tb.Close:Dock(RIGHT)
	tb.Close:DockMargin(8, 8, 8, 8)
	tb.Close.Text = "X"
	tb.Close.Col = color4
	tb.Close.DoClick = function()
		DarkRP.closeF4Menu()
	end

	tb.MenuBar = vgui.Create("DPanel", self)
	tb.MenuBar:Dock(LEFT)
	tb.MenuBar:SetWide(220)
	tb.MenuBar.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, color3)
	end

	tb.MenuBar.Info = vgui.Create("DPanel", tb.MenuBar)
	tb.MenuBar.Info:Dock(TOP)
	tb.MenuBar.Info:DockMargin(5, 5, 5, 0)
	tb.MenuBar.Info:SetTall(77)
	local ply = LocalPlayer()
	tb.MenuBar.Info.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, 72, color4)

		draw.SimpleText(ply:Name(), "mg_f420", 80, 5, mg_f4.Color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

		draw.RoundedBox(2, 80, 28, 120, 2, mg_f4.Color)

		draw.SimpleText(team.GetName(ply:Team()), "mg_f420", 80, 30, color5, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
		draw.SimpleText(DarkRP.formatMoney(ply:getDarkRPVar("money") or 0), "mg_f420", 80, 48, color5, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end

	tb.MenuBar.Info.Avatar = vgui.Create("AvatarCircleMask", tb.MenuBar.Info)
	tb.MenuBar.Info.Avatar:SetPlayer(ply, 64)
	tb.MenuBar.Info.Avatar:SetPos(4, 4)
	tb.MenuBar.Info.Avatar:SetSize(64, 64)
	tb.MenuBar.Info.Avatar:SetMaskSize(64 / 2)

	tb.MenuBar.List = vgui.Create("DPanel", tb.MenuBar)
	tb.MenuBar.List:Dock(FILL)
	tb.MenuBar.List:DockMargin(5, 0, 5, 5)
	tb.MenuBar.List.Paint = function(this, w, h)
	end

	tb.Dashboard = vgui.Create("mg_f4Dashboard", self)
	tb.Tab = 1

	if mg_f4.AllowedTabs["Dashboard"] then
		self:AddCat("Dashboard", mg_f4.HomeButton, tb.Dashboard)
	end

	if mg_f4.AllowedTabs["Berufe"] then
		tb.Jobs = vgui.Create("mg_f4Container", self)
		if !tb.Jobs then return end
		tb.Jobs:SetContents(RPExtraTeams)
		self:AddCat("Berufe", mg_f4.JobsButton, tb.Jobs)
	end

	if mg_f4.WebsiteLink != "" or mg_f4.DonationLink != "" then
		self:AddCat("")
	end

	if mg_f4.WebsiteLink != "" and mg_f4.AllowedTabs["Forum"] then
		tb.Website = vgui.Create("mg_f4WebBase", self)
		tb.Website:SetLink(mg_f4.WebsiteLink)
		self:AddCat("Forum", mg_f4.WebButton, tb.Website)
	end

	if mg_f4.DonationLink != "" and mg_f4.AllowedTabs["Shop"] then
		tb.Donate = vgui.Create("mg_f4WebBase", self)
		tb.Donate:SetLink(mg_f4.DonationLink)
		self:AddCat("Shop", mg_f4.DonateButton, tb.Donate)
	end

	for k, v in ipairs(tb.Tabs) do
		if v:IsValid() then
			v:SetVisible(false)
		end
	end

	if IsValid(tb.Jobs) then
		tb.Jobs:SetVisible(true)
		tb.Tab = table.KeyFromValue(tb.Tabs, tb.Jobs)
	else
		tb.Tabs[1]:SetVisible(true)
		tb.Tab = 1
	end
end

function PANEL:AddCat(name, icon, panel)
	if panel then
		panel.Name = name
		table.insert(self.Tabs, panel)
	end

	local cat = vgui.Create(panel and "DButton" or "DLabel", self.MenuBar.List)
	cat:SetSize(self:GetParent():GetWide(), panel and 36 or 12)
	cat:DockMargin(0, 0, 0, 5)
	cat:Dock(TOP)
	cat.Name = name
	if panel then
		cat.ChildPanel = panel
	end

	local cur_tab = table.KeyFromValue(self.Tabs, panel)
	cat.DoClick = function()
		if !panel then return end
		if panel.IsSitePage then
			panel:OpenPage()
			return
		end

		self.Tab = cur_tab
		for _, v in ipairs(self.Tabs) do
			if v:IsValid() then
				v:SetVisible(false)
			end
		end
		if panel:IsValid() then
			panel:SetVisible(true)
		end
	end
	cat:SetText("")

	cat.Paint = function(this, w, h)
		if panel then
			if self.Tab == cur_tab then
				cat.Col = mg_f4.Color
			else
				cat.Col = Color(210, 210, 210)
			end

			draw.RoundedBox(4, 0, 0, w, h, name == "Dashboard" and Color(82, 82, 82) or Color(62, 62, 62))
			draw.SimpleText(string.upper(name), "mg_f418", 54, 18, cat.Col, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(">", "mg_f418", w-20, 18, cat.Col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		if icon then
			surface.SetMaterial(icon)
			surface.SetDrawColor(cat.Col.r, cat.Col.g, cat.Col.b)
			surface.DrawTexturedRect(20, 10, 16, 16)
		end
	end
end

function PANEL:OnKeyCodePressed(k)
	if k == KEY_F4 then
		DarkRP.toggleF4Menu()
	end
end

function PANEL:Paint(w, h)
	draw.RoundedBox(4, 0, 0, w, h, Color(62, 62, 62, 255))
	if mg_f4.BlurBackground then
		Derma_DrawBackgroundBlur(self, self.StartTime)
	end
end

vgui.Register("mg_f4Base", PANEL, "EditablePanel")