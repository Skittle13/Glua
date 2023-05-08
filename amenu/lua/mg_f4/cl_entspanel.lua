-- "addons\\amenu\\lua\\amenu\\cl_entspanel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
------------------ Parent panel for shit
local PANEL = {}

function PANEL:Init()
	self:Dock(FILL)

	self.Num 			= 1
	self.Key 			= 0

	self.Contents 		= {}
	self.Categories 	= {}
	self.Type 			= 0
	self.Placeholder 	= {}
	self.Placeholder.name = "None"
	self.Placeholder.price = ""
	self.Placeholder.description = ""
	self.Placeholder.model 		= ""

	self.ShouldEnable 	= true
end

function PANEL:SetContents(contents, conttype)
	self.Contents = table.Copy(contents)
	self.Type = conttype
	if conttype == 1 then 
		self.LoopCheck = self.CheckEntity
	elseif conttype == 2 then
		self.LoopCheck = self.CheckWeapon
	elseif conttype == 3 then 
		self.LoopCheck = self.CheckShipment
	elseif conttype == 4 then 
		self.LoopCheck = self.CheckAmmo
	elseif conttype == 5 then
		self.LoopCheck = self.CheckFood
	end	

	self:Populate()
end

function PANEL:GetContents()
	return self.Contents
end

function PANEL:Populate()
	local wide, height = ScrW()*0.8 - 220, ScrH()*0.8 - 55

	if (not self.Contents) or (self.Contents[1] == nil) then
		self.List = vgui.Create("DScrollPanel", self)
		self.List:Dock(FILL)
		self.List:SetWide(self:GetWide()*0.66)
		self.List.Paint = function(this, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(62, 62, 62, 255))
		end
		local category = self:CreateNewCategory("Nothing to see here!", self.List)
		category.PerformLayout = function()
			category:SetTall(44)
		end
		return
	end

	
	self.Key 		= table.KeyFromValue(self.Contents, self.Contents[1])
	self.Selected 	= self.Contents[1]

	self.Preview = vgui.Create("DPanel", self)
	self.Preview:Dock(RIGHT)
	self.Preview:SetWide((wide*0.33) - 15) --thank mr scrollbar
	self.Preview.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(41, 41, 41, 255))
		draw.RoundedBox(4, 5, 5, w-10, height*0.4, Color(65, 65, 65 , 255))
	end

	self.Preview.Model = vgui.Create("DModelPanel", self.Preview)
	self.Preview.Model:Dock(TOP)
	self.Preview.Model:SetSize(self.Preview:GetWide(), height*0.4)
	self.Preview.Model:SetCamPos(Vector(45, 55, 35))
	self.Preview.Model:SetLookAt(Vector(0, 0, 10))
	self.Preview.Model:SetFOV(55)
	self.Preview.Model.OnCursorEntered 	= function() return end
	self.Preview.Model.OnCursorExited 	= function() return end	
	self.Preview.Model.DoClick 			= function() return end
	--self.Preview.Model.LayoutEntity 	= function(ent)	ent:RunAnimation() end

	self.Preview.Title = vgui.Create("DLabel", self.Preview)
	self.Preview.Title:Dock(TOP)
	self.Preview.Title:DockMargin(5, 12, 5, 5)
	self.Preview.Title:SetTall(32)
	self.Preview.Title:SetFont("aMenuJob")
	self.Preview.Title:SetContentAlignment(8)
	self.Preview.Title.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(65, 65, 65, 255))
		draw.RoundedBox(2, 4, h-4, w-8, 2, aMenu.Color)
	end
	self.Preview.Title.PerformLayout = function()
		if self.Selected then
			self.Preview.Title:SetText(self.Selected.name)
		else
			self.Preview.Title:SetText(self.Contents[self.Key].name)
		end
	end

	self.Preview.Description = vgui.Create("DScrollPanel", self.Preview)
	self.Preview.Description:Dock(TOP)
	self.Preview.Description:DockMargin(5, 0, 5, 5)
	self.Preview.Description:SetTall(height*0.4)
	self.Preview.Description.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(65, 65, 65, 255))
	end

	self.Preview.Description.Text = vgui.Create("DLabel", self.Preview.Description)
	self.Preview.Description.Text:Dock(TOP)
	self.Preview.Description.Text:DockMargin(5, 5, 5, 5)
	self.Preview.Description.Text:SetTall(height*0.4)
	self.Preview.Description.Text:SetFont("aMenu20")
	self.Preview.Description.Text:SetWrap(true)
	self.Preview.Description.Text:SetContentAlignment(8)
	self.Preview.Description.Text.PerformLayout = function()
		if isstring(self.Contents[self.Key].price) then
			self.Preview.Description.Text:SetText("")
			self.Preview.Description:SizeToContents()
			self.Preview.Control.Click.Disabled = true
			return 
		end
		local price = 0
		if self.Selected then
			if self.Type == 2 then
				price = self.Selected.pricesep
			else
				price = self.Selected.price
			end
			if not price then price = 0 end
			if self.Selected.description or aMenu.Descriptions[tostring(self.Selected.name)] then
				local desc = self.Selected.description or aMenu.Descriptions[tostring(self.Selected.name)]
				self.Preview.Description.Text:SetText(desc .. "\n\nPrice - $" .. (price or "Unknown"))
			else
				self.Preview.Description.Text:SetText("Price - $" .. (price or "Unknown"))
			end	
		else
			if self.Type == 2 then
				price = self.Contents[self.Key].pricesep
			else
				price = self.Contents[self.Key].price
			end
			if self.Contents[self.Key].description or aMenu.Descriptions[tostring(self.Contents[self.Key].name)] then
				local desc = self.Contents[self.Key].description or aMenu.Descriptions[tostring(self.Contents[self.Key].name)]
				self.Preview.Description.Text:SetText(desc .. "\n\nPrice - $" .. (price or "Unknown"))
			else
				self.Preview.Description.Text:SetText("Price - $" .. (price or "Unknown"))
			end	
		end
		self.Preview.Description:SizeToContents()
	end

	self.Preview.Control = vgui.Create("DPanel", self.Preview)
	self.Preview.Control:Dock(FILL)
	self.Preview.Control:DockMargin(5, 0, 5, 5)
	self.Preview.Control.Paint = function(this, w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(65, 65, 65, 255))
	end

	self.Preview.Control.Click = vgui.Create("aMenuButton", self.Preview.Control)
	self.Preview.Control.Click:Dock(FILL)
	self.Preview.Control.Click:DockMargin(5, 5, 5, 5)
		
	self.Preview.Model.PerformLayout = function() --Putting this shit down here because I hate docking
		self.Preview.Model:SetModel(self.Contents[self.Key].model)
		self.Preview.Control.Click.Text = "Purchase"
		self.Preview.Control.Click.DoClick = function()
			if self.Type == 1 then
				RunConsoleCommand("darkrp", self.Selected.cmd)
			elseif self.Type == 2 then
				RunConsoleCommand("darkrp", "buy", self.Selected.name)
			elseif self.Type == 3 then
				RunConsoleCommand("darkrp", "buyshipment", self.Selected.name)
			elseif self.Type == 4 then
				RunConsoleCommand("darkrp", "buyammo", self.Selected.id)
			else
				RunConsoleCommand("darkrp", "buyfood", self.Selected.name)			
			end	
		end
	end

	self.List = vgui.Create("DScrollPanel", self)
	self.List:Dock(FILL)
	self.List:SetWide(self:GetWide()*0.66)
	self.List.Paint = function(this, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(62, 62, 62, 255))
	end
	aMenu.PaintScroll(self.List)

	for k, v in pairs(self.Contents) do

		if v.name == team.GetName(LocalPlayer():Team()) then continue end
		if self:LoopCheck(v) == false then continue end

		local category
		if v.category then
			category = self:CreateNewCategory(v.category, self.List)
		else
			category = self:CreateNewCategory("Unassigned", self.List)
		end

		category:DockPadding(0, 36, 0, 5)

		v.Bar = vgui.Create("DPanel", category)
		v.Bar.Max = v.max
		v.Bar.Cur = #team.GetPlayers(v.team)
		v.Bar.BackAlpha = 0
		v.Bar:DockMargin(10, 10, 10, 0)
		v.Bar:SetTall(70)
		v.Bar.Ent = v

		if v.Bar.Max == 0 then v.Bar.Max = "∞" end

		v.Bar.Paint = function(this, w, h)
			draw.RoundedBox(4, 0, 0, w, h, Color(41, 41, 41, 255))
			draw.RoundedBox(4, 0, 0, w, h, Color(aMenu.Color.r,aMenu.Color.g, aMenu.Color.b, v.Bar.BackAlpha))

			surface.SetFont("aMenuSubTitle")

			local sw, sh = surface.GetTextSize(string.upper(v.name))

			draw.SimpleText(v.name, "aMenuSubTitle", 70, 1, Color(210, 210, 210), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP) 
			draw.RoundedBox(2, 70, 25, sw + 10, 2, aMenu.Color)

			if self.Type == 2 then
				if LocalPlayer():canAfford(v.pricesep) then
					draw.RoundedBox(4, w-65, h/2-30, 60, 60, aMenu.Color)
				else
					draw.RoundedBox(4, w-65, h/2-30, 60, 60, Color(62, 62, 62, 255))
				end				
				draw.SimpleText(DarkRP.formatMoney(v.pricesep), "aMenu20", w-35, h/2, Color(210, 210, 210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				if LocalPlayer():canAfford(v.price) then
					draw.RoundedBox(4, w-65, h/2-30, 60, 60, aMenu.Color)
				else
					draw.RoundedBox(4, w-65, h/2-30, 60, 60, Color(62, 62, 62, 255))
				end	
				draw.SimpleText(DarkRP.formatMoney(v.price), "aMenu20", w-35, h/2, Color(210, 210, 210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			draw.RoundedBox(4, 5, 5, 60, 60, Color(62, 62, 62, 255))
		end

		v.Bar.Model = vgui.Create("DModelPanel", v.Bar)
		v.Bar.Model.LayoutEntity = function() return end
		if istable(v.model) then 
			v.Bar.Model:SetModel(v.model[1])
		else
			v.Bar.Model:SetModel(v.model)
		end
		v.Bar.Model:SetPos(5, 5)
		v.Bar.Model:SetSize(60, 60)
		if v.Bar.Model:GetEntity() and v.Bar.Model:GetEntity():GetModelRadius() then
			v.Bar.Model:SetFOV(v.Bar.Model:GetEntity():GetModelRadius())
		else
			v.Bar.Model:SetFOV(20)
		end
		
		v.Bar.Model.PaintOver = function(this, w, h)
			if LevelSystemConfiguration and v.level then 
				if v.level > LocalPlayer():getDarkRPVar("level") then
					draw.RoundedBox(2, 0, h-10, w, 10, mg_f4.LevelDenyColor)
				else	
					draw.RoundedBox(2, 0, h-10, w, 10, mg_f4.LevelAcceptColor)
				end				
				draw.SimpleText(v.level, "mg_f414", w/2, h-6, Color(210, 210, 210), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
        end

        v.Bar.Model:SetCamPos(Vector(105, 94, 85))
		v.Bar.Model:SetLookAt(Vector(10, 10, 15))

		v.Bar.Button = vgui.Create("DButton", v.Bar)
		v.Bar.Button:Dock(FILL)
		v.Bar.Button:SetText("")
		v.Bar.Button.Paint = function() end
		v.Bar.Button.DoClick = function()
			self.Selected 	= v
			self.Key 		= k
			self.Num 		= 1
			self.Preview.Model:InvalidateLayout()
		end
		v.Bar.Button.DoDoubleClick = function()
			self.Preview.Control.Click.DoClick()
		end

		category:AddChild(v.Bar)

	end

	if #self.Categories == 0 then
		local category = self:CreateNewCategory("Nothing to see here!", self.List)
		category.PerformLayout = function()
			category:SetTall(44)
		end
		self.Selected = self.Placeholder
		self.ShouldEnable = false
	else
		self.Selected = self.Categories[1]:GetChildren()[1].Ent
		return
	end
end

function PANEL:CreateNewCategory(name, parent)

	for k, v in pairs(self.Categories) do
		if v:GetName() == name then
			return v
		end
	end

	local category = vgui.Create("aMenuCategory", parent)
	category:SetName(name)

	table.insert(self.Categories, category)

	return category
end

--Entity checking functions from the original DarkRP menu (why re-write these?)
function PANEL:CheckEntity(item)
	local ply = LocalPlayer()
	
	if istable(item.allowed) and not table.HasValue(item.allowed, ply:Team()) then return false end
	if item.customCheck and not item.customCheck(ply) then return false end

	if not aMenu.ShowAllEntities then
		if not ply:canAfford(item.price) then return false end
	end	

	return true
end

function PANEL:CheckWeapon(ship)
	local ply = LocalPlayer()
	if not (ship.separate or ship.noship) then return false end
	local cost = ship.pricesep
	if GAMEMODE.Config.restrictbuypistol and not table.HasValue(ship.allowed, ply:Team()) then return false end
	if ship.customCheck and not ship.customCheck(ply) then return false end
	if not aMenu.ShowAllEntities then
		if not ply:canAfford(cost) then return false end
	end

	return true
end

function PANEL:CheckShipment(ship)
	local ply = LocalPlayer()
	if ship.noship then return false end
	if ship.allowed and not table.HasValue(ship.allowed, ply:Team()) then return false end
	if ship.customCheck and not ship.customCheck(ply) then return false end

	local canbuy, suppress, message, price = hook.Call("canBuyShipment", nil, ply, ship)
	local cost = price or ship.getPrice and ship.getPrice(ply, ship.price) or ship.price

	if not aMenu.ShowAllEntities then
		if not ply:canAfford(cost) then return false end
	end
	if canbuy == false then return false end

	return true
end

function PANEL:CheckAmmo(item)
    local ply = LocalPlayer()

    if item.customCheck and not item.customCheck(ply) then return false end

    local canbuy, suppress, message, price = hook.Call("canBuyAmmo", nil, ply, item)
    local cost = price or item.getPrice and item.getPrice(ply, item.price) or item.price

	if not aMenu.ShowAllEntities then
		if not ply:canAfford(cost) then return false end
	end

    if canbuy == false then return false end

    return true
end

function PANEL:CheckFood(food)
	local ply = LocalPlayer()

	if (food.requiresCook == nil or food.requiresCook == true) and
	(not RPExtraTeams[ply:Team()] or not RPExtraTeams[ply:Team()].cook) then return false end
	if food.customCheck and not food.customCheck(LocalPlayer()) then return false end

	if not aMenu.ShowAllEntities then
		if not ply:canAfford(food.price) then return false end
	end

	return true
end

function PANEL:LoopCheck(item) end

PrintTable(PANEL)

vgui.Register("aMenuEntBase", PANEL, "DPanel")