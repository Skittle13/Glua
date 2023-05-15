ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

ENT.PrintName = "Ragdoll"
ENT.Category = "Roleplay"

ENT.Spawnable = true
ENT.AdminSpawnable = true

sound.Add( {
	name = "heart_bacon_loop",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 80,
	pitch = { 95, 110 },
	sound = "gui/heart_loop.wav"
} )

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Owner")
	self:NetworkVar("Entity", 1, "Ragdoll")
	self:NetworkVar("Float", 2, "WakeUp")
	self:NetworkVar("Bool", 3, "IsDead")
	self:NetworkVar("Float", 4, "Respawn")
end