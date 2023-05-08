-- "addons\\scp_darkrpmod\\lua\\darkrp_customthings\\groupchats.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[---------------------------------------------------------------------------
Group chats
---------------------------------------------------------------------------
Team chat for when you have a certain job.
e.g. with the default police group chat, police officers, chiefs and mayors can
talk to one another through /g or team chat.
HOW TO MAKE A GROUP CHAT:
Simple method:
GAMEMODE:AddGroupChat(List of team variables separated by comma)
Advanced method:
GAMEMODE:AddGroupChat(a function with ply as argument that returns whether a random player is in one chat group)
This is for people who know how to script Lua.
---------------------------------------------------------------------------]]
-- Example: GAMEMODE:AddGroupChat(TEAM_MOB, TEAM_GANG)
-- Example: GAMEMODE:AddGroupChat(function(ply) return ply:isCP() end)

DarkRP.createGroupChat(TEAM_DKLASSE, TEAM_DKLASSESCHLAEGER, TEAM_DKLASSELIGHT, TEAM_DKLASSEHEAVY, TEAM_DKLASSETUEFTLER)

DarkRP.createGroupChat(TEAM_MEDIZINERLEITUNG, TEAM_ALLGEMEINMEDIZINER, TEAM_PSYCHOLOGE, TEAM_FELDSANITAETER)

DarkRP.createGroupChat(TEAM_WISSENSCHAFTLER, TEAM_WISSENSCHAFTLEITUNG)

DarkRP.createGroupChat(TEAM_SICHERHEITSDIENST, TEAM_SICHERHEITSKOMMANDO, TEAM_SICHERHEITSLEITUNG, TEAM_RIOT)

DarkRP.createGroupChat(TEAM_CONTAINMENT, TEAM_CTPIONIER, TEAM_CTLEITUNG)

DarkRP.createGroupChat(TEAM_MTF, TEAM_DELTA5, TEAM_NU7, TEAM_BETA7, TEAM_KREINHEIT, TEAM_FOUNDATIONHUND, TEAM_OMEGASEVEN, TEAM_FELDAGENT, TEAM_LAMBDA9, TEAM_EPSILON11)

DarkRP.createGroupChat(TEAM_SD, TEAM_O5, TEAM_ETHIK, TEAM_ZIFFERAGENT, TEAM_ALPHA1)

DarkRP.createGroupChat(TEAM_SHCMD, TEAM_SHHEAVY, TEAM_SHASSAULT, TEAM_SHSUPPORTER, TEAM_SHINF, TEAM_SHWACHHUND)

DarkRP.createGroupChat(TEAM_CICMD, TEAM_CIINFANTERY, TEAM_CIENFORCER, TEAM_CISUPPORT, TEAM_CIINT, TEAM_CIWACHHUND)

DarkRP.createGroupChat(TEAM_SEKRETAERIN, TEAM_GOC, TEAM_EVENT, TEAM_SOD, TEAM_OWNER)

DarkRP.createGroupChat(function(ply) -- SCPs
	local job_tbl = RPExtraTeams[ply:Team()]
	return job_tbl and job_tbl.scp and !job_tbl.scp.nogc
end)