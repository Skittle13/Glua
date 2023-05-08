mg_vars = mg_vars or {}
mg_vars.requestdata = mg_vars.requestdata or true

local Player = FindMetaTable("Entity")
function Player:SetMGVar(name, var)
	local prev_var = mg_vars[self] and mg_vars[self][name]

	if prev_var == var then return end

	local typ = type(var)
	if typ == "boolean" and (!prev_var and var == false) then return end
	if typ == "number" and (!prev_var and var == 0) then return end
	if typ == "string" and (!prev_var and var == "") then return end

	mg_vars[self] = mg_vars[self] or {}

	local old = mg_vars[self][name]

	if var == false or var == 0 or var == "" then
		mg_vars[self][name] = nil
	else
		mg_vars[self][name] = var
	end

	hook.Run("mg_vars_update", self, name, var, old)
end

function Player:GetMGVar(name, fallback)
	return mg_vars[self] and mg_vars[self][name] or (fallback or false)
end

hook.Add("InitPostEntity", "mg_vars_ask", function()
	hook.Remove("InitPostEntity", "mg_vars_ask")

	timer.Create("mg_vars_ask", 10, 0, function()
		if mg_vars.requestdata then
			net.Start("mg_vars_ask")
			net.SendToServer()
		else
			timer.Remove("mg_vars_ask")
		end
	end)
end)