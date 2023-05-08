-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\doorsetup\\cl_doorsetup.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MG_DamagedDoors = MG_DamagedDoors or {}

local function CreateEffect()
	timer.Create("MG_DamagedDoors_Effect", 2.5, 0, function()
		if !table.IsEmpty(MG_DamagedDoors) then
			local curTime = CurTime()
			for k, v in pairs(MG_DamagedDoors) do
				if !IsValid(k) then
					MG_DamagedDoors[k] = nil
					continue
				end
				local pos = k:LocalToWorld(k:OBBCenter())
				if MG_GetCamPos():DistToSqr(pos) > 250000 then continue end

				if curTime >= math.max(v[1], v[2]) then
					MG_DamagedDoors[k] = nil
					continue
				end
				
				local blocked = false
				if curTime <= v[1] then
					k:EmitSound("ambient/energy/spark"..math.random(1, 5)..".wav", 60, nil, 0.25)
					blocked = true
				end

				pos = pos + VectorRand() * 25
				local emitter = ParticleEmitter(pos)
				for i = 0, math.random(4, 10) do
					local part = emitter:Add("effects/spark", pos)
					if part then
						part:SetDieTime(1)
						part:SetStartAlpha(255)
						part:SetEndAlpha(255)
						part:SetStartSize(1)
						part:SetEndSize(0)
						if blocked then
							part:SetColor(0, 191, 255)
						end
						part:SetGravity(Vector(0, 0, -200))
						part:SetVelocity(VectorRand() * 40)
						part:SetCollide(true)
						part:SetBounce(0.4)
						part:SetStartLength(0.05)
						part:SetEndLength(0)
						part:SetVelocityScale(true)
					end
				end
				emitter:Finish()
			end
		else
			timer.Remove("MG_DamagedDoors_Effect")
		end
	end)
end

net.Receive("MG_DamagedDoors_Network", function()
	local ent = net.ReadEntity()
	local tmr1 = net.ReadUInt(32)
	local tmr2 = net.ReadUInt(32)
	
	MG_DamagedDoors[ent] = {tmr1, tmr2}

	CreateEffect()
end)