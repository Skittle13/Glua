-- "addons\\scp_f4menu\\lua\\mg_f4\\cl_dashboard.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

local general_commands = {
	{name = "Geld fallen lassen", command = "say /dropmoney {}", text = "Wert angeben.", comm_name = "/dropmoney"},
	{name = "Geld geben", command = "say /give {}", text = "Wert angeben.", comm_name = "/give"},
	{name = "Beruf mit Person wechseln", command = "say /switchjob", comm_name = "/switchjob"},
	{name = "AFK-Modus wechseln", command = "say /afk", comm_name = "/afk"}
}

local roleplay_commands = {
	{name = "Waffe fallen lassen", command = "say /drop",  comm_name = "/drop"},
	{name = "RP-Name ändern", command = "say /rpname {}", text = "Name angeben.",  comm_name = "/rpname"},
	{name = "Schlafen oder aufwachen", command = "say /sleep", comm_name = "/sleep"},
}

local chat_commands = {
	{name = "Out of Character", command = "say /ooc {}", text = "Text angeben.", comm_name = "/ooc"},
	{name = "Lokaler OOC", command = "say /looc {}", text = "Text angeben.", comm_name = "/looc"},
	{name = "Akt ausführen", command = "say /akt {}", text = "Text angeben.", comm_name = "/akt"},
	{name = "Brüllen", command = "say /y {}", text = "Text angeben.", comm_name = "/y"},
	{name = "Flüstern", command = "say /w {}", text = "Text angeben.", comm_name = "/w"},
	{name = "Gruppe", command = "say /g {}", text = "Text angeben.", comm_name = "/g"},
}

local mayor_commands = {
	{name = "Facility Management", command = "say /manage", comm_name = "/manage"},
	{name = "Etwas verkünden", command = "say /broadcast {}", comm_name = "/broadcast"},
}

local color_cvar = CreateClientConVar("mg_f4_color", mg_f4.DefaultColor)
local blur_cvar = CreateClientConVar("mg_f4_blur", mg_f4.BlurBackground and 1 or 0)

function PANEL:Init()
	local wide, height = ScrW() * 0.8 - 220, ScrH() * 0.8 - 55
	local color1, color2, color3, color4, color5, color6 = Color(62, 62, 62), Color(31, 31, 31), Color(200, 200, 200), Color(41, 41, 41), Color(100, 100, 100, 20), Color(0, 0, 0, 40)

	local tb = self:GetTable()

	mg_f4.Color = mg_f4.Designs[color_cvar:GetString()] or mg_f4.Designs[mg_f4.DefaultColor]
	mg_f4.BlurBackground = blur_cvar:GetBool() and true or false

	self:Dock(FILL)
	tb.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color1)
	end

	tb.Admins = {}

	tb.Commands = vgui.Create("DPanel", self)
	tb.Commands:Dock(BOTTOM)
	tb.Commands:DockMargin(5, 0, 5, 5)
	tb.Commands:SetTall(height*0.55)
	tb.Commands.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color2)
	end

	tb.GeneralCommands = general_commands
	tb.RoleplayCommands = roleplay_commands
	tb.ChatCommands = chat_commands
	tb.MayorCommands = mayor_commands

	self:AddClassCommands("Generelle Befehle", Color(92, 184, 92), tb.GeneralCommands)
	self:AddClassCommands("Roleplay Befehle", Color(91, 192, 222), tb.RoleplayCommands)
	self:AddClassCommands("Chat Befehle", Color(66, 139, 202), tb.ChatCommands)
	self:AddClassCommands("Management", Color(217, 83, 79), tb.MayorCommands)

	tb.StaffList = vgui.Create("DPanel", self)
	tb.StaffList:SetSize(wide / 2 - 5, height / 2 - 50)
	tb.StaffList:Dock(LEFT)
	tb.StaffList:DockMargin(5, 5, 5, 5)
	tb.StaffList.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color2)

		draw.SimpleText("Teammitglieder online", "mg_f4Title", 12, 5, color3, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
		draw.RoundedBox(2, 10, 37, w - 20, 2, mg_f4.Color)
	end
	tb.StaffList:DockPadding(0, 0, 0, 5)	

	tb.StaffList.List = vgui.Create("DScrollPanel", tb.StaffList)
	tb.StaffList.List:Dock(FILL)
	tb.StaffList.List:DockMargin(10, 45, 10, 10)
	mg_f4.PaintScroll(tb.StaffList.List)

	self:UpdateStaff()

	timer.Create("mg_f4StaffUpdate", 1, 0, function()
		if self:IsValid() then
			self:UpdateStaff()
		else
			timer.Remove("mg_f4StaffUpdate")
		end
	end)

	tb.JobsGraph = vgui.Create("DPanel", self)
	tb.JobsGraph:SetSize(wide / 2 - 10, height / 2 - 50)
	tb.JobsGraph:Dock(RIGHT)
	tb.JobsGraph:DockMargin(5, 5, 5, 5)
	tb.JobsGraph.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color2)
		draw.SimpleText("Berufteilung", "mg_f4Title", 12, 5, color3, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
		draw.RoundedBox(2, 10, 37, w - 20, 2, mg_f4.Color)
	end

	local numPlayers = {}
	local totalJobs = {}
	local toDraw 	= {}
	local curstart 	= 0

	local players = player.GetAll()
	local plyCount = 0
	local ply
	for _, v in ipairs(players) do
		local tm = v:Team()
		local jobTable = RPExtraTeams[tm]
		if jobTable and jobTable.can_see then
			local allowed = false
			for k, v in pairs(jobTable.can_see) do
				ply = ply or LocalPlayer()
				local job_tbl = RPExtraTeams[ply:GetMGVar("job_override") or ply:Team()]
				if job_tbl then
					local check = job_tbl[k]
					if check and v == true then
						allowed = true
						break
					end
					if check and v == false then
						allowed = false
						break
					end
				end
			end
			if !allowed then
				continue
			end
		end
		if v.GetMGVar and v:GetMGVar("scoreboard_hide") then
			continue
		end
		plyCount = plyCount + 1
		numPlayers[tm] = numPlayers[tm] or 0
		numPlayers[tm] = numPlayers[tm] + 1
	end

	local cat = DarkRP.getCategories()["jobs"]
	for _, data in ipairs(cat) do
		local members = data["members"]
		if #members > 0 then
			for _, v in ipairs(members) do
				local tm = v.team
				local num_plys = numPlayers[tm]
				if num_plys and num_plys > 0 then
					table.insert(totalJobs, {tm, num_plys})
				end
			end
		end
	end

	local count = 255
	for k, v in ipairs(totalJobs) do
		local numsections = 360 / plyCount

		local en = (curstart + (v[2] * numsections))

		local col = team.GetColor(v[1])
		col.a = 200

		table.insert(toDraw, {name = team.GetName(v[1]), col = col, startang = curstart, endang = en})
		curstart = en
	end

	tb.JobsGraph.Graph = vgui.Create("DPanel", tb.JobsGraph)
	tb.JobsGraph.Graph:Dock(LEFT)
	tb.JobsGraph.Graph:DockMargin(10, 45, 5, 10)
	tb.JobsGraph.Graph:SetWide((tb.JobsGraph:GetTall() * 0.3) * 2 + 70)
	tb.JobsGraph.Graph.Paint = function(this, w, h)

		local radius = math.min(h * 0.4, w * 0.4)
		local thickness = radius / 2
		local roughness = 0
		local clockwise = true

		draw.RoundedBox(4, 0, 0, w, h, color1)				
		draw.NoTexture() --fuck you, you elusive bastard

		draw.Arc(w / 2, h / 2, radius + 15, thickness + radius + 15, 0, 360, roughness, color4, clockwise)

		for k, v in ipairs(toDraw) do
			draw.Arc(w / 2, h / 2, radius, thickness * 2, v.startang, v.endang, roughness, v.col, clockwise)
		end
	end

	tb.JobsGraph.Info = vgui.Create("DScrollPanel", tb.JobsGraph)
	tb.JobsGraph.Info:Dock(FILL)
	tb.JobsGraph.Info:DockMargin(5, 45, 10, 10)
	tb.JobsGraph.Info.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color1)
	end
	mg_f4.PaintScroll(tb.JobsGraph.Info)

	for _, v in ipairs(totalJobs) do
		local base = vgui.Create("DPanel", tb.JobsGraph.Info)
		base:Dock(TOP)
		base:DockMargin(5, 3, 5, 3)

		local color = team.GetColor(v[1])
		base.Paint = function(this, w, h)
			if mg_f4.ChartFullColour then
				draw.RoundedBox(4, 0, 0, w, h, color)
				draw.RoundedBox(4, 0, 0, w, h, color6)
			else
				draw.RoundedBox(4, 0, 0, w, h, color4)
				draw.RoundedBox(4, 5, 5, 14, 14, color)
			end
		end

		base.lbl = vgui.Create("DLabel", base)

		base.lbl.PerformLayout = function()
			base.lbl:SetAutoStretchVertical(true)
			base.lbl:SetText(team.GetName(v[1]).."\nSpieler: "..v[2])
			base.lbl:SizeToContentsY()
			base:SizeToChildren(false, true)
			base:SetTall(base:GetTall() + 3)
		end

		base.lbl:Dock(FILL)

		if mg_f4.ChartFullColour then
			base.lbl:DockMargin(3, 2, 2, 2)
		else
			base.lbl:DockMargin(23, 2, 2, 2)
		end

		base.lbl:SetFont("mg_f419")
		base.lbl.Paint = function(this, w, h)
			--draw.RoundedBox(4, 0, 0, w, h, Color(41, 41, 41))
		end
	end
end

function PANEL:UpdateStaff()
	local color1, color2 = Color(65, 65, 65), Color(200, 200, 200)

	local tb = self:GetTable()

	for k, v in pairs(tb.Admins) do
		v:Remove() --Get rid of the old panels
	end

	tb.Admins = {} --Get rid of those nulls

	local admins = {}
	local ply = ply or LocalPlayer()
	for _, v in ipairs(player.GetAll()) do
		local job_tbl = RPExtraTeams[v.GetMGVar and v:GetMGVar("job_override") or v:Team()] -- skip members you shouldn't be able to see
		if job_tbl and job_tbl.can_see and ply != v then
			local job_tbl2 = RPExtraTeams[ply.GetMGVar and ply:GetMGVar("job_override") or ply:Team()]
			if job_tbl2 then
				local allowed = false
				for k, v in pairs(job_tbl.can_see) do
					local check = job_tbl2[k]
					if check and v == true then
						allowed = true
						break
					end
					if check and v == false then
						allowed = false
						break
					end
				end
				if !allowed then
					continue
				end
			end
		end
		
		if mg_f4.StaffGroups[v:GetUserGroup()] then
			if v.GetMGVar and v:GetMGVar("scoreboard_hide") then
				continue
			end

			table.insert(admins, v)
		end
	end

	table.sort(admins, function(a, b) return mg_f4.SortOrder[a:GetUserGroup()] < mg_f4.SortOrder[b:GetUserGroup()] end)

	for k, v in ipairs(admins) do --Start over
		local vtb = v:GetTable()

		vtb.Base = vgui.Create("DPanel", tb.StaffList.List)
		vtb.Base:Dock(TOP)
		vtb.Base:DockMargin(0, 0, 5, 5)
		vtb.Base:SetTall(54)

		surface.SetFont("mg_f4Job")

		local nick = v:Nick()
		local pw, ph = surface.GetTextSize(nick)
		local str = mg_f4.StaffGroups[v:GetUserGroup()]

		vtb.Base.Paint = function(this, w, h)
			draw.RoundedBox(4, 0, 0, w, h, color1)
			draw.SimpleText(nick, "mg_f4Job", 60, 1, mg_f4.Color, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
			draw.RoundedBox(2, 60, 28, pw + 10, 2, mg_f4.Color)
			draw.SimpleText(str, "mg_f420", 60, 30, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
		end

		vtb.Base.Avatar = vgui.Create("AvatarCircleMask", vtb.Base)
		vtb.Base.Avatar:SetPlayer(v, 64)
		vtb.Base.Avatar:SetPos(4, 4)
		vtb.Base.Avatar:SetSize(46, 46)
		vtb.Base.Avatar:SetMaskSize(46 / 2)

		vtb.Base.Button = vgui.Create("DButton", vtb.Base)
		vtb.Base.Button:Dock(FILL)
		vtb.Base.Button:SetText("")
		vtb.Base.Button.Paint = function() end
		vtb.Base.Button.DoClick = function()
			if IsValid(v) then
				v:ShowProfile()
			end
		end
		table.insert(self.Admins, vtb.Base)
	end
end

function PANEL:AddClassCommands(name, color, content)
	local wide, height = ScrW() * 0.8 - 220, ScrH() * 0.8 - 55
	local color1, color2, color6, color7, color8, color10, color11, color12 = Color(41, 41, 41), Color(200, 200, 200), Color(0, 0, 0, 40), Color(62, 62, 62), Color(215, 85, 80), Color(230, 230, 230), Color(30, 30, 30), Color(149, 240, 193)

	local base = vgui.Create("DScrollPanel", self.Commands)

	base:SetWide(wide / 4 - 9)	
	base:Dock(LEFT)
	base:DockMargin(5, 5, 0, 5)
	base:GetCanvas():DockPadding(5, 40, 5, 5)
	base.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color1)
		draw.SimpleText(name, "mg_f4Title", 12, 4, color2, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
		draw.RoundedBox(2, 10, 37, w - 20, 2, color)
	end
	mg_f4.PaintScroll(base)

	for k, v in pairs(content) do
		local b = vgui.Create("mg_f4Button", base)
		b:Dock(TOP)
		b:SetTall(40)
		b:DockMargin(5, 5, 5, 5)
		b.Text = v.name
		b.Col = color
		b:SetTooltip(v.comm_name)
		b.DoClick = function()
			local cmd = v.command
			if string.EndsWith(cmd, "{}") then
				local Background
				if IsValid(Background) then Background:Close() end
				Background = vgui.Create("DFrame")
				Background:SetTitle("")
				Background:SetDraggable(false)
				Background:ShowCloseButton(false)
				Background:SetSize(ScrW(), ScrH())
				Background:SetPos(0, 0)
				Background:MakePopup()
				Background:ParentToHUD()

				Background.Paint = function() end

				local FrameWindow = vgui.Create("DFrame", Background)
				FrameWindow:SetSize(500, 170)
				FrameWindow:SetDraggable(false)
				FrameWindow:Center()
				FrameWindow:SetTitle("")
				FrameWindow:ShowCloseButton(false)

				FrameWindow.Init = function(self)
					self.StartTime = SysTime()
				end

				FrameWindow.Paint = function(self, w, h)
					Derma_DrawBackgroundBlur(self, self.StartTime)
					draw.RoundedBox(0, 1, 1, w - 2, h - 2, color1)
					draw.RoundedBox(0, 0, 0, w, 50, color8)
					draw.SimpleText(v.name or "F4-Menü Anfrage", "mg_f422", 10, 6, color_white)
					draw.SimpleText(v.text or "Wert eingeben.", "mg_f422", w / 2, 62, color_white, TEXT_ALIGN_CENTER)
					surface.SetDrawColor(color8)
				end

				local Close = vgui.Create("DButton", FrameWindow)
				Close:SetSize(85, 35)
				Close:SetPos(FrameWindow:GetWide() - 90, FrameWindow:GetTall() - 165)
				Close:SetText("X")
				Close:SetFont("mg_f422")
				Close:SetTextColor(color_white)
				Close.Paint = function(self, w, h)
					draw.RoundedBox(3, 0, 0, w, h, color7, false, false, true, true)
				end

				Close.DoClick = function()
					Background:Close()
				end

				local Text = vgui.Create("DTextEntry", FrameWindow)
				Text:SetText("")
				Text:SetPos(FrameWindow:GetWide() / 2 - 100, FrameWindow:GetTall() - 70)
				Text:SetSize(200, 20)
				Text.Paint = function(self, w, h)
					draw.RoundedBox(5, 0, 0, w, h, color10)
					draw.RoundedBox(5, 1, 1, w - 2, h - 2, color_white)
					self:DrawTextEntryText(color11, color12, color_black)
				end

				local AcceptButton = vgui.Create("DButton", FrameWindow)
				AcceptButton:SetSize(110, 30)
				AcceptButton:SetPos(FrameWindow:GetWide() / 2 - 55, FrameWindow:GetTall() - 42)
				AcceptButton:SetText("Akzeptieren")
				AcceptButton:SetFont("mg_f422")
				AcceptButton:SetTextColor(color_white)

				AcceptButton.Paint = function(self, w, h)
					draw.RoundedBox(3, 0, 0, w, h, color7)
				end

				AcceptButton.DoClick = function()
					local amt = Text:GetValue()
					if amt then
						LocalPlayer():ConCommand(string.Replace(cmd, "{}", amt))
					end
					Background:Close()
				end
			else
				LocalPlayer():ConCommand(cmd)
			end			
		end
	end
end

vgui.Register("mg_f4Dashboard", PANEL, "DPanel")