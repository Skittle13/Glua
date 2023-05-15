SWEP.Instructions = "Linksklick: Spieler wiederbeleben"
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "SCP:RP Mediziner"
SWEP.ViewModelFOV = 62

SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = "none"
SWEP.Primary.DefaultClip = -1

SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1

SWEP.PrintName = "Defibrillator"
SWEP.ViewModel = "models/weapons/c_defib_gonzo.mdl"
SWEP.WorldModel = "models/weapons/c_defib_gonzo.mdl"

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "Charge")

end

function SWEP:CreateEffect(pos, ent)
	local vPoint = pos
	local effectdata = EffectData()
	effectdata:SetOrigin( vPoint )
	effectdata:SetMagnitude(20)
	effectdata:SetScale(20)
	effectdata:SetEntity(ent)
	util.Effect( "TeslaHitboxes", effectdata )
end

local function diff(a, b)
	return b > a and b - a or a - b
end

function SWEP:PrimaryAttack()
	if !IsFirstTimePredicted() then return end
	if self:GetCharge() <= 0 then return end

	local trace = util.QuickTrace(self.Owner:GetShootPos(), self.Owner:GetAimVector() * 96, self.Owner)

	if (IsValid(trace.Entity) and trace.Entity:GetNW2Bool("IsPlayerRagdoll", false)) then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		timer.Simple(0.3, function()
			self:SetCharge(0)
			self:EmitSound( "ambient/energy/spark"..math.random(1,5)..".wav" )
			self:CreateEffect(self.Owner:GetShootPos(), trace.Entity)
			if SERVER then
				trace.Entity:GetPhysicsObject():ApplyForceCenter(Vector(0,0,200))
				if (!IsValid(trace.Entity.DeathRagdoll)) then
					trace.Entity:Remove()
					return
				end
				if trace.Entity.DeathRagdoll.dt.IsDead then return end
				local ply = trace.Entity.DeathRagdoll:GetOwner()
				local chance = math.random(1,100) < MedConfig.DefibChance
				if (chance) then
					timer.Simple(0.3, function()
						if not IsValid(trace.Entity) then return end
						local savedBodyState = ply._bodyState
						local pos = trace.Entity:GetPos()
						trace.Entity.DeathRagdoll.IsDeath = false
						trace.Entity.DeathRagdoll:ReturnWeapons()
						trace.Entity.DeathRagdoll:Remove()
						local cct = {
							["Opfer SteamID"] = ply:SteamID()
						}
						hook.Call("MedicSys_RevivePlayer", nil, self.Owner, ply)
						alogs.AddLog("Mediziner", self.Owner:Nick() .. " (" .. team.GetName(self.Owner:Team()) .. ") hat " .. ply:Nick() .. " (" .. team.GetName(ply:Team()) .. ") wiederbelebt", self.Owner:SteamID(), self.Owner:SteamID64(), cct)
						timer.Create("GDefib_HealthTimer_" .. ply:Nick(), 0.5, 1, function()
							ply:SetHealth(5 + math.random(5,20))
							ply:SetArmor(0)
							ply:SetBleeding(math.random(20, 70))

							ply:StripWeapons()

							if(ply._SavedDeathWeapons) then
								for wep in pairs(ply._SavedDeathWeapons) do
									ply:Give(wep, true)
								end
							end

							--Set Bodystate
							net.Start("Medic.UpdateBodyState")
							net.WriteInt(HITGROUP_HEAD, 4)
							net.WriteFloat(diff(ply._bodyState.head, savedBodyState.head))
							net.Send(ply)
							net.Start("Medic.UpdateBodyState")
							net.WriteInt(HITGROUP_CHEST, 4)
							net.WriteFloat(diff(ply._bodyState.chest, savedBodyState.chest))
							net.Send(ply)
							net.Start("Medic.UpdateBodyState")
							net.WriteInt(HITGROUP_RIGHTARM, 4)
							net.WriteFloat(diff(ply._bodyState.arms, savedBodyState.arms))
							net.Send(ply)
							net.Start("Medic.UpdateBodyState")
							net.WriteInt(HITGROUP_RIGHTLEG, 4)
							net.WriteFloat(diff(ply._bodyState.legs, savedBodyState.legs))
							net.Send(ply)
							ply._bodyState = savedBodyState
						end)
					end)
				end
			end
		end)
	elseif (trace.Entity:IsPlayer()) then
		self:SetCharge(0)
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		timer.Simple(0.3, function()
			trace.Entity:SetLocalVelocity(self.Owner:GetAimVector() * 500)
			if SERVER then
				local dmg = DamageInfo()
				dmg:SetDamage(math.random(5, 20))
				dmg:SetDamageType(DMG_SHOCK)
				dmg:SetAttacker(self.Owner)
				trace.Entity:TakeDamageInfo(dmg)
			end
			self:CreateEffect(self.Owner:GetShootPos(), trace.Entity)
			self:EmitSound( "ambient/energy/spark"..math.random(1,5)..".wav" )
		end)	
	end
	self:SetNextSecondaryFire(CurTime() + 1)
end

function SWEP:Reload()
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
end

function SWEP:SecondaryAttack()
	if  self:GetCharge() > 0 then return end
	self:SetNextSecondaryFire(CurTime() + MedConfig.DefibCharge + 2)
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	if SERVER or !IsFirstTimePredicted() then
		self.Owner:EmitSound("buttons/button1.wav")
		timer.Simple(1.3, function()
			if (IsValid(self) and self.Owner:GetActiveWeapon() == self) then
				self:SetCharge(100)
			end
		end)
	end
end

function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )

	local bone, pos, ang
	if (tab.rel and tab.rel != "") then

		local v = basetab[tab.rel]

		if (!v) then return end

		// Technically, if there exists an element with the same name as a bone
		// you can get in an infinite loop. Let's just hope nobody's that stupid.
		pos, ang = self:GetBoneOrientation( basetab, v, ent )

		if (!pos) then return end

		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
	else
		bone = ent:LookupBone(bone_override or tab.bone)
		if (!bone) then return end
		
		pos, ang = Vector(0,0,0), Angle(0,0,0)
		local m = ent:GetBoneMatrix(bone)
		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		if (IsValid(self.Owner) and self.Owner:IsPlayer() and
			ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r // Fixes mirrored models
		end

	end

	return pos, ang
end

function SWEP:Think()
	if (self:GetCharge() > 0) then
		self:SetCharge(self:GetCharge() - 1)
	end
end

function SWEP:ViewModelDrawn(vm)
	
    local pos,ang = self:GetBoneOrientation( {}, {}, vm, "screen_l" )
    pos = pos + ang:Up() * 0.1
    ang:RotateAroundAxis(ang:Forward(),60)

    cam.Start3D2D(pos, ang, 0.02)
        surface.SetDrawColor(Color(200,0,0,255))
        surface.DrawRect(0, 72 * (1 - self:GetCharge() / 100), 68, 72 * (self:GetCharge() / 100))
    cam.End3D2D()

    local pos,ang = self:GetBoneOrientation( {}, {}, vm, "screen_r" )
    pos = pos + ang:Up() * 0.1
    ang:RotateAroundAxis(ang:Forward(),60)

    cam.Start3D2D(pos, ang, 0.02)
        surface.SetDrawColor(Color(200,0,0,255))
        surface.DrawRect(0, 72 * (1 - self:GetCharge() / 100), 68, 72 * (self:GetCharge() / 100))
    cam.End3D2D()

	vm:SetBodygroup(0, 1)
end

function SWEP:DrawWorldModel()
	self:DrawModel()
    self:SetModelScale(0.8, 0)
end

function SWEP:Initialize()
	self:SetHoldType("knife")
end

function SWEP:Deploy()
	self:SetCharge(0)
	self.Owner.Discharge = false
	return true
end

function SWEP:Holster()
	return true
end
