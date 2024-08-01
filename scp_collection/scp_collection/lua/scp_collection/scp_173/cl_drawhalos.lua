PlayerToDrawHalos = {}

net.Receive("SCP_Collection:SendWatchers",function()
    PlayerToDrawHalos = net.ReadTable()
end)

hook.Add( "PreDrawHalos", "173Halo", function()
    if not LocalPlayer():HasWeapon("scp_173") then return end

    local localplayer = LocalPlayer()
    PrintTable(PlayerToDrawHalos)

    local CanSee = {}
    local CantSee = {}

    for i,v in pairs(player.GetAll()) do
        if v == localplayer then continue end 
        if not LocalPlayer():IsLineOfSightClear(v) then continue end
        if PlayerToDrawHalos[v] then table.insert(CanSee,v) print("cool") continue end
        table.insert(CantSee,v) 
    end
    halo.Add(CanSee,  Color( 255, 56, 56), 0, 0, 5, true, true)	

    halo.Add(CantSee,  Color( 0, 255, 0), 0, 0, 5, true, true)	
end)