if SERVER then
    util.AddNetworkString("SCP_939_LAYEGG")
    util.AddNetworkString("939_SendDoorOpen")

    SCP_Collection_SCP_939 = {}
    SCP_Collection_SCP_939_Think = {}
    net.Receive("SCP_939_LAYEGG",function(len,ply)
        if not (ply:Frags() >= 5) then return end
        local pos = ply:GetPos()
        if IsValid(SCP_Collection_SCP_939[ply:SteamID()]) then
            SCP_Collection_SCP_939[ply:SteamID()]:Remove()
        end
        
        SCP_Collection_SCP_939[ply:SteamID()] = ents.Create("939egg")
        SCP_Collection_SCP_939[ply:SteamID()]:SetPos( ply:GetPos() )
        SCP_Collection_SCP_939[ply:SteamID()]:Spawn()

        ply:SetFrags(0)
    end)

    hook.Add("PlayerSpawn","Spawn-At-EGG",function(victim, transition )
        if IsValid(SCP_Collection_SCP_939[victim:SteamID()]) then
            timer.Simple(0.1,function()
                victim:SetPos(SCP_Collection_SCP_939[victim:SteamID()]:GetPos())
                SCP_Collection_SCP_939_Think[victim] = {CurTime(),victim:GetModelScale()}
                timer.Simple(0.1,function()
                    SCP_Collection_SCP_939[victim:SteamID()]:Remove()
                end)
            end)
        end
    end)

    hook.Add("OnPlayerChangedTeam","Destroy-on-job-change",function(ply,team)
        ply:SetFrags(0)
        if IsValid(SCP_Collection_SCP_939[ply:SteamID()]) then
            SCP_Collection_SCP_939[ply:SteamID()]:Remove()
            SCP_Collection_SCP_939[ply:SteamID()] = nil
        end
    end)

    hook.Add("Think","Think-SCP-939",function()
            for i,v in pairs(SCP_Collection_SCP_939_Think) do
                local value = (CurTime()-v[1]) / 15
                local cvalue = math.Clamp(value,.5,v[2])
                local cvalue = cvalue * 1
                
                i:SetModelScale(cvalue,0.00001)
            end
    end)

    function GetPlayersWith939()
        local to_return = {}
        for i,v in pairs(player.GetAll()) do
            if v:HasWeapon("scp_939") then
                table.insert(to_return,v)
            end
        end
        return to_return
    end
        
    hook.Add( "PlayerUse", "939_SendDoorOpen", function( ply, ent )
        if ent:GetClass() == "func_door" or ent:GetClass() == "func_button" or ent:GetClass() == "prop_door_rotating" then
    
        local to_return = {}
        for i,v in pairs(ents.FindInSphere(ent:GetPos(),50)) do
            if v:GetClass() == "prop_dynamic" then table.insert(to_return,v) end
        end
    
        net.Start("939_SendDoorOpen")
        net.WriteTable(to_return)
        net.Send(GetPlayersWith939())
        end
    end)
end

if CLIENT then
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
    
end