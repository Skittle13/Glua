--Made/Edited By Ciarox

local codecol = Color(0,255,0)
local codecode = "Code: Green"

surface.CreateFont( "LSCPCodeFont", {
	font = "Roboto",
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = false,
} )

hook.Add("HUDPaint","ciarox_scp_code",function()
  surface.SetFont("WSG.CodesHeader")
  surface.SetDrawColor(Color(50,50,50,200))
  surface.DrawRect(ScrW() * 0.007, ScrW() * 0.039, ScrW() * 0.15,ScrW() * 0.016 +1.2 )
  surface.SetDrawColor(Color(255,255,255,50))
  surface.DrawOutlinedRect(ScrW() * 0.007, ScrW() * 0.039, ScrW() * 0.15,ScrW() * 0.016 +1.2 )
  surface.SetDrawColor(Color(255,255,255,120))
  		WSG.DrawEdges(ScrW() * 0.007, ScrW() * 0.039, ScrW() * 0.15,ScrW() * 0.016,  8, 2)
  draw.DrawText(codecode, "WSG.CodesHeader", ScrW() * 0.081,ScrW() * 0.041, codecol, TEXT_ALIGN_CENTER)
end)

hook.Add("InitPostEntity", "ciarox_scp_code", function()
	net.Start("ciarox_scp_code")
	net.SendToServer()
end )

--config

net.Receive("ciarox_scp_code", function()
  local codetext = net.ReadString()
  codecode = "Code: "..codetext
  if (codetext == "Green") then
    codecol = Color(0,255,0)
    chat.AddText(codecol, "[CODESYSTEM]:Die Site besteht unter Code Green das gesamte Personal kann ihrer Arbeit nachgehen ")
  elseif (codetext == "Yellow") then
    codecol = Color(255,255,0)
    chat.AddText(codecol, "[CODESYSTEM]:Die Site besteht unter Code Yellow erh�te Gefahrenstufe  ")
  else
    codecol = Color(255,0,0)
    chat.AddText(codecol, "[CODESYSTEM]:Die Site besteht unter Code Red alle nicht relevanten Verteidigungs Einheiten begeben sich in den Bunker  ")
  end
end)

--end

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


