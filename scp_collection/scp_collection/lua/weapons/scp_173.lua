SWEP.PrintName = "SCP 173"
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

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	
	local tr = util.TraceHull( {
        start = self.Owner:GetShootPos(),
        endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 5000,
        filter = self.Owner,
        mins = Vector( -5, -5, -5 ),
        maxs = Vector( 5, 5, 5 ),
        mask = MASK_SHOT_HULL  
    } )

    if not IsValid(tr.Entity) then return end
    if tr.Entity:IsScripted() then return end
    if IsValid(tr.Entity) and (tr.Entity:IsPlayer() or tr.Entity:IsBot()) and SERVER then
        self.Weapon:SetNextPrimaryFire( CurTime() + 5 )
        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(self.Owner) 
        dmginfo:SetInflictor(self) 
        dmginfo:SetDamage(10000000) 
        dmginfo:SetDamageType(DMG_SLASH) 
        tr.Entity:TakeDamageInfo(dmginfo)


        timer.Simple(0.05,function()
            self.Owner:SetPos(tr.Entity:GetPos())
        end)
    end
end

function SWEP:Reload() end

function SWEP:SecondaryAttack() end
