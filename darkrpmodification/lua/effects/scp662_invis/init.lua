-- "addons\\scp_darkrpmod\\lua\\effects\\scp662_invis\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	for i=1, 100 do
		local p = self.Emitter:Add("particle/warp1_warp", self.Start + VectorRand() * math.Rand(-10, 10))
		if p then
			p:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			p:SetAngleVelocity(Angle(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-5, 5)))
			p:SetCollide(true)
			p:SetDieTime(math.Rand(2, 4))
			p:SetEndAlpha(0)
			p:SetStartAlpha(255)
			p:SetStartSize(25)
			p:SetEndSize(25)
			p:SetVelocity(Vector(math.Rand(-20, 20), math.Rand(-20, 20), math.Rand(-15, 20)))
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end