-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\ragdoll\\cl_ragdoll.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local local_ply, ragdollplayer
local view = {}
local function CalcView(ply, origin, angles, fov)
	ragdollplayer = ply.RagdollPlayer
	if IsValid(ragdollplayer) and ply:GetViewEntity() == ply then
		local bid = ragdollplayer:LookupBone("ValveBiped.Bip01_Head1")
		if bid then
			local pos, ang = ragdollplayer:GetBonePosition(bid)
			pos = pos + ang:Forward() * 7
			ang:RotateAroundAxis(ang:Up(), -90)
			ang:RotateAroundAxis(ang:Forward(), -90)
			pos = pos + ang:Forward() * 3
			view.origin = pos
			view.angles = ang
			return view
		end
	end
end

local parent
local unconcious_clr = Color(0, 0, 0, 254)

local function RagdollDrawHUD()
	local_ply = local_ply or LocalPlayer()
	ragdollplayer = local_ply.RagdollPlayer

	if IsValid(ragdollplayer) then
		local allowed = ragdollplayer:GetDTBool(1) and 2 or ragdollplayer:GetDTBool(0) and 1 or false

		if allowed then
			local scrw = ScrW()
			local scrh = ScrH()
			local text1 = allowed == 2 and "Du wurdest überrannt." or "Du schläfst."
			local text2 = "Wache mit \"/sleep\" auf."
			draw.DrawNonParsedSimpleText(text1, "DarkRPHUD2", scrw / 2, scrh / 2 - 100, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.DrawNonParsedSimpleText(text2, "DarkRPHUD2", scrw / 2, scrh / 2 - 60, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

local function RagdollDrawBackground()
	local_ply = local_ply or LocalPlayer()
	ragdollplayer = local_ply.RagdollPlayer

	if IsValid(ragdollplayer) then
		local allowed = ragdollplayer:GetDTBool(1) and 2 or ragdollplayer:GetDTBool(0) and 1 or false

		if allowed then
			surface.SetDrawColor(unconcious_clr)
			local scrw = ScrW()
			local scrh = ScrH()
			surface.DrawRect(-1, -1, scrw + 2, scrh + 2)
		end
	end
end

local RagdollPlayers = {}
local function CuffsSupport()
	for _, v in pairs(RagdollPlayers) do
		if v:GetDTString(0, "cuffs_cuffmat") == "" or v:GetDTString(1, "cuffs_ropemat") == "" then continue end
		if !v.Cuffed then
			local kidnapper = v:GetDTEntity(1)
			local isleash = v:GetDTBool(4)
			local handcuffed = weapons.GetStored("weapon_handcuffed")
			if !handcuffed then continue end
			v.Cuffed = {
				cuffmat = v:GetDTString(0, "cuffs_cuffmat"),
				ropemat = v:GetDTString(1, "cuffs_ropemat"),
				GetBonePos = handcuffed.GetBonePos,
				GetCuffMaterial = function(self) return self.cuffmat end,
				GetRopeMaterial = function(self) return self.ropemat end,
				GetIsLeash = function() return isleash end,
				GetKidnapper = function() return kidnapper end,
				Owner = v
			}
			if isleash then
				v.Cuffed.DrawWorldModel = LEASH.DrawWorldModel
			else
				v.Cuffed.DrawWorldModel = handcuffed.DrawWorldModel
			end
			PrintTable(v.Cuffed)
		end
		v.Cuffed:DrawWorldModel()
	end
end

hook.Add("NetworkEntityCreated", "Ragdoll_RagdollCreated", function(ent)
	if ent:IsRagdoll() then
		local ply = ent:GetDTEntity(0)
		if ply:IsValid() and ply:IsPlayer() then
			if table.IsEmpty(RagdollPlayers) then
				hook.Add("PostDrawOpaqueRenderables", "Ragdoll_CuffsSupport", CuffsSupport)
			end
			if ply == LocalPlayer() then
				hook.Add("CalcView", "Ragdoll_CalcView", CalcView)
				hook.Add("HUDPaintBackground", "Ragdoll_DrawHUD", RagdollDrawHUD)
				hook.Add("RenderScreenspaceEffects", "Ragdoll_DrawBackground", RagdollDrawBackground)
			end
			RagdollPlayers[ent:EntIndex()] = ent
			ply.RagdollPlayer = ent
			ent.PlayerRagdoll = ply
			if ent:GetCreationTime() > CurTime() - 1 then
				ent:SnatchModelInstance(ply)
			end
			ent.GetPlayerColor = function()
				return ply:GetPlayerColor()
			end
		end
	end
end)

hook.Add("EntityRemoved", "Ragdoll_RagdollRemoved", function(ent)
	if RagdollPlayers[ent:EntIndex()] then
		if ent.PlayerRagdoll == LocalPlayer() then
			hook.Remove("CalcView", "Ragdoll_CalcView")
			hook.Remove("HUDPaintBackground", "Ragdoll_DrawHUD")
			hook.Remove("RenderScreenspaceEffects", "Ragdoll_DrawBackground")
		end
		RagdollPlayers[ent:EntIndex()] = nil
		if table.IsEmpty(RagdollPlayers) then
			hook.Remove("PostDrawOpaqueRenderables", "Ragdoll_CuffsSupport")
		end
	end
end)