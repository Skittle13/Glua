-- "addons\\scp_darkrpmod\\lua\\autorun\\client\\cl_hidetabs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function RemoveTabs()
	for _, v in ipairs(g_SpawnMenu.CreateMenu.Items) do
		local name = v.Name
		if name == "#spawnmenu.category.dupes" or name == "#spawnmenu.category.saves" or name == "#spawnmenu.category.postprocess" then
			g_SpawnMenu.CreateMenu:CloseTab(v.Tab, true)
		end
	end
end

hook.Add("PopulateContent", "MG_RemoveSpawnMenuTabs", function()
	timer.Simple(0, function()
		RemoveTabs()
	end)
end)