-- "addons\\scp_darkrpmod\\lua\\effects\\scp_foamspray.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	local tb = self:GetTable()

	tb.Origin = data:GetOrigin()
	tb.Forward = data:GetNormal()
	tb.Scale = data:GetScale()

	tb.Angle = tb.Forward:Angle()

	local teh_effect = ParticleEmitter(tb.Origin, true)
	if !teh_effect then return end

	for i = 1, 12 * tb.Scale do
		local particle = teh_effect:Add("effects/splash4", tb.Origin)
		if particle then
			local Spread = 0.3

			particle:SetVelocity((Vector(math.sin(math.Rand(0, 360)) * math.Rand(-Spread, Spread), math.cos(math.Rand(0, 360)) * math.Rand(-Spread, Spread), math.sin(math.random()) * math.Rand(-Spread, Spread)) + self.Forward) * 750)

			local ang = tb.Angle
			if (i / 2 == math.floor(i / 2)) then
				ang = (tb.Forward * -1):Angle()
			end

			particle:SetAngles(ang)
			particle:SetDieTime(0.25)
			particle:SetColor(255, 255, 255)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(8)
			particle:SetEndSize(0)
			particle:SetCollide(1)
			particle:SetCollideCallback(function(particleC, HitPos, normal)
				particleC:SetAngleVelocity(angle_zero)
				particleC:SetVelocity(vector_origin)
				particleC:SetPos(HitPos + normal * 0.1)
				particleC:SetGravity(vector_origin)

				local angles = normal:Angle()
				angles:RotateAroundAxis(normal, math.Rand(-360, 360))
				particleC:SetAngles(angles)

				particleC:SetLifeTime(0)
				particleC:SetDieTime(math.Rand(4, 6))
				particleC:SetStartSize(8)
				particleC:SetEndSize(8)
				particleC:SetStartAlpha(128)
				particleC:SetEndAlpha(0)
			end)
		end
	end

	teh_effect:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end