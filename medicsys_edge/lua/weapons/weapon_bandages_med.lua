AddCSLuaFile()

SWEP.Instructions = "Linksklick: Spieler vor dir bandagieren.\nRechtsklick: Dich selbst bandagieren."
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Category = "SCP:RP Mediziner"
SWEP.ViewModelFOV = 50

if CLIENT then
	language.Add("ammo_bandage_ammo", "Bandagen")
else
	util.AddNetworkString("Bandages.SendBodyState")
	util.AddNetworkString("Medic.UpdateWounds")
end

SWEP.Primary.Ammo = "ammo_bandage"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Ammo = -1

SWEP.PrintName = "Mediziner Bandage"
SWEP.ViewModel = "models/weapons/c_bandage.mdl"
SWEP.WorldModel = "models/weapons/c_bandage.mdl"

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "Charge")
end

sound.Add( {
	name = "flesh_scrapple",
	channel = CHAN_STATIC,
	sound = "physics/flesh/flesh_scrape_rough_loop.wav"
} )

net.Receive("Medic.UpdateWounds", function()
	LocalPlayer()._bodyState = net.ReadTable()
end)

function SWEP:PlayerTrace(owner)
	owner:LagCompensation(true)
	local tr = LG_TraceAttack({
		start = owner:GetShootPos(),
		endpos = owner:GetShootPos() + owner:GetAimVector() * 60,
		filter = owner,
		mins = Vector(-10, -10, -8),
		maxs = Vector(10, 10, 8),
	})
	owner:LagCompensation(false)
	return tr
end

function SWEP:SecondaryAttack()
	local owner = self.Owner
	local tb = self:GetTable()

	if !owner:Alive() or owner:IsKnocked() then return end

	local body_state = owner:GetBodyState()

	if (body_state.head == 100
	and body_state.chest == 100
	and body_state.arms == 100
	and body_state.legs == 100
	and owner:GetBleeding() == 0) then return end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	self:EmitSound("physics/wood/wood_strain2.wav")
	tb.Busy = true
	tb.ScrappleTime = CurTime() + 0.6
	tb.HealTime = CurTime() + self:SequenceDuration() * 0.9

	self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
end

function SWEP:PrimaryAttack()
	local owner = self.Owner
	local tb = self:GetTable()

	if !owner:Alive() or owner:IsKnocked() then return end

	local tr = self:PlayerTrace(owner)
	local ply = tr.Entity
	if !IsValid(ply) or !ply:IsPlayer() or !ply:Alive() or ply:IsKnocked() then return end

	local body_state = ply:GetBodyState()

	if (body_state.head == 100
	and body_state.chest == 100
	and body_state.arms == 100
	and body_state.legs == 100
	and ply:GetBleeding() == 0) then return end

	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

	self:EmitSound("physics/wood/wood_strain2.wav")
	tb.Busy = true
	tb.ScrappleTime = CurTime() + 0.6
	tb.HealTime = CurTime() + self:SequenceDuration() * 0.9
	tb.Target = ply

	self:SetNextSecondaryFire(CurTime() + self:SequenceDuration())
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
end

function SWEP:Think()
	local owner = self.Owner
	local tb = self:GetTable()

	if SERVER then
		if ((tb.NextSync or 0) < CurTime()) then
			local tr = self:PlayerTrace(owner)
			local target = tr.Entity
			if IsValid(target) and target:IsPlayer() then
				local bodystate = target:GetBodyState()

				net.Start("Bandages.SendBodyState")
				net.WriteEntity(target)
					net.WriteInt(bodystate.head, 8)
					net.WriteInt(bodystate.chest, 8)
					net.WriteInt(bodystate.arms, 8)
					net.WriteInt(bodystate.legs, 8)
				net.Send(owner)
				tb.NextSync = CurTime() + 1
			end
		end
	end

	if tb.Busy then
		local ply = tb.Target or owner
		if !IsValid(ply) then
			tb.Busy = nil
			tb.Target = nil
			self:StopSound("flesh_scrapple")
			return
		end

		local cur_time = CurTime()

		if tb.ScrappleTime and cur_time > tb.ScrappleTime then
			tb.ScrappleTime = nil
			self:EmitSound("flesh_scrapple")
		end

		if tb.HealTime and cur_time > tb.HealTime then
			self:SendWeaponAnim(ACT_VM_DRAW)

			local heal_amount = MedConfig.WoundHealing * 100
			local bodystate = ply:GetBodyState()
			if bodystate.head < 100 then
				bodystate.head = math.min(bodystate.head + heal_amount, 100)
			elseif bodystate.chest < 100 then
				bodystate.chest = math.min(bodystate.chest + heal_amount, 100)
			elseif bodystate.arms < 100 then
				bodystate.arms = math.min(bodystate.arms + heal_amount, 100)
			elseif bodystate.legs < 100 then
				bodystate.legs = math.min(bodystate.legs + heal_amount, 100)
			end

			if ply:GetBleeding() > 0 then
				ply:AddBleeding(-MedConfig.BleedingHealing)
			end

			hook.Run("MedicSys_BandagePlayer", owner, ply)

			if SERVER then
				net.Start("Medic.UpdateWounds")
					net.WriteTable(bodystate)
				net.Send(ply)
			end

			tb.Busy = nil
			tb.Target = nil
			tb.HealTime = nil
			self:StopSound("flesh_scrapple")
		end
	end
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:Holster()
	self.Busy = nil
	self:StopSound("flesh_scrapple")
	self:SendWeaponAnim(ACT_VM_DRAW)
	return true
end

function SWEP:OnRemove()
	self:StopSound("flesh_scrapple")
end

if SERVER then return end

net.Receive("Bandages.SendBodyState", function()
	local ent = net.ReadEntity()
	ent._bodyState = {
		head = net.ReadInt(8),
		chest = net.ReadInt(8),
		arms = net.ReadInt(8),
		legs = net.ReadInt(8)
	}
end)

local tags = {
	"Head","Chest","Arms","Legs"
}
local display_tags = {
	"Kopf", "Brust", "Arme", "Beine"
}

local bleed = surface.GetTextureID("ggui/bleed")

function SWEP:DrawHUD()
	if (MedConfig.BandageShowInfo) then
		local owner = self.Owner

		local target = self:PlayerTrace(owner).Entity
		local hud_target = nil

		if IsValid(target) and target:IsPlayer() then
			hud_target = target
		else
			hud_target = owner
		end

		if IsValid(hud_target) then
			local scrw = ScrW()
			local scrh = ScrH()

			local heal_text = ""
			local bodystate = hud_target:GetBodyState()
			if bodystate.head < 100 then
				heal_text = "Kopf"
			elseif bodystate.chest < 100 then
				heal_text = "Brust"
			elseif bodystate.arms < 100 then
				heal_text = "Arme"
			elseif bodystate.legs < 100 then
				heal_text = "Beine"
			elseif hud_target:GetBleeding() > 0 then
				heal_text = "Blutung"
			end

			if heal_text != "" then
				local final_text = (hud_target == owner and "[Rechtsklick]" or "[Linksklick]") .. " " .. heal_text .. " bandagieren"
				draw.SimpleTextOutlined(final_text, "LG_WeaponFont1", scrw / 2, scrh - 100, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
			end
		end

		if !IsValid(target) then return end
		if (!target:IsPlayer()) then return end

		if (target:IsBleeding()) then
			surface.SetDrawColor(Color(255,255,255))
			surface.SetTexture(bleed)
			surface.DrawTexturedRectRotated(ScrW() / 2 + 272, ScrH() / 2 - 48, 128, 128, 0)
			draw.SimpleText("BLUTUNG", "BEBAS_Status", ScrW() / 2 + 272, ScrH() / 2 - 28, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if (MedConfig.WoundsEnabled) then
			surface.SetDrawColor(color_white)
			local x, y, w = ScrW() / 2 + 96, ScrH() / 2 - 108, 128
			for k,v in pairs(tags) do
				draw.SimpleText(display_tags[k], "BEBAS_Status", x, y - 20 + (k - 1) * 36, color_white)
				surface.SetDrawColor(color_white)
				surface.DrawOutlinedRect(x, y + (k - 1) * 36, w - 14, 12)

				local percent = target:GetBodyState()[string.lower(v)] / 100
				local clr = LerpVector(percent, Vector(255,70,0), Vector(50,255,75))
				surface.SetDrawColor(clr.x, clr.y, clr.b)
				surface.DrawRect(x + 2, y + (k - 1) * 36 + 2, (w - 18) * percent, 8)
			end
		end
	end
end

function SWEP:GetViewModelPosition( pos, ang )
	return pos + Vector(0,0,-8), ang + Angle(-16,0,0)
end
