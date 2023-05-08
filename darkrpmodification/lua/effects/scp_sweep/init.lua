-- "addons\\scp_darkrpmod\\lua\\effects\\scp_sweep\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Normal = data:GetNormal()
	self.Emitter = ParticleEmitter(self.Start)
	for i=1, math.random(2, 4) do
		local smoke = self.Emitter:Add("particle/smokesprites_000"..math.random(1, 9), self.Start)
		if smoke then
			smoke:SetVelocity(VectorRand() * math.Rand(-50, 50) + (self.Normal * math.Rand(10, 50)))
			smoke:SetDieTime(math.Rand(0.5, 1.5))
			smoke:SetStartAlpha(math.Rand(30, 50))
			smoke:SetEndAlpha(0)
			smoke:SetStartSize(math.Rand(10, 15))
			smoke:SetEndSize(math.Rand(25, 30))
			smoke:SetRoll(math.Rand(-360, 360))
			smoke:SetRollDelta(math.Rand(-1, 1))
			smoke:SetColor(90, 60, 30)
			smoke:SetGravity(Vector(0, 0, math.Rand(-100, -150)))
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end