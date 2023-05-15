function EFFECT:Init( data )
	local vOffset = data:GetOrigin()
	local vAngle = data:GetAngles()
	local emitter = ParticleEmitter( vOffset, false )

		for i=0,5 do
			local mat = Material("particle/smokesprites_000"..math.random(1,9))
			local particle = emitter:Add( mat, vOffset + Vector(math.Rand(-1, 1) * 5, math.Rand(-1, 1) * 5, math.random(5, 30)))
			if particle then
				particle:SetAngles( vAngle )
				particle:SetVelocity( Vector(0, 0, 0) )
				particle:SetDieTime( 6 )
				particle:SetStartAlpha( 75 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(20, 40) )
				particle:SetEndSize( math.Rand(20, 40) )
				particle:SetCollide(true)
				particle:SetColor(130, 40, 40)
				particle:SetGravity(Vector(0, 0, 0))
			end
		end
		for i=0,50 do
			local mat = Material("effects/fleck_cement"..math.random(1,2))
			local particle = emitter:Add( mat, vOffset + Vector(math.random(5, 15), math.random(5, 15), math.random(5, 30)))
			if particle then
				particle:SetAngles( vAngle )
				particle:SetVelocity( Vector(math.Rand(-1, 1) * 15, math.Rand(-1, 1) * 15, math.Rand(-1, 1) * 15) )
				particle:SetDieTime( 3 )
				particle:SetStartAlpha( 100 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 1 )
				particle:SetEndSize( 0 )
				particle:SetCollide(true)
				particle:SetColor(130, 40, 40)
				particle:SetGravity(Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(-10, 10)))
			end
		end
		for i=0,50 do
			local mat = Material("particles/flamelet"..math.random(1,5))
			local particle = emitter:Add( mat, vOffset + Vector(math.random(5, 15), math.random(5, 15), math.random(5, 30)))
			if particle then
				particle:SetAngles( vAngle )
				particle:SetVelocity( Vector(math.Rand(-1, 1) * 15, math.Rand(-1, 1) * 15, math.Rand(-1, 1) * 15) )
				particle:SetDieTime( 3 )
				particle:SetStartAlpha( 100 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( 1 )
				particle:SetEndSize( 0 )
				particle:SetCollide(true)
				particle:SetColor(130, 40, 40)
				particle:SetGravity(Vector(math.Rand(-10, 10), math.Rand(-10, 10), math.Rand(-10, 10)))
			end
		end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end