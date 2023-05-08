-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\manage\\sh_config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SCP_Manage = SCP_Manage or {}

SCP_Manage.DemoteTime = 900

SCP_Manage.Config = SCP_Manage.Config or {}

timer.Simple(0, function()
	SCP_Manage.Config = {
		allowed = {
			management = true,
		},
	}
end)