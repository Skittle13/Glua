include("shared.lua")

surface.CreateFont("WeaponHUDFont1", {
    font = "Roboto", 
    size = 20, 
    weight = 500,
})



function SWEP:DrawHUD()
    local owner = self:GetOwner()
    local dt = self.dt 

    local color_black = Color(0, 0, 0, 255)
    local color_white = Color(255, 255, 255, 255)

    if not IsValid(owner) then return end

    local trace = LPlayerTrace({
        start = owner:GetShootPos(),
        endpos = owner:GetShootPos() + owner:GetAimVector() * 58,
        filter = owner,
    })

    local ent = trace.Entity

    if IsValid(ent) and (ent:IsPlayer() or ent:GetClass() == "scp106_portal") then
        local text = "In die Pocket Dimension schicken"

        if ent:GetClass() == "scp106_portal" then
            text = "Portal schließen"
        end

        if CurTime() < dt.NextAttack then 
            draw.SimpleTextOutlined("[Linksklick] " .. text .. " (" .. string.ToMinutesSeconds(dt.NextAttack - CurTime()) .. ")", "WeaponHUDFont1", ScrW() / 2, ScrH() - 120, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
        else
            draw.SimpleTextOutlined("[Linksklick] " .. text, "WeaponHUDFont1", ScrW() / 2, ScrH() - 120, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
        end

    end

    if CurTime() < dt.PortalTimeForNextPortal then 
        draw.SimpleTextOutlined("[Rechtsklick] Portal setzen (" .. string.ToMinutesSeconds(dt.PortalTimeForNextPortal - CurTime()) .. ")", "WeaponHUDFont1", ScrW() / 2, ScrH() - 100, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    else
        draw.SimpleTextOutlined("[Rechtsklick] Portal setzen", "WeaponHUDFont1", ScrW() / 2, ScrH() - 100, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    end
end 

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

local canLasUse = 0
function SWEP:Reload()
    if not CLIENT then return end 
    if CurTime() < canLasUse then return end
    canLasUse = CurTime() + 0.5

    local mainframe = vgui.Create("DFrame")
    mainframe:SetSize(300, 700)
    mainframe:Center()
    mainframe:SetDraggable(true)
    mainframe:ShowCloseButton(false)
    mainframe:SetTitle("")
    mainframe:MakePopup()
    mainframe.Paint = function(self, w, h)
        draw.RoundedBox(5, 0, 0, w, h, Color(0, 0, 0, 250))
        draw.RoundedBox(5, 0, 0, w, 20, Color(102, 46, 46, 250))
        draw.SimpleText("Pocket Dimension", "EdgeHUD:Small", 6, 11, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        
    end

    local closebutton = vgui.Create("DButton", mainframe)
    closebutton:SetSize(20, 20)
    closebutton:SetPos(mainframe:GetWide() - 20, 0)
    closebutton:SetText("")
    closebutton.Paint = function(self, w, h)
        if not self:IsHovered() then 
            draw.SimpleText("r", "Marlett", w / 2, h / 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else 
            draw.SimpleText("r", "Marlett", w / 2, h / 2, Color(233, 16, 16), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
    closebutton.DoClick = function()
        mainframe:Remove()
    end

    local enterpocket = mainframe:Add( "DButton" )
    enterpocket:Dock( TOP )
    enterpocket:DockMargin( 0, 0, 0, 5 )
    enterpocket:SetText( "" )
    enterpocket.Paint = function(self,w,h)
        

        if not self:IsHovered() then 
            draw.SimpleText( "Die Pocket Dimension betreten", "EdgeHUD:Small", (w/2), 11, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            draw.RoundedBox(0, 0, h - 2, w, 2, Color(255, 255, 255, 255))
            draw.RoundedBox(0, 0, 0, w, 2, Color(255, 255, 255, 255))
            draw.RoundedBox(0, 0, 0, 2, h, Color(255, 255, 255, 255))
            draw.RoundedBox(0, w - 2, 0, 2, h, Color(255, 255, 255, 255))
        else 
            draw.SimpleText( "Die Pocket Dimension betreten", "EdgeHUD:Small", (w/2), 11, Color(16, 233, 16), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            draw.RoundedBox(0, 0, h - 2, w, 2, Color(16, 233, 16))
            draw.RoundedBox(0, 0, 0, w, 2, Color(16, 233, 16))
            draw.RoundedBox(0, 0, 0, 2, h, Color(16, 233, 16))
            draw.RoundedBox(0, w - 2, 0, 2, h, Color(16, 233, 16))
        end

        
    end
    enterpocket.DoClick = function()
        net.Start("TeleportToPocketDimension")
            net.WriteBool(false)
        net.SendToServer()

        mainframe:Remove()
    end

    local exitpocket = mainframe:Add( "DButton" )
    exitpocket:Dock( TOP )
    exitpocket:DockMargin( 0, 0, 0, 5 )
    exitpocket:SetText( "" )
    exitpocket.Paint = function(self,w,h)
        if not self:IsHovered() then 
            draw.SimpleText( "Die Pocket Dimension verlassen", "EdgeHUD:Small", (w/2), 11, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            draw.RoundedBox(0, 0, h - 2, w, 2, Color(255, 255, 255, 255))
            draw.RoundedBox(0, 0, 0, w, 2, Color(255, 255, 255, 255))
            draw.RoundedBox(0, 0, 0, 2, h, Color(255, 255, 255, 255))
            draw.RoundedBox(0, w - 2, 0, 2, h, Color(255, 255, 255, 255))
        else 
            draw.SimpleText( "Die Pocket Dimension verlassen", "EdgeHUD:Small", (w/2), 11, Color(233, 16, 16), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
            draw.RoundedBox(0, 0, h - 2, w, 2, Color(233, 16, 16))
            draw.RoundedBox(0, 0, 0, w, 2, Color(233, 16, 16))
            draw.RoundedBox(0, 0, 0, 2, h, Color(233, 16, 16))
            draw.RoundedBox(0, w - 2, 0, 2, h, Color(233, 16, 16))
        end
    end
    exitpocket.DoClick = function()
        net.Start("TeleportToPocketDimension")
            net.WriteBool(true)
        net.SendToServer()

        mainframe:Remove()
    end

    for i, v in ipairs( ents.FindByClass("scp106_portal") ) do
        local button = mainframe:Add( "DButton" )
        button:Dock( TOP )
        button:DockMargin( 0, 0, 0, 5 )
        button:SetText( "" )
        button.Paint = function(self,w,h)
            if !IsValid(v) then return end

            if not self:IsHovered() then 
                draw.SimpleText( "Portal " .. i, "EdgeHUD:Small", (w/2), 11, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                draw.RoundedBox(0, 0, h - 2, w, 2, Color(255, 255, 255, 255))
                draw.RoundedBox(0, 0, 0, w, 2, Color(255, 255, 255, 255))
                draw.RoundedBox(0, 0, 0, 2, h, Color(255, 255, 255, 255))
                draw.RoundedBox(0, w - 2, 0, 2, h, Color(255, 255, 255, 255))
            else 
                draw.SimpleText( "Portal " .. i, "EdgeHUD:Small", (w/2), 11, Color(233, 16, 16), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
                draw.RoundedBox(0, 0, h - 2, w, 2, Color(233, 16, 16))
                draw.RoundedBox(0, 0, 0, w, 2, Color(233, 16, 16))
                draw.RoundedBox(0, 0, 0, 2, h, Color(233, 16, 16))
                draw.RoundedBox(0, w - 2, 0, 2, h, Color(233, 16, 16))
            end
        end
        button.DoClick = function()
            if !IsValid(v) then return end
            net.Start("TeleportToPortals")
                net.WriteEntity(v)
            net.SendToServer()

            mainframe:Remove()
        end
    end

    mainframe:InvalidateLayout( true )
    mainframe:SizeToChildren( false, true )

end 