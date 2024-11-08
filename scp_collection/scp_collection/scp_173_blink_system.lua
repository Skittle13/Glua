if SERVER then

util.AddNetworkString("SCP_Collection:Blink")
util.AddNetworkString("")

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

function GetSCP_173()
    local to_return

    for i,v in pairs(player.GetAll()) do
        if v:HasWeapon("scp_173") then 
            to_return = v
        end
    end

    return to_return
end

SCP_Collection_Blink_Data = {}
SCP_Collection_Blink_Data_CanNotSee = {}

function SCP_173_GetWatched()
    local to_return = false
    local scp_173 = GetSCP_173()

    if not scp_173 then return false end

    for i,v in pairs(player.GetAll()) do
        if v == scp_173 then continue end
        if SCP_Collection_Blink_Data_CanNotSee[v] or SCP_Collection_Blink_Data_CanNotSee[v] == nil then continue end 
        if v:CanSeePly(scp_173) then
            to_return = true
        end
    end

    return to_return
end

local LastTimeChecked = CurTime()
hook.Add("Think","SCP_Collection_Blink_Think",function()
    if CurTime() < LastTimeChecked + 0.15 then return end -- I don't want to loop though every player the entire time

    local Players = player.GetAll()
    local scp_173 = GetSCP_173()

    if not scp_173 then return end
    local to_blink = {}
    for i,v in pairs(Players) do
        if v:HasWeapon("scp_173") then continue end
        if v:GetPos():Distance(scp_173:GetPos()) > 750 then continue end
        if not SCP_Collection_Blink_Data[v] then SCP_Collection_Blink_Data[v] = CurTime() to_blink[#to_blink + 1] = v continue end
        if CurTime() > SCP_Collection_Blink_Data[v] + 15 then
            SCP_Collection_Blink_Data[v] = CurTime() to_blink[#to_blink + 1] = v
        end
    end

    net.Start("SCP_Collection:Blink")
    net.Send(to_blink)

    for i,v in pairs(to_blink) do
        SCP_Collection_Blink_Data_CanNotSee[v] = true

        timer.Simple(0.75,function()
            SCP_Collection_Blink_Data_CanNotSee[v] = false
        end)
    end


    print(SCP_173_GetWatched())
end)

end

if CLIENT then
    net.Receive("SCP_Collection:Blink",function()
        LocalPlayer():ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0, 255 ), 0.3, 0.1 )
        timer.Simple(0.35,function()
            LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 0.3, 0.1 )
        end)
    end)
end