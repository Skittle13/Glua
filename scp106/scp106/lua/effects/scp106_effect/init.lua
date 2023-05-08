

function EFFECT:Init( data )
    local origin = data:GetOrigin()
    local angle = data:GetAngles()
    local ent = data:GetEntity()

    local alpha = 255

    if ent and ent:IsValid() then
        if not ent:IsPlayer() then 
            alpha = 40 
        end 
    end

    local emitter = ParticleEmitter( origin, false )

    for i = 0, 10 do 
        local smokemat = Material("particle/smokesprites_000"..math.random(1,9))
        local part = emitter:Add( smokemat, origin )

        if part then 
            part:SetDieTime( math.Rand(2, 5) )

            part:SetStartAlpha( alpha )
            part:SetEndAlpha( 0 )

            part:SetAngles(angle)
            part:SetVelocity( Vector(math.Rand(-1, 1) * 10, math.Rand(-1, 1) * 10, math.Rand(0, 1) * 25) )

            part:SetStartSize( math.Rand(10, 20) )
            part:SetEndSize( math.Rand(30, 40) )

            part:SetCollide( true )
            part:SetBounce( 0.5 )

            part:SetColor(0,0,0)
            
        end 
    end 

    for i=0,100 do
		local mat = Material("particle/warp1_warp")
		local part = emitter:Add( mat, origin)
		if part then
			part:SetAngles( angle  )
			part:SetVelocity( Vector(math.Rand(-1, 1) * 10, math.Rand(-1, 1) * 10, math.Rand(0, 1) * 25) )
            
			part:SetDieTime( math.Rand(2, 4) )

			part:SetStartAlpha( alpha )
			part:SetEndAlpha( 0 )

			part:SetStartSize( math.Rand(1, 2) )
			part:SetEndSize( math.Rand(1, 4) )

			part:SetCollide(true)
			part:SetBounce(1)

			part:SetRollDelta(math.Rand(-10, 10))
			part:SetColor(0,0,0)
		end
	end
    emitter:Finish()
end 

function EFFECT:Think()
    return false
end

function EFFECT:Render()
end