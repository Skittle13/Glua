-- "addons\\scp_darkrpmod\\lua\\effects\\scp106_erode\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local emitter = ParticleEmitter(pos)
	for i=1, 100 do
		local p = emitter:Add("effects/fleck_cement"..math.random(1, 2), pos + VectorRand() * math.Rand(-10, 10))
		if p then
			p:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			p:SetAngleVelocity(Angle(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(-10, 10)))
			p:SetCollide(true)
			p:SetDieTime(math.Rand(12, 16))
			p:SetEndAlpha(0)
			p:SetStartAlpha(255)
			p:SetStartSize(math.Rand(1, 4))
			p:SetEndSize(0)
			p:SetVelocity(Vector(math.Rand(-75, 75), math.Rand(-75, 75), math.Rand(-75, 150)))
			p:SetGravity(Vector(0, 0, -math.Rand(200, 400)))
			p:SetAirResistance(50)
			p:SetBounce(0.4)
			p:SetColor(0, 0, 0)
		end
	end
	for i=1, 75 do
		local c = emitter:Add("particle/smokesprites_000"..math.random(1, 9), pos + VectorRand() * math.Rand(-10, 10))
		if c then
			c:SetDieTime(math.Rand(6, 10))
			c:SetStartAlpha(math.Rand(100, 155))
			c:SetEndAlpha(0)
			c:SetStartSize(math.Rand(8, 12))
			c:SetEndSize(math.Rand(32, 48))
			c:SetRoll(math.Rand(0, 360))
			c:SetRollDelta(math.Rand(-1, 1))
			c:SetAirResistance(150)
			c:SetVelocity(Vector(math.Rand(-75, 75), math.Rand(-75, 75), math.Rand(-150, 150)))
			c:SetGravity(Vector(0, 0, -math.Rand(100, 200)))
			c:SetCollide(true)
			c:SetBounce(0.4)
			c:SetColor(0, 0, 0)
		end
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end