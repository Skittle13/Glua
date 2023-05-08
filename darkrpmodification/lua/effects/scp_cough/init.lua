-- "addons\\scp_darkrpmod\\lua\\effects\\scp_cough\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	local ply = data:GetEntity()
	if !IsValid(ply) then return end

	local attachid = ply:LookupAttachment("eyes")
	if !attachid then return end

	local data = ply:GetAttachment(attachid)
	if !data then return end

	local velocity = ply:GetVelocity()

	local eyeAng, pos
	if LocalPlayer() == ply and LocalPlayer():GetObserverMode() == OBS_MODE_IN_EYE then
		eyeAng = ply:EyeAngles():Forward()
		pos = ply:EyePos() + gui.ScreenToVector(ScrW() / 2, ScrH() / 4 * 3) * 10
	else
		local dir = (data.Ang:Forward() - data.Ang:Up()):GetNormalized()

		eyeAng = data.Ang:Forward()
		pos = data.Pos + dir * 3
	end

	local emitter = ParticleEmitter(pos)

	for i = 1, math.random(2, 6) do
		local random = {"decals/yblood1", "decals/yblood2", "decals/yblood3", "decals/yblood4", "decals/yblood5", "decals/yblood6"}
		local effect = random[math.random(#random)]

		local particle = emitter:Add(effect, pos)
		if particle then
			particle:SetDieTime(math.Rand(0.5, 2.5))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			local size = math.Rand(0.2, 0.6)
			particle:SetStartSize(size)
			particle:SetEndSize(size)
			particle:SetVelocity(velocity + (eyeAng * math.Rand(20, 60)) + VectorRand() * math.Rand(-20, 20))
			particle:SetRoll(math.Rand(-360, 360))
			particle:SetRollDelta(math.Rand(-5, 5))
			particle:SetColor(math.random(100, 200), math.random(100, 200), math.random(0, 100))
			particle:SetGravity(Vector(0, 0, -math.Rand(75, 100)))
			particle:SetAirResistance(10)
			particle:SetCollide(true)
		end
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end