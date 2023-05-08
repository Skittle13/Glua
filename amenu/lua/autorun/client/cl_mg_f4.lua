-- "addons\\scp_f4menu\\lua\\autorun\\client\\cl_mg_f4.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
hook.Add("OnGamemodeLoaded", "mg_f4IncludeCall", function()
	hook.Remove("OnGamemodeLoaded", "mg_f4IncludeCall")
	include("mg_f4.lua")
end)