-- "addons\\scp_f4menu\\lua\\mg_f4\\cl_jobspanel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
------------------ Watchlist

mg_f4.Watchlist = mg_f4.Watchlist or {}

net.Receive("mg_f4_Watchlist", function()
	local clear = net.ReadBool()
	local job = net.ReadUInt(8)
	
	if clear then
		mg_f4.Watchlist[job] = nil
	else
		local job_tbl = RPExtraTeams[job]

		chat.AddText(job_tbl.color, "[@] ", color_white, "Im Beruf ", job_tbl.color, job_tbl.name, color_white, " ist eine Stelle frei geworden.")
		surface.PlaySound("hl1/fvox/blip.wav")
	end
end)

------------------ Jobs panel

local custom_model_pos = {
	["models/scp_9992/scp_9992_animated_pm.mdl"] = {Vector(70, 25, 90), Vector(90, 25, 100), Vector(0, 0, 0)},
	["models/scp131a2/scp131a2_animated_pm.mdl"] = {Vector(60, 10, 50), Vector(120, 25, 45), Vector(0, 0, 15)},
	["models/scp131b2/scp131b2_animated_pm.mdl"] = {Vector(90, 25, 50), Vector(120, 25, 45), Vector(0, 0, 15)},
	["models/scp096pm_raf.mdl"] = {Vector(90, 25, 50), Vector(85, 15, 40), Vector(0, 0, 50)},
	["models/breach173.mdl"] = {Vector(85, 10, 0), Vector(80, 25, 0), Vector(0, 0, 75)},
	["models/scp_682/scp_682_v2.mdl"] = {Vector(200, 60, 40), Vector(180, 69, 40), Vector(0, 0, 50), Vector(40, 0, 40)},
	["models/unity_scp_939_v2.mdl"] = {Vector(200, 100, 65), Vector(55, 100, 55), Vector(0, 0, 65), Vector(0, 0, 45)},
	["models/scp_066_pm.mdl"] = {Vector(90, 25, 100), Vector(90, 25, 100), Vector(0, 0, 20)},
	["models/falloutdog/falloutdog.mdl"] = {Vector(90, 55, 50), nil, Vector(0, 0, 25)},
	["models/1048/tdy/tdybrownpm.mdl"] = {Vector(50, 10, 1), Vector(80, 25, 25), Vector(0, 0, 15)},
	["models/pigeon.mdl"] = {Vector(45, 25, 50), Vector(120, 25, 25), Vector(0, 0, 15)},
}

local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)

	self.Num = 1

	self.Contents = {}
	self.Categories = {}
end

function PANEL:SetContents(contents)
	self.Contents = contents
	self:Populate()
end

function PANEL:Populate()
	local wide, height = ScrW() * 0.8 - 220, ScrH() * 0.8 - 55
	local color1, color2, color3, color4, color5 = Color(41, 41, 41), Color(210, 210, 210), Color(62, 62, 62), Color(31, 31, 31, 245), Color(65, 65, 65, 255)

	local tb = self:GetTable()

	tb.List = vgui.Create("DScrollPanel", self)
	tb.List:Dock(FILL)
	tb.List:SetWide(self:GetWide() * 0.66)
	tb.List.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, color3)
	end
	mg_f4.PaintScroll(tb.List)

	local ply = LocalPlayer()
	local tm = ply:Team()

	local jobTable = {}
	local firstSelect

	for k, v in ipairs(tb.Contents) do
		if v.team == tm then continue end

		if v.NeedToChangeFrom then
			if isnumber(v.NeedToChangeFrom) then
				if v.NeedToChangeFrom != tm then
					continue
				end
			elseif istable(v.NeedToChangeFrom) then
				local found
				for _, e in ipairs(v.NeedToChangeFrom) do
					if e == tm then 
						found = true 
					end
				end

				if not found then
					continue 
				end
			end
		end

		if not mg_f4.ShowVIP then
			if v.customCheck and not v.customCheck(ply) then
				continue
			end
		end

		if !firstSelect then
			firstSelect = k
		end

		jobTable[k] = v
	end

	for k, v in SortedPairsByMemberValue(jobTable, "sortOrder", false) do
		local category
		if v.category then
			category = self:CreateNewCategory(v.category, tb.List)
		else
			category = self:CreateNewCategory("Nicht zugeteilt", tb.List)
		end
		
		local excluded = false
		if v.can_see then
			excluded = true
			for k, v in pairs(v.can_see) do
				local job_tbl = RPExtraTeams[ply:GetMGVar("job_override") or tm]
				if job_tbl then
					local check = job_tbl[k]
					if check and v == true then
						excluded = false
						break
					end
					if check and v == false then
						excluded = true
						break
					end
				end
			end
		end

		local function PredictPlayerCount(job)
			local players = 0
			if excluded then
				players = "?"
				return players
			end			
			players = team.NumPlayers(v.team)
			return players
		end

		v.Bar = vgui.Create("DPanel", category)
		v.Bar.Max = excluded and 0 or (isfunction(v.getMax) and v.getMax(ply) or v.max or 0)
		v.Bar.Cur = PredictPlayerCount(v)
		v.Bar.CurUpdate = CurTime() + 1
		v.Bar.BackAlpha = 0

		if v.Bar.Max == 0 then
			v.Bar.Max = "∞"
		end

		local todraw = (isstring(v.Bar.Cur) or isstring(v.Bar.Max)) and 0 or math.min(v.Bar.Cur / v.Bar.Max, 1)
		
		v.Bar.Paint = function(this, w, h)
			if v.Bar.Max != 0 and v.Bar.CurUpdate < CurTime() then -- Update
				v.Bar.CurUpdate = CurTime() + 1
				if isfunction(v.getMax) then
					v.Bar.Max = v.getMax(ply)
				end
				v.Bar.Cur = PredictPlayerCount(v)
				todraw = (isstring(v.Bar.Cur) or isstring(v.Bar.Max)) and 0 or math.min(v.Bar.Cur / v.Bar.Max, 1)
			end

			draw.RoundedBox(4, 0, 0, w, h, color1)
			draw.RoundedBox(4, 0, 0, w, h, Color(mg_f4.Color.r, mg_f4.Color.g, mg_f4.Color.b, v.Bar.BackAlpha))
			draw.RoundedBox(4, 5, 5, 60, 60, color3)
			surface.SetFont("mg_f4SubTitle")

			local sw = surface.GetTextSize(v.name)

			if excluded then
				draw.SimpleText(v.name, "mg_f4SubTitle", 70, 20, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
				draw.RoundedBox(2, 70, 25 + 20, sw + 10, 2, mg_f4.Color)				
			else
				draw.SimpleText(v.name, "mg_f4SubTitle", 70, 1, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
				draw.RoundedBox(2, 70, 25, sw + 10, 2, mg_f4.Color)				
	
				draw.RoundedBox(4, 70, h - 27, w - 140, 22, color3)
				if v.Bar.Cur != 0 then
					draw.RoundedBox(4, 72, h - 25, (w - 144) * todraw, 18, mg_f4.Color)
				end
				draw.SimpleText(v.Bar.Cur.."/"..v.Bar.Max, "mg_f419", w / 2, h - 17, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			draw.RoundedBox(4, w - 65, h / 2 - 30, 60, 60, mg_f4.Color)
			draw.SimpleText(DarkRP.formatMoney(v.salary), "mg_f4SubTitle", w - 35, h / 2, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		v.Bar.Model = vgui.Create("DModelPanel", v.Bar)
		v.Bar.Model.LayoutEntity = function()
		end
		if istable(v.model) then 
			local preferred_model = DarkRP.getPreferredJobModel(v.team)
			v.Bar.Model:SetModel(preferred_model and table.HasValue(v.model, preferred_model) and preferred_model or v.model[1])
		else
			v.Bar.Model:SetModel(v.model)
		end
		v.Bar.Model:SetPos(5, 5)
		v.Bar.Model:SetSize(60, 60)
		v.Bar.Model:SetFOV(37)
		local model = v.Bar.Model:GetModel()
		v.Bar.Model:SetCamPos(custom_model_pos[model] and custom_model_pos[model][1] or Vector(25, -7, 65))
		v.Bar.Model:SetLookAt(custom_model_pos[model] and custom_model_pos[model][3] or Vector(0, 0, 65))

		local local_ply = LocalPlayer()
		v.Bar.Model.PaintOver = function(this, w, h)
			if v.customIcon then
				render.OverrideDepthEnable(true, false)
				render.SetLightingMode(2)
				surface.SetMaterial(v.customIcon)
				surface.DrawTexturedRect(0, 0, w, h)
				render.OverrideDepthEnable(false, false)
				render.SetLightingMode(0)
			end
			if LevelSystemConfiguration and v.level then 
				if v.level > (local_ply:getDarkRPVar("level") or 0) then
					draw.RoundedBox(2, 0, h-10, w, 10, mg_f4.LevelDenyColor)
				else	
					draw.RoundedBox(2, 0, h-10, w, 10, mg_f4.LevelAcceptColor)
				end				
				draw.SimpleText("Level "..v.level, "mg_f414", w/2, h-6, color2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
			end
			if v.joblabelf4 then
				if v.level then
					draw.RoundedBox(2, 0, h-22, w, 12, mg_f4.LevelDenyColor)
					draw.SimpleText(v.joblabelf4, "mg_f414", w/2, h-18, Color(210, 210, 210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.RoundedBox(2, 0, h-12, w, 12, mg_f4.LevelDenyColor)
					draw.SimpleText(v.joblabelf4, "mg_f414", w/2, h-8, Color(210, 210, 210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
		end
		if IsValid(v.Bar.Model.Entity) then
			v.Bar.Model.Entity.GetPlayerColor = function()
				return Vector(mg_f4.Color.r/255, mg_f4.Color.g/255, mg_f4.Color.b/255) 
			end
		end

		v.Bar.Button = vgui.Create("DButton", v.Bar)
		v.Bar.Button:Dock(FILL)
		v.Bar.Button:SetText("")
		v.Bar.Button.Paint = function()
		end
		v.Bar.Button.DoClick = function()
			if tb.Selected != v then
				tb.Preview.Model:InvalidateLayout()
				if istable(v.model) then
					local preferred_model = DarkRP.getPreferredJobModel(v.team)
					tb.Num = preferred_model and table.KeyFromValue(v.model, preferred_model) or 1
				else
					tb.Num = 1
				end
			end
			tb.Selected = v

			if isstring(v.Bar.Max) or v.Bar.Max == 0 or tb.Selected.goi or tb.Selected.emergency then
				tb.Preview.Control.Watchlist:SetDisabled(true)
			else
				tb.Preview.Control.Watchlist:SetDisabled(false)
			end
		end
		v.Bar.Button.DoDoubleClick = function()
			tb.Preview.Control.Click.DoClick()
		end

		category:AddChild(v.Bar)
	end

	if !firstSelect then return end

	tb.Selected = tb.Contents[firstSelect]

	if istable(tb.Selected.model) then
		local preferred_model = DarkRP.getPreferredJobModel(tb.Selected.team)
		tb.Num = preferred_model and table.KeyFromValue(tb.Selected.model, preferred_model) or 1
	else
		tb.Num = 1
	end

	tb.Preview = vgui.Create("DPanel", self)
	tb.Preview:Dock(RIGHT)
	tb.Preview:SetWide((wide * 0.33) - 15) --thank mr scrollbar
	tb.Preview.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, color1)
		draw.RoundedBox(4, 5, 5, w - 10, height * 0.4, color5)
	end

	tb.Preview.Model = vgui.Create("DModelPanel", tb.Preview)
	tb.Preview.Model:Dock(TOP)
	tb.Preview.Model:SetSize(tb.Preview:GetWide(), height*0.4)
	tb.Preview.Model:SetFOV(70)
	tb.Preview.Model.OnCursorEntered 	= function()
	end
	tb.Preview.Model.OnCursorExited 	= function()
	end	
	tb.Preview.Model.DoClick 			= function()
	end
	tb.Preview.Model.Angles = Angle(0, 0, 0)
	tb.Preview.Model.DragMousePress = function(self)
		self.PressX, self.PressY = gui.MousePos()
		self.Pressed = true
	end
	tb.Preview.Model.DragMouseRelease = function(self)
		self.Pressed = false
	end
	tb.Preview.Model.LayoutEntity = function(self, ent)
		if self.Pressed then
			local mx, my = gui.MousePos()
			self.Angles = self.Angles - Angle(0, (self.PressX or mx) - mx, 0)
			self.PressX, self.PressY = gui.MousePos()
		end
		ent:SetAngles(self.Angles)
	end

	tb.Preview.Title = vgui.Create("DLabel", tb.Preview)
	tb.Preview.Title:Dock(TOP)
	tb.Preview.Title:DockMargin(5, 12, 5, 5)
	tb.Preview.Title:SetTall(32)
	tb.Preview.Title:SetFont("mg_f4Job")
	tb.Preview.Title:SetContentAlignment(8)
	tb.Preview.Title.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color5)
		draw.RoundedBox(2, 4, h - 4, w - 8, 2, mg_f4.Color)
	end
	tb.Preview.Title.PerformLayout = function()
		tb.Preview.Title:SetText(tb.Selected.name)
	end

	tb.Preview.Description = vgui.Create("DScrollPanel", tb.Preview)
	tb.Preview.Description:Dock(TOP)
	tb.Preview.Description:DockMargin(5, 0, 5, 5)
	tb.Preview.Description:SetTall(height * 0.4)
	tb.Preview.Description.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color5)
	end
	mg_f4.PaintScroll(tb.Preview.Description)
	tb.Preview.Description.Text = vgui.Create("DLabel", tb.Preview.Description)
	tb.Preview.Description.Text:Dock(TOP)
	tb.Preview.Description.Text:DockMargin(5, 5, 5, 5)
	tb.Preview.Description.Text:SetTall(height*0.4)
	tb.Preview.Description.Text:SetFont("mg_f4JobDesc")
	tb.Preview.Description.Text:SetWrap(true)
	tb.Preview.Description.Text:SetAutoStretchVertical(true)
	tb.Preview.Description.Text:SetContentAlignment(8)
	tb.Preview.Description.Text.PerformLayout = function()
		if istable(tb.Selected.weapons) and #tb.Selected.weapons > 0 and mg_f4.DisplayWeapons then
			--functions for getting the weapon names from the job table from the original DarkRP F4 menu
			local weaponString = ""
			for _, v in ipairs(tb.Selected.weapons) do
				local weapon = weapons.Get(v)
				if weapon then
					weaponString = weaponString.."\n"..(weapon.PrintName or weapon.ClassName)
				else
					weaponString = weaponString.."\n"..v
				end
			end

			tb.Preview.Description.Text:SetText(tb.Selected.description.."\n\nBerufsausrüstung:"..weaponString)
		else
			tb.Preview.Description.Text:SetText(tb.Selected.description)
		end
	end

	tb.Preview.Control = vgui.Create("DPanel", tb.Preview)
	tb.Preview.Control:Dock(FILL)
	tb.Preview.Control:DockMargin(5, 0, 5, 5)
	tb.Preview.Control.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color5)
	end

	tb.Preview.Control.Left = vgui.Create("mg_f4Button", tb.Preview.Control)
	tb.Preview.Control.Left:Dock(LEFT)
	tb.Preview.Control.Left.Text = "<"
	tb.Preview.Control.Left:DockMargin(5, 5, 5, 5)
	tb.Preview.Control.Left:SetWide(tb.Preview:GetWide() * 0.15 - 10)
	tb.Preview.Control.Left.DoClick = function()
		tb.Num = tb.Num - 1
		if tb.Num < 1 then tb.Num = #tb.Selected.model end
		if tb.Num > #tb.Selected.model then tb.Num = 1 end
		tb.Preview.Model:SetModel(tb.Selected.model[tb.Num])
		tb.Preview.Model:SetColor(tb.Selected.plycolor or color_white)
		tb.Preview.Model.Model = tb.Selected.model[tb.Num]
		tb.Preview.Model:InvalidateLayout()
		if IsValid(tb.Preview.Model.Entity) then
			DarkRP.setPreferredJobModel(tb.Selected.team, tb.Selected.model[tb.Num])
		end
	end

	tb.Preview.Control.Click = vgui.Create("mg_f4Button", tb.Preview.Control)
	tb.Preview.Control.Click:Dock(LEFT)
	tb.Preview.Control.Click:DockMargin(0, 5, 0, 5)
	tb.Preview.Control.Click:SetWide(tb.Preview:GetWide() * 0.55 - 5)
	tb.Preview.Control.Click.DoClick = function()
		if tb.Selected.vote or tb.Selected.RequiresVote(LocalPlayer()) then
			RunConsoleCommand("darkrp", "vote"..tb.Selected.command)
		else
			RunConsoleCommand("darkrp", tb.Selected.command)
		end
	end

	tb.Preview.Control.Watchlist = vgui.Create("mg_f4Button", tb.Preview.Control)
	tb.Preview.Control.Watchlist:Dock(LEFT)
	tb.Preview.Control.Watchlist:DockMargin(5, 5, 0, 5)
	tb.Preview.Control.Watchlist:SetWide(tb.Preview:GetWide() * 0.15 - 10)
	tb.Preview.Control.Watchlist.Text = ""
	tb.Preview.Control.Watchlist.DoClick = function()
		local job_tbl = RPExtraTeams[tb.Selected.team]
		
		if !mg_f4.Watchlist[tb.Selected.team] then
			mg_f4.Watchlist[tb.Selected.team] = true
			chat.AddText(color_white, "Du hast dich ", Color(0, 255, 0), "in", color_white," die Beobachtungsliste von ", job_tbl.color, job_tbl.name, color_white, " eingetragen.")
		else
			mg_f4.Watchlist[tb.Selected.team] = nil
			chat.AddText(color_white, "Du hast dich ", Color(255, 0, 0), "aus", color_white," der Beobachtungsliste von ", job_tbl.color, job_tbl.name, color_white, " ausgetragen.")
		end

		net.Start("mg_f4_Watchlist")
			net.WriteUInt(tb.Selected.team, 8)
		net.SendToServer()
	end

	tb.LastJob = tb.Selected
	tb.MaxCheck = nil

	tb.Preview.Control.Watchlist.Paint = function(self, w, h)
		local i_w, i_h = 26, 26

		if tb.LastJob != tb.Selected or !tb.MaxCheck then
			tb.LastJob = tb.Selected
			tb.MaxCheck = isfunction(tb.Selected.getMax) and tb.Selected.getMax(ply) or tb.Selected.max or 0
		end
		
		if tb.MaxCheck == 0 or tb.Selected.goi or tb.Selected.emergency then
			draw.RoundedBox(4, 0, 0, w, h, color1)
			
			surface.SetMaterial(mg_f4.NoBell)
			surface.SetDrawColor(color3)
			surface.DrawTexturedRect(w / 2 - (i_w / 2), h / 2 - (i_h / 2), i_w, i_h)
		else	
			draw.RoundedBox(4, 0, 0, w, h, mg_f4.Color)

			local bell_mat = mg_f4.NoBell
			if mg_f4.Watchlist[tb.Selected.team] then		
				bell_mat = mg_f4.Bell
			end
			
			surface.SetMaterial(bell_mat)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRect(w / 2 - (i_w / 2), h / 2 - (i_h / 2), i_w, i_h)
		end
	end

	tb.Preview.Control.Right = vgui.Create("mg_f4Button", tb.Preview.Control)
	tb.Preview.Control.Right:Dock(LEFT)
	tb.Preview.Control.Right.Text = ">"
	tb.Preview.Control.Right:DockMargin(5, 5, 5, 5)
	tb.Preview.Control.Right:SetWide(tb.Preview:GetWide() * 0.15 - 10)
	tb.Preview.Control.Right.DoClick = function()
		tb.Num = tb.Num + 1
		if tb.Num < 1 then tb.Num = #tb.Selected.model end
		if tb.Num > #tb.Selected.model then tb.Num = 1 end
		tb.Preview.Model:SetModel(tb.Selected.model[tb.Num])
		tb.Preview.Model:SetColor(tb.Selected.plycolor or color_white)
		tb.Preview.Model.Model = tb.Selected.model[tb.Num]
		tb.Preview.Model:InvalidateLayout()
		if IsValid(tb.Preview.Model.Entity) then
			DarkRP.setPreferredJobModel(tb.Selected.team, tb.Selected.model[tb.Num])
		end
	end

	tb.Preview.Model.PerformLayout = function() --Putting this shit down here because I hate docking
		if istable(tb.Selected.model) then
			if !IsValid(tb.Preview.Model.Entity) or tb.Preview.Model.Model != tb.Selected.model[tb.Num] then
				tb.Preview.Model.Angles = Angle(0, 0, 0)
				tb.Preview.Model:SetModel(tb.Selected.model[tb.Num])
				tb.Preview.Model:SetColor(tb.Selected.plycolor or color_white)
				tb.Preview.Model.Model = tb.Selected.model[tb.Num]
			end
		else
			if !IsValid(tb.Preview.Model.Entity) or tb.Preview.Model.Model != tb.Selected.model then
				tb.Preview.Model.Angles = Angle(0, 0, 0)
				tb.Preview.Model:SetModel(tb.Selected.model)
				tb.Preview.Model:SetColor(tb.Selected.plycolor or color_white)
				tb.Preview.Model.Model = tb.Selected.model
			end
		end
		tb.Preview.Model:SetCamPos(custom_model_pos[tb.Preview.Model:GetModel()] and custom_model_pos[tb.Preview.Model:GetModel()][2] or Vector(55, 45, 55))
		tb.Preview.Model:SetLookAt(custom_model_pos[tb.Preview.Model:GetModel()] and custom_model_pos[tb.Preview.Model:GetModel()][4] or Vector(0, 0, 40))

		if mg_f4.PreviewThemeColour then
			if IsValid(tb.Preview.Model.Entity) then
				tb.Preview.Model.Entity.GetPlayerColor = function() --and putting this in here to stop shit breaking
					local playercolor = LocalPlayer():GetPlayerColor()
					return Vector(playercolor[1]*255, playercolor[2]*255, playercolor[3]*255)
				end
			end
		end

		if tb.Selected.vote == true or (tb.Selected.RequiresVote and tb.Selected.RequiresVote(LocalPlayer())) then
			tb.Preview.Control.Click.Text = "Abstimmung starten"
			tb.Preview.Control.Click.DoClick = function()
				if IsValid(tb.Preview.Model.Entity) then
					DarkRP.setPreferredJobModel(tb.Selected.team, tb.Preview.Model.Model)
				end
				RunConsoleCommand("darkrp", "vote"..tb.Selected.command)
				DarkRP.closeF4Menu()
			end
		else
			tb.Preview.Control.Click.Text = "Beruf werden"
			tb.Preview.Control.Click.DoClick = function()
				if IsValid(tb.Preview.Model.Entity) then
					DarkRP.setPreferredJobModel(tb.Selected.team, tb.Preview.Model.Model)
				end
				RunConsoleCommand("darkrp", tb.Selected.command)
				DarkRP.closeF4Menu()
			end
		end

		tb.Preview.Control.Right.Disabled = true
		tb.Preview.Control.Left.Disabled = true
		tb.Preview.Control.Right:SetDisabled(true)
		tb.Preview.Control.Left:SetDisabled(true)

		if istable(tb.Selected.model) then
			if !table.IsEmpty(tb.Selected.model) then
				tb.Preview.Control.Right:SetDisabled(false)
				tb.Preview.Control.Left:SetDisabled(false)
				tb.Preview.Control.Right.Disabled = false
				tb.Preview.Control.Left.Disabled = false
			end
		end
	end
end

function PANEL:CreateNewCategory(Name, parent)

	for _, v in ipairs(self.Categories) do
		if v:GetName() == Name then
			return v
		end
	end

	category = vgui.Create("mg_f4Category", parent)
	category:SetName(Name)

	table.insert(self.Categories, category)

	for k, v in ipairs(self.Categories) do
		for _, cat in pairs(DarkRP.getCategories().jobs) do
			if v.Name == cat.name then
				v.sortOrder = cat.sortOrder
			end
		end
	end

	table.sort(self.Categories, function(a, b)
		if a and a.sortOrder then
			if b and b.sortOrder then
				return a.sortOrder < b.sortOrder 
			end
		end

		return false
	end)

	--local n = vgui.Create("DPanel", self)
	for _, v in ipairs(self.Categories) do
		--v:SetParent(n)

		v:SetParent(self.List)
		v:Dock(TOP)
	end

	--n:Remove()

	return category
end

vgui.Register("mg_f4Container", PANEL, "DPanel")