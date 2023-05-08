	
include('shared.lua')

ENT.Effect = nil
ENT.NextEmit = 0

function ENT:OnRemove()
	if IsValid(self.Effect) then
		self.Effect:Finish()
	end
end

local local_ply
function ENT:Think()
	local_ply = local_ply or LocalPlayer()
	if local_ply:GetPos():DistToSqr(self:GetPos()) > 2600000 then return end

	local tb = self:GetTable()

	if CurTime() > tb.NextEmit then
		tb.NextEmit = CurTime() + 0.1

		tb.Effect = tb.Effect or ParticleEmitter(self:GetPos(), false)
		if !IsValid(tb.Effect) then return end

		for i=0,3 do
			local mat = Material("particle/smokesprites_000"..math.random(1,9))
			local particle = tb.Effect:Add(mat, self:GetPos() + Vector(math.Rand(-25, 25), math.Rand(-25, 25), 2))
			if particle then
				particle:SetAngles( Angle(math.Rand(-180, 180), math.Rand(-180, 180)) )
				particle:SetVelocity( Vector(math.Rand(-2, 2), math.Rand(-2, 2), math.Rand(-2, 15)) )
				particle:SetDieTime( 5 )
				particle:SetStartAlpha( 180 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(10, 20) )
				particle:SetEndSize( math.Rand(2, 5) )
				particle:SetCollide(true)
				particle:SetBounce(1)
				particle:SetColor(0,0,0)
			end
		end

		for i=0,10 do
			local mat = Material("particle/warp1_warp")
			local particle = tb.Effect:Add( mat, self:GetPos())
			if particle then
				particle:SetAngles( Angle(180,180) )
				particle:SetVelocity( Vector(math.Rand(-1, 1) * 10, math.Rand(-1, 1) * 10, math.Rand(0, 1) * 25) )
				particle:SetDieTime( math.Rand(2, 4) )
				particle:SetStartAlpha( 60 )
				particle:SetEndAlpha( 0 )
				particle:SetStartSize( math.Rand(1, 2) )
				particle:SetEndSize( 1 )
				particle:SetCollide(true)
				particle:SetBounce(1)
				particle:SetColor(0,0,0)
			end
		end
	end
end

function ENT:Draw()
    
end