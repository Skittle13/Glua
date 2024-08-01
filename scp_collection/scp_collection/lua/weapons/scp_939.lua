SWEP.PrintName = "SCP 939"
SWEP.Spawnable = true
SWEP.Category = "SCP Collection"
SWEP.Author = "Alex"
SWEP.ViewModel				= Model( "" )
SWEP.WorldModel				= Model( "" )
SWEP.DrawWorldModel			= false
SWEP.ViewModelFOV			= 60
SWEP.UseHands				= true

function SWEP:Holster()
    return false
end

function SWEP:Initialize()
    self:SetHoldType("normal")
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	
	local tr = util.TraceHull( {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 75,
        filter = self.Owner,
        mins = Vector( -5, -5, -5 ),
        maxs = Vector( 5, 5, 5 ),
        mask = MASK_SHOT_HULL  
    } )

    if not IsValid(tr.Entity) then return end
    if tr.Entity:IsScripted() then return end
    if IsValid(tr.Entity) and (tr.Entity:IsPlayer() or tr.Entity.IsBot and tr.Entity:IsBot()) and SERVER then
        self.Weapon:SetNextPrimaryFire( CurTime() + 1.5 )
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(self.Owner) 
        dmginfo:SetInflictor(self) 
        dmginfo:SetDamage(75) 
        dmginfo:SetDamageType(DMG_SLASH) 
        tr.Entity:TakeDamageInfo(dmginfo)
    end

    if tr.Entity:GetClass() == "func_door" or tr.Entity:GetClass() == "func_door_rotating" or tr.Entity:GetClass() == "prop_dynamic"  and SERVER then
        self:GetOwner():EmitSound( "physics/wood/wood_box_impact_hard3.wav" )
        tr.Entity:Fire("Open", "", 0)
        tr.Entity:Fire("Unlock", "", 0)

        self.Weapon:SetNextPrimaryFire( CurTime() + 1.5 )
        
    end
	
    self:GetOwner():ViewPunch( Angle( -15, 0, 0 ) )

end

function SWEP:Reload() end

function SWEP:SecondaryAttack() end

PressedR = nil
LastTimePressedR = nil
LastMaxClientSpeed = 0

OldWalkspeed = {}
hook.Add( "PlayerButtonDown", "PlayerButtonDown-SCP939", function( ply, button )
    if CLIENT and ( button == 28 ) then
        if LastTimePressedR and LastTimePressedR + 5 > CurTime() then return else 
            LastTimePressedR = nil 
        end 
        if LocalPlayer():HasWeapon("scp_939") then
            if LastTimePressedR and LastTimePressedR + 5 > CurTime() then return else 
                LastTimePressedR = nil 
                PressedR = CurTime()
            end 
        end
    end
end)
    
hook.Add( "PlayerButtonUp", "PlayerButtonUp-SCP939", function( ply, button )
    if CLIENT and ( button == 28 ) then
        if LocalPlayer():HasWeapon("scp_939") then
            if LastTimePressedR then return end
            PressedR = nil
        end
    end
end)

if CLIENT then
    local scrh = ScrH()
    local function screencalc(size)
    return size / 1080 * scrh
    end

    local egg_icon_939 = Material("materials/scp_collection/egg_icon_939.png")
    hook.Add("HUDPaint","HUDPaint-939-loading",function()
        if not LocalPlayer():HasWeapon("scp_939") or not EdgeHUD then return end
        local COLORS = table.Copy(EdgeHUD.Colors)
        local VARS = table.Copy(EdgeHUD.Vars)

        local cvalue = math.Clamp(LocalPlayer():Frags(),0,5)
        local cvalue = cvalue * screencalc(300)

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.SetMaterial( egg_icon_939 )
        surface.DrawTexturedRect( screencalc(10), (ScrH() / 2) - (64/2), 64, 64 )


        surface.SetDrawColor(COLORS["White_Outline"])
        surface.DrawOutlinedRect(screencalc(10),(ScrH() / 2) - (64/2),64,64)

        surface.SetDrawColor(COLORS["White_Corners"])
        EdgeHUD.DrawEdges(screencalc(10),(ScrH() / 2) - (64/2),64,64, 8)

        if LocalPlayer():Frags() < 5 then
            surface.SetDrawColor(COLORS["Black_Transparent"])
            surface.DrawRect(screencalc(10),(ScrH() / 2) - (64/2),64,64)

            draw.SimpleText(5-LocalPlayer():Frags(),"EdgeHUD:Large",screencalc(42),(ScrH() / 2),Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

        else
            draw.SimpleText("Halte R um ein Ei zu legen","EdgeHUD:Medium",screencalc(80),(ScrH() / 2) - screencalc(16),Color(255, 255, 255, 255),TEXT_ALIGN_LEFT,TEXT_ALIGN_LEFT)

        end


        if type(PressedR) == "number" then
            local value = (CurTime()-PressedR) / 3.5
            local cvalue = math.Clamp(value,0,1)
            local cvalue = cvalue * screencalc(300)
        
            local h = screencalc(25)
            local w = screencalc(300)
            local ScrWDivided = (ScrW() / 2)
            local ScrHDivided = (ScrH() / 2)
            local x = ScrWDivided - (w / 2)
            local y = ScrHDivided - (h / 2)
            surface.SetDrawColor(COLORS["Gray_Transparent"])
            surface.DrawRect(x,y,w,h)

            surface.SetDrawColor(COLORS["Black_Transparent"])
            surface.DrawRect(x,y,cvalue,h)
        
            surface.SetDrawColor(COLORS["White_Outline"])
            surface.DrawOutlinedRect(x,y,w,h)
        
            surface.SetDrawColor(COLORS["White_Corners"])
            EdgeHUD.DrawEdges(x,y,w,h, 8)

            draw.SimpleText("Ei wird gelegt...","EdgeHUD:Small_2",ScrWDivided,ScrHDivided,Color(255, 255, 255, 255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)


            if cvalue == screencalc(300) then
                LastTimePressedR = CurTime()
                PressedR = nil

                net.Start("SCP_939_LAYEGG")
                net.SendToServer()
            end
        end
    end)
end