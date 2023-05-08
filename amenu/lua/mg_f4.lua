--Main Table
mg_f4 = {}

mg_f4.Designs = {
	["red"] = Color(215, 85, 80),
	["blue"] = Color(66, 139, 202),
	["turquoise"] = Color(26, 188, 156),
	["green"] = Color(92, 184, 92),
	["purple"] = Color(135, 95, 154),
	["darkred"] = Color(200, 25, 40),
	["grey"] = Color(139, 148, 163),
	["orange"] = Color(255, 129, 38),
	["slateblue"] = Color(100, 100, 255),
	["pink"] = Color(243, 116, 174),
	["lightbrown"] = Color(126, 108, 108),
}

mg_f4.DefaultColor = "red" -- Fallback color (eg default color)

--The text underneath the title at the top of the menu
mg_f4.SubTitle = "SCP-RP by Serotinin-Gaming"

--Do we show VIP jobs in the jobs tab?
mg_f4.ShowVIP = false


-----Disabling main tabs stuff
--In order to disable a tab, change its value from true to false and change map

mg_f4.AllowedTabs = {}

mg_f4.AllowedTabs["Dashboard"] 		= true
mg_f4.AllowedTabs["Berufe"] 		= true
mg_f4.AllowedTabs["Forum"] 		= true
mg_f4.AllowedTabs["Shop"] 		= true

-----Dashboard stuff
--Put the names of the user ranks that you wish to appear inside the online staff list here, alongside their display names.

--For example, listing "superadmin" here will not only make users with that rank show up in the staff 
--list, but also show their rank as "Super Admin" rather than "superadmin"

mg_f4.StaffGroups = {}

mg_f4.StaffGroups["owner"]				= "Owner"
mg_f4.StaffGroups["stellv. owner"]			= "Stellv. Owner"
mg_f4.StaffGroups["community-manager"]			= "Community Manager"
mg_f4.StaffGroups["teamleiter"]				= "Teamleiter"
mg_f4.StaffGroups["developer"]				= "Developer"
mg_f4.StaffGroups["superadmin_vip"]			= "Superadmin (VIP)"
mg_f4.StaffGroups["superadmin"]				= "Superadmin"
mg_f4.StaffGroups["admin_vip"]				= "Admin (VIP)"
mg_f4.StaffGroups["admin"]				= "Admin"
mg_f4.StaffGroups["moderator_vip"]			= "Moderator (VIP)"
mg_f4.StaffGroups["moderator"]				= "Moderator"

mg_f4.SortOrder = {}

mg_f4.SortOrder["owner"]				= 1
mg_f4.SortOrder["stellv. owner"]			= 2
mg_f4.SortOrder["community-manager"]			= 3
mg_f4.SortOrder["teamleiter"]				= 4
mg_f4.SortOrder["developer"]				= 5
mg_f4.SortOrder["superadmin_vip"]			= 6
mg_f4.SortOrder["superadmin"]				= 7
mg_f4.SortOrder["admin_vip"]				= 8
mg_f4.SortOrder["admin"]				= 9
mg_f4.SortOrder["moderator_vip"]			= 10
mg_f4.SortOrder["moderator"]				= 11

-----Extra tabs stuff
--All web addresses have to start with either http:// or https://
--Leave variable blank as "" if you don't want a certain button

--Website link
mg_f4.WebsiteLink = ""

--Donation link
mg_f4.DonationLink = ""

--Workshop collection link
mg_f4.WorkshopLink = ""

--Do we show the player colour in the preview box on the right when we click on a job?
mg_f4.PreviewThemeColour = true

--Do we preview the job's full colour in the pie chart's key?
mg_f4.ChartFullColour = false

--Blur behind the F4 menu?
mg_f4.BlurBackground = true


-----Levels stuff
--What colour do we want the job's level bar in the jobs list to be if we can't be the job?
mg_f4.LevelAcceptColor = Color(50, 130, 0, 245)

--What colour do we want the job's level bar in the jobs list to be if we can be the job?
mg_f4.LevelDenyColor = Color(31, 31, 31, 245)


-----Fonts 
--Feel free to edit if you need to
surface.CreateFont("mg_f4Title", 	{font = "Open Sans", 	size = 32, 	weight = 500})
surface.CreateFont("mg_f4SubTitle", {font = "Open Sans", 	size = 24, 	weight = 500})
surface.CreateFont("mg_f4JobDesc",  {font = "Arial", 		size = 16, 	weight = 500})
surface.CreateFont("mg_f4Job", 		{font = "Open Sans", 	size = 28, 	weight = 500})
surface.CreateFont("mg_f422", 		{font = "Open Sans", 	size = 22, 	weight = 500})
surface.CreateFont("mg_f420", 		{font = "Open Sans", 	size = 20, 	weight = 500})
surface.CreateFont("mg_f419", 		{font = "Open Sans", 	size = 19, 	weight = 500})
surface.CreateFont("mg_f418", 		{font = "Open Sans", 	size = 18, 	weight = 500})
surface.CreateFont("mg_f414", 		{font = "Open Sans", 	size = 15, 	weight = 500})

--Oh yeah and don't touch anything below this line unless you know what you're doing
mg_f4.HomeButton = Material("mg_f4menu/home.png")
mg_f4.JobsButton = Material("mg_f4menu/jobs.png")
mg_f4.WebButton = Material("mg_f4menu/website.png")
mg_f4.DonateButton = Material("mg_f4menu/donate.png")
mg_f4.Bell = Material("mg_f4menu/bell.png", "smooth")
mg_f4.NoBell = Material("mg_f4menu/no_bell.png", "smooth")

mg_f4.PaintScroll = function(panel)
	local scr = panel:GetVBar()
	scr.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(62, 62, 62))
	end
	scr.btnUp.Paint = function()
	end
	scr.btnDown.Paint = function() 
	end
	scr.btnGrip.Paint = function(self, w, h)
		draw.RoundedBox(6, 2, 0, w - 4, h - 2, mg_f4.Color)
	end
end

--Includes
include("mg_f4/vgui/cl_circleavatar.lua")
include("mg_f4/vgui/cl_circles.lua")
include("mg_f4/vgui/cl_mg_f4category.lua")
include("mg_f4/vgui/cl_mg_f4button.lua")

include("mg_f4/cl_masterpanel.lua")
include("mg_f4/cl_dashboard.lua")
include("mg_f4/cl_jobspanel.lua")
include("mg_f4/cl_websites.lua")

function DarkRP.openF4Menu()
	if IsValid(mg_f4.Base) then
		mg_f4.Base:Remove()
		mg_f4.Base = nil
	end

	mg_f4.Base = vgui.Create("mg_f4Base")
end

function DarkRP.closeF4Menu()
	if IsValid(mg_f4.Base) then
		mg_f4.Base:Remove()
		mg_f4.Base = nil
	end
end

function DarkRP.toggleF4Menu()
	if !IsValid(mg_f4.Base) then
		DarkRP.openF4Menu()
	else
		DarkRP.closeF4Menu()
	end
end

MsgC(Color(240, 173, 78), "[F4 menu] ", Color(210, 210, 210), "Loaded f4 menu\n" )