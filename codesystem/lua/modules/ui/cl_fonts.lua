function WSG:CreateFont(name, size)
    local tbl = {
		font = "Default",
		size = size + 2,
		weight = 500,
		extended = true
	}

    surface.CreateFont(name, tbl)
end


surface.CreateFont("WSG.CodesHeader", {
	font = "Roboto",
	weight = 10,
	size = ScrW() * 0.011,
})

surface.CreateFont("WSG.CodesBig", {
	font = "Roboto",
	weight = 10,
	size = ScrW() * 0.018,
})


surface.CreateFont("WSG.HeadBig", {
	font = "Roboto",
	weight = 10,
	size = 75,
})

surface.CreateFont("WSG.DeathHead", {
	font = "Roboto",
	weight = 10,
	size = 60,
})

surface.CreateFont("WSG.DeathText", {
	font = "Roboto",
	weight = 10,
	size = 25,
})


surface.CreateFont("WSG.CodesPlayer", {
	font = "Roboto",
	weight = 10,
	size = ScrW() * 0.020,
})


surface.CreateFont("WSG.Scoreboard", {
	font = "Roboto",
	weight = 10,
	size = ScrW() * 0.015,
})


surface.CreateFont("PermaProps.Title", {
	font = "Roboto",
	extended = false,
	size = ScrH()/27,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})


surface.CreateFont("PermaProps.Title2", {
	font = "Roboto",
	size = ScrH()/40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont("PermaProps.Title2Symbol", {
	font = "Roboto",
	extended = true,
	size = ScrH()/40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	symbol = true,
})

surface.CreateFont("PermaProps.Button", {
	font = "Roboto",
	extended = false,
	size = ScrH()/40,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont("PermaProps.Button2", {
	font = "Roboto",
	extended = false,
	size = ScrH()/60,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont("PermaProps.Text", {
	font = "Roboto",
	extended = false,
	size = ScrH()/50,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont("PermaProps.DetailText", {
	font = "Roboto",
	extended = false,
	size = ScrH()/65,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})

surface.CreateFont("PermaProps.TextEntry", {
	font = "Roboto",
	extended = false,
	size = ScrH()/55,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})
