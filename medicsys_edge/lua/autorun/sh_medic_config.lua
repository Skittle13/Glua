MedConfig = {}

MedConfig.EnableDebug = false //Enables some useful printing

MedConfig.EnableRagdoll = true //Enables ragdoll system, disabling it will remove GM_Dragging, but increase perfomance (Just a bit since ragdolls are heaviest)
MedConfig.DisableKnockup = true //Disables knockup (So explosions, getting hit by a car or any iteraction is cancelled)
MedConfig.EnableDeathScreen = true //Disabling it (Along with EnableRagdoll) will make players to control their spawn

MedConfig.RagdollDamage = true //When someone shoots at a ragdoll, it deals damage to owner
MedConfig.RagdollHealth = 100 //Max damage a ragdoll can get before getting killed
MedConfig.DeathCountdown = 60 //Death timer seconds 100
MedConfig.UnconsciousCD = 60 //Time when you are unconscious

MedConfig.PersistHealth = true //User when get revived, recover it health?
MedConfig.DisallowSuicide = true //Disallow suicide

MedConfig.AllowGM_Dragging = true //Allow corpses GM_Dragging

MedConfig.EnableBleeding = true //Enables bleeding system
MedConfig.BleedingDecals = true //Enable bleeding decals, might crash servers with cars models
MedConfig.BleedingChance = 60 //When getting damaged by a bullet, whatare your chances of getting a bleed
MedConfig.BleedingExtra = 0.5 //If a bullet has 5 damage, you will receive 15 of damage
MedConfig.BleedingInterval = {2, 5.5} //How much does the bleeding lasts
MedConfig.MaxBleeding = 500 //Max bleeding you can catch
MedConfig.BleedOverlay = true //Shows a light red overlay while having a bleeding

MedConfig.WoundsEnabled = true //Enables wound system
if CLIENT then
    MedConfig.StatePosition = {16, 180} //State hud position 
    MedConfig.BleedScale = 1 //HUD Bleed Scale
end
MedConfig.AimMagnitude = 1 //How arm aim get affected by getting arms crippled
MedConfig.LegsMagnitude = 0.3
MedConfig.ExtraChestDamage = 0.5 //Extra damage caused by cripple chest (At 0%. you will make extra 50% damage)

MedConfig.DefibChance = 100 //Chance of getting revived
MedConfig.DefibCharge = 2 //How much does last a defib charge
MedConfig.MaxBandages = 100 //How many bandages can a player carry
MedConfig.BandageHealing = 0 //How much does bandage heal
MedConfig.WoundHealing = 0.40 //How much does the bandage heal your wounds, example 15% of head wounds
MedConfig.BleedingHealing = 15 //How many bleeding does it heal (put -1 to heal completely)
MedConfig.BandageShowInfo = true //Draw player wounds when aiming

MedConfig.EnableYelling = true //People screams when getting hurt
MedConfig.ExtraFemales = { //Special female models with not female/male inside it path
    ["models/dea_pack/dea_04.mdl"] = true,
}

MedConfig.UseBuiltInDamageScaler = true //Use below configuration to modify damage scale on hitgroups
MedConfig.DamageScale = {
    [HITGROUP_GENERIC] = 0.8, //Default hitgroup, used on bad playermodels
    [HITGROUP_HEAD] = 1, //Head
    [HITGROUP_CHEST] = 0.7, //Chest
    [HITGROUP_STOMACH] = 0.6, //Stomatch (Not sure if it works)
    [HITGROUP_LEFTARM] = 0.5, //Left arm
    [HITGROUP_RIGHTARM] = 0.5, //Right Arm
    [HITGROUP_LEFTLEG] = 0.5, //Left Leg
    [HITGROUP_RIGHTLEG] = 0.5, //Right Leg
    [HITGROUP_GEAR] = 0.5 //Belt, not all models has this bodygroup
}

MedConfig.Jobs = {} //Don't add your jobs here, or those won't work
MedConfig.BlacklistedTeams = {} //Teams that are completely ignored by the script
MedConfig.LootCrate_BlacklistTeam = {}
timer.Simple(1, function()
    MedConfig.Jobs = { //Add the jobs inside [] = true
        [TEAM_MEDIC] = true,
        [TEAM_POLICE or 1] = true
    }
    MedConfig.LootCrate_BlacklistTeam = { //Jobs that won't drop loot crates
        [TEAM_POLICE or -1] = true
    }
    MedConfig.BlacklistedTeams = {
        [TEAM_NOTHING or -1] = true
    }
end)

MedConfig.Translatables = {}

MedConfig.Translatables.DragRagdoll = "Tragen"

MedConfig.Translatables.Bleed = "Blutung"
MedConfig.Translatables.Bleed_1 = "Starke"
MedConfig.Translatables.Bleed_2 = "Riskante"
MedConfig.Translatables.Bleed_3 = "Kleine"
MedConfig.Translatables.Bleed_4 = "Leichte"

MedConfig.Translatables.Head = "Kopf"
MedConfig.Translatables.Chest = "Brust"
MedConfig.Translatables.Arms = "Arme"
MedConfig.Translatables.Legs = "Beine"

//Don't touch anything below this!

game.AddAmmoType( {
	name = "ammo_bandage",
	maxcarry = MedConfig.MaxBandages
} )

function MedConfig.CanSee(ply)
    return MedConfig.Jobs[ply:Team()]
end

function MedConfig.MedicsAvailable()
    local i = 0
    for _,v in pairs(player.GetAll()) do
        if (MedConfig.Jobs[v:Team()]) then
            i = i + 1
        end
    end
    return i
end
