--[[---------------------------------------------------------------------------
DarkRP custom jobs
---------------------------------------------------------------------------

This file contains your custom jobs.
This file should also contain jobs from DarkRP that you edited.

Note: If you want to edit a default DarkRP job, first disable it in darkrp_config/disabled_defaults.lua
	Once you've done that, copy and paste the job to this file and edit it.

The default jobs can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/jobrelated.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomJobFields

Add jobs under the following line:
---------------------------------------------------------------------------]]

-- Beitrittsberuf

TEAM_BEITRITSBERUF = DarkRP.createJob("Beitrittsberuf", {
	color = Color(255, 0, 0, 255),
	model = {
		"models/player/group02/male_02.mdl",
		"models/player/group02/male_04.mdl",
		"models/player/group02/male_06.mdl",
		"models/player/group02/male_08.mdl"
	},
	description = [[Dieser Beruf ist ausschließlich fürs Verbinden auf den Server da.]],
	weapons = {},
	command = "beitrittsberuf",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Beitrittsberuf",
	candemote = false,
	hidef4 = true,
})

-- D-Klasse

TEAM_DKLASSE = DarkRP.createJob("D-Klasse", {
	color = Color(255, 128, 0, 255),
	model = {
		"models/player/kerry/class_d_1.mdl",
		"models/player/kerry/class_d_2.mdl",
		"models/player/kerry/class_d_3.mdl",
		"models/player/kerry/class_d_4.mdl",
		"models/player/kerry/class_d_5.mdl",
		"models/player/kerry/class_d_6.mdl",
		"models/player/kerry/class_d_7.mdl",
		"models/player/kerry/class_d_8.mdl",
		"models/player/kerry/class_d_9.mdl"
	},
	description = [[Die D-Klassen sind menschliche Versuchsobjekte für die Wissenschaftler der Foundation.
	Sie können auf viele Wege in die Foundation gelangt sein (z.B. Strafgefangene), haben aber all ihre Erinnerung verloren und müssen sich den Experimenten der Wissenschaftler fügen.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "dklasse",
	max = 0,
	salary = 40,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "D-Klasse",
	candemote = false,
	sortOrder = 1,
        dclass = true,
	dtrakt = true,
	dclass_name = true,
})

TEAM_DKLASSESCHLAEGER = DarkRP.createJob("D-Klasse Schläger", {
	color = Color(255, 128, 0, 255),
	model = "models/cultist/bor.mdl",
	description = [[Die D-Klassen sind menschliche Versuchsobjekte für die Wissenschaftler der Foundation.
	Sie können auf viele Wege in die Foundation gelangt sein (z.B. Strafgefangene), haben aber all ihre Erinnerung verloren und müssen sich den Experimenten der Wissenschaftler fügen.

	Die Schläger wurden durch Drogendelikte und Raubüberfälle in die Foundation gebracht, weshalb sie neben den Heavys zu den gefährlichsten Insassen gehören.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "dschläger",
	max = 4,
	salary = 40,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "D-Klasse",
	candemote = false,
	sortOrder = 2,
	health = 150,
	speed = 0.9,
	level = 25,
})

TEAM_DKLASSELIGHT = DarkRP.createJob("D-Klasse Light", {
	color = Color(255, 128, 0, 255),
	model = {
		"models/cultist/class_d_1.mdl",
		"models/cultist/class_d_2.mdl",
		"models/cultist/class_d_3.mdl",
		"models/cultist/class_d_4.mdl",
		"models/cultist/class_d_5.mdl",
		"models/cultist/class_d_6.mdl",
		"models/cultist/class_d_7.mdl",
		"models/cultist/class_d_8.mdl",
		"models/cultist/class_d_9.mdl"
	},
	description = [[Die D-Klassen sind menschliche Versuchsobjekte für die Wissenschaftler der Foundation.
	Sie können auf viele Wege in die Foundation gelangt sein (z.B. Strafgefangene), haben aber all ihre Erinnerung verloren und müssen sich den Experimenten der Wissenschaftler fügen.

	Die Light-Klasse besteht aus abgemagerten Individuuen, die ganz unten in der Nahrungskette stehen.
	Ihr knochiges Aussehen, beschert ihnen einen gewissen Geschwindigkeitsbonus.
	In der Foundation werden sie von anderen Insassen aufgrund ihrer Irrelevanz größtenteils ignoriert.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "dlight",
	max = 3,
	salary = 40,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "D-Klasse",
	candemote = false,
	sortOrder = 3,
	health = 75,
	speed = 1.2,
	jumppower = 1.2,
	level = 45,
})

TEAM_DKLASSEHEAVY = DarkRP.createJob("D-Klasse Heavy", {
	color = Color(255, 128, 0, 255),
	model = "models/cultist/fat_d.mdl",
	description = [[Die D-Klassen sind menschliche Versuchsobjekte für die Wissenschaftler der Foundation.
	Sie können auf viele Wege in die Foundation gelangt sein (z.B. Strafgefangene), haben aber all ihre Erinnerung verloren und müssen sich den Experimenten der Wissenschaftler fügen.

	Die Heavy-Klasse ist von gewalttätigen Psychopathen und Mördern dominiert.
	Mit diesen Kerlen ist nicht zu scherzen.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "dheavy",
	max = 3,
	salary = 40,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "D-Klasse",
	candemote = false,
	sortOrder = 4,
	health = 200,
	speed = 0.8,
	level = 45,
})

-- Personal

TEAM_SP = DarkRP.createJob("Service Personal", {
	color = Color(125, 125, 125, 255),	
	model = {
		"models/player/tfa_trent_cleaner_flamer.mdl",
		"models/player/tfa_trent_cleaner_boss.mdl",
		"models/player/tfa_trent_cleaner_grenadier.mdl",
		"models/player/tfa_trent_cleaner_mech.mdl",
		"models/player/tfa_trent_cleaner_runner.mdl",
		"models/player/tfa_trent_cleaner_sniper.mdl"
	},
	description = [[Das Service Personal ist die Reinigungskraft der Foundation.
	Sie werfen Müll weg, leeren Mülleimer und putzen den Boden sauber.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "sp",
	max = 3,
	salary = 60,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Personal",
	candemote = false,
	sortOrder = 1,
	personal = true,
	level = 5,
})

TEAM_KOCH = DarkRP.createJob("Koch", {
	color = Color(125, 125, 125, 255),	
	model = "models/player/p_butcher.mdl",
	description = [[Der Koch verkauft Essen an die D-Klassen und an Personal in der Cafeteria des D-Trakts.
	Der Koch bereitet sein Essen in der Kantine zu und nimmt Bestellungen über ein sicheres Terminal auf.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "koch",
	max = 2,
	salary = 70,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Personal",
	candemote = false,
	sortOrder = 2,
	level = 10,
})

TEAM_TECHNIKER = DarkRP.createJob("Techniker", {
	color = Color(125, 125, 125, 255),	
	model = "models/scp_engineer/engineer.mdl",
	description = [[Der Techniker ist für die technische Stabilität der Site zuständig.
	Er wird für Reparaturen und improvisierte Konstrukte hinzugezogen.
	Er erleichtert somit vielen das Leben innerhalb der Site.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "techniker",
	max = 2,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Personal",
	candemote = false,
	sortOrder = 3,
	personal = true,
	level = 15,
	joblabelf4 = "VIP",
})

-- Mediziner

TEAM_ALLGEMEINMEDIZINER = DarkRP.createJob("Allgemeinmediziner", {
	color = Color(50, 200, 50, 255),
	model = {
		"models/cultist/scientists/medic_1.mdl",
		"models/cultist/scientists/medic_2.mdl",
		"models/cultist/scientists/medic_3.mdl",
		"models/cultist/scientists/medic_4.mdl",
		"models/cultist/scientists/medic_5.mdl",
		"models/cultist/scientists/medic_6.mdl",
		"models/cultist/scientists/medic_7.mdl",
		"models/cultist/scientists/medic_8.mdl",
		"models/cultist/scientists/medic_9.mdl",
		"models/redninja/pmedic01f.mdl",
		"models/redninja/pmedic02f.mdl"
	},
	description = [[Die Mediziner werden in drei Berufe gegliedert: Allgemeinmediziner, Feldsanitäter, Psychiater.
	Sie unterscheiden sich nur in den Aufgaben, haben aber alle die gleichen Regeln.
	Man fängt als Allgemeinmediziner an und bleibt in der MedBay, bis man eine Ausbildung zum Psychiater oder Feldsanitäter abgeschlossen hat.
	Alternativ können Ärzte und höher, wenn nötig, die Station verlassen und an anderen Orten der Site helfen.
	Mediziner dürfen ab dem Beitritt zu einer dieser Fraktionen frei zwischen der neu gewählten Fraktion und Allgemeinmediziner wechseln.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "allgemeinmediziner",
	max = 8,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mediziner",
	candemote = false,
	sortOrder = 1,
	level = 10,
})

TEAM_PSYCHOLOGE = DarkRP.createJob("Psychiater", {
	color = Color(50, 200, 50, 255),
	model = {
		"models/cultist/scientists/scientists_1.mdl",
		"models/cultist/scientists/scientists_2.mdl",
		"models/cultist/scientists/scientists_3.mdl",
		"models/cultist/scientists/scientists_4.mdl",
		"models/cultist/scientists/scientists_5.mdl",
		"models/cultist/scientists/scientists_6.mdl",
		"models/cultist/scientists/scientists_8.mdl",
		"models/cultist/scientists/scientists_7.mdl",
		"models/cultist/scientists/scientists_9.mdl",
		"models/bmscientistcits/p_female_p_01.mdl",
		"models/bmscientistcits/p_female_p_02.mdl",
		"models/bmscientistcits/p_female_p_03.mdl",
		"models/bmscientistcits/p_female_p_04.mdl",
		"models/bmscientistcits/p_female_p_06.mdl",
		"models/bmscientistcits/p_female_p_07.mdl"
	},
	description = [[Die Mediziner werden in drei Berufe gegliedert: Allgemeinmediziner, Feldsanitäter, Psychiater.
	Sie unterscheiden sich nur in den Aufgaben, haben aber alle die gleichen Regeln.
	Man fängt als Allgemeinmediziner an und bleibt in der MedBay, bis man eine Ausbildung zum Psychiater oder Feldsanitäter abgeschlossen hat.
	Alternativ können Ärzte und höher, wenn nötig, die Station verlassen und an anderen Orten der Site helfen.
	Mediziner dürfen ab dem Beitritt zu einer dieser Fraktionen frei zwischen der neu gewählten Fraktion und Allgemeinmediziner wechseln.

	Der Facharzt für Psychologie ist für alle psychischen Erkrankungen zuständig und darf die Station verlassen.
	Er kann außerhalb der Med Bay in zugelassenen Bereichen, Räume für Behandlungen und Patientengespräche einrichten.
	Sollte er Personal für unfähig befinden, weil sie z.B. psychisch krank sind, kann er eine Entlassung beantragen.
	Psychiater können zu psychologischen Tests zwischen SCPs und D-Klassen hinzugezogen werden.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "psychiater",
	max = 3,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mediziner",
	candemote = false,
	sortOrder = 2,
	joblabelf4 = "Ausbildung",
})

TEAM_FELDSANITAETER = DarkRP.createJob("Feldsanitäter", {
	color = Color(50, 200, 50, 255),
	model = "models/scp/guard_med.mdl",
	description = [[Die Mediziner werden in drei Berufe gegliedert: Allgemeinmediziner, Feldsanitäter, Psychiater.
	Sie unterscheiden sich nur in den Aufgaben, haben aber alle die gleichen Regeln.
	Man fängt als Allgemeinmediziner an und bleibt in der MedBay, bis man eine Ausbildung zum Psychiater oder Feldsanitäter abgeschlossen hat.
	Alternativ können Ärzte und höher, wenn nötig, die Station verlassen und an anderen Orten der Site helfen.
	Mediziner dürfen ab dem Beitritt zu einer dieser Fraktionen frei zwischen der neu gewählten Fraktion und Allgemeinmediziner wechseln.
	
	Die Feldsanitäter sind für den Kampf spezialisierte Sanitätseinheiten.
	Ihre primäre Aufgabe ist die Versorgung der verwundeten Soldaten oder des Personals entweder im Innen oder Außeneinsatz.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "feldsanitäter",
	max = 4,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mediziner",
	candemote = false,
	sortOrder = 3,
	armor = 100,
	joblabelf4 = "Ausbildung",
})

TEAM_MEDIZINERLEITUNG = DarkRP.createJob("Mediziner Leitung", {
	color = Color(50, 200, 50, 255),
	model = {
		"models/cultist/scientists/medic_1.mdl",
		"models/cultist/scientists/medic_2.mdl",
		"models/cultist/scientists/medic_3.mdl",
		"models/cultist/scientists/medic_4.mdl",
		"models/cultist/scientists/medic_5.mdl",
		"models/cultist/scientists/medic_6.mdl",
		"models/cultist/scientists/medic_7.mdl",
		"models/cultist/scientists/medic_8.mdl",
		"models/cultist/scientists/medic_9.mdl",
		"models/redninja/pmedic01f.mdl",
		"models/redninja/pmedic02f.mdl"
	},
	description = [[Die Mediziner werden in drei Berufe gegliedert: Allgemeinmediziner, Feldsanitäter, Psychiater.
	Sie unterscheiden sich nur in den Aufgaben, haben aber alle die gleichen Regeln.
	Man fängt als Allgemeinmediziner an und bleibt in der MedBay, bis man eine Ausbildung zum Psychiater oder Feldsanitäter abgeschlossen hat.
	Alternativ können Ärzte und höher, wenn nötig, die Station verlassen und an anderen Orten der Site helfen.
	Mediziner dürfen ab dem Beitritt zu einer dieser Fraktionen frei zwischen der neu gewählten Fraktion und Allgemeinmediziner wechseln.
	
	Die medizinische Leitung kümmert sich um die Leitung der medizinischen Sparten.
	Sie ist das Oberhaupt aller Mediziner und achtet darauf, dass alles mit rechten Dingen vor sich geht.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "medizinerleitung",
	max = 2,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mediziner",
	candemote = false,
	sortOrder = 4,
	joblabelf4 = "Leitung",
})

-- Wissenschaftler

TEAM_WISSENSCHAFTLER = DarkRP.createJob("Wissenschaftler", {
	color = Color(90, 230, 230, 255),
	model = {
		"models/player/kerry/class_scientist_1.mdl",
		"models/player/kerry/class_scientist_2.mdl",
		"models/player/kerry/class_scientist_3.mdl",
		"models/player/kerry/class_scientist_4.mdl",
		"models/player/kerry/class_scientist_5.mdl",
		"models/player/kerry/class_scientist_6.mdl",
		"models/player/kerry/class_scientist_7.mdl",
		"models/player/kerry/class_scientist_8.mdl",
		"models/player/kerry/class_scientist_9.mdl",
		"models/bmscientistcits/p_female_01.mdl",
		"models/bmscientistcits/p_female_02.mdl",
		"models/bmscientistcits/p_female_03.mdl",
		"models/bmscientistcits/p_female_04.mdl",
		"models/bmscientistcits/p_female_06.mdl",
		"models/bmscientistcits/p_female_07.mdl"
	},
	description = [[Die Wissenschaftler sind eines der wichtigsten Glieder der Foundation. 
	Ihre Aufgabe ist das Erforschen von SCP’s und derzeit unbekannten Anomalien.
	Sie erhalten für das offizielle Testen mit D-Klassen & SCPs, Zuschüsse der Foundation.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "wissenschaftler",
	max = 12,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Wissenschaftler",
	candemote = false,
	sortOrder = 1,
	level = 10,
})

TEAM_WISSENSCHAFTLEITUNG = DarkRP.createJob("Wissenschaftler Leitung", {
	color = Color(90, 230, 230, 255),
	model = {
		"models/player/kerry/class_scientist_1.mdl",
		"models/player/kerry/class_scientist_2.mdl",
		"models/player/kerry/class_scientist_3.mdl",
		"models/player/kerry/class_scientist_4.mdl",
		"models/player/kerry/class_scientist_5.mdl",
		"models/player/kerry/class_scientist_6.mdl",
		"models/player/kerry/class_scientist_7.mdl",
		"models/player/kerry/class_scientist_8.mdl",
		"models/player/kerry/class_scientist_9.mdl",
		"models/bmscientistcits/p_female_01.mdl",
		"models/bmscientistcits/p_female_02.mdl",
		"models/bmscientistcits/p_female_03.mdl",
		"models/bmscientistcits/p_female_04.mdl",
		"models/bmscientistcits/p_female_06.mdl",
		"models/bmscientistcits/p_female_07.mdl"
	},
	description = [[Die Wissenschaftler sind eines der wichtigsten Glieder der Foundation. 
	Ihre Aufgabe ist das Erforschen von SCP’s und derzeit unbekannten Anomalien.
	Sie erhalten für das offizielle Testen mit D-Klassen & SCPs, Zuschüsse der Foundation.
	
	Die Wissenschaftler Leitung arbeitet seit Jahren für die Foundation und haben sich in zahlreichen Projekten und Operationen bewiesen.
	Sie sind die schlauesten Köpfe der Foundation und haben die Leitung über neue und erfahrene Wissenschaftler.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "wissenschaftlerleitung",
	max = 2,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Wissenschaftler",
	candemote = false,
	sortOrder = 2,
	joblabelf4 = "Leitung",
})

-- Sicherheitsdienst

local shd_min = 8
local shd_subtract = 2

TEAM_SICHERHEITSDIENST = DarkRP.createJob("Sicherheitsdienst", {
	color = Color(169, 74, 252, 255),
	model = "models/player/kerry/class_securety.mdl",
	description = [[Der Sicherheitsdienst ist für die Sicherheit in der LCZ und im D-Trakt zuständig. 
	Die Hauptaufgabe des Sicherheitsdiensts besteht darin, D-Klassen unter Kontrolle zu halten und das Personal der LCZ vor Gefahren zu schützen.
	D-Klassen werden nach Strafmaß bestraft und so zurecht gestutzt.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "sicherheitsdienst",
	max = 0,
	getMax = function(ply)
		local count = 0

		for _, v in ipairs(player.GetAll()) do
			local tbl = RPExtraTeams[v:Team()]
			if tbl and tbl.dclass then
				count = count + 1
			end
		end

		return math.max(math.floor(count / shd_subtract), shd_min)
	end,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Sicherheitsdienst",
	candemote = false,
	sortOrder = 1,
	armor = 100,
	level = 10
})

TEAM_SICHERHEITSLEITUNG = DarkRP.createJob("Sicherheitsleitung", {
	color = Color(169, 74, 252, 255),
	model = "models/player/kerry/class_securety_2.mdl",
	description = [[Der Sicherheitsdienst ist für die Sicherheit in der LCZ und im D-Trakt zuständig. 
	Die Hauptaufgabe des Sicherheitsdiensts besteht darin, D-Klassen unter Kontrolle zu halten und das Personal der LCZ vor Gefahren zu schützen.
	D-Klassen werden nach Strafmaß bestraft und so zurecht gestutzt.

	Die Sicherheitsleitung ist die höchste Instanz innerhalb des Sicherheitsdienstes. 
	Sie ist für die Ordnung und die Koordination innerhalb des Sicherheitsdienstes verantwortlich und leitet diese an.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "sicherheitsleitung",
	max = 3,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	ping_all = true,
	category = "Sicherheitsdienst",
	candemote = true,
	sortOrder = 3,
	health = 150,
	armor = 100,
	joblabelf4 = "Leitung",
})

-- Sicherheitspersonal

TEAM_FELDAGENT = DarkRP.createJob("Feldagent", {
	color = Color(50, 80, 80, 255),
	model = {
		"models/player/suits/robber_open.mdl",
		"models/player/suits/robber_shirt.mdl",
		"models/player/suits/robber_shirt_2.mdl",
		"models/player/suits/robber_tie.mdl",
		"models/player/suits/robber_tuckedtie.mdl"
	},
	description = [[Der Feldagent ist auf Spionage und Aufklärung an der Oberfläche spezialisiert.
	Der Feldagent kann bei Feuergefechten, Verhandlungen und Breaches aushelfen, aber auch allgemein Unterstützung leisten.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "feldagent",
	max = 1,
	salary = 160,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Sicherheitspersonal",
	candemote = false,
	sortOrder = 2,
	health = 200,
	armor = 100,
	speed = 1.15,
	level = 40,
})

TEAM_KREINHEIT = DarkRP.createJob("KR-Einheit", {
	color = Color(195, 40, 175, 255),
	model = "models/player/n7legion/turian_havoc.mdl",
	description = [[Die Kampfroboter-Einheit (kurz: KR-Einheit) ist ein Android der Foundation, welcher hauptsächlich das Personal beschützen soll. 
	Hat man die richtige Sicherheitsfreigabe, kann man der KR-Einheit, Befehle geben, welche sie dann ausführt.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "kreinheit",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Sicherheitspersonal",
	candemote = false,
	sortOrder = 3,
	health = 250,
	armor = 100,
	speed = 0.85,
	level = 50,
	joblabelf4 = "VIP +",
})

TEAM_FOUNDATIONHUND = DarkRP.createJob("Foundation Hund", {
	color = Color(195, 40, 175, 255),
	model = "models/falloutdog/falloutdog.mdl",
	description = [[Der Foundation Hund ist der treue Gefährte eines jeden Mitarbeiters der Foundation.
	Egal ob im Kampf gegen feindliche Einheiten, als Wachhund im D-Trakt, als Therapiehund oder zur allgemeinen Bespaßung der Mitarbeiter - der Foundation Hund ist immer zur Stelle, wo man ihn braucht.]],
	weapons = {"pocket"},
	command = "foundationhund",
	max = 2,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Sicherheitspersonal",
	sortOrder = 4,
    health = 400,
	footstep = true,
	walkspeed = 0.75,
	runspeed = 1.25,
	hullmaxs = Vector(16, 16, 36),
	hullduckmaxs = Vector(16, 16, 24),
	height = 0.45,
	heightduck = 0.42,
	jumppower = 1.4,
	level = 10,
	joblabelf4 = "VIP",
})

-- Containment Team

TEAM_CONTAINMENT = DarkRP.createJob("Containment Team", {
	color = Color(119, 0, 224, 255),
	model = {
		"models/ninja/mw3/delta/delta4_masked.mdl", 
		"models/player/hhp227/ct_sas_cso2.mdl",
		"models/player/cod_ghost/hazmatchik/hazmat_pm.mdl"
	},
	description = [[Das Containment Team ist eine Abspaltung der MTF, die sich speziell auf die Handhabung von SCPs spezialisiert haben.
	Sie sind für die Ordnung und Sicherheit der HCZ und LCZ zuständig.
	Sie überprüfen SCP-Zellen regelmäßig auf Schäden, sorgen für Ordnung, halten die stationierten SCPs unter Kontrolle und begleiten Wissenschaftler bei ihren Tests.

	Ihr Hazmat Suit schützt sie vor jeglichen Gefahren, ist aber nicht gegen Kugeln & Explosionen geschützt.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "ct",
	max = 8,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Containment Team",
	candemote = false,
	sortOrder = 1,
        nvg = true,
	armor = 100,
	level = 20,
})

TEAM_CTLEITUNG = DarkRP.createJob("Containment Team Leitung", {
	color = Color(119, 0, 224, 255),
	model = {
		"models/player/xuvon/xuvon_ntf_re_base.mdl",
		"models/player/cod_ghost/hazmatchik/hazmat_pm.mdl"
	},
	description = [[Das Containment Team ist eine Abspaltung der MTF, die sich speziell auf die Handhabung von SCPs spezialisiert haben.
	Sie sind für die Ordnung und Sicherheit der HCZ und LCZ zuständig.
	Sie überprüfen SCP-Zellen regelmäßig auf Schäden, sorgen für Ordnung, halten die stationierten SCPs unter Kontrolle und begleiten Wissenschaftler bei ihren Tests.

	Die Containment Leitung ist die höchste Instanz des Containment Teams.
	Sie hat die Befehlsgewalt über alle Containment Team-Mitglieder und passt auf, dass innerhalb der Fraktion alles ordentlich abläuft.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "ctleitung",
	max = 2,
	salary = 160,
	admin = 0,
	vote = false,
	hasLicense = false,
	ping_all = true,
	hm_numbers = true,
	category = "Containment Team",
	candemote = false,
	sortOrder = 3,
	health = 150,
	armor = 100,
	joblabelf4 = "Leitung",
})

-- MTF Einheiten

TEAM_MTF = DarkRP.createJob("MTF Epsilon-6", {
	color = Color(0, 95, 255, 255),
	model = {
		"models/scp/soldier_1.mdl",
		"models/scp/soldier_2.mdl",
		"models/scp/soldier_4.mdl"
	},
	description = [[Die Mobile Task Force ist die Eliteeinheit der Foundation. 
	Sollte ein SCP ausbrechen, eine Interessengruppe oder etwas anderes eine Bedrohung für die Foundation darstellt, ist die Mobile Task Force an vorderster Stelle. 

	Die Mobile Task Force Epsilon-6 "Village Idiots" ist auf die Untersuchung, Eindämmung und der anschließenden Beseitigung von Anomalien in ländlichen und vorstädtischen Regionen spezialisiert.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "mtf",
	max = 8,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mobile Task Force",
	candemote = false,
	sortOrder = 2,
	armor = 100,
	level = 20,
})

TEAM_DELTA5 = DarkRP.createJob("MTF Delta-5", {
	color = Color(0, 95, 255, 255),
	model = {
		"models/scp/soldier_3.mdl",
		"models/scp/guard_left.mdl"
	},
	description = [[Die Mobile Task Force ist die Eliteeinheit der Foundation. 
	Sollte ein SCP ausbrechen, eine Interessengruppe oder etwas anderes eine Bedrohung für die Foundation darstellt, ist die Mobile Task Force an vorderster Stelle. 

	Die Mobile Task Force Delta-5 "Front Runners" ist eine Einheit, die sich darauf spezialisiert hat feindliche Interessengruppen, sowie Eindringlinge effektiv und so schnellst wie möglich auszuschalten.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "delta5",
	max = 4,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mobile Task Force",
	candemote = true,
	sortOrder = 3,
	armor = 100,
	speed = 1.15,
	jumppower = 1.15,
	locked = true,
	joblabelf4 = "Ausbildung",
})

TEAM_NU7 = DarkRP.createJob("MTF Nu-7", {
	color = Color(0, 95, 255, 255),
	model = "models/scp/juggernaut.mdl",
	description = [[Die Mobile Task Force ist die Eliteeinheit der Foundation. 
	Sollte ein SCP ausbrechen, eine Interessengruppe oder etwas anderes eine Bedrohung für die Foundation darstellt, ist die Mobile Task Force an vorderster Stelle. 

	Die Mobile Task Force Nu-7 "Hammer Down" ist eine Bataillonsstreitmacht, die aus drei Einheiten der Infanterietruppen in Kompaniestärke, einer leichten Panzerfahrzeuggruppe, einem Panzerzug, einem Hubschraubergeschwader und einem chemisch-biologisch-radiologisch-nuklearen Zug besteht.
	Die MTF Nu-7 basiert in erster Linie auf Armed Bio-Containment Area-14 und hat die Aufgabe, auf Vorfälle zu reagieren, bei denen die Kommunikation mit wichtigen Foundation-Einrichtungen unter Umständen unterbrochen wird, bei denen ein ortsweiter Verstoß, eine feindliche Komprimierung oder ein anderes ähnlich katastrophales Ereignis vermutet wird.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "nu7",
	max = 4,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mobile Task Force",
	candemote = false,
	sortOrder = 4,
	health = 250,
	armor = 100,
	speed = 0.9,
	locked = true,
	joblabelf4 = "Ausbildung",
})

TEAM_ALPHA1 = DarkRP.createJob("MTF Alpha-1", {
	color = Color(0, 95, 255, 255),
	model = "models/scp/captain.mdl",
	description = [[Die Mobile Task Force ist die Eliteeinheit der Foundation. 
	Sollte ein SCP ausbrechen, eine Interessengruppe oder etwas anderes eine Bedrohung für die Foundation darstellt, ist die Mobile Task Force an vorderster Stelle. 

	Die Mobile Task Force Alpha-1 "Red Right Hand" ist eine Task Force, die direkt an den O5 Council berichtet und in Situationen eingesetzt wird, welche die strengste Betriebssicherheit erfordern. 
	Die Task Force besteht aus den besten und loyalsten Mitarbeitern der MTF.
	Weitere Informationen zu MTF Alpha-1 sind in Level 5 eingestuft.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "alpha1",
	max = 3,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Mobile Task Force",
	candemote = true,
	sortOrder = 5,
	health = 150,
	armor = 100,
	joblabelf4 = "Bewerbung",
})

TEAM_BETA7 = DarkRP.createJob("MTF Beta-7", {
	color = Color(0, 95, 255, 255),
	model = "models/scp/soldier_haz.mdl",
	description = [[Die Mobile Task Force ist die Eliteeinheit der Foundation. 
	Sollte ein SCP ausbrechen, eine Interessengruppe oder etwas anderes eine Bedrohung für die Foundation darstellt, ist die Mobile Task Force an vorderster Stelle. 

	Die Mobile Task Force Beta-7 "Maz Hatters" ist spezialisiert darin, Anomalien mit extremen biologischen, chemischen oder radiologischen Gefahren einzudämmen und betroffene Gebiete zu säubern.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "beta7",
	max = 2,
	salary = 160,
	admin = 0,
	vote = false,
	hasLicense = false,
	ping_all = true,
	hm_numbers = true,
	category = "Mobile Task Force",
	candemote = true,
	sortOrder = 6,
	health = 150,
	armor = 100,
	joblabelf4 = "Ausbildung",
})

-- Notfalleinheiten

TEAM_EPSILON11 = DarkRP.createJob("MTF Epsilon-11", {
	color = Color(0, 25, 255, 255),
	model = {
		"models/zoom/atc_hazmat_model.mdl",
		"models/player/cod_ghost/hazmatchik/hazmat_pm.mdl"
	},
	description = [[Die Mobile Task Force ist die Eliteeinheit der Foundation. 
	Sollte ein SCP ausbrechen, eine Interessengruppe oder etwas anderes eine Bedrohung für die Foundation darstellt, ist die Mobile Task Force an vorderster Stelle. 

	Die MTF Epsilon-11 ist eine spezielle Einsatzgruppe, die im Notfall eines Breaches eingesetzt wird. 
	Wenn die Standardprotokolle fehlschlagen und ein Verstoß unmittelbar bevorsteht, wird die MTF Epsilon-11 dazu gerufen, um Genanntes zu verhindern.]],
	weapons = {"weapon_fists","keys","pocket"},
	command = "epsilon11",
	max = 6,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Notfalleinheiten",
	candemote = false,
	sortOrder = 1,
	health = 200,
	armor = 100,
    joblabelf4 = "Notfall",
    level = 10,
})

TEAM_RIOT = DarkRP.createJob("Riot Trooper", {
	color = Color(0, 25, 255, 255),
	model = "models/omonru/riot/riot_ru.mdl",
	description = [[Die Riot-Trooper sind eine speziell ausgebildete und streng selektierte Division des Sicherheitsdiensts.
	Diese ist dafür zuständig Revolten von D-Klassen zu unterbinden und ggf. aufzuhalten.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","stunstick","cw_ar15","cw_bo2_m1216","cw_m1911","weapon_cuff_elastic","radio_device","weapon_taser","weapon_keycard_level3","weaponchecker","riot_shield","weapon_bandages","cw_flash_grenade","cw_smoke_grenade"},
	command = "riot",
	max = 4,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Notfalleinheiten",
	candemote = false,
	sortOrder = 1,
    health = 250,
	armor = 100,
	speed = 0.9,
    joblabelf4 = "Notfall",
	level = 5
})

-- Management

TEAM_SD = DarkRP.createJob("Site Director", {
	color = Color(150, 20, 20, 255),
	model = {
		"models/gonzo/cultist/director/director.mdl",
		"models/player/suits/male_01_open.mdl",
		"models/player/suits/male_02_open.mdl",
		"models/player/suits/male_03_open.mdl",
		"models/player/suits/male_04_open.mdl",
		"models/player/suits/male_05_open.mdl",
		"models/player/suits/male_06_open.mdl",
		"models/player/suits/male_07_open.mdl",
		"models/player/suits/male_08_open.mdl",
		"models/player/suits/male_09_open.mdl"
	},
	description = [[Der Site Director ist die höchstrangige Person an einem Foundation Standort. 
	Dieser ist verantwortlich für die kontinuierliche Sicherheit des Standortes, der darin enthaltenen SCP, des Personals und Dokumenten.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_cuff_shackles","radio_device","weapon_keycard_level5","management_hammer","weapon_clipboard"},
	command = "sd",
	max = 1,
	salary = 180,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Management",
	candemote = true,
	sortOrder = 1,
	armor = 100,
	level = 100,
})

TEAM_ZIFFERAGENT = DarkRP.createJob("Zifferagent", {
	color = Color(150, 20, 20, 255),
	model = {
		"models/player/suits/male_01_closed_coat_tie.mdl",
		"models/player/suits/male_02_closed_coat_tie.mdl",
		"models/player/suits/male_03_closed_coat_tie.mdl",
		"models/player/suits/male_04_closed_coat_tie.mdl",
		"models/player/suits/male_05_closed_coat_tie.mdl",
		"models/player/suits/male_06_closed_coat_tie.mdl",
		"models/player/suits/male_07_closed_coat_tie.mdl",
		"models/player/suits/male_08_closed_coat_tie.mdl",
		"models/player/suits/male_09_closed_coat_tie.mdl",
		"models/combineadmin/player/female_01.mdl",
		"models/combineadmin/player/female_02.mdl"
	},
	description = [[Die 12-Zifferagenten bilden zusammen das OIE-Protokoll (Observation, Infiltration, Execution) und unterstehen direkt dem O5-Rat.
	Aufgrund ihrer direkten Verbindung zum O5-Rat werden sie, gemäß Geheimhaltungsprotokoll Alpha, nur mit den Namen Ziffer 0 bis Ziffer 12 bezeichnet.
	Ihre Hauptfunktion ist das Finden und Ausschalten von korruptem Foundation-Personal.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_cuff_shackles","lockpick","radio_device","weapon_taser","stunstick","weapon_keycard_level5","weaponchecker","ma85_wf_pt14","management_hammer","weapon_clipboard"},
	command = "zifferagent",
	max = 3,
	salary = 180,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Management",
	candemote = false,
	sortOrder = 2,
    joblabelf4 = "Bewerbung",
	goi = true,
	sh = true,
	can_see = {
		staff = true,
	},

})

TEAM_O5 = DarkRP.createJob("O5-Rat", {
	color = Color(150, 20, 20, 255),
	model = {
		"models/player/suits/male_01_open_waistcoat.mdl",
		"models/player/suits/male_02_open_waistcoat.mdl",
		"models/player/suits/male_03_open_waistcoat.mdl",
		"models/player/suits/male_04_open_waistcoat.mdl",
		"models/player/suits/male_05_open_waistcoat.mdl",
		"models/player/suits/male_06_open_waistcoat.mdl",
		"models/player/suits/male_07_open_waistcoat.mdl",
		"models/player/suits/male_08_open_waistcoat.mdl",
		"models/player/suits/male_09_open_waistcoat.mdl",
		"models/combineadmin/player/female_01.mdl",
		"models/combineadmin/player/female_02.mdl"
	},
	description = [[Der O5-Rat besteht aus 13 Ratsmitgliedern, welche die oberste Leitung des Foundation bilden.
	Sie sind die höchste Befehlsgewalt und die wichtigsten Personen der Organisation, weshalb ihre wahre Identität ein Geheimnis ist.
	Sie agieren nur unter dem Decknamen O5-1 bis O5-13.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_cuff_shackles","radio_device","weapon_keycard_level5","management_hammer","weapon_clipboard"},
	command = "o5",
	max = 0,
	salary = 180,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Management",
	candemote = false,
    sortOrder = 3,
	armor = 100,
	joblabelf4 = "Bewerbung",
	goi = true,
	sh = true,
	can_see = {
		staff = true,
	},
})

TEAM_ETHIK = DarkRP.createJob("Ethikkommission", {
	color = Color(150, 20, 20, 255),
	model = {
		"models/player/suits/male_01_closed_tie.mdl",
		"models/player/suits/male_02_closed_tie.mdl",
		"models/player/suits/male_03_closed_tie.mdl",
		"models/player/suits/male_04_closed_tie.mdl",
		"models/player/suits/male_05_closed_tie.mdl",
		"models/player/suits/male_06_closed_tie.mdl",
		"models/player/suits/male_07_closed_tie.mdl",
		"models/player/suits/male_08_closed_tie.mdl",
		"models/player/suits/male_09_closed_tie.mdl",
		"models/combineadmin/player/female_01.mdl",
		"models/combineadmin/player/female_02.mdl"
	},
	description = [[Die Ethikkommission ist ein kleiner, vom O5 unabhängiger Rat, welcher für angemessene Eindämmungsmaßnahmen, Testfreigaben und eine ethische Behandlung des Foundationpersonals zuständig ist. 
	Sie begutachten durchgeführte Tests und entscheiden über angemessene Strafen für Mitarbeiter. 
	Im Falle eines korrupten O5-Rates führen sie eine Neubesetzung durch.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_cuff_shackles","radio_device","weapon_keycard_level5","management_hammer","weapon_clipboard"},
	command = "ethik",
	max = 0,
	salary = 180,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Management",
	candemote = false,
	sortOrder = 4,
	armor = 100,
    joblabelf4 = "Bewerbung",
	goi = true,
	sh = true,
	can_see = {
		staff = true,
	},
})
 
-- The Serpent's Hand

TEAM_SHASSAULT = DarkRP.createJob("Serpent's Hand Assault", { 
	color = Color(145, 145, 35, 255),
	model = "models/trent/thedivision/hun/chained.mdl",
	description = [[Die Serpent's Hand besteht aus einer Gruppe von Söldnern und Idealisten, welche Anomalien (wie z.B. SCPs) auf eine Ebene mit den Menschen setzen.
	Sie in Gefangenschaft der SCP-Foundation zu sehen, ist für sie unerträglich, weshalb sie angreifen, um SCPs zu befreien oder Daten zu stehlen.

	Der Serpents Hand Assault ist an der vordersten Front da. Er ist für den Sturmangriff in & außerhalb gedacht. 
	Er besitzt leichtes & schweres Kaliber an Waffen und man sollte ihm nicht den Weg kreuzen.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","lockpick","radio_device","cw_frag_grenade","cw_spade","deployable_shield","weaponchecker","weapon_bandages","weapon_leash_elastic"},
	command = "shassault",
	max = 4,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "The Serpent's Hand",
	candemote = false,
	sortOrder = 1,
    armor = 100,
    joblabelf4 = "Bewerbung",
	goi = true,
	sh = true,
	can_see = {
		sh = true,
		staff = true,
	},
})

TEAM_SHSUPPORTER = DarkRP.createJob("Serpent's Hand Supporter", {
	color = Color(145, 145, 35, 255),
	model = "models/kuma96/stealtharmor/stealtharmor_pm.mdl",
	description = [[Die Serpent's Hand besteht aus einer Gruppe von Söldnern und Idealisten, welche Anomalien (wie z.B. SCPs) auf eine Ebene mit den Menschen setzen.
	Sie in Gefangenschaft der SCP-Foundation zu sehen, ist für sie unerträglich, weshalb sie angreifen, um SCPs zu befreien oder Daten zu stehlen.

	Der Serpents Hand Supporter ist der Mediziner innerhalb der Serpent's Hand. 
	Sollte man im Kampf verletzt werden oder sogar fast sterben, ist der Supporter für die medizinische Versorgung zuständig.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","lockpick","radio_device","cw_flash_grenade","cw_bat","weapon_med_kit","weapon_defib","weapon_bandages_medic","riot_shield","weaponchecker","weapon_bandages","weapon_leash_elastic"},
	command = "shsupporter",
	max = 4,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "The Serpent's Hand",
	candemote = false,
	sortOrder = 2,
    armor = 100,
    joblabelf4 = "Bewerbung",
	goi = true,
	sh = true,
	can_see = {
		sh = true,
		staff = true,
	},
})

TEAM_SHHEAVY = DarkRP.createJob("Serpent's Hand Defender", {
	color = Color(145, 145, 35, 255),
	model = "models/adi/falllout/airforcepa.mdl",
	description = [[Die Serpent's Hand besteht aus einer Gruppe von Söldnern und Idealisten, welche Anomalien (wie z.B. SCPs) auf eine Ebene mit den Menschen setzen.
	Sie in Gefangenschaft der SCP-Foundation zu sehen, ist für sie unerträglich, weshalb sie angreifen, um SCPs zu befreien oder Daten zu stehlen.

	Der Serpents Hand Heavy ist die schwerste Einheit innerhalb der Serpent's Hand. 
	Mit ihm sollte man sich nicht anlegen, da ein Kampf mit ihm nahezu unbezwingbar ist.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","lockpick","radio_device","heavy_shield","cw_smoke_grenade","cw_hatchet","weaponchecker","weapon_bandages","weapon_leash_elastic"},
	command = "shdefender",
	max = 4,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "The Serpent's Hand",
	candemote = false,
	sortOrder = 3,
    health = 250,
	armor = 100,
	speed = 0.9,
    joblabelf4 = "Bewerbung",
	goi = true,
	sh = true,
	can_see = {
		sh = true,
		staff = true,
	},
})

TEAM_SHCMD = DarkRP.createJob("Serpent's Hand Commander", {
	color = Color(145, 145, 35, 255),
	model = "models/player/pidorasy.mdl",
	description = [[Die Serpent's Hand besteht aus einer Gruppe von Söldnern und Idealisten, welche Anomalien (wie z.B. SCPs) auf eine Ebene mit den Menschen setzen.
	Sie in Gefangenschaft der SCP-Foundation zu sehen, ist für sie unerträglich, weshalb sie angreifen, um SCPs zu befreien oder Daten zu stehlen.

	Die Aufgaben des Serpents Hand Commanders sind unbekannt.
	Bekannt ist nur, dass er die Serpents Hand leitet und das oberste Sagen hat.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_cuff_shackles","lockpick","radio_device","cw_frag_grenade","cw_machete","weapon_keycard_level3","heavy_shield","weaponchecker","weapon_bandages","weapon_leash_elastic","weapon_clipboard","commander_hammer"},
	command = "shcommander",
	max = 2,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "The Serpent's Hand",
	candemote = false,
	sortOrder = 4,
    health = 200,
	armor = 100,
    joblabelf4 = "Leitung",
	goi = true,
	sh = true,
	can_see = {
		sh = true,
		staff = true,
	},
})

TEAM_SHINF = DarkRP.createJob("Serpent's Hand Infiltrator", {
	color = Color(145, 145, 35, 255),
	model = {
		"models/dizcordum/rebel.mdl",
		"models/dizcordum/female_rebel.mdl"
	},
	description = [[Die Serpent's Hand besteht aus einer Gruppe von Söldnern und Idealisten, welche Anomalien (wie z.B. SCPs) auf eine Ebene mit den Menschen setzen.
	Sie in Gefangenschaft der SCP-Foundation zu sehen, ist für sie unerträglich, weshalb sie angreifen, um SCPs zu befreien oder Daten zu stehlen.

	Der Infiltrator ist keine Kampfeinheit im engeren Sinn, jedoch dazu in der Lage, sich als unterschiedliches Personal der Foundation zu tarnen und somit unauffällig in Einrichtungen einzudringen.
	Dort beschafft er wichtige Informationen, wie etwa über die Sicherheitsmaßnahmen der dortigen SCPs oder über andere größere Vorfälle.
	Weiters kann er anderes Personal zu korruptem Verhalten anstiften und im Falle eines Angriffs auch mit Waffengewalt aus dem Inneren agieren.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_cuff_elastic","lockpick","radio_device","weapon_keycard_level3","weaponchecker","weapon_leash_elastic","weapon_clipboard"},
	command = "shinfiltrator",
	max = 1,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "The Serpent's Hand",
	candemote = false,
	sortOrder = 5,
    armor = 100,
	maxpocket = 8,
	hiddenPocket = true,
    joblabelf4 = "Bewerbung",
	goi = true,
	sh = true,
	can_see = {
		sh = true,
		staff = true,
	},

})

-- Chaos Insurgency

TEAM_CIINFANTERY = DarkRP.createJob("Chaos Insurgency Infantry",{
	color = Color(145, 95, 40, 255),
	model = "models/ninja/mgs4_praying_mantis_merc.mdl",
	description = [[Die Chaos Insurgency ist eine Splittergruppe der Foundation, gegründet von Abtrünnigen, die sich mit mehreren sehr nützlichen SCPs davongemacht haben. 
	Seitdem zieht die Insurgency mehrere Terrorangriffe gegen Foundation durch.

	Die Infanteristen sind primär für Unterdrückungsfeuer und generelle Feuerkraft zuständig. 
	Sie sind die Einzigen, welche für Long Range ausgerüstet sind. 
	Zudem besitzen sie einen Schild auf welchem sie ihre High Cap Rifle auflegen können.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","lockpick","radio_device","cw_frag_grenade","cw_spade","deployable_shield","weaponchecker","weapon_bandages","weapon_leash_elastic"},
	command = "ciinfantery",
	max = 4,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Chaos Insurgency",
	candemote = false,
	sortOrder = 1,
    armor = 100,
	speed = 1.1,
	jumppower = 1.1,
    joblabelf4 = "Bewerbung",
	goi = true,
	ci = true,
	can_see = {
		ci = true,
		staff = true,
	},

})

TEAM_CISUPPORT = DarkRP.createJob("Chaos Insurgency Support",{
	color = Color(145, 95, 40, 255),
	model = "models/ninja/mgs4_praying_mantis_merc_short_sleeved.mdl",
	description = [[Die Chaos Insurgency ist eine Splittergruppe der Foundation, gegründet von Abtrünnigen, die sich mit mehreren sehr nützlichen SCPs davongemacht haben. 
	Seitdem zieht die Insurgency mehrere Terrorangriffe gegen Foundation durch.

	Der Supporter ist keine primäre Kampfeinheit.
	Sein Aufgabengebiet ist es Verbündeten auf dem Schlachtfeld zu helfen, sei es durch Feuerunterstützung oder medizinische Versorgung. 
	Als flexible Starteinheit kann der Supporter zwischen mittlere Distanz und kurze Distanz hin und her wechseln.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","lockpick","radio_device","cw_flash_grenade","cw_bat","weapon_med_kit","weapon_defib","weapon_bandages_medic","riot_shield","weaponchecker","weapon_bandages","weapon_leash_elastic"},
	command = "cisupport",
	max = 4,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Chaos Insurgency",
	candemote = false,
	sortOrder = 2,
    armor = 100,
	speed = 1.1,
	jumppower = 1.1,
    joblabelf4 = "Bewerbung",
	goi = true,
	ci = true,
	can_see = {
		ci = true,
		staff = true,
	},
})

TEAM_CIENFORCER = DarkRP.createJob("Chaos Insurgency Enforcer",{
	color = Color(145, 95, 40, 255),
	model = "models/ninja/mgs4_raven_sword_merc.mdl",
	description = [[Die Chaos Insurgency ist eine Splittergruppe der Foundation, gegründet von Abtrünnigen, die sich mit mehreren sehr nützlichen SCPs davongemacht haben. 
	Seitdem zieht die Insurgency mehrere Terrorangriffe gegen Foundation durch.

	Die Enforcer sind das Rückgrat der Insurgency. 
	Sie sind für das Aufbrechen von Verteidigungen verantwortlich und stehen ganz vorne an der Front, jederzeit bereit los zu stürmen. 
	Mit Ihrem schweren Schild blocken Sie Feindfeuer und durch hohe Feuerrate schreddern Sie gegnerische Stellungen.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","lockpick","radio_device","cw_smoke_grenade","cw_hatchet","heavy_shield","weaponchecker","weapon_bandages","weapon_leash_elastic"},
	command = "cienforcer",
	max = 4,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Chaos Insurgency",
	candemote = false,
	sortOrder = 3,
    health = 200,
	armor = 100,
    joblabelf4 = "Bewerbung",
	goi = true,
	ci = true,
	can_see = {
		ci = true,
		staff = true,
	},
})

TEAM_CICMD = DarkRP.createJob("Chaos Insurgency Commander",{
	color = Color(145, 95, 40, 255),
	model = "models/ninja/mgs4_pieuvre_armament_merc.mdl",
	description = [[Die Chaos Insurgency ist eine Splittergruppe der Foundation, gegründet von Abtrünnigen, die sich mit mehreren sehr nützlichen SCPs davongemacht haben. 
	Seitdem zieht die Insurgency mehrere Terrorangriffe gegen Foundation durch.

	Die Aufgabe des Commanders ist das Befehligen und Ausbilden neuer Einheiten. 
	Sie führen ihre Truppen in den Kampf und können als Filler agieren, welche sich je nach Situation passend ausrüsten können.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","lockpick","radio_device","cw_frag_grenade","cw_machete","weapon_keycard_level3","heavy_shield","weaponchecker","weapon_bandages","weapon_leash_elastic","weapon_clipboard","commander_hammer"},
	command = "cicommander",
	max = 2,
	salary = 140,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Chaos Insurgency",
	candemote = false,
	sortOrder = 4,
    health = 150,
	armor = 100,
    joblabelf4 = "Bewerbung",
	goi = true,
	ci = true,
	can_see = {
		ci = true,
		staff = true,
	},
})

TEAM_CIINT = DarkRP.createJob("Chaos Insurgency Intruder", {
	color = Color(145, 95, 40, 255),
	model = "models/jwk987/cod/ghost/keegan2.mdl",
	description = [[Die Chaos Insurgency ist eine Splittergruppe der Foundation, gegründet von Abtrünnigen, die sich mit mehreren sehr nützlichen SCPs davongemacht haben. 
	Seitdem zieht die Insurgency mehrere Terrorangriffe gegen Foundation durch.

	Der Intrduer ist keine Kampfeinheit im engeren Sinn, jedoch dazu in der Lage, sich als unterschiedliches Personal der Foundation zu tarnen und somit unauffällig in Einrichtungen einzudringen.
	Dort beschafft er wichtige Informationen, wie etwa über die Sicherheitsmaßnahmen der dortigen SCPs oder über andere größere Vorfälle.
	Weiters kann er anderes Personal zu korruptem Verhalten anstiften und im Falle eines Angriffs auch mit Waffengewalt aus dem Inneren agieren.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_cuff_elastic","lockpick","radio_device","weapon_keycard_level3","weaponchecker","weapon_leash_elastic","weapon_clipboard"},
	command = "ciintruder",
	max = 1,
	salary = 120,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Chaos Insurgency",
	candemote = false,
	sortOrder = 5,
    armor = 100,
	joblabelf4 = "Intern",
	goi = true,
	ci = true,
	can_see = {
		ci = true,
		staff = true,
	},
})

-- SCPs

TEAM_SCP999 = DarkRP.createJob("SCP-999", {
	color = Color(180, 180, 180, 255),
	model = "models/scp_9992/scp_9992_animated_pm.mdl",
	description = [[SCP-999 ist eine große, amorphe, gallertartige Masse aus durchscheinendem orangefarbenem Schleim zu sein, mit einem Gewicht von etwa 54 kg und einer Konsistenz ähnlich der von Erdnussbutter.
	Größe und Form des Subjekts sind leicht verformbar und es kann seine Gestalt nach Belieben verändern.
	Im Ruhezustand ist SCP-999 eine runde, abgeflachte Kuppel von etwa 2 m Breite und 1 m Höhe.
	Jeder Mitarbeiter darf mit ihm spielen, wenn es nicht mit anderen Arbeiten beschäftigt ist und SCP-999 dabei nicht geschadet wird.
	SCP-999 umarmt das Personal gerne und kitztelt andere hier und da auch mal.

	SCP-999 darf sich in den freigegebenen Zonen der Einrichtung frei bewegen, wenn es dies wünscht.]],
	weapons = {"weapon_scp999"},
	command = "sc999",
	max = 1,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 1,
	footstep = true,
	health = 1000,
	speed = 0.8,
	hullmins = Vector(-22, -22, 0),
	hullmaxs = Vector(22, 22, 38),
	height = 0.5,
	jumppower = 1.25,
	jumpcooldown = 0.5,
	level = 20,
})

TEAM_SCP131 = DarkRP.createJob("SCP-131", {
	color = Color(180, 180, 180, 255),
	model = {"models/scp131a2/scp131a2_animated_pm.mdl"},
	description = [[SCP-131-A und SCP-131-B sind ein Paar tropfenförmiger Kreaturen von etwa 30 cm Höhe mit einem einzigen Auge in der Mitte ihres Körpers.
	SCP-131-A hat eine orange Farbe, während SCP-131-B gelb ist.
	An der Basis jeder Kreatur befindet sich ein radähnlicher Fortsatz, der eine Fortbewegung ermöglicht, was auf einen möglichen biomechanischen Ursprung hindeutet.
	Sie dürfen sich frei bewegen und konnten bereits bei Aufgaben, wie dem Anschauen von SCP-173 helfen.
	Die Subjekte scheinen über die Intelligenz gemeiner Hauskatzen zu verfügen und sind unstillbar neugierig.
	Die Subjekte scheinen auf jede Zuneigung positiv zu reagieren, die ihnen gegeben wird, und binden sich schnell an den Urheber, ähnlich wie ein Welpe sich an einen Menschen bindet.

	Bei SCP-131-A und SCP-131-B müssen keine besonderen Sicherheitsmaßnahmen getroffen werden.
	Es ist den Subjekten gestattet, sich frei zu bewegen, solange sie nicht versuchen, verbotene Areale zu betreten oder die Anlage zu verlassen.]],
	weapons = {},
	command = "scp131",
	max = 2,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 2,
	footstep = true,
	speed = 1.25,
	hullmins = Vector(-12, -12, 0),
	hullmaxs = Vector(12, 12, 24),
	height = 0.25,
	jumppower = 1.6,
	jumpcooldown = 0.25,
	level = 30,
})

TEAM_SCP096 = DarkRP.createJob("SCP-096", {
	color = Color(180, 180, 180, 255),
	model = "models/scp096pm_raf.mdl",
	description = [[SCP-096 ist eine ungefähr 2,38 Meter große Kreatur mit menschlicher Erscheinung, welches die meiste Zeit damit verbringt, die Ostwand  seiner Zelle anzuschauen und zu weinen.
	Wenn jemand das Gesicht von SCP-096 sieht, tritt es in eine eine Phase emotionaler Anspannung ein.
	Dann hält SCP-096 die Hände an sein Gesicht und fängt an zu schreien und zu weinen.
	Nach kurzer Zeit nach dem ersten Sichtkontakt rennt SCP-096 zu der Person, die ihm ins Gesicht gesehen hat (die von diesem Zeitpunkt an als SCP-096-1 bezeichnet wird).
	Wenn SCP-096 auf SCP-096-1 trifft, tötet SCP-096 es.
	Nachdem SCP-096-1 getötet wurde, beruhigt sich SCP-096 wieder.

	SCP-096 muss zu jeder Zeit in einem 5 m x 5 m x 5 m luftdichten Stahlwürfel gesichert werden.
	Wöchentliche Überprüfungen auf Löcher oder Risse sind Pflicht.]],
	weapons = {"weapon_scp096"},
	command = "scp096",
	max = 1,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 4,
    speed = 0.8,
	slowwalkspeed = 0.6,
	height = 1.05,
	health = 100000,
	jumpcooldown = 0.5,
	level = 45,
})

TEAM_SCP173 = DarkRP.createJob("SCP-173", {
	color = Color(180, 180, 180, 255),
	model = "models/breach173.mdl",
	description = [[SCP-173 ist eine aus Beton und Bewehrungsstäben gebaute Statue mit Spuren von Sprühfarbe.
	SCP-173 ist extrem feindselig und bewegungsfähig, wenn es nicht innerhalb der Blickachse einer Person liegt.
	Es wird berichtet, dass das Objekt durch Genickbruch kurz unter der Schädelbasis angreif.
	Die rotbraune Substanz am Boden ist eine Mischung aus Fäkalien und Blut. Die Herkunft dieser Materialien ist unbekannt. Das Gehege ist zweiwöchig zu reinigen.

	SCP-173 ist jederzeit in einem verschlossenen Container aufzubewahren.
	Wenn Personal SCP-173s Container betreten muss, dürfen ihn nicht weniger als 3 Personen gleichzeitig betreten und die Tür ist hinter ihnen wieder zu verschließen.
	Zu jeder Zeit müssen zwei Personen direkten Blickkontakt mit SCP-173 halten, bis das ganze Personal den Container geräumt und wieder verschlossen hat.]],
	weapons = {"weapon_scp173"},
	command = "scp173",
	max = 1,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 5,
    footstep = true,
	walkspeed = 2,
	runspeed = 4,
	jumppower = 1.5,
	jumpcooldown = 0.5,
	height = 1.3,
	hullmaxs = Vector(16, 16, 96),
	health = 100000,
	level = 25,
})

TEAM_SCP1048 = DarkRP.createJob("SCP-1048", {
	color = Color(180, 180, 180, 255),
	model = "models/1048/tdy/tdybrownpm.mdl",
	description = [[SCP-1048 ist ein kleiner Teddybär, etwa 33 cm groß.
	Durch Tests wurde festgestellt, dass es verglichen mit einem Teddybären, der nicht denkfähig ist, keine Unterschiede in seiner Zusammensetzung gibt.
	Das SCP ist in der Lage, sich selbstständig zu bewegen.
	Es demonstriert Individuen gegenüber regelmäßig Zuneigung, welche von den meisten Menschen als liebenswert angesehen wird.
	Jegliches Foundation-Personal, das mit SCP-1048 in Kontakt getreten ist, zeigte eine positive Reaktion auf die Zuneigung.

	Das anomalere Verhalten von SCP-1048 wurde erst ungefähr 7 Monate nach seiner ursprünglichen Sicherstellung beobachtet.
	Die Hypothese ist, dass SCP-1048 in der Lage ist, grobe Repliken von sich selbst mit unterschiedlichen Materialien zu erstellen.]],
	weapons = {"weapon_scp1048"},
	command = "scp1048",
	max = 1,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 6,
    speed = 1.1,
	hullmins = Vector(-12, -12, 0),
	hullmaxs = Vector(12, 12, 24),
	hullduckmins = Vector(-12, -12, 0),
	hullduckmaxs = Vector(12, 12, 24),
	height = 0.26,
	heightduck = 0.2,
	jumppower = 1.25,
	level = 40,
})

TEAM_SCP049 = DarkRP.createJob("SCP-049", {
	color = Color(180, 180, 180, 255),
	model = "models/vinrax/player/scp049_player.mdl",
	description = [[SCP-049 ist eine etwa 1,90 Meter große humanoide Entität, die das Erscheinungsbild eines mittelalterlichen Seuchen-Doktors hat.
	Die Robe und die Keramikmaske, die SCP-049 trägt, sind mit der Zeit aus dem Körper des SCPs herausgewachsen und nun kaum mehr von dessen Körper zu unterscheiden.
	Untersuchungen mittels Röntgenaufnahmen deuten darauf hin, dass SCP-049 unter seiner äußeren Schicht eine humanoide Skelettstruktur aufweist.
	Er ist der Ansicht, dass jeder Mensch von einer Art Seuche infiziert ist und von ihm geheilt werden muss.
	Der Prozess seiner "Heilung" ist extrem schmerzhaft und endet mit dem kompletten Verlust aller kognitiven Fähigkeiten für das jeweilige Subjekt.
	Im Anschluss ist dieser eine Art Untoter, der sich am Fleisch anderer aufzehrt und nur noch, wenn auch nur leicht, auf SCP-049 reagiert und hört.

	SCP-049 ist in einer Standard-Isolierzelle für Humanoide]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_scp049","weapon_clipboard"},
	command = "scp049",
	max = 1,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 7,
    health = 5000,
	runspeed = 1.05,
	jumpcooldown = 1,
	level = 60,
})

TEAM_SCP682 = DarkRP.createJob("SCP-682", {
	color = Color(180, 180, 180, 255),
	model = "models/scp_682/scp_682_v2.mdl",
	description = [[SCP-682 ist eine reptilienartige Kreatur mit unbekannter Herkunft.
	Das SCP scheint extrem intelligent zu sein und während des kurzen Zusammentreffens mit SCP-079 eine komplexe Kommunikation.
	SCP-682 scheint alles Leben zu hassen und hat dies in mehreren Befragungen während der Isolation zum Ausdruck gebracht.
	Es wies stets extreme Stärke, hohe Agilität und flinke Reflexe auf, wenngleich sich dies mit seiner Form ändert.
	Der Körper des SCPS wächst und verändert sich sehr schnell, während es Material konsumiert oder abstößt.
	SCP-682 gewinnt Energie von allem, was es aufnimmt, gleich ob organisch oder anorganisch.
	Die Verdauung scheint von filternden Kiemen in den Nasenlöchern des SCPs unterstützt zu werden.
	Diese nehmen alles Brauchbare aus jeder Flüssigkeit auf, was es dazu befähigt, sich in der Säure, in der es isoliert wird, permanent zu regenerieren.]],
	weapons = {"weapon_scp682"},
	command = "scp682",
	max = 1,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 8,
	health = 6000,
	speed = 1.2,
	hullmins = Vector(-22, -22, 0),
	hullmaxs = Vector(22, 22, 44),
	height = 0.65,
	jumppower = 1.3,
	jumpcooldown = 0.5,
	level = 65,
})

TEAM_SCP106 = DarkRP.createJob("SCP-106", {
	color = Color(180, 180, 180, 255),
	model = "models/unity_scp_106_player.mdl",
	description = [[SCP-106, auch "The Old Man" genannt, ist ein SCP, mit dem zu keiner Zeit physisch interagiert werden darf.
	Sollte man dennoch mit ihm interagieren, wird SCP-106 diese Person in seine "Pocket Dimension" zerren, in welcher dann einen Weg zur Flucht gefunden werden muss.
	Wenn man SCP-106 recontainen möchte, muss eine Person in den "Femur Breaker" in dessen Zelle eingespannt werden und damit der Oberschenkel-Knochen (Femur) der Person gebrochen werden, damit das SCP aufgrund des Schreis wieder in seine Zelle zurückkehrt.
	Sofern jedoch SCP-106 nicht aus seiner Zelle ausgebrochen ist, muss die Zelle innerhalb eines elektromagnetischen Feldes mindestens 60 cm von der Oberfläche entfernt schweben.]],
	weapons = {"weapon_scp106"},
	command = "scp106",
	max = 1,
	salary = 80,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs",
	candemote = false,
	sortOrder = 9,
	speed = 1.3,
	health = 100000,
	jumpcooldown = 1,
	level = 70,
})


-- VIP-SCPs

TEAM_SCP527 = DarkRP.createJob("SCP-527", {
	color = Color(180, 180, 180, 255),
	model = "models/scp_527/scp_527.mdl",
	description = [[SCP-527 ist ein männlicher Humanoid, der 1,67 m groß und biologisch nicht anomal ist, mit Ausnahme seines Kopfes, der dem einer Messingbarbe ähnelt.
	SCP-527 zeigt keine anderen anomalen Eigenschaften.
	Der Kopf von SCP-527 funktioniert genauso wie der Kopf eines nicht anomalen Menschen.
	SCP-527 ist der normalen menschlichen Sprache fähig.
	Eine Tätowierung mit der Aufschrift "Mr. Fish von Little Misters ® von Dr. Wondertainment" erscheint auf der Unterseite seines linken Fußes.

	SCP-527 ist in einer Standardunterkunf einzudämmen.
	Es sind keine weiteren Sicherheitsmaßnahmen notwendig.]],
	weapons = {"weapon_fists","keys","pocket","animation_base"},
	command = "scp527",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs - VIP",
	candemote = false,
	sortOrder = 11,
        health = 200,
	joblabelf4 = "VIP",
	customCheck = function(ply) 
        return CLIENT or table.HasValue({"VIP"}, ply:GetUserGroup()) 
    end,
    CustomCheckFailMsg = "Nur für VIPs!",
})

TEAM_SCP966 = DarkRP.createJob("SCP-966", {
	color = Color(180, 180, 180, 255),
	model = "models/scp/966.mdl",
	description = [[SCP-966-Exemplare sind räuberische Kreaturen, die haarlosen, zehengängigen Menschen ähneln.
	Die Form ihres Gesichts ist länglich und die im Mund angelegten Zähne ähneln Nadeln.
	Physisch sind SCP-966-Instanzen schwach und besitzen nebst Hohlknochen eine geringe Muskeldichte, was sehr schnell zum Nachteil werden kann.
	SCP-966-Instanzen verspeisen mittelgroße bis große Tiere als Nahrung, Menschen mit eingeschlossen.
	Die Jagdmethode der SCP-966-Instanzen besteht darin, dass diese einen einzelnen Impuls aussenden, dessen Art unbekannt ist.
	Dieser Impuls nimmt jeglichen Kreaturen die Möglichkeit, eine Schlafphase zu erreichen.
	Nachdem SCP-966-Instanzen ihren Opfern den Schlaf geraubt haben, verfolgen sie diese, bis sie durch Erschöpfung außer Gefecht gesetzt worden sind, um diese dann kaltblütig zu verspeisen.

	SCP-966 müssen in einem 10 x 10 m großen Raum gehalten werden, der aus Stahl besteht und mit Blei ausgekleidet ist.]],
	weapons = {"weapon_scp966"},
	command = "DFSDJHFJ",
	max = 2,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs - VIP",
	candemote = false,
	sortOrder = 12,
    speed = 0.9,
	health = 4000,
	maxhealth = 6000,
	jumppower = 1.35,
	jumpcooldown = 1,
	footstep = true,
	joblabelf4 = "VIP +",
})

TEAM_SCP939 = DarkRP.createJob("SCP-939", {
	color = Color(180, 180, 180, 255),
	model = "models/unity_scp_939_v2.mdl",
	description = [[SCP-939 ist ein Rudel aus 9 Raubtieren, welche unter starken Nahrungsmangel leiden.
	Ihre Haut ist rot, sie sind aufrecht 2,2m groß und versuchen Beute anzulocken.
	Um diese Beute anzulocken, imitieren sie die Stimmen ihrer vorherigen Opfer.
	Es ist unklar, wie genau sie diese Stimmen imitieren und ob sie nur Gehörtes wiedergeben oder verstehen und mit dieser Stimme eigene Sätze bilden.

	SCP-939 werden in 10 x 10 x 3m großen Aufbewahrungsräumen beheimatet.
	Die Zelle ist umweltreguliert, unter negativem Druck und aus Stahlbeton erbaut.]],
	weapons = {"weapon_scp939"},
	command = "scp939",
	max = 2,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs - VIP",
	candemote = false,
	sortOrder = 13,
    health = 6000,
	speed = 1.4,
	hullmins = Vector(-22, -22, 0),
	hullmaxs = Vector(22, 22, 80),
	hullduckmins = Vector(-22, -22, 0),
	hullduckmaxs = Vector(22, 22, 60),
	height = 1.1,
	jumppower = 1.5,
	jumpcooldown = 0.5,
	joblabelf4 = "VIP +"
})

-- Bewerbungs SCP's

TEAM_SCP066 = DarkRP.createJob("SCP-066", {
	color = Color(180, 180, 180, 255),
	model = "models/scp_066_pm.mdl",
	description = [[SCP-066 ist eine amorphe Masse aus geflochtenem Garn und Bändern, die etwa einen Kilogramm wiegt.
	Stränge von SCP-066 können einzeln aufgenommen und bearbeitet werden.
	Wenn dies getan wird, wird von SCP-066 eine Note auf der diatonischen Tonleiter (C-D-E-F-G-A-B) erzeugt.

	Nach Vorfall 066–2, in welchem versucht wurde, ein Teil von SCP-066 mittels einer Schere zu entfernen, begann das SCP, Eigenschaften aufzuweisen, welche höchst widersprüchlich zu seinem früheren Verhalten sind.
	SCP-066 zeigt nun signifikante Mobilität, vor allem dahingehend, dass es tentakelartige Teile seines Körpers mit sehr hoher Geschwindigkeit bewegen kann.

	SCP-066 darf sich frei bewegen, solange es keinerlei Gefahr für das Personal darstellt.]],
	weapons = {"weapon_scp066"},
	command = "scp066",
	max = 1,
	salary = 100,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "SCPs - VIP",
	candemote = false,
	sortOrder = 15,
    footstep = true,
	health = 250,
	speed = 1.25,
	hullmaxs = Vector(16, 16, 26),
	height = 0.35,
	jumppower = 0.6,
	joblabelf4 = "VIP",
})

TEAM_EVENT = DarkRP.createJob("Eventberuf", {
	color = Color(255, 200, 0, 255),
	model = {
		"models/player/group01/female_01.mdl",
		"models/player/group01/female_02.mdl",
		"models/player/group01/female_03.mdl",
		"models/player/group01/female_04.mdl",
		"models/player/group01/female_06.mdl",
		"models/player/group01/male_01.mdl",
		"models/player/group01/male_02.mdl",
		"models/player/group01/male_03.mdl",
		"models/player/group01/male_04.mdl",
		"models/player/group01/male_05.mdl",
		"models/player/group01/male_06.mdl",
		"models/player/group01/male_07.mdl",
		"models/player/group01/male_08.mdl",
		"models/player/group01/male_09.mdl",

		"models/cultist/fbi_1.mdl",
		"models/cultist/fbi_2.mdl",
		"models/cultist/fbi_3.mdl"
	},
	description = [[Ein Eventberuf, der nur zu speziellen Anlässen benutzt wird.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","radio_device"},
	command = "event",
	max = 0,
	salary = 0,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Serverteam",
	staff = true,
	candemote = false,
	sortOrder = 3,
	joblabelf4 = "Intern",
})

TEAM_SOD = DarkRP.createJob("Staff on Duty", {
	color = Color(122, 102, 122, 255),
	model = "models/player/gman_high.mdl",
	description = [[>>Nur für Teammitglieder vorgesehen<<

	Dieser Beruf kann nur vom Serverteam benutzt werden und dient lediglich dem dauerhaften Administrieren auf dem Server.]],
	weapons = {"weapon_fists","keys","pocket","animation_base","weapon_physgun","gmod_tool","radio_device","weapon_keycard_level6","weapon_bandages_medic","weapon_med_kit"},
	command = "sod",
	max = 0,
	salary = 50,
	admin = 0,
	vote = false,
	hasLicense = false,
	category = "Serverteam",
	candemote = false,
	staff = true,
	sortOrder = 4,
	joblabelf4 = "Intern",
})

--[[-------------------------------------- ------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------]]
GAMEMODE.DefaultTeam = TEAM_BEITRITSBERUF

--[[---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------]]
GAMEMODE.CivilProtection = {
}