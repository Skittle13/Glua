-- "addons\\scp_f4menu\\lua\\mg_f4\\vgui\\cl_circles.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local draw, surface, math = draw, surface, math

function draw.Arc(cx, cy, radius, thickness, startang, endang, roughness, color) 
	surface.SetDrawColor(color)
	surface.DrawArc(surface.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness))
end

function surface.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness)
	local triarc = {}

	local roughness = math.max(roughness or 1, 1)
	local step = roughness

	local startang,endang = startang or 0, endang or 0
	
	if startang > endang then
		step = math.abs(step) * -1
	end
	
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		local ox, oy = cx+(math.cos(rad)*r), cy+(-math.sin(rad)*r)
		table.insert(inner, {
			x = ox,
			y = oy,
			u = (ox - cx) / radius + .5,
			v = (oy - cy) / radius + .5,
		})
	end
	
	local outer = {}
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		local ox, oy = cx + (math.cos(rad) * radius), cy + (-math.sin(rad) * radius)
		table.insert(outer, {
			x = ox,
			y = oy,
			u = (ox - cx) / radius + 0.5,
			v = (oy - cy) / radius + 0.5,
		})
	end
	
	for tri=1, #inner * 2 do
		local p1, p2, p3
		p1 = outer[math.floor(tri / 2) + 1]
		p3 = inner[math.floor((tri + 1) / 2) + 1]
		if tri % 2 == 0 then
			p2 = outer[math.floor((tri + 1) / 2)]
		else
			p2 = inner[math.floor((tri + 1) / 2)]
		end
	
		table.insert(triarc, {p1, p2, p3})
	end
	
	return triarc
	
end

function surface.DrawArc(arc)
	for _,v in ipairs(arc) do
		surface.DrawPoly(v)
	end
end