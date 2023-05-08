-- "addons\\scp_darkrpmod\\lua\\effects\\scp999_heart\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local heart = Material("mg_scprp/scp999/heart.png")
function EFFECT:Init(data)
	local ent = data:GetEntity()
	if !IsValid(ent) then return end
	local emitter = ParticleEmitter(ent:GetPos())

	local particleLimit = math.random(10, 15)

	for i=1, particleLimit do
		timer.Simple(i * 0.1, function()
			if !IsValid(ent) then emitter:Finish() return end

			local heart = emitter:Add(heart, ent:GetPos() + Vector(math.Rand(-20, 20), math.Rand(-20, 20), 0))

			if heart then
				local dieTime = math.Rand(1.1, 1.25)
	
				heart:SetDieTime(dieTime)
				heart:SetStartAlpha(255)
				heart:SetEndAlpha(0)
				local size = math.Rand(2, 3)

				heart:SetStartSize(size)
				heart:SetEndSize(size * math.Rand(2, 2.5))
				heart:SetRoll(0)
				heart:SetRollDelta(0)
				heart:SetGravity(Vector(math.Rand(-25, 25), math.Rand(-25, 25), 100))
			end
			
			if i == particleLimit then
				emitter:Finish()
			end
		end)
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end