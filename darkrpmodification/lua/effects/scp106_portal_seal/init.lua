-- "addons\\scp_darkrpmod\\lua\\effects\\scp106_portal_seal\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local emitter = ParticleEmitter(pos)
	for i=1, 100 do
		local p = emitter:Add("effects/fleck_cement"..math.random(1, 2), pos)
		if p then
			p:SetAngles(Angle(math.Rand(-180, 180), math.Rand(-180, 180), math.Rand(-180, 180)))
			p:SetAngleVelocity(Angle(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(-10, 10)))
			p:SetCollide(true)
			p:SetDieTime(math.Rand(12, 20))
			p:SetEndAlpha(0)
			p:SetStartAlpha(255)
			p:SetStartSize(math.Rand(2, 4))
			p:SetEndSize(0)
			p:SetVelocity(Vector(math.Rand(-100, 100), math.Rand(-100, 100), math.Rand(-100, 150)))
			p:SetGravity(Vector(0, 0, -math.Rand(200, 400)))
			p:SetAirResistance(50)
			p:SetBounce(0.4)
			p:SetColor(math.random(0, 25), 0, 0)
		end
	end
	for i=1, 100 do
		local c = emitter:Add("particle/smokesprites_000"..math.random(1, 9), pos)
		if c then
			c:SetDieTime(math.Rand(12, 20))
			c:SetStartAlpha(math.Rand(100, 155))
			c:SetEndAlpha(0)
			c:SetStartSize(math.Rand(16, 24))
			c:SetEndSize(math.Rand(32, 48))
			c:SetRoll(math.Rand(0, 360))
			c:SetRollDelta(math.Rand(-1, 1))
			c:SetAirResistance(100)
			c:SetVelocity(Vector(math.Rand(-125, 125), math.Rand(-125, 125), math.Rand(-125, 150)))
			c:SetGravity(Vector(0, 0, -math.Rand(100, 200)))
			c:SetCollide(true)
			c:SetBounce(1)
			c:SetColor(math.random(0, 25), 0, 0)
		end
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end