-- "addons\\scp_darkrpmod\\lua\\darkrp_modules\\mg_settings\\cl_mg_settings.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function AddForm(panel)
	local gui = vgui.Create("DForm", panel)
	gui.Paint = function(self, w, h)
		draw.RoundedBox(4, 0, 0, w, self:GetHeaderHeight(), Color(30, 30, 30))
	end

	return gui
end

local function AddCheckBox(panel, text, cvar)
	local box = panel:CheckBox(text, cvar)

	box:SetDark(false)
end

local function AddComboBox(panel, text, cvar, options)
	local box, label = panel:ComboBox(text, cvar)
	MG_Theme.Theme.ComboBox.Setup(box)

	label:SetDark(false)
	box:SetTextColor(Color(180, 180, 180))
	for _, v in ipairs(options) do
		box:AddChoice(v.name, v.value)
	end
end

local function AddSlider(panel, text, cvar, min, max, decimal)
	local slider = panel:NumSlider(text, cvar, min, max, decimal)

	slider:SetDark(false)
end

local frame
local function SettingsMenu()
	if IsValid(frame) then return end
	frame = vgui.Create("DFrame")
	frame:SetSize(600, 400)
	frame:Center()
	frame:MakePopup()
	frame:ParentToHUD()
	frame:SetDraggable(false)
	frame:SetTitle("Modern Gaming - Einstellungen")

	MG_Theme.Theme.Frame.SetupTheme(frame)

	local settings = vgui.Create("DPanelList", frame)
	settings:SetPos(5, 25)
	settings:SetSize(frame:GetWide() - 10, frame:GetTall() - 35)
	settings:EnableVerticalScrollbar(true)
	settings:SetPadding(5)
	settings:SetSpacing(15)

	MG_Theme.Theme.ScrollBar.Setup(settings.VBar)

	local gui = AddForm(settings)
	gui:SetName("Gameplay")

	AddCheckBox(gui, "Aufsätze nach dem Kauf automatisch montieren, wenn Platz", "mg_att_vendor_autoequip")
	AddCheckBox(gui, "Akustische Funk-Benachrichtigungen erhalten", "mg_ping_notify")
	AddCheckBox(gui, "Funktionen von \"/funk\" und \"/funkp\" vereinen", "mg_funk_vereinen")
	AddCheckBox(gui, "OOC-Chat deaktivieren", "mg_disable_ooc")
	AddCheckBox(gui, "Alternativen Intercom-Ton benutzen", "mg_alt_intercom")

	settings:AddItem(gui)

	local gui = AddForm(settings)
	gui:SetName("Steuerung")

	AddCheckBox(gui, "LALT (gedrückt halten) zum Anzeigen körperlicher Verfassung", "mg_medic_allowkey1")
	AddCheckBox(gui, "C (gedrückt halten) zum Anzeigen körperlicher Verfassung", "mg_medic_allowkey2")
	AddCheckBox(gui, "Granate mittels [LMB + E] werfen", "cw_quickgrenade")

	settings:AddItem(gui)

	local gui = AddForm(settings)
	gui:SetName("HUD")

	AddComboBox(gui, "F4-Menü Farbe", "mg_f4_color", {
		{name = "Rot", value = "red"},
		{name = "Blau", value = "blue"},
		{name = "Türkis", value = "turquoise"},
		{name = "Grün", value = "green"},
		{name = "Lila", value = "purple"},
		{name = "Dunkelrot", value = "darkred"},
		{name = "Grau", value = "grey"},
		{name = "Orange", value = "orange"},
		{name = "Schieferblau", value = "slateblue"},
		{name = "Pink", value = "pink"},
		{name = "Hellbraun", value = "lightbrown"},
	})

	AddCheckBox(gui, "F4-Menü Blur", "mg_f4_blur")

	AddCheckBox(gui, "Mapabstimmung im Kontextmenü anzeigen", "mg_mapvote_draw")

	AddCheckBox(gui, "NLR-Timer anzeigen", "cl_nlrtimer")
	AddCheckBox(gui, "Fortschrittsleiste anzeigen", "cl_progressbar")
	AddCheckBox(gui, "Alternative Fortschrittsleiste benutzen", "cl_use_old_progressbar")
	AddCheckBox(gui, "Anzeigen, wenn XP erhalten wird", "cl_xp_info")
	AddCheckBox(gui, "Spielzeit anzeigen", "utime_enable")
	AddCheckBox(gui, "3D2D Munitionsanzeige", "cw_customammohud")
	AddCheckBox(gui, "Fadenkreuz anzeigen", "cw_crosshair")
	settings:AddItem(gui)

	local gui = AddForm(settings)
	gui:SetName("Visuell")

	AddSlider(gui, "Laser-Qualität", "cw_laser_quality", 1, 2, 0)
	AddSlider(gui, "RT Zielfernrohr-Qualität", "cw_rt_scope_quality", 1, 4, 0)
	AddCheckBox(gui, "Realistische Waffenpositionen", "cw_alternative_vm_pos")
	AddCheckBox(gui, "BLUR: Beim Nachladen", "cw_blur_reload")
	AddCheckBox(gui, "BLUR: Beim Konfigurieren", "cw_blur_customize")
	AddCheckBox(gui, "BLUR: Beim Benutzen eines Visiers", "cw_blur_aim_telescopic")
	settings:AddItem(gui)

	local gui = AddForm(settings)
	gui:SetName("Experimentell")

	AddCheckBox(gui, "Multicore Rendering aktivieren", "mg_multicore")
	AddCheckBox(gui, "Standardmäßig verwenden", "mg_multicore_save")
	AddCheckBox(gui, "3D Skybox zeichnen", "r_3dsky")
	settings:AddItem(gui)
end

hook.Add("OnPlayerChat", "MG_Settings", function(ply, text)
	if string.lower(text) == "!settings" then
		if ply != LocalPlayer() then return true end
		SettingsMenu()
		return true 
	end
end)

concommand.Add("mg_settings", SettingsMenu)

CreateClientConVar("mg_multicore", 0, false)
CreateClientConVar("mg_multicore_save", 0)

cvars.AddChangeCallback("mg_multicore", function(name, old, new)
	if tonumber(new) != 0 then
		RunConsoleCommand("cl_threaded_bone_setup", 1)
		RunConsoleCommand("cl_threaded_client_leaf_system", 1)
		RunConsoleCommand("r_threaded_client_shadow_manager", 1)
		RunConsoleCommand("r_threaded_particles", 1)
		RunConsoleCommand("r_threaded_renderables", 1)
		RunConsoleCommand("r_queued_ropes", 1)
		RunConsoleCommand("studio_queue_mode", 1)
		RunConsoleCommand("mat_queue_mode", -1)
		RunConsoleCommand("gmod_mcore_test", 1)
	else
		RunConsoleCommand("gmod_mcore_test", 0)
	end
end)

if GetConVar("mg_multicore_save"):GetBool() then
	RunConsoleCommand("mg_multicore", 1)
end

cvars.AddChangeCallback("mg_multicore_save", function(name, old, new)
	if (tonumber(new) or 0) != 0 then
		RunConsoleCommand("mg_multicore", 1)
	end
end)