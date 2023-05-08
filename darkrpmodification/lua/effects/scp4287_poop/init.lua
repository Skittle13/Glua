-- "addons\\scp_darkrpmod\\lua\\effects\\scp4287_poop\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
for i=1, 4 do
	local mat = CreateMaterial("mg_scp4287_poop_"..i, "UnlitGeneric", {
		["$basetexture"] = "decals/decal_birdpoop00"..i,
		["$translucent"] = 1,
	})
end

function EFFECT:Init(data)
	local ply = data:GetEntity()
	if !IsValid(ply) then return end
	local pos = ply:GetPos()

	local strength = data:GetRadius()
	local emitter = ParticleEmitter(pos)
	local velocity = ply:GetVelocity()

	local particle = emitter:Add("!mg_scp4287_poop_"..math.random(1, 4), pos)
	if particle then
		local size = math.Rand(4, 6) 

		particle:SetDieTime(math.Rand(4, 8))
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetStartSize(size)
		particle:SetEndSize(size)
		particle:SetVelocity(velocity * 0.2 + Vector(strength, strength, 0))
		particle:SetRoll(math.Rand(-360, 360))
		particle:SetRollDelta(math.Rand(-5, 5))
		particle:SetGravity(Vector(0, 0, -400))
		particle:SetAirResistance(-50)
		particle:SetCollide(true)
		particle:SetCollideCallback(function(part, hitpos, hitnormal)
			if part.Decal then return end
			part.Decal = true
			part:SetDieTime(0)

			util.Decal("BirdPoop", hitpos + hitnormal, hitpos - hitnormal, {part, ply})
		end)
	end
	emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end