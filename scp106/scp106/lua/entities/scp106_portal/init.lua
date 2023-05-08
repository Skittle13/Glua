AddCSLuaFile( "cl_init.lua" ) -- Make sure clientside
AddCSLuaFile( "shared.lua" )  -- and shared scripts are sent.
 
include("shared.lua")
 
function ENT:Initialize()

    self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
    
    self:SetCollisionGroup( COLLISION_GROUP_WORLD )



    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

local plys = player.GetAll()

function ENT:Think()
    for k, v in ipairs(plys) do 
        if not IsValid(v) then continue end 
        if v:Team() == TEAM_106 then continue end

        if v:GetPos():Distance(self:GetPos()) <= 50 then 
            SendPlayerToPocketDimension(v)
        end 
    end 
end 