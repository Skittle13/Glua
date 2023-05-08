-- "addons\\scp_darkrpmod\\lua\\effects\\scp_s_destroy\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	for i = 1, 20 do
		local t = self.Emitter:Add("effects/yellowflare", self.Start)
		if t then
			t:SetVelocity(Vector(math.random(-45, 45), math.random(-45, 45), math.random(25, 80)))
			t:SetDieTime(1)
			t:SetStartAlpha(255)
			t:SetStartSize(1)
			t:SetEndSize(0)
			t:SetRoll(0)
			t:SetGravity(Vector(0, 0, -250))
			t:SetCollide(false)
			t:SetStartLength(0.1)
			t:SetEndLength(0.15)
			t:SetVelocityScale(true)
		end
	end
	for i = 1, 10 do
		local c = self.Emitter:Add("particle/smokesprites_000"..math.random(1, 9), self.Start)
		if c then
			c:SetDieTime(1)
			c:SetStartAlpha(35)
			c:SetEndAlpha(0)
			c:SetStartSize(5)
			c:SetEndSize(15)
			c:SetRoll(math.Rand(-40, 40))
			c:SetRollDelta(math.Rand(-0.6,0.6))
			c:SetAirResistance(150)
			c:SetVelocity(Vector(math.Rand(-40, 40), math.Rand(-40, 40), math.Rand(0, 50)))
			c:SetGravity(Vector(0, 0, -30))
			c:SetColor(125, 125, 125)
		end
	end
	for i = 1, 10 do
		local w = self.Emitter:Add("effects/fleck_tile"..math.random(1, 2), self.Start + Vector(math.Rand(-1, 1), math.Rand(-1, 1), math.Rand(0, 1)))
		if w then
			w:SetVelocity(Vector(math.Rand(-75, 75), math.Rand(-75, 75), math.Rand(75, 100)))
			w:SetDieTime(math.Rand(2, 10))
			w:SetStartAlpha(255)
			w:SetEndAlpha(0)
			local size = math.Rand(0.5, 1)
			w:SetStartSize(size)
			w:SetEndSize(size)
			w:SetRoll(math.Rand(-360, 360))
			w:SetRollDelta(math.Rand(-5, 5))
			w:SetAirResistance(70)
			w:SetGravity(Vector(0, 0, -600))
			w:SetCollide(true)
			w:SetBounce(0.6)
			w:SetColor(200, 200, 200)
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end