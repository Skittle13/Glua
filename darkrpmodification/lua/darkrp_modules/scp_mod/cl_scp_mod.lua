-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\scp_mod\\cl_scp_mod.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- Hazmat Suit-Funktionalität

local lastTexture = nil
local mat_Overlay = nil

local function DrawMaterialOverlay(texture)
	if (texture != lastTexture or mat_Overlay == nil) then
		mat_Overlay = Material( texture )
		lastTexture = texture
	end
	if mat_Overlay == nil or mat_Overlay:IsError() then return end
	render.UpdateScreenEffectTexture()
	mat_Overlay:SetFloat("$envmap", 0)
	mat_Overlay:SetFloat("$envmaptint", 0)
	mat_Overlay:SetFloat("$refractamount", 0.1)
	mat_Overlay:SetFloat("$alpha", 0.4)
	mat_Overlay:SetInt("$ignorez", 1)
	render.SetMaterial(mat_Overlay)
	render.DrawScreenQuad(true)
end

hook.Add("RenderScreenspaceEffects", "SCP_RP_HazmatSuit", function()
	local_ply = local_ply or LocalPlayer()
	if MG_HasHazmatSuit(local_ply) then
		DrawMaterialOverlay("effects/combine_binocoverlay")
	end
end)

local edge_wd = 2
function MG_DrawEdges(x, y, width, height, size)
	surface.DrawRect(x, y, size, edge_wd)
	surface.DrawRect(x, y + edge_wd, edge_wd, size - edge_wd)
	local xright = x + width
	surface.DrawRect(xright - size, y, size, edge_wd)
	surface.DrawRect(xright - edge_wd, y + edge_wd, edge_wd,size - edge_wd)
	local ybottom = y + height
	surface.DrawRect(xright - size, ybottom - edge_wd, size, edge_wd)
	surface.DrawRect(xright - edge_wd, ybottom - size, edge_wd, size - edge_wd)
	surface.DrawRect(x, ybottom - edge_wd, size, edge_wd)
	surface.DrawRect(x, ybottom - size, edge_wd, size - edge_wd)
end