-- "addons\\scp_darkrpmod\\lua\\effects\\scp_extinguish.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	local tb = self:GetTable()

	tb.Origin = data:GetOrigin()
	tb.Radius = data:GetRadius()

	local teh_effect = ParticleEmitter(tb.Origin)
	if !teh_effect then return end

	for i = 1, math.random(40, 50) do
		local particle = teh_effect:Add("effects/splash4", tb.Origin)
		if particle then
			particle:SetVelocity(Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(-100, 125)))
			particle:SetDieTime(1)

			local color = math.Round(tb.Radius) == 1 and {200, 200, 255} or {255, 255, 255}

			particle:SetColor(color[1], color[2], color[3])
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)

			local size = math.Rand(8, 10)

			particle:SetStartSize(size)
			particle:SetEndSize(size / 2)
			particle:SetGravity(Vector(0, 0, -math.Rand(75, 100)))
			particle:SetAirResistance(40)
			particle:SetCollide(false)
			particle:SetRoll(math.Rand(-360, 360))
			particle:SetRollDelta(math.Rand(-2, 2))
		end
	end

	teh_effect:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end