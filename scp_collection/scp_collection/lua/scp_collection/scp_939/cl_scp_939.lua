local meta = FindMetaTable("Player")

meta.GetPlayersInView = function(self,check_line_of_sight)
    local to_return = {}
    local Players = player.GetAll()
    local check_line_of_sight = check_line_of_sight or false
    for i=1,#Players do
        local to_check = Players[i]
        if to_check != self then
            local isVisible = to_check:GetPos():ToScreen().visible
            
            if (isVisible and not check_line_of_sight) or (isVisible and self:IsLineOfSightClear(to_check)) then table.insert(to_return,to_check) end
        end
    end
    return to_return
end

function meta:IsInView(check_line_of_sight)
    local to_return = nil

    local isVisible = self:GetPos():ToScreen().visible        
    if (isVisible and not check_line_of_sight) or (isVisible and LocalPlayer():IsLineOfSightClear(self)) then 
        to_return = to_check 
    end

    return to_return
end

local Render_settings = {
    [1] = {
        ["$pp_colour_brightness"] = -0.1,
        ["$pp_colour_contrast"] = .2,
        ["$pp_colour_colour"] = 0
    },
    [2] = {
        ["$pp_colour_brightness"] = -0,
        ["$pp_colour_contrast"] = 1,
        ["$pp_colour_colour"] = 1
    }
}

hook.Add( "RenderScreenspaceEffects", "939SobelAndStuff", function()
    if (LocalPlayer():HasWeapon("scp_939")) then
        DrawColorModify(Render_settings[1])
        DrawSobel( 1 )
    else
        DrawColorModify( Render_settings[2] )
        DrawSobel( 1000 )
    end
end )


DrawHoloDoors = {}
net.Receive("939_SendDoorOpen",function()
    local entity = net.ReadTable()
    for i,v in pairs(entity) do
        DrawHoloDoors[v] = true
    end
    timer.Simple(2,function()
        for i,v in pairs(entity) do
            DrawHoloDoors[v] = nil
        end
    end)
end)

DrawStuff3d = {}
function CreateDot(ply,pos)
    if not DrawStuff3d[ply] then DrawStuff3d[ply] = {} end
    local distance = LocalPlayer():GetPos():Distance(ply:GetPos())
    if distance > 750 then return end
    if #DrawStuff3d[ply] >= 5 then return end
    if (DrawStuff3d[ply].LastAdded and DrawStuff3d[ply].LastAdded + .25 > CurTime()) then return end

    local Coool = CurTime()
    DrawStuff3d[ply].LastAdded = Coool
    table.insert(DrawStuff3d[ply],{pos,Coool})
    local i = #DrawStuff3d[ply]
    timer.Simple(1.5,function()
        for i,v in ipairs(DrawStuff3d[ply]) do
            if v[2] == Coool then
                table.remove(DrawStuff3d[ply],i) -- i know thats shit but... it fixed something
            end
        end
    end)
end 

hook.Add("DrawOverlay", "Draw-Dots", function()
    for k,ply in pairs(DrawStuff3d) do
        for i, dotinfo in pairs(ply) do
            if not dotinfo then continue end
            if type(dotinfo) == "number" then continue end
            local cool = dotinfo[1]:ToScreen()
            draw.RoundedBox(10,cool.x,cool.y,10,10,Color(255,0,0))            
        end
    end
end)


hook.Add("SetupWorldFog", "Draw-Fog", function()
    if not LocalPlayer():HasWeapon("scp_939") then return false end

    render.FogMode( MATERIAL_FOG_LINEAR )
    render.FogStart( 100)
    render.FogEnd( 300 )
    render.FogMaxDensity(1)

    render.FogColor( 0,0,0 )

    return true
    
end)


hook.Add( "PreDrawHalos", "939HaloEffect", function()
    if not LocalPlayer():HasWeapon("scp_939") then return end

    local localplayer = LocalPlayer()

    for key, ply in ipairs(localplayer:GetPlayersInView(true)) do
        ply:SetColor(Color(0,0,0))
        ply:SetRenderMode( RENDERMODE_TRANSCOLOR )
    end

    for i,v in pairs(localplayer:GetPlayersInView(true)) do
        CreateDot(v,v:GetPos())
    end
    local holotable = {}
    for i,v in pairs(DrawHoloDoors) do 
        local distance = LocalPlayer():GetPos():Distance(i:GetPos())
    if distance > 750 then continue end
        table.insert(holotable,i) 
    end

    halo.Add(holotable,  Color( 255, 0, 10), 5, 5, 5, true, true)	

end)