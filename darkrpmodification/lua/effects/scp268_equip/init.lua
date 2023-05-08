-- "addons\\scp_darkrpmod\\lua\\effects\\scp268_equip\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	self.Start = data:GetOrigin()
	self.Emitter = ParticleEmitter(self.Start)
	for i=1, 25 do
		local p = self.Emitter:Add("particle/warp1_warp", self.Start)
		if p then
			p:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			p:SetAngleVelocity(Angle(math.Rand(-5, 5), math.Rand(-5, 5), math.Rand(-5, 5)))
			p:SetCollide(true)
			p:SetDieTime(math.Rand(1, 1.5))
			p:SetEndAlpha(255)
			p:SetStartAlpha(255)
			p:SetStartSize(10)
			p:SetEndSize(0)
			p:SetVelocity(Vector(math.Rand(-30, 30), math.Rand(-30, 30), math.Rand(-30, 30)))
		end
	end
	self.Emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end