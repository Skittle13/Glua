-- Do not touch anything below here unless you know what you are doing. Trust me, it's better. 

--Fonts
surface.CreateFont( "HexAmnestics.Title", { 
    font = "Bauhaus Md BT", 
    size = 65, 
    weight = 10,
    italic = true, 
} )
surface.CreateFont( "HexAmnestics.SubTitle", { 
    font = "Bauhaus Md BT", 
    size = 35, 
    weight = 10,
    italic = true, 
} )
net.Receive("HCS.Amnestic.Sending", function()
    local typ = net.ReadString() 
    local amnestic = HexSh.Config["src_amnestic"].AMNESTICLEVELS

    if not amnestic[typ] then return end

    local message = amnestic[typ].message 

    local BlurDuration = amnestic[typ].time or 0 -- How long the blur effect lasts
    local BlurIntensity = amnestic[typ].BlurIntensity 

    hook.Add("RenderScreenspaceEffects", "HCS.Amnestic.Blur", function()
        DrawMotionBlur(BlurIntensity.AddAlpha,BlurIntensity.DrawAlpha,BlurIntensity.Delay)

        draw.SimpleTextOutlined(HexSh:L("src_amnestic", "goInjected"), "HexAmnestics.Title", HexSh:toDecimal( 50 ) * ScrW(), HexSh:toDecimal( 50 ) * ScrH() - 60, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255) )
        draw.SimpleTextOutlined(message, "HexAmnestics.SubTitle", HexSh:toDecimal( 50 ) * ScrW(), HexSh:toDecimal( 50 ) * ScrH(), Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0,255) )
    end)

    timer.Simple(BlurDuration, function()
        hook.Remove("RenderScreenspaceEffects", "HCS.Amnestic.Blur")
    end)
end)

net.Receive("HCS.Amnestic.Swap", function(len,ply)
    local wpn = LocalPlayer():GetActiveWeapon()
    if(not IsValid(wpn) or wpn:GetClass() ~= "weapon_amnestic") then return end
    local newAmnestic = net.ReadString()

    wpn.AmnesticType = newAmnestic
end)
