local sin = math.sin
local draw = draw

surface.CreateFont("NG_EntFont1", {font = "Roboto", size = 35, weight = 500})
surface.CreateFont("NG_EntFont2", {font = "Roboto", size = 26, weight = 400})
surface.CreateFont("NG_EntFont3", {font = "Roboto", size = 28, weight = 400})
surface.CreateFont("NG_EntFont4", {font = "Roboto", size = 34, weight = 800})

surface.CreateFont("NG_WeaponFont1", {font = "Roboto", size = 22, weight = 800})
surface.CreateFont("NG_WeaponFont2", {font = "Roboto", size = 21, weight = 800})
surface.CreateFont("NG_WeaponFont3", {font = "Roboto Regular", size = 18})
surface.CreateFont("NG_WeaponFont4", {font = "Roboto", size = 18, weight = 800})
surface.CreateFont("NG_WeaponFont5", {font = "Roboto Regular", size = 16})
surface.CreateFont("NG_WeaponFont6", {font = "Roboto", size = 16, weight = 800})

-- 3d2d Text

local local_ply
function North_3d2dEntityText(self, dist, tb, move)
	local_ply = local_ply or LocalPlayer()
	if local_ply:GetPos():DistToSqr(self:GetPos()) > dist then return end

	local pos = self:LocalToWorld(self:OBBCenter())
	if move then
		pos = pos + Vector(0, 0, sin(SysTime() * 2) * 2)
	end
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang.x = 0
	ang.y = local_ply:EyeAngles().y - 90
	ang.z = 90
	cam.Start3D2D(pos, ang, 0.07)
		local headInfo = tb[1]
		local header = headInfo.text
		draw.SimpleTextOutlined(header, headInfo.font or "NG_EntFont1", 0, (headInfo.offset or 0), headInfo.color or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		for i = 2, table.Count(tb) do
			local textInfo = tb[i]
			draw.SimpleTextOutlined(textInfo.text, textInfo.font or "NG_EntFont2", 0, (textInfo.offset or 0), textInfo.color or color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		end
	cam.End3D2D()
end

-- Alkohol Effekt

local local_ply
local function AlcoholEffect()
	local_ply = local_ply or LocalPlayer()
	if local_ply:IsKnocked() or !local_ply:Alive() then
		timer.Remove("NG_SCP294_RandomKey")
		hook.Remove("RenderScreenspaceEffects", "North_DrawAlcohol")
	end
	DrawMotionBlur(0.05, 0.8, 0.01)
end

net.Receive("North_AlcoholEffect", function()
	local_ply = local_ply or LocalPlayer()
	local add_hook = net.ReadBool()

	if add_hook then
		local keys = {"attack", "forward", "back", "moveleft", "moveright", "left", "right"}
		timer.Create("NG_SCP294_RandomKey", 1, 0, function()
			local key = keys[math.random(#keys)]
			RunConsoleCommand("+" .. key)

			timer.Simple(0.1, function()
				RunConsoleCommand("-" .. key)
			end)
		end)
		hook.Add("RenderScreenspaceEffects", "North_DrawAlcohol", AlcoholEffect)
	else
		timer.Remove("NG_SCP294_RandomKey")
		hook.Remove("RenderScreenspaceEffects", "North_DrawAlcohol")
	end
end)

-- Hülle vom Spieler anpassen

net.Receive("North_SetHull", function()
	local ply = net.ReadEntity()
	local mins = net.ReadVector()
	local maxs = net.ReadVector()
	if ply.SetHull then
		ply:SetHull(mins, maxs)
	end
end)

-- Springen/Ducken verbieten

local function StartCommand(ply, cmd)
	local job_tbl = ply:getJobTable()
	if !job_tbl then return end
	-- Ducken
	if job_tbl.restrictduck then
		if cmd:KeyDown(IN_DUCK) then
			cmd:RemoveKey(IN_DUCK)
		end
	end
	-- Springen
	if job_tbl.restrictjump then
		if cmd:KeyDown(IN_JUMP) then
			cmd:RemoveKey(IN_JUMP)
		end
	end
end

hook.Add("StartCommand", "North_StartCommandRestrict", StartCommand)