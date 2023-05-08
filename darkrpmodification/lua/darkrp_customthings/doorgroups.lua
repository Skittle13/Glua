-- "addons\\scp_darkrpmod\\lua\\darkrp_customthings\\doorgroups.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[---------------------------------------------------------------------------
Door groups
---------------------------------------------------------------------------
The server owner can set certain doors as owned by a group of people, identified by their jobs.


HOW TO MAKE A DOOR GROUP:
AddDoorGroup("NAME OF THE GROUP HERE, you will see this when looking at a door", Team1, Team2, team3, team4, etc.)
---------------------------------------------------------------------------]]

-- Example: AddDoorGroup("Cops and Mayor only", TEAM_CHIEF, TEAM_POLICE, TEAM_MAYOR)
-- Example: AddDoorGroup("Gundealer only", TEAM_GUN)

AddDoorGroup("Serpent's Hand-Lagerhalle", TEAM_SHCMD, TEAM_SHHEAVY, TEAM_SHASSAULT, TEAM_SHSUPPORTER, TEAM_SHINF, TEAM_SHWACHHUND, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)

AddDoorGroup("Serpent's Hand-Basis", TEAM_SHCMD, TEAM_SHHEAVY, TEAM_SHASSAULT, TEAM_SHSUPPORTER, TEAM_SHINF, TEAM_SHWACHHUND, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)

AddDoorGroup("Chaos Insurgency-Lagerhalle", EAM_CICMD, TEAM_CIINFANTERY, TEAM_CIENFORCER, TEAM_CISUPPORT, TEAM_CIINT, TEAM_CICMD, TEAM_CIWACHHUND, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)

AddDoorGroup("Chaos Insurgency-Basis", EAM_CICMD, TEAM_CIINFANTERY, TEAM_CIENFORCER, TEAM_CISUPPORT, TEAM_CIINT, TEAM_CICMD, TEAM_CIWACHHUND, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)

AddDoorGroup("Medic Bay", TEAM_FELDSANITAETER, TEAM_PSYCHOLOGE, TEAM_MEDIZINERLEITUNG, TEAM_ALLGEMEINMEDIZINER, TEAM_SD, TEAM_EPSILON11, TEAM_LAMBDA9, TEAM_ZIFFERAGENT, TEAM_O5, TEAM_ETHIK, TEAM_ALPHA1, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)

AddDoorGroup("Kühlraum", TEAM_KOCH, TEAM_SICHERHEITSDIENST, TEAM_SICHERHEITSKOMMANDO, TEAM_SICHERHEITSLEITUNG, TEAM_OMEGASEVEN, TEAM_SD, TEAM_EPSILON11, TEAM_LAMBDA9, TEAM_ZIFFERAGENT, TEAM_O5, TEAM_ETHIK, TEAM_ALPHA1, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)

AddDoorGroup("Kontrollpunkt", TEAM_MTF, TEAM_DELTA5, TEAM_NU7, TEAM_ALPHA1, TEAM_BETA7, TEAM_EPSILON11, TEAM_LAMBDA9, TEAM_SD, TEAM_ZIFFERAGENT, TEAM_O5, TEAM_ETHIK, TEAM_CONTAINMENT, TEAM_CTPIONIER, TEAM_CTLEITUNG, TEAM_KREINHEIT, TEAM_FOUNDATIONHUND, TEAM_OMEGASEVEN, TEAM_FELDAGENT, TEAM_MEDIZINERLEITUNG, TEAM_FELDSANITAETER, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)

AddDoorGroup("Hidden S&S Solutions", TEAM_MTF, TEAM_DELTA5, TEAM_NU7, TEAM_ALPHA1, TEAM_BETA7, TEAM_EPSILON11, TEAM_LAMBDA9, TEAM_SD, TEAM_ZIFFERAGENT, TEAM_O5, TEAM_ETHIK, TEAM_CONTAINMENT, TEAM_CTPIONIER, TEAM_CTLEITUNG, TEAM_KREINHEIT, TEAM_FOUNDATIONHUND, TEAM_OMEGASEVEN, TEAM_FELDAGENT, TEAM_MEDIZINERLEITUNG, TEAM_FELDSANITAETER, TEAM_SOD, TEAM_OWNER, TEAM_EVENT)