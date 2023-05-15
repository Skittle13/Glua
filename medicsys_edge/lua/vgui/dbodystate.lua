local PANEL = {}

function PANEL:Init()
    self:SetSize(200, 152)
    self:SetPos(MedConfig.StatePosition[1], MedConfig.StatePosition[2])
end

local info = {
    {
        Header = "Head",
    },
    {
        Header = "Chest",
    },
    {
        Header = "Arms",
    },
    {
        Header = "Legs",
    }
}

local local_ply
function PANEL:Paint(w,h)
    local_ply = local_ply or LocalPlayer()

    surface.SetDrawColor(Color(0,0,0,96))
    surface.DrawOutlinedRect(0, 0, w, h)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(color_white)
    
    draw.SimpleText("Kopf", "BEBAS_Status", 6, 4, color_white)
    surface.DrawOutlinedRect(6, 24, w - 14, 12)

    draw.SimpleText("Brust", "BEBAS_Status", 6, 40, color_white)
    surface.DrawOutlinedRect(6, 24 + 36, w - 14, 12)

    draw.SimpleText("Arme", "BEBAS_Status", 6, 76, color_white)
    surface.DrawOutlinedRect(6, 24 + 72, w - 14, 12)

    draw.SimpleText("Beine", "BEBAS_Status", 6, 112, color_white)
    surface.DrawOutlinedRect(6, 24 + 108, w - 14, 12)

    local i = 0
    local x,y = self:LocalCursorPos()

    local bodystate = local_ply:GetBodyState()
    for k,v in pairs(info) do
        local percent = bodystate[string.lower(v.Header)] / 100
        
        draw.SimpleText(math.Round(percent*100, 1) .. "%", "BEBAS_Status", w - 8, i * 36 + 4, Color(255,255,255,40), TEXT_ALIGN_RIGHT)

        local clr = LerpVector(percent, Vector(255,70,0), Vector(50,255,75))
        surface.SetDrawColor(clr.x, clr.y, clr.b)
        surface.DrawRect(8, 24 + i * 36 + 2, (w - 18) * percent, 8)
        i = i + 1
    end

    
end

vgui.Register("DBodyState", PANEL, "DPanel")

if (IsValid(_bodyStatePanel)) then
    _bodyStatePanel:Remove()
end

if CLIENT then
hook.Add( "Think", "BodyStatePanelKey", function(ply, key)
    if(input.IsKeyDown(KEY_LALT)) then
        if (!MedConfig.WoundsEnabled) then return end
        if (!IsValid(_bodyStatePanel)) then
            _bodyStatePanel = vgui.Create("DBodyState")
        else
            _bodyStatePanel:Show()
        end
    else
        if (IsValid(_bodyStatePanel)) then
            _bodyStatePanel:Hide()
        end
    end
end)
end

hook.Add("OnContextMenuOpen", "BodyStatePanelOpen", function()
    
end)

hook.Add("OnContextMenuClose", "BodyStatePanelClose", function()
    if (IsValid(_bodyStatePanel)) then
        _bodyStatePanel:Hide()
    end
end)
