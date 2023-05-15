include('shared.lua')

ENT.OverrideModel = nil
ENT.CheckedOverride = false

function ENT:OnRemove()
	if self.OverrideModel then
		self.OverrideModel:Remove()
		self.OverrideModel = nil
	end
end

local margin = 15
local boxSize = 85
local iconSize = boxSize * 0.6
local iconMargin = (boxSize - iconSize) / 2
local iconVehicleSize = 100

local help = surface.GetTextureID("ggui/death")

local COLORS
local MAT_USER =  Material("edgehud/icon_user.png", "smooth")

local maxDist = 400 ^ 2
local local_ply

function ENT:DrawTranslucent()
	local_ply = local_ply or LocalPlayer()
	local tb = self:GetTable()

	COLORS = COLORS or table.Copy(EdgeHUD.Colors)
	if !COLORS then return end
	if IsValid(tb.dt.Ragdoll) and IsValid(self:GetOwner()) then
		if local_ply:GetPos():DistToSqr(self:GetPos()) > maxDist then return end
		local ply = self:GetOwner()
		local name = ply:Nick()
		local jobname = tb.dt.IsDead and team.GetName(ply:Team())

		local eyeAngs = local_ply:EyeAngles()

		--Get the text size of the name.
		surface.SetFont("EdgeHUD:3D2D:Large")
		local nameTextWidth, _ = surface.GetTextSize(name)

		--Get the text size of the job.
		surface.SetFont("EdgeHUD:3D2D:Small")
		local jobTextWidth, _ = surface.GetTextSize(jobname)

		--Calculate the boxPos.
		local boxPos = -((boxSize + margin + math.max(nameTextWidth,jobTextWidth)) / 2)


		local pos = self:GetPos()
		--Start cam3D
		cam.Start3D2D(Vector(pos.x, pos.y, pos.z + 30),Angle(0,eyeAngs.y - 90,90),0.1)

			--Draw the gray square.
			surface.SetDrawColor(COLORS["Black_Transparent"])
			surface.DrawRect(boxPos,0,boxSize,boxSize)


			--Draw health.
			surface.SetDrawColor(ColorAlpha(COLORS["Red"],70 * math.Round(CurTime() % 1)))
			surface.DrawRect(boxPos,0,boxSize,boxSize)


			--Draw the outline.
			surface.SetDrawColor(COLORS["White_Outline"])
			surface.DrawOutlinedRect(boxPos,0,boxSize,boxSize)

			--Draw edges.
			surface.SetDrawColor(COLORS["White_Corners"])
			EdgeHUD.DrawEdges(boxPos,0,boxSize,boxSize,8)

			--Draw icon.
			surface.SetDrawColor(COLORS["White"])
			surface.SetMaterial(MAT_USER)	
			surface.DrawTexturedRect(boxPos + iconMargin,0 + iconMargin,iconSize,iconSize)

			--Draw info.
			draw.SimpleText(name,"EdgeHUD:3D2D:Large", boxPos + boxSize + margin, 0, Color(200,200,200,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			draw.SimpleText(jobname,"EdgeHUD:3D2D:Small", boxPos + boxSize + margin, boxSize, team.GetColor( ply:Team()), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
			
			local text = ""
			local textCol = COLORS["Red"]
			if tb.dt.IsDead or tb.dt.Ragdoll.IsInfected then
				text = "Gestorben"
			else
				if tb.dt.WakeUp then
					text = "Stirbt in " .. string.ToMinutesSeconds(tb.dt.WakeUp - CurTime()) .. ""
				end
			end
			draw.SimpleText(text,"EdgeHUD:3D2D:Small",boxPos  + boxSize + margin,boxSize + 35,textCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

		--End cam3d2d
		cam.End3D2D()
	end
end

function ENT:Think()
	local tb = self:GetTable()

	if tb.CheckedOverride == false then
		local override_model = hook.Run("MedicSys_ModelOverride", self)
		if override_model and !IsValid(tb.OverrideModel) then
			tb.OverrideModel = ClientsideModel(override_model)
		end
		tb.CheckedOverride = true
	end
	if tb.OverrideModel then
		local ragdoll = self:GetRagdoll()
		local mins = self:OBBMaxs()
		tb.OverrideModel:SetPos(ragdoll:GetPos() - Vector(0, 0, 5) * mins)
		tb.OverrideModel:SetAngles(ragdoll:GetAngles())
	end

	if (IsValid(tb.dt.Ragdoll) and IsValid(self:GetOwner())) then
		if (!tb.dt.Ragdoll.Color) then 
			tb.dt.Ragdoll.Color = self:GetOwner():GetPlayerColor() 
		end
		tb.dt.Ragdoll.GetPlayerColor = function(s)
			return s.Color
		end
	end
end