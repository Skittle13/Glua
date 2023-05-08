-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\entitysettings\\sh_entitysettings.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local weapon = weapons.GetStored
local entity = scripted_ents.GetStored

mg_weapon_override = mg_weapon_override or false

local function ModifyEntities()
	-- Kamera-Beschränkung
	weapon("gmod_camera").PrintName = "Kamera"
	weapon("gmod_camera").Tick = function(self)
		if CLIENT and self.Owner != LocalPlayer() then return end
		local cmd = self.Owner:GetCurrentCommand()
		if !cmd or !cmd:KeyDown(IN_ATTACK2) then return end
		self:SetZoom(math.Clamp(self:GetZoom() + cmd:GetMouseY() * FrameTime() * 6.6, 1, 140))
		self:SetRoll(self:GetRoll() + cmd:GetMouseX() * FrameTime() * 1.65)
	end

	-- DarkRP Waffen-Editierungen
	weapon("keys").PrintName = "Schlüssel"
	weapon("keys").Instructions = "Linksklick zum Abschließen.\nRechtsklick zum Aufschließen.\nNachladen auf eine Tür für Tür-Einstellungen oder Gestenmenü."
	weapon("keys").Purpose = "Hiermit können Türen auf/abgeschlossen werden oder Gesten vorgespielt werden."
	weapon("keys").Primary.Delay = 1
	weapon("keys").Secondary.Delay = 1
	weapon("weaponchecker").PrintName = "Waffenchecker"
	weapon("weaponchecker").Instructions = "Linksklick, um Personen nach Waffen zu durchsuchen.\nRechtklick, um jegliche Waffen zu konfiszieren.\nNachladen, um Waffen wieder retour zu geben."
	weapon("weaponchecker").Purpose = "Dient zum Überprüfen und Konfiszieren von Waffen anderer Personen."
	weapon("pocket").PrintName = "Tasche"
	weapon("pocket").Instructions = "Linksklick, um Sachen aufzuheben.\nRechtsklick, um Sachen aus der Tasche zu werfen.\nNachladen, um ein Menü mit Überblick auf die Inhalte der Tasche anzeigen zu lassen."
	weapon("pocket").Purpose = "Hiermit können Gegenstände in deine Tasche aufgenommen werden."
	weapon("door_ram").PrintName = "Rammbock"
	weapon("door_ram").Instructions = "Linksklick, um Türen aufzubrechen, Props zu entfrieren oder Personen aus Fahrzeugen zu werfen.\nRechtsklick zum Bereithalten."
	weapon("door_ram").Purpose = "Dient zum Aufbrechen von Türen, zum Entfrieren von Props oder zum Rauswerfen von Personen aus Fahrzeugen."
	weapon("stunstick").PrintName = "Schlagstock"
	weapon("stunstick").Instructions = "Linksklick zum Disziplinieren.\nRechtsklick für einen schädlichen Elektroschlag."
	weapon("stunstick").Purpose = nil
	weapon("arrest_stick").PrintName = "Haftstab"
	weapon("arrest_stick").Instructions = "Linksklick zum Inhaftieren einer Person.\nRechtsklick zum Wechseln zwischen dem Haft und Frei-Stab."
	weapon("arrest_stick").Purpose = "Dient zum Inhaftieren anstößiger Personen."
	weapon("unarrest_stick").PrintName = "Freistab"
	weapon("unarrest_stick").Instructions = "Linksklick, um Personen aus der Haft zu entlassen.\nRechtsklick zum Wechseln zwischen dem Haft und Frei-Stab."
	weapon("unarrest_stick").Purpose = "Dient zum Befreien von inhaftierten Personen."
	weapon("med_kit").Instructions = "Linksklick, um Verletzte zu heilen.\nRechtsklick, um dich selbst zu heilen."
	weapon("med_kit").Purpose = "Heilt verletzte Personen."
	weapon("med_kit").Description = nil
	weapon("lockpick").PrintName = "Brechstange"
	weapon("lockpick").SlotPos = 40
	weapon("lockpick").Instructions = "Linksklick oder Rechtsklick zum Aufbrechen von Türen."
	weapon("weapon_keypadchecker").Instructions = "Linksklick auf ein Keypad oder auf eine Fading Door um sie zu überprüfen.\nRechtsklick, um die gesammelten Informationen zurückzusetzen."

	weapon("weaponchecker").CheckTime = 2
	weapon("weaponchecker").ConfiscateTime = 3

	weapon("weapon_m42").DarkRPViewModelBoneManipulations = nil

	-- Design Rework: Waffen

	if !mg_weapon_override then
		mg_weapon_override = true

		entity("spawned_weapon").t.RenderGroup = RENDERGROUP_BOTH
		entity("spawned_shipment").t.RenderGroup = RENDERGROUP_BOTH
		
		entity("spawned_weapon").t.StartTouch = function()
		end

		if SERVER then
			local oldFunc = entity("spawned_weapon").t.Initialize
			entity("spawned_weapon").t.Initialize = function(self)
				oldFunc(self)

				MG_CleanupTimer(self, 1800)
			end

			local oldFunc = entity("spawned_shipment").t.Initialize
			entity("spawned_shipment").t.Initialize = function(self)
				oldFunc(self)

				MG_CleanupTimer(self, 1800)
			end
		else
			surface.CreateFont("mg_weaponfont", {font = "Prototype", size = 72, weight = 700, blursize = 0, antialias = true, shadow = false})
			surface.CreateFont("mg_weaponfont2", {font = "Prototype", size = 100, weight = 700, blursize = 0, antialias = true, shadow = false})

			function draw.ShadowText(text, font, x, y, colortext, colorshadow, dist, xalign, yalign)
				draw.SimpleText(text, font, x + dist, y + dist, colorshadow, xalign, yalign)
				draw.SimpleText(text, font, x, y, colortext, xalign, yalign)
			end

			local up, clr, local_ply, eye_ang, wid = Vector(0, 0, 15), Color(0, 200, 255, 255)

			entity("spawned_weapon").t.Draw = function(self)
				self:DrawModel()
			end

			entity("spawned_weapon").t.DrawTranslucent = function(self)
				local_ply = local_ply or LocalPlayer()
				if local_ply:EyePos():DistToSqr(self:GetPos()) > 40000 then return end
				eye_ang = EyeAngles()
				eye_ang.p = 0
				eye_ang.y = eye_ang.y - 90
				eye_ang.r = 90
				self.CachedClass = self.CachedClass or weapons.Get(self:GetWeaponClass())
				self.CachedName = self.CachedClass and self.CachedClass.PrintName or "Nicht einsehbar"
				surface.SetFont("mg_weaponfont")
				wid = surface.GetTextSize(self.CachedName)
				cam.Start3D2D(self:GetPos() + up, eye_ang, 0.05)
					surface.SetDrawColor(clr)
					surface.DrawRect(-wid / 2 - 15, -100, wid + 30, 65)
					draw.ShadowText(self.CachedName, "mg_weaponfont", 0, -70, color_white, color_black, 2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				cam.End3D2D()
			end

			entity("spawned_shipment").t.DrawTranslucent = entity("spawned_shipment").t.Draw

			entity("spawned_shipment").t.Draw = function(self)
			end

			entity("spawned_shipment").t.drawInfo = function(self)
				local pos = self:GetPos()
				local ang = self:GetAngles()
				local content = self:Getcontents() or ""
				local contents = CustomShipments[content]
				if !contents then return end
				contents = contents.name
				surface.SetFont("mg_weaponfont2")
				local text = DarkRP.getPhrase("contents")
				local TextWidth, TextHeight = surface.GetTextSize(text)
				local TextWidth2, TextHeight2 = surface.GetTextSize(contents)
				cam.Start3D2D(pos + ang:Up() * 25, ang, 0.05)
					draw.WordBox(2, -TextWidth * 0.5, 0, text, "mg_weaponfont2", Color(0, 0, 0, 100), color_white)
					draw.WordBox(2, -TextWidth2 * 0.5, TextHeight + 50, contents, "mg_weaponfont2", Color(140, 0, 0, 100), color_white)
				cam.End3D2D()
				ang:RotateAroundAxis(ang:Forward(), 90)
				text = DarkRP.getPhrase("amount")
				TextWidth = surface.GetTextSize(text)
				TextWidth2 = surface.GetTextSize(self:Getcount())
				cam.Start3D2D(pos + ang:Up() * 17, ang, 0.04)
					draw.WordBox(2, -TextWidth * 0.5, -500, text, "mg_weaponfont2", Color(0, 0, 0, 100), color_white)
					draw.WordBox(2, -TextWidth2 * 0.5, -500 + TextHeight + 20, self:Getcount(), "mg_weaponfont2", Color(0, 0, 0, 100), color_white)
				cam.End3D2D()
			end
		end

		local reg = debug.getregistry()
		local GetTable = reg.Entity.GetTable
		local GetOwner = reg.Entity.GetOwner

		weapon("weapon_base").TranslateActivity = function(self, act) -- Optimierung für normale Waffen Basis
			local tb = GetTable(self)

			if GetOwner(self):IsNPC() then
				if tb.ActivityTranslateAI[act] then
					return tb.ActivityTranslateAI[act]
				end
				return -1
			end

			if tb.ActivityTranslate[act] != nil then
				return tb.ActivityTranslate[act]
			end

			return -1
		end
	end
end
hook.Add("OnGamemodeLoaded", "DarkRP_ModifyEntities", ModifyEntities)
hook.Add("OnReloaded", "DarkRP_ModifyEntities", ModifyEntities)