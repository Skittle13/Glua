include("shared.lua")

net.Receive("SCP.GetSounds", function()
	local ent = net.ReadEntity()
	ent.LastSound = CurTime()
end)


local tab = {}
tab[ "$pp_colour_addr" ] = 0
tab[ "$pp_colour_addg" ] = 0
tab[ "$pp_colour_addb" ] = 0
tab[ "$pp_colour_brightness" ] = 0
tab[ "$pp_colour_contrast" ] = 0.8
tab[ "$pp_colour_colour" ] = 0
tab[ "$pp_colour_mulr" ] = 0
tab[ "$pp_colour_mulg" ] = 0
tab[ "$pp_colour_mulb" ] = 0

function SWEP:RenderScreenspaceEffects()
	DrawMotionBlur(0.1, 0.5, 0.01)
	DrawColorModify(tab)
end

local plys = {}
local nextUpdate = 0

function SWEP:PreDrawHalos()
	local owner = self.Owner
	
	if nextUpdate <= CurTime() then
		nextUpdate = CurTime() + 1
		plys = player.GetAll()
	end

	for k, v in ipairs(plys) do
		if !v or !IsValid(v) then continue end
		if v == owner then continue end
		if v:IsDormant() then continue end
		if v:GetNoDraw() then continue end
		if v:IsKnocked() then continue end
		if owner:GetPos():DistToSqr(v:GetPos()) > 2600000 then continue end
		local col = Color(255, 0, 0, 255)
		halo.Add({v}, col, 2, 2, 1, true, false)
	end
end

function SWEP:CheckVisPlayer()
	local owner = self.Owner

	if nextUpdate <= CurTime() then
		nextUpdate = CurTime() + 1
		plys = player.GetAll()
	end

	for k, v in ipairs(plys) do
		if !IsValid(v) or v:IsDormant() or v == owner then continue end
		

		local moving = false

		if v:GetVelocity():LengthSqr() > 2700 or CurTime() - (v.LastSound or 0) < 1.5 then
			moving = true
			v:SetNoDraw(false)
		else
			v:SetNoDraw(true)
		end

		if !moving then
			local ActiveWeapon = v:GetActiveWeapon()
	        if ActiveWeapon:IsValid() then
	            ActiveWeapon:SetNoDraw(true)

	            if ActiveWeapon.dt and IsValid(ActiveWeapon.dt.Shield) then
	            	ActiveWeapon.dt.Shield:SetNoDraw(true)
	            end

	            if ActiveWeapon:GetClass() == "weapon_physgun" then
	                for a,b in ipairs(ents.FindByClass("physgun_beam")) do
	                    if b:GetParent() == v then
	                        b:SetNoDraw(true)
	                    end
	                end
	            end
	        end
	    else
	    	local ActiveWeapon = v:GetActiveWeapon()
	        if ActiveWeapon:IsValid() then
	            ActiveWeapon:SetNoDraw(false)

	            if ActiveWeapon.dt and IsValid(ActiveWeapon.dt.Shield) then
	            	ActiveWeapon.dt.Shield:SetNoDraw(false)
	            end
	        end
		end
	end
end

function SWEP:Think()
	self:CheckVisPlayer()
end