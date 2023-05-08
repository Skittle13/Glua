-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\manage\\cl_manage.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
surface.CreateFont("MG_ManageFont", {font = "Roboto", size = 24, weight = 1000, blursize = 0, scanlines = 0})

local PANEL = {}
function PANEL:Init()
	self:SetTitle("Facility Management")
	self:MakePopup()
	self:ParentToHUD()
	self:SetWide(400)
	local opened = false
	self.Think = function(self)
		if !input.IsKeyDown(KEY_F2) then
			opened = true
		end
		if input.IsKeyDown(KEY_F2) and opened then
			self:Remove()
		end
	end
	MG_Theme.Theme.Frame.SetupTheme(self)
	local buttons = 0
	local Emergency = vgui.Create("DButton", self)
	Emergency:SetSize(self:GetWide() - 20, 50)
	Emergency:SetPos(10, 35 + (buttons * 55))
	Emergency:SetFont("MG_ManageFont")
	Emergency:SetTextColor(color_white)
	Emergency:SetText("Notfalleinheiten rufen")
	Emergency.Paint = MG_Theme.Theme.Button.Paint
	Emergency.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "emergency")
	end
	buttons = buttons + 1
	local Code = vgui.Create("DButton", self)
	Code:SetSize(self:GetWide() - 20, 50)
	Code:SetPos(10, 35 + (buttons * 55))
	Code:SetFont("MG_ManageFont")
	local code = MG_Codes.AvailableCodes[MG_Codes.CurrentCode]
	Code:SetTextColor(code[2])
	Code:SetText(code[1])
	Code.Paint = MG_Theme.Theme.Button.Paint
	Code.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "code")
	end
	buttons = buttons + 1
	local Degrade = vgui.Create("DButton", self)
	Degrade:SetSize(self:GetWide() - 20, 50)
	Degrade:SetPos(10, 35 + (buttons * 55))
	Degrade:SetFont("MG_ManageFont")
	Degrade:SetTextColor(color_white)
	Degrade:SetText("Zu D-Klasse degradieren")
	Degrade.Paint = MG_Theme.Theme.Button.Paint
	Degrade.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "degrade")
	end
	buttons = buttons + 1
	local Execute = vgui.Create("DButton", self)
	Execute:SetSize(self:GetWide() - 20, 50)
	Execute:SetPos(10, 35 + (buttons * 55))
	Execute:SetFont("MG_ManageFont")
	Execute:SetTextColor(color_white)
	Execute:SetText("Exekutieren")
	Execute.Paint = MG_Theme.Theme.Button.Paint
	Execute.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "execute")
	end
	buttons = buttons + 1
	local Promote = vgui.Create("DButton", self)
	Promote:SetSize(self:GetWide() - 20, 50)
	Promote:SetPos(10, 35 + (buttons * 55))
	Promote:SetFont("MG_ManageFont")
	Promote:SetTextColor(color_white)
	Promote:SetText("Beförderungsmenü")
	Promote.Paint = MG_Theme.Theme.Button.Paint
	Promote.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "p")
	end
	buttons = buttons + 1
	local Protocol = vgui.Create("DButton", self)
	Protocol:SetSize(self:GetWide() - 20, 50)
	Protocol:SetPos(10, 35 + (buttons * 55))
	Protocol:SetFont("MG_ManageFont")
	Protocol:SetTextColor(color_white)
	Protocol:SetText("Testprotokolle")
	Protocol.Paint = MG_Theme.Theme.Button.Paint
	Protocol.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "protokolle")
	end
	buttons = buttons + 1
	local Razzia = vgui.Create("DButton", self)
	Razzia:SetSize(self:GetWide() - 20, 50)
	Razzia:SetPos(10, 35 + (buttons * 55))
	Razzia:SetFont("MG_ManageFont")
	Razzia:SetTextColor(color_white)
	Razzia:SetText("Razzia anordnen")
	Razzia.Paint = MG_Theme.Theme.Button.Paint
	Razzia.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "razzia")
	end
	buttons = buttons + 1
	local Lockdown = vgui.Create("DButton", self)
	Lockdown:SetSize(self:GetWide() - 20, 50)
	Lockdown:SetPos(10, 35 + (buttons * 55))
	Lockdown:SetFont("MG_ManageFont")
	Lockdown:SetTextColor(color_white)
	Lockdown:SetText("Lockdown einleiten")
	Lockdown.Paint = MG_Theme.Theme.Button.Paint
	Lockdown.DoClick = function()
		self:Close()
		surface.PlaySound("ui/buttonclick.wav")
		RunConsoleCommand("darkrp", "lockdownmenu")
	end
	buttons = buttons + 1
	if LocalPlayer():getJobTable().ziffer_agent then
		local Disguise = vgui.Create("DButton", self)
		Disguise:SetSize(self:GetWide() - 20, 50)
		Disguise:SetPos(10, 35 + (buttons * 55))
		Disguise:SetFont("MG_ManageFont")
		Disguise:SetTextColor(color_white)
		Disguise:SetText("Verkleidungsmenü öffnen")
		Disguise.Paint = MG_Theme.Theme.Button.Paint
		Disguise.DoClick = function()
			self:Close()
			surface.PlaySound("ui/buttonclick.wav")
			RunConsoleCommand("darkrp", "disguise")
		end
		buttons = buttons + 1
	end
	self:SetTall(40 + (buttons * 55))
	self:Center()
end

vgui.Register("SCP_ManageMenu", PANEL, "DFrame")

local emergencymenu
net.Receive("SCP_Manage_Open", function()
	if IsValid(emergencymenu) then emergencymenu:Close() end
	emergencymenu = vgui.Create("SCP_ManageMenu")
end)