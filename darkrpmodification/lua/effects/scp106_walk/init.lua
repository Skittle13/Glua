-- "addons\\scp_darkrpmod\\lua\\effects\\scp106_walk\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	for i=1, 25 do
		local p = self.Emitter:Add("effects/fleck_cement"..math.random(1, 2), self.Start + VectorRand() * math.Rand(-5, 5))
		if p then
			p:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			p:SetAngleVelocity(Angle(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(-10, 10)))
			p:SetCollide(true)
			p:SetDieTime(math.Rand(4, 6))
			p:SetEndAlpha(0)
			p:SetStartAlpha(255)
			p:SetStartSize(math.Rand(0.5, 2))
			p:SetEndSize(0)
			p:SetVelocity(Vector(math.Rand(-60, 60), math.Rand(-60, 60), math.Rand(-60, 60)))
			p:SetGravity(Vector(0, 0, -400))
			p:SetAirResistance(50)
			p:SetBounce(0.6)
			p:SetColor(0, 0, 0)
		end
	end
	for i=1, 15 do
		local c = self.Emitter:Add("particle/smokesprites_000"..math.random(1, 9), self.Start)
		if c then
			c:SetDieTime(math.Rand(2, 4))
			c:SetStartAlpha(math.Rand(150, 255))
			c:SetEndAlpha(0)
			c:SetStartSize(math.Rand(2, 4))
			c:SetEndSize(math.Rand(12, 16))
			c:SetRoll(math.Rand(0, 360))
			c:SetRollDelta(math.Rand(-2, 2))
			c:SetAirResistance(150)
			c:SetVelocity(Vector(math.Rand(-60, 60), math.Rand(-60, 60), math.Rand(-60, 60)))
			c:SetGravity(Vector(0, 0, -200))
			c:SetCollide(true)
			c:SetBounce(0.6)
			c:SetColor(0, 0, 0)
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end