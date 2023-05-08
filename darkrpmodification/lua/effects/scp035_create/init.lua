-- "addons\\scp_darkrpmod\\lua\\effects\\scp035_create\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	for i=1, 15 do
		local smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1, 9), self.Start + Vector(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-5, 5)))
		if smoke then
			smoke:SetVelocity(Vector(math.Rand(-25, 25), math.Rand(-25, 25), math.Rand(-25, 50)))
			smoke:SetDieTime(math.Rand(0.25, 1))
			smoke:SetStartAlpha(math.Rand(25, 100))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.Rand(10, 15))
			smoke:SetEndSize(math.Rand(30, 50))
			smoke:SetRoll(0)
			smoke:SetRollDelta(0)
			smoke:SetColor(i, 0, 0)
			smoke:SetGravity(Vector(0, 0, math.Rand(-75, -150)))
		end
	end
	for i=1, 40 do
		local comp = self.Emitter:Add("particle/particle_composite", self.Start + Vector(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-5, 5)))
		if comp then
			comp:SetVelocity(Vector(math.Rand(-30, 30), math.Rand(-30, 30), math.Rand(-25, 50)))
			comp:SetDieTime(math.Rand(0.25, 1))
			comp:SetStartAlpha(math.Rand(25, 100))
			comp:SetEndAlpha(0)
			comp:SetStartSize(math.Rand(10, 15))
			comp:SetEndSize(math.Rand(25, 50))
			comp:SetRoll(0)
			comp:SetRollDelta(0)
			comp:SetColor(i, 0, 0)
			comp:SetGravity(Vector(0, 0, math.Rand(-75, -150)))
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end