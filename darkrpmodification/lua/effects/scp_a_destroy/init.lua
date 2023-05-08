-- "addons\\scp_darkrpmod\\lua\\effects\\scp_a_destroy\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	for i = 1, 75 do
		local w = self.Emitter:Add("effects/fleck_cement"..math.random(1, 2), self.Start)
		if w then
			w:SetVelocity(Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(0, 150)))
			local size = math.Rand(1, 1.5)
			w:SetDieTime(math.Rand(1, 6))
			w:SetStartAlpha(255)
			w:SetEndAlpha(0)
			w:SetStartSize(size)
			w:SetEndSize(size)
			w:SetRoll(math.Rand(-360, 360))
			w:SetRollDelta(math.Rand(-5, 5))
			w:SetAirResistance(70)
			w:SetColor(90,85,75)
			w:SetGravity(Vector(0,0,-600))
			w:SetCollide(true)
			w:SetBounce(math.Rand(0.4, 0.6))
		end
	end
	for i = 1, 2 do
		local c = self.Emitter:Add("particle/particle_composite", self.Start)
		if c then
			c:SetDieTime(2)
			c:SetStartAlpha(100)
			c:SetEndAlpha(0)
			c:SetStartSize(15)
			c:SetEndSize(35)
			c:SetRoll(math.Rand(150, 360))
			c:SetRollDelta(math.Rand(-1,1))
			c:SetAirResistance(150)
			c:SetVelocity(Vector(math.Rand(-45,45), math.Rand(-45,45), math.Rand(0,65)))
			c:SetGravity(Vector(0, 0, -50))
			c:SetColor(90,85,75)
		end
	end
	for i = 1, 5 do
		local p = self.Emitter:Add("particle/smokesprites_000"..math.random(1, 9), self.Start)
		p:SetDieTime(2)
		p:SetStartAlpha(math.Rand(75, 125))
		p:SetEndAlpha(0)
		p:SetStartSize(math.Rand(20, 25))
		p:SetEndSize(math.Rand(50, 60))
		p:SetRoll(math.Rand(-0.25, 0.25))
		p:SetRollDelta(math.Rand(-0.1, 0.1))
		p:SetGravity(Vector(0, 0, -30))
		p:SetVelocity(Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(5, 10)))
		p:SetColor(142, 107, 72)
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end