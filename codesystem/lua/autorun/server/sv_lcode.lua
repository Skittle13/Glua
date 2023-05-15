--Made/Edited By Ciarox

util.AddNetworkString("ciarox_scp_code")
--config
local lallowedCodes = {
  ["Green"] = true,
  ["Red"] = true,
  ["Yellow"] = true,
}

local lallowedJobs = {
  ["Mayor"] = true,
  ["Site Director"] = true,
  ["O5-Rat"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  ["XXXXXXXX"] = true,
  
}
--end
local lcurcode = "Green"


--nur übersetzen
hook.Add("PlayerSay", "ciarox_scp_code", function(ply,text,team) 
	if string.Split(text," ")[1] == "/code" then
    if not lallowedJobs[ply:getJobTable().name] then
      DarkRP.notify(ply,1,5,"du bist uncool. du darfst das nicht")
      return ""
    end
    local code = string.Split(text," ")[2]
    if not lallowedCodes[code] then
      DarkRP.notify(ply,1,5,"Du nix code ändern")
      return
    end
    lcurcode = code
    net.Start("ciarox_scp_code")
      net.WriteString(code)
    net.Broadcast()
    DarkRP.notify(player.GetAll(),1,5,"Code geändert in "..code.."!")
    return ""
  end
end)
--end

net.Receive("ciarox_scp_code", function(len,ply)
  net.Start("ciarox_scp_code")
      net.WriteString(lcurcode)
    net.Send(ply)
end)

print("[Ciarox: Code_System] Loaded!")
print("[Chupapi] Loaded!")
