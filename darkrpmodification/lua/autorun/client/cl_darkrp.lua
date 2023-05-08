-- "addons\\scp_darkrpmod\\lua\\autorun\\client\\cl_darkrp.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
net.Receive("DarkRP_ColoredText", function()
	local text = net.ReadTable()
	chat.AddText(unpack(text))
	chat.PlaySound()
end)