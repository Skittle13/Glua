util.AddNetworkString("Ragdoll.SendDrag")
util.AddNetworkString("Ragdoll.StartGM_Dragging")

local meta = FindMetaTable("Player")

local function TakeMoney(ply, amount)
    if amount == 0 then return end
    local money = ply:getDarkRPVar("money", 0)
    if money < amount then
        ply:addMoney(-money)
        return
    end
    ply:addMoney(-amount)
end

function meta:TurnIntoRagdoll(knof, vel, dmg, time)
    local tb = self:GetTable()

    if tb._IsDead then return end
    tb._IsDead = true
    hook.Call("MedicSys_PlayerDeath", nil, self, dmg)

    local weptbl = {}
    if self.GetWeapons then
        for k, v in pairs(self:GetWeapons()) do
            if IsValid(v) then
                if v.ClassName then
                    if string.find(v.ClassName, "handcuffed") then continue end
                    weptbl[v.ClassName] = true
                end
            end
        end
    end
	tb._SavedDeathWeapons = weptbl
    self:StripWeapons()

    self:AddDeaths(1)

	if(dmg:GetAttacker():IsPlayer()) then
        dmg:GetAttacker():AddFrags(1)
	end
    if not self:IsKnocked() then
        tb._wakeIn = CurTime() + MedConfig.DeathCountdown
		self:SetNW2Entity("RagdollEntity", self:GetRagdollEntity())
    end
    local networked_entity = self
    if (MedConfig.EnableRagdoll and !self:IsKnocked()) then
        self:SetHealth(math.max(self:Health() - dmg:GetDamage(), 0))
        local ragdoll = ents.Create("sent_death_ragdoll")
        ragdoll:SetModel(self:GetModel())
        ragdoll:Spawn()
        ragdoll:SetPlayer(self, knof, vel, dmg, time)
        self:SetBleeding(0)
        
        if tb.MedicSys_InstantDeath then
            tb.MedicSys_InstantDeath = nil
            if ragdoll then
                ragdoll.dt.IsDead = true
            end
        end

        networked_entity = ragdoll
        hook.Run("MedicSys_RagdollCreated", self, ragdoll, dmg)
    end

    tb.DeathBody = networked_entity

    local money = self:getDarkRPVar("money", 0)
    local mult = tb.MedicSys_MoneyLossMult or 1
    if math.random(0, 4) == 2 or money > 700000 then
        TakeMoney(self, math.random(100, money/20) * mult)
        networked_entity:EmitSound("npc/combine_soldier/gear3.wav")
    end
end

local function ReleaseRagdoll(ply)
    ply:SetNWInt("DragPlayerGMNext", CurTime() + 0.5)
    net.Start("Ragdoll.SendDrag")
    net.WriteEntity(game.GetWorld())
    net.Send(ply)

    if (ply.GM_Dragging != nil and IsValid(ply.CarryHack) and IsValid(ply.GM_Dragging.ent)) then
		if(ply.GM_Dragging.ent.PlayerOwn) then
			if(IsValid(ply.GM_Dragging.ent.PlayerOwn)) then
				alogs.AddLog("Mediziner", ply:Nick() .. " (" .. team.GetName(ply:Team()) .. ") hat aufgehört die Leiche von " .. ply.GM_Dragging.ent.PlayerOwn:Nick() .. " (" .. team.GetName(ply.GM_Dragging.ent.PlayerOwn:Team()) .. ") zu tragen", ply:SteamID(), ply:SteamID64())
			end
		end
		if (IsValid(ply.CarryHack.Constr)) then
            ply.CarryHack.Constr:Remove()
        end
        ply.CarryHack:Remove()

        local phys = ply.GM_Dragging.ent:GetPhysicsObject()
        if IsValid(phys) then
            phys:EnableCollisions(true)
            phys:EnableGravity(true)
            phys:EnableDrag(true)
            phys:EnableMotion(true)
            phys:Wake()
            phys:ApplyForceCenter(ply:GetAimVector() * 500)

            phys:ClearGameFlag(FVPHYSICS_PLAYER_HELD)
            phys:AddGameFlag(FVPHYSICS_WAS_THROWN)
        end
        
        ply.GM_Dragging.ent.IsGrabbed = false
    end

    ply.GM_Dragging = nil
end

hook.Add("KeyPress", "Ragdoll.Grab", function(ply, key)
    if ((key == IN_USE or key == IN_ATTACK or key == IN_JUMP or key == IN_SPEED or key == IN_RELOAD) and ply.GM_Dragging) then
        if(ply:GetNWInt("DragPlayerGMNext", 0) < CurTime()) then
            ReleaseRagdoll(ply)
        end
    end
end)

net.Receive("Ragdoll.StartGM_Dragging", function(l, ply)
    if ply:getJobTable().disallowDrag then return end
    local ply_tb = ply:GetTable()

    local nextAllowedSend = ply.StartDragCooldown or 0
    if nextAllowedSend > CurTime() then return end
    ply_tb.StartDragCooldown = CurTime() + 0.25
    ply:SetNWInt("DragPlayerGMNext", CurTime() + 0.5)
    local trace = ply:GetEyeTrace().Entity
    if ((trace.DeathRagdoll) and !trace.IsGrabbed) then
        if (IsValid(ply_tb.CarryHack)) then
            ply_tb.CarryHack:Remove()
            ply_tb.CarryHack = nil
        end
        local tr = util.TraceLine( {
            start = ply:EyePos(),
            endpos = ply:EyePos() + ply:EyeAngles():Forward() * 10000,
            filter = ply
        } )

        ply_tb.GM_Dragging = {
            ent = trace,
            bone = tr.PhysicsBone
        }

        ply_tb.CarryHack = ents.Create("prop_physics")
        if IsValid(ply_tb.CarryHack) then
			if(trace.PlayerOwn) then
				if(IsValid(trace.PlayerOwn)) then
                    if(trace:GetClass() == "prop_ragdoll") then
                        alogs.AddLog("Mediziner", ply:Nick() .. " (" .. team.GetName(ply:Team()) .. ") hat angefangen " .. trace.PlayerOwn:Nick() .. " (" .. team.GetName(trace.PlayerOwn:Team()) .. ") zu tragen", ply:SteamID(), ply:SteamID64())
                    else
                        alogs.AddLog("Mediziner", ply:Nick() .. " (" .. team.GetName(ply:Team()) .. ") hat angefangen die Leiche von " .. trace.PlayerOwn:Nick() .. " (" .. team.GetName(trace.PlayerOwn:Team()) .. ") zu tragen", ply:SteamID(), ply:SteamID64())
                    end
					ply_tb.CarryHack:SetPos(trace:GetPos())
				end
			end

            ply_tb.CarryHack:SetModel("models/weapons/w_bugbait.mdl")

            ply_tb.CarryHack:SetColor(Color(50, 250, 50, 240))
            ply_tb.CarryHack:SetNoDraw(true)
            ply_tb.CarryHack:DrawShadow(false)

            ply_tb.CarryHack:SetHealth(999)
            ply_tb.CarryHack:SetOwner(ply)
            ply_tb.CarryHack:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
            ply_tb.CarryHack:SetSolid(SOLID_NONE)
            
            -- set the desired angles before adding the constraint
            ply_tb.CarryHack:SetAngles(ply:GetAngles())

            ply_tb.CarryHack:Spawn()
        end

        local phys = ply_tb.CarryHack:GetPhysicsObject()
        if IsValid(phys) then
            phys:SetMass(200)
            phys:SetDamping(0, 1000)
            phys:EnableGravity(false)
            phys:EnableCollisions(true)
            phys:EnableMotion(false)
            phys:AddGameFlag(FVPHYSICS_PLAYER_HELD)
        end

        trace:GetPhysicsObject():AddGameFlag(FVPHYSICS_PLAYER_HELD)

        //ply.CarryHack.Constr = constraint.Weld(ply.CarryHack, trace, 0, tr.PhysicsBone, 0, true)
        ply_tb.CarryHack.Constr = constraint.Rope(ply_tb.CarryHack, trace, 0, tr.PhysicsBone, Vector(0,0,0), Vector(0,0,0), 0, 16, 0, 0, nil, false)

        net.Start("Ragdoll.SendDrag")
        net.WriteEntity(trace)
        net.WriteInt(tr.PhysicsBone, 8)
        net.Send(ply)
       // PrintTable(ply:GetEyeTrace())
        trace.IsGrabbed = true
    end
end)

local function SetSubPhysMotionEnabled(ent, enable)
   if not IsValid(ent) then return end

   for i=0, ent:GetPhysicsObjectCount()-1 do
      local subphys = ent:GetPhysicsObjectNum(i)
      if IsValid(subphys) then
         subphys:EnableMotion(enable)
         if enable then
            subphys:Wake()
         end
      end
   end
end

local function KillVelocity(ent)
   ent:SetVelocity(vector_origin)

   -- The only truly effective way to prevent all kinds of velocity and
   -- inertia is motion disabling the entire ragdoll for a tick
   -- for non-ragdolls this will do the same for their single physobj
   SetSubPhysMotionEnabled(ent, false)

   timer.Simple(0, function() SetSubPhysMotionEnabled(ent, true) end)
end

local function RESET_BODY(owner, ply)
    if IsValid(owner.CarryHack) then
        owner.CarryHack:Remove()
    end

    if IsValid(owner.CarryHack.Constr) then
        owner.CarryHack.Constr:Remove()
    end

    if IsValid(owner.GM_Dragging.ent) then
        -- the below ought to be unified with self:Drop()
        local phys = owner.GM_Dragging.ent:GetPhysicsObject()
        if IsValid(phys) then
            phys:ClearGameFlag(FVPHYSICS_PLAYER_HELD)
            phys:AddGameFlag(FVPHYSICS_WAS_THROWN)
            phys:EnableCollisions(true)
            phys:EnableGravity(true)
            phys:EnableDrag(true)
            phys:EnableMotion(true)
        end

        if owner.GM_Dragging.ent:GetClass() == "prop_ragdoll" then
            KillVelocity(owner.GM_Dragging.ent)
        end
    end
end

local nextDrag = nil
local ent_diff = vector_origin
local ent_diff_time = CurTime()
hook.Add("PlayerTick", "Ragdoll.Drag", function(ply)
    if (!ply.GM_Dragging) then return end
    if (!nextDrag) then
        nextDrag = CurTime() + 0.5
    end
    if (nextDrag < CurTime() and IsValid(ply.GM_Dragging.ent)) then
        nextDrag = CurTime()
        local ent = ply.GM_Dragging.ent
        
        if CurTime() > ent_diff_time then
            ent_diff = ply:GetPos() - ent:GetPos()
            if ent_diff:Dot(ent_diff) > 40000 then
                RESET_BODY(ply)
                return
            end

            ent_diff_time = CurTime() + 1
        end

        //local target = ply:Get
        local target = ply:EyePos() + ply:GetAimVector() * 70
        if (IsValid(ply.CarryHack)) then
            ply.CarryHack:SetPos(LerpVector(FrameTime() * 5, ply.CarryHack:GetPos(), target))

            ply.CarryHack:SetAngles(ply:GetAngles())

            ent:PhysWake()
        end
    end
end)
