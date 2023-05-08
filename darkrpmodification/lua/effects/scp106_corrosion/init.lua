-- "addons\\scp_darkrpmod\\lua\\effects\\scp106_corrosion\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local emitter = ParticleEmitter(pos)
	for i=1, 75 do
		local c = emitter:Add("particle/smokesprites_000"..math.random(1, 9), pos + VectorRand() * math.Rand(-25, 25))
		if c then
			c:SetDieTime(math.Rand(2, 6))
			c:SetStartAlpha(math.Rand(100, 155))
			c:SetEndAlpha(0)
			c:SetStartSize(math.Rand(8, 12))
			c:SetEndSize(math.Rand(32, 48))
			c:SetRoll(math.Rand(0, 360))
			c:SetRollDelta(math.Rand(-0.5, 0.5))
			c:SetAirResistance(250)
			c:SetVelocity(Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(-150, 150)))
			c:SetGravity(Vector(0, 0, -math.Rand(75, 125)))
			c:SetColor(0, 0, 0)
		end
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end