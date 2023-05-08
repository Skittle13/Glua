-- "addons\\scp_darkrpmod\\lua\\darkrp_customthings\\categories.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[-----------------------------------------------------------------------
Categories
---------------------------------------------------------------------------
The categories of the default F4 menu.
Please read this page for more information:
http://wiki.darkrp.com/index.php/DarkRP:Categories
In case that page can't be reached, here's an example with explanation:
DarkRP.createCategory{
	name = "Citizens", -- The name of the category.
	categorises = "jobs", -- What it categorises. MUST be one of "jobs", "entities", "shipments", "weapons", "vehicles", "ammo".
	startExpanded = true, -- Whether the category is expanded when you open the F4 menu.
	color = Color(0, 107, 0, 255), -- The color of the category header.
	canSee = function(ply) return true end, -- OPTIONAL: whether the player can see this category AND EVERYTHING IN IT.
	sortOrder = 100, -- OPTIONAL: With this you can decide where your category is. Low numbers to put it on top, high numbers to put it on the bottom. It's 100 by default.
}
Add new categories under the next line!
---------------------------------------------------------------------------]]

DarkRP.createCategory{
	name = "Beitrittsberuf",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return false end,
	sortOrder = 0,
}

DarkRP.createCategory{
	name = "D-Klasse",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 1,
}

DarkRP.createCategory{
	name = "Wissenschaftler",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 2,
}

DarkRP.createCategory{
	name = "Personal",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 3,
}

DarkRP.createCategory{
	name = "Sicherheitspersonal",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 4,
}

DarkRP.createCategory{
	name = "Sicherheitsdienst",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 5,
}

DarkRP.createCategory{
	name = "Containment Team",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 6,
}

DarkRP.createCategory{
	name = "Mobile Task Force",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 7,
}

DarkRP.createCategory{
	name = "Notfalleinheiten",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 8,
}

DarkRP.createCategory{
	name = "Mediziner",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 9,
}

DarkRP.createCategory{
	name = "Management",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 10,
}

DarkRP.createCategory{
	name = "SCPs",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 11,
}

DarkRP.createCategory{
	name = "SCPs - VIP",
	categorises = "jobs",
	startExpanded = true,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 12,
}

DarkRP.createCategory{
	name = "The Serpent's Hand",
	categorises = "jobs",
	startExpanded = false,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 13,
}

DarkRP.createCategory{
	name = "Chaos Insurgency",
	categorises = "jobs",
	startExpanded = false,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return true end,
	sortOrder = 14,
}

DarkRP.createCategory{
	name = "Serverteam",
	categorises = "jobs",
	startExpanded = false,
	color = Color(0, 0, 0, 255),
	canSee = function(ply) return ply:IsAdmin() end,
	sortOrder = 15,
}