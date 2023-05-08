-- "addons\\scp_darkrpmod\\lua\\effects\\scp966_devour\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Pos = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Pos)
	self.Scale = data:GetScale()
	self:Blood()
end

function EFFECT:Blood()
	for i=0, 10 * self.Scale do
		local Smoke = self.Emitter:Add("particle/particle_composite", self.Pos)
		if Smoke then
			Smoke:SetVelocity(VectorRand():GetNormalized() * math.random(30, 60) * self.Scale)
			Smoke:SetDieTime(math.Rand(1, 2))
			Smoke:SetStartAlpha(80)
			Smoke:SetEndAlpha(0)
			Smoke:SetStartSize(60 * self.Scale)
			Smoke:SetEndSize(120 * self.Scale)
			Smoke:SetRoll(math.Rand(0, 10))
			Smoke:SetRollDelta(math.Rand(-0.1, 0.1))
			Smoke:SetAirResistance(100)
			Smoke:SetGravity(Vector(math.Rand(-25, 25) * self.Scale, math.Rand(-25, 25) * self.Scale, math.Rand(-25, -100)))
		  	Smoke:SetColor(70, 35, 35)
		end
	end
	for i=0, 15 * self.Scale do
		local Smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1,9), self.Pos)
		if Smoke then
			Smoke:SetVelocity(VectorRand():GetNormalized() * math.random(30, 60) * self.Scale)
			Smoke:SetDieTime(math.Rand(3, 5))
			Smoke:SetStartAlpha(100)
			Smoke:SetEndAlpha(0)
			Smoke:SetStartSize(50 * self.Scale)
			Smoke:SetEndSize(100 * self.Scale)
			Smoke:SetRoll(math.Rand(0, 10))
			Smoke:SetRollDelta(math.Rand(-0.1, 0.1))
			Smoke:SetAirResistance(200)
			Smoke:SetGravity(Vector(math.Rand(-25, 25) * self.Scale, math.Rand(-25, 25) * self.Scale, math.Rand(-25, -100)))
			Smoke:SetColor(70, 35, 35)
		end
	end
	for i=1, 200 * self.Scale do
		local Debris = self.Emitter:Add("effects/fleck_cement"..math.random(1, 2), self.Pos)
		if Debris then
			Debris:SetVelocity(VectorRand():GetNormalized() * math.random(100, 250) * self.Scale)
			Debris:SetDieTime(math.random(8, 16))
			Debris:SetStartAlpha(155)
			Debris:SetEndAlpha(0)
			Debris:SetStartSize(math.Rand(3, 5) * self.Scale)
			Debris:SetEndSize(0)
			Debris:SetRoll(math.Rand(0, 360))
			Debris:SetRollDelta(math.Rand(-5, 5))
			Debris:SetAirResistance(20)
			Debris:SetColor(70, 35, 35)
			Debris:SetGravity(Vector(0, 0, -400))
			Debris:SetCollide(true)
			Debris:SetBounce(0.3)
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end