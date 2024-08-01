local meta = FindMetaTable("Player")

function meta:CanSeePly(ply)
    local directionAngCos = math.cos(math.pi / 3) 
    local aimVector = self:GetAimVector()
    local entVector = ply:GetPos() - self:GetShootPos() 
    local angCos = aimVector:Dot(entVector) / entVector:Length()
    if (angCos >= directionAngCos) then
        
        return self:IsLineOfSightClear(ply)
    end

    return false
end