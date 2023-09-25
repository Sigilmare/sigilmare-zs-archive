--ZE Boss system from https://github.com/samuelmaddock/zombie-escape
--Modifcations and fixes by https://github.com/mka0207

util.AddNetworkString("BossDefeated")
util.AddNetworkString("BossSpawn")
util.AddNetworkString("BossTakeDamage")

/*---------------------------------------------------------
	Boss Object
---------------------------------------------------------*/
BOSS_MATH		= 1
BOSS_PHYSBOX	= 2

local BOSS = {}

function BOSS:Setup(name, modelEnt, counterEnt)

	local boss = {}

	setmetatable( boss, self )
	self.__index = self

	boss.Name = name
	boss:Reset()

	boss.Targets = {}
	boss.Targets.Model = modelEnt
	boss.Targets.Counter = counterEnt

	return boss

end

function BOSS:IsValid()
	return IsValid( self:GetCounter() ) and
		IsValid( self:GetClientModel() ) and
		self:GetType() != -1 --and
		-- self.KilledOnRound != GAMEMODE:GetRound()
end

function BOSS:Reset()
	self.Type = -1
	self.bInitialized = nil
	self.Entities = {}
end

function BOSS:HasCounter(ent)
	return self.Targets.Counter == ent:GetName()
end

function BOSS:Health()
	if self:GetType() == BOSS_MATH then
		return IsValid(self.Entities.Counter) and self.Entities.Counter:GetDTInt(4) or -1
	elseif self:GetType() == BOSS_PHYSBOX then
		if !IsValid(self.Entities.Counter) then return -1 end

		-- Update max health
		local health = self.Entities.Counter:Health()
		if !self._MaxHealth or health > self._MaxHealth then
			self._MaxHealth = health
		end

		return health
	end
end

function BOSS:MaxHealth()
	if self:GetType() == BOSS_MATH then
		return IsValid(self.Entities.Counter) and self.Entities.Counter:GetDTInt(2) or -1
	elseif self:GetType() == BOSS_PHYSBOX then
		return IsValid(self.Entities.Counter) and self._MaxHealth or self:Health()
	end
end

function BOSS:GetType()
	return self.Type or -1
end

function BOSS:GetCounterTarget()
	return self.Targets.Counter
end

function BOSS:GetModelTarget()
	return self.Targets.Model
end

function BOSS:GetName()
	return self.Name
end

function BOSS:GetCounter()

	if self:GetType() == -1 or !IsValid(self.Entities.Counter) then

		-- Attempt to find health counter entity
		for _, v in pairs(ents.FindByName(self.Targets.Counter)) do
			if IsValid(v) and v:GetName() == self.Targets.Counter then
				if v:GetClass() == "math_counter" then
					self.Type = BOSS_MATH
				elseif v:GetClass() == "func_physbox_multiplayer" then
					self.Type = BOSS_PHYSBOX
				else
					continue -- not what we want
				end

				self.Entities.Counter = v
				break
			end
		end

	end

	return self.Entities.Counter

end

function BOSS:GetClientModel()

	if !IsValid(self.Entities.Model) then

		-- Attempt to find valid client entity
		for _, v in pairs(ents.FindByName(self.Targets.Model)) do
			if IsValid(v) and v:GetName() == self.Targets.Model then
				self.Entities.Model = v
				break
			end
		end

	end

	return self.Entities.Model

end

function BOSS:OnDamageTaken( activator )

	if !self.bInitialized then

		-- Broadcast boss spawn
		net.Start("BossSpawn")
			net.WriteFloat( self:GetClientModel():EntIndex() )
			net.WriteString( self:GetName() )
		net.Broadcast()

		self.bInitialized = true

	end

	-- Broadcast health stats
	net.Start("BossTakeDamage")
		net.WriteFloat( self:GetClientModel():EntIndex() )
		net.WriteFloat( self:Health() )
		net.WriteFloat( self:MaxHealth() )
	net.Broadcast()

	-- Output debug info
	if CVars.BossDebug:GetInt() > 0 then
		Msg("BOSS TAKE DAMAGE:\n")
		Msg("\tMath: " .. tostring(self:GetCounter()) .. "\n")
		Msg("\tProp: " .. tostring(self:GetClientModel()) .. "\n")
		Msg("\tActivator: " .. tostring(activator) .. "\n")
	end

end

function BOSS:OnDeath( activator )

	-- Announce death to players
	net.Start("BossDefeated")
		net.WriteFloat( self:GetClientModel():EntIndex() )
	net.Broadcast()

	-- Reset boss
	self.KilledOnRound = GAMEMODE:GetWave() --GAMEMODE:GetRound()
	self:Reset()

	-- Output debug info
	if CVars.BossDebug:GetInt() > 0 then
		Msg("BOSS DEFEATED:\n")
		Msg("\tMath: " .. tostring(self:GetCounter()) .. "\n")
		Msg("\tProp: " .. tostring(self:GetClientModel()) .. "\n")
		Msg("\tActivator: " .. tostring(activator) .. "\n")
	end

	-- Call hook for any developers looking to integrate more
	hook.Call( "OnBossDefeated", GAMEMODE, self, activator )

end


/*---------------------------------------------------------
	Bosses
---------------------------------------------------------*/

GM.Bosses = {}

GM.ValidBossEntities = {}
GM.ValidBossEntities[ "math_counter" ] 				= true
GM.ValidBossEntities[ "func_physbox_multiplayer" ] 	= true


-- AddBoss( name, model entity, math counter )
function GM:AddBoss(name, propEnt, healthEnt)
	local boss = BOSS:Setup(name,propEnt,healthEnt)
	table.insert(self.Bosses, boss)
end

-- return boss table
function GM:GetBoss(ent)

	if CVars.BossDebug:GetInt() == 2 then
		Msg("REQUESTING BOSS\n")
		Msg(ent)
		Msg("\n")
	end

	if !self.ValidBossEntities[ ent:GetClass() ] then
		return
	end

	if CVars.BossDebug:GetInt() == 1 then
		Msg("REQUESTING BOSS\n")
		Msg(ent)
		Msg("\n")
	end

	for _, boss in pairs(self.Bosses) do
		if boss:HasCounter(ent) then
			if CVars.BossDebug:GetInt() > 0 then
				Msg("FOUND BOSS\n")
				Msg(boss)
				Msg("\n")
			end
			return boss
		end
	end

	return nil

end


/*---------------------------------------------------------
	Boss Updates
---------------------------------------------------------*/
function GM:BossDamageTaken( ent, activator )

	if !IsValid(ent) then return end
	if self.NextBossUpdate && self.NextBossUpdate > CurTime() then return end -- prevent umsg spam

	local boss = self:GetBoss(ent)
	if IsValid(boss) then
		boss:OnDamageTaken( activator )
		self.NextBossUpdate = CurTime() + 0.15
	end

end

function GM:BossDeath(ent, activator)

	if !IsValid(ent) then return end

	local boss = self:GetBoss(ent)
	if IsValid(boss) and boss.bInitialized then
		boss:OnDeath( activator )
	end

end

--[[function GM:MathCounterUpdate(ent, activator)
	self:BossDamageTaken(ent, activator)
end

function GM:MathCounterHitMin(ent, activator)
	self:BossDeath(ent, activator)
end]]

-- Physbox boss handling
hook.Add("EntityTakeDamage", "PhysboxTakeDamage", function( ent, dmginfo )
	if ent:GetClass() == "func_physbox_multiplayer" then
		GAMEMODE:BossDamageTaken(ent, dmginfo:GetAttacker())
	end
end)

hook.Add("EntityRemoved", "PhysboxRemoved", function(ent)
	if ent:GetClass() == "func_physbox_multiplayer" then
		GAMEMODE:BossDeath(ent, nil)
	end
end)