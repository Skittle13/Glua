-- "addons\\scp_darkrpmod\\lua\\effects\\scp_dump\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	for i=1, 5 do
		local smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1, 9), self.Start + Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(15, 25)))
		if smoke then
			smoke:SetVelocity(Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(75, 100)))
			smoke:SetDieTime(math.Rand(0.5, 1))
			smoke:SetStartAlpha(math.Rand(25, 75))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.Rand(5, 10))
			smoke:SetEndSize(math.Rand(40, 50))
			smoke:SetRoll(math.Rand(-360, 360))
			smoke:SetRollDelta(0)
			smoke:SetColor(100, 100, 100)
			smoke:SetGravity(Vector(0, 0, math.Rand(-150, -200)))
		end
	end
	for i=1, 8 do
		local comp = self.Emitter:Add("particle/particle_composite", self.Start + Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(15, 25)))
		if comp then
			comp:SetVelocity(Vector(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(75, 100)))
			comp:SetDieTime(math.Rand(0.5, 1))
			comp:SetStartAlpha(math.Rand(25, 75))
			comp:SetEndAlpha(0)
			comp:SetStartSize(math.Rand(1, 5))
			comp:SetEndSize(math.Rand(50, 60))
			comp:SetRoll(math.Rand(-360, 360))
			comp:SetRollDelta(0)
			comp:SetColor(100, 100, 100)
			comp:SetGravity(Vector(0, 0, math.Rand(-150, -200)))
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end