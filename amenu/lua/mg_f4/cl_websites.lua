-- "addons\\scp_f4menu\\lua\\mg_f4\\cl_websites.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
------------------ Website link page
local PANEL = {}

function PANEL:Init()
	self.Type 		= 0
	self.IsSitePage = true
	self.Link 		= ""

	self:Dock(FILL)
end

function PANEL:OpenPage()
	gui.OpenURL(self.Link)
end

function PANEL:SetLink(link)
	self.Link = link
end

vgui.Register("mg_f4WebBase", PANEL, "DPanel")