


AddCSLuaFile()

if(CLIENT) then
    
    surface.CreateFont("HCS.Amnestic.BaseFont", {
        font = "Roboto", 
        size = 18, 
    })

    surface.CreateFont("HCS.Amnestic.BaseFont2", {
        font = "Roboto", 
        size = 24, 
    })
    
    surface.CreateFont("HCS.Amnestic.BaseFont3", {
        font = "BF4 Numbers", 
        size = 60, 
    })

end

if SERVER then 
    util.AddNetworkString("HCS.Amnestic.Swap")
end 

SWEP.PrintName = "Amnestics"
SWEP.Instructions = "Left click to inject a player with an amnestic.\nReload to open the amnestic menu."
SWEP.Slot = 5
SWEP.SlotPos = 2
SWEP.AmnesticType = "A"
SWEP.Author = "HCS Studios | Sintact"

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.DrawWeaponInfoBox = false
SWEP.BounceWeaponIcon = false 


SWEP.Spawnable = true 
SWEP.AdminSpawnable = true 
SWEP.Category = "HCS Amnestics"

SWEP.ViewModel = "models/weapons/darky_m/c_syringe_v2.mdl"
SWEP.WorldModel = "models/weapons/darky_m/w_syringe_v2.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Syringes"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HoldType = "slam"

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_VM_DRAW)
    self.ReadyAfterDeployAnimation = CurTime()+2.5
    return true
end

function SWEP:Holster()
    return true
end


function SWEP:Injection()
    local Owner = self:GetOwner()
    
    local Injection = util.TraceLine({
        start = Owner:GetShootPos(),
        endpos = Owner:GetShootPos() + Owner:GetAimVector() * 64,
        filter = Owner
    })
    
    
    return Injection.Entity
end 

function SWEP:PrimaryAttack()
    if CLIENT then return end 
    local owner = self:GetOwner()
    local target = self:Injection()

    local maxAmnestics = table.Count(HexSh.Config["src_amnestic"].AMNESTICLEVELS)
    for k, v in SortedPairs(HexSh.Config["src_amnestic"].AMNESTICLEVELS) do 
        if (!v.Restriction[owner:getJobTable().name]) then
            maxAmnestics = maxAmnestics - 1
        end
    end
    if maxAmnestics <= 0 then 
        owner:ChatPrint(HexSh:L("src_amnestic", "hahaerror"))
        return 
    end 

    if (target.amnested == true) then 
        owner:ChatPrint(HexSh:L("src_amnestic", "youalreadyhave")  )
        return 
    end 

    if IsValid(target) and target:IsPlayer() or target:IsNPC() then
        self:SetNextPrimaryFire(CurTime()+3)

        owner:DoAnimationEvent(ACT_GMOD_GESTURE_MELEE_SHOVE_1HAND)
        owner:EmitSound("darky_rust.syringe-inject-friend")

        AmnesticEffect(owner, target, self.AmnesticType)

        self:TakePrimaryAmmo(1)
        if self:Ammo1() <= 0 then 
            owner:StripWeapon("weapon_amnestic")
        end 

        owner:ChatPrint("You have injected " .. owner:Nick() .. " with Amnestic " .. self.AmnesticType .. "."  )
    end 
end

function SWEP:SecondaryAttack()
    return 
end 

function SWEP:DrawHUD()
    if !CLIENT then return end 
    local y, x = ScrH(), ScrW()
    local color_black = Color(0, 0, 0)

    draw.SimpleTextOutlined(HexSh:L("src_amnestic", "selected.type").. self.AmnesticType, "HCS.Amnestic.BaseFont", x * 0.5, y - 100 , color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black )
end 


if (CLIENT) then 
local color_black = Color(0, 0, 0)
local color_lightblack = Color(37,33,33,250)
local getAlpha = function(col, a) return Color(col["r"], col["g"], col["b"], a) end

local function AmnesticMenu()
    local x, y = ScrW(), ScrH()
    local wep = LocalPlayer():GetActiveWeapon()
    local i = 0

    local maxAmnestics = table.Count(HexSh.Config["src_amnestic"].AMNESTICLEVELS)
    for k, v in SortedPairs(HexSh.Config["src_amnestic"].AMNESTICLEVELS) do 
        if (!v.Restriction[LocalPlayer():getJobTable().name]) then
            maxAmnestics = maxAmnestics - 1
        end
    end
    if maxAmnestics <= 0 then 
        chat.AddText(HexSh:L("src_amnestic", "hahaerror"))
        return 
    end 

    local amnesticMainMenu = vgui.Create("DFrame")
    amnesticMainMenu:SetSize(750, 500)
    amnesticMainMenu:Center()
    amnesticMainMenu:MakePopup()
    amnesticMainMenu:SetTitle("")
    amnesticMainMenu:ShowCloseButton(false)
    amnesticMainMenu.Paint = function(self, w, h)
        draw.SimpleTextOutlined("Amnestika Menü", "HCS.Amnestic.BaseFont3", w / 2, 75, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
    end 

    local tall = amnesticMainMenu:GetTall()

    for k, v in SortedPairs(HexSh.Config["src_amnestic"].AMNESTICLEVELS) do 
        if (!v.Restriction[LocalPlayer():getJobTable().name]) then continue end
        if wep.AmnesticType == v.type then return end 

        local amnesticButton = vgui.Create("DButton",  amnesticMainMenu)
        amnesticButton:SetSize(125, 200)
        amnesticButton:SetPos(50 + (i * 135), tall / 2 - 100)
        amnesticButton:SetText("")
        amnesticButton:SetTextColor(color_black)
        amnesticButton.Lerp = HexSh:Lerp(0,0,0.3)
        amnesticButton.OnCursorEntered = function(self)
            self.Lerp = HexSh:Lerp(0,255,0.3)
            self.Lerp:DoLerp()
        end
        amnesticButton.OnCursorExited = function(self)
            self.Lerp = HexSh:Lerp(255,0,0.3)
            self.Lerp:DoLerp()
        end
        amnesticButton.Paint = function(self, w, h)
            if (self.Lerp) then self.Lerp:DoLerp() end 

            draw.RoundedBox(15, 0, 0, w, h, self.Lerp:GetValue() > 0 && getAlpha(v.color,self.Lerp:GetValue()) || color_lightblack)
            draw.SimpleText(v.name or "Unknown", "HCS.Amnestic.BaseFont2", w / 2, h / 2 - 85, self.Lerp:GetValue() > 0 && color_black || color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.RoundedBox(15, 2, h / 2 - 55 , w - 5, 150, color_lightblack)

            surface.SetDrawColor(color_white)
            surface.SetMaterial(HexSh:getImgurImage("Nz358kE"))
            surface.DrawTexturedRect(2, h / 2 - 75, w - 5, 150)
        end
        amnesticButton.DoClick = function(self)
            if !IsValid(wep) then return end 
            if wep:GetClass() != "weapon_amnestic" then return end

            net.Start("HCS.Amnestic.Swap")
                net.WriteString(k)
            net.SendToServer()

            amnesticMainMenu:Close()
        end
        i = i + 1
    end 

end 

local lastUse = 0 
function SWEP:Reload()
    if lastUse > CurTime() then return end 
    lastUse = CurTime() + 1

    local owner = self:GetOwner()
    if !owner:IsPlayer() or !IsValid(owner) then return end 

    AmnesticMenu()
end 

end 

