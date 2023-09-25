local AddCSLuaFile = AddCSLuaFile
local include = include
local CurTime = CurTime
local SetGlobalBool = SetGlobalBool
local BroadcastLua = BroadcastLua
local ipairs = ipairs
local player_GetAll = player.GetAll
local IsValid = IsValid
local ents_FindInSphere = ents.FindInSphere
local math_min = math.min
local player_GetHumans = player.GetHumans
local math_random = math.random
local ents_FindByClass = ents.FindByClass
local ents_Create = ents.Create

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

ENT.FOVMin = 100
ENT.FOVMax = 110
ENT.BlackholePower = 1
ENT.BlackholePowerBase = -20
ENT.BaseMass = 1.01

function ENT:Initialize()
	self:DrawShadow(false)

	self.BlackholeDuration = CurTime() + 30.2

	for k, v in pairs(ents_FindByClass("prop_*")) do
		if v:GetClass() == "prop_ragdoll" then return end
		
		local ent = ents_Create("prop_physics")
		if ent:IsValid() then
			ent:SetModel(v:GetModel())
			ent:SetBodyGroups(v:GetBodyGroups())
			ent:SetMaterial(v:GetMaterial())
			ent:SetColor(v:GetColor())
			ent:SetPos(v:GetPos())
			ent:SetAngles(v:GetAngles())
			ent:Spawn()
		end

		v:Remove()
	end
end

function ENT:OnRemove()
	BroadcastLua("LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 255, 255, 255, 255 ), 1, 2.5 )")
	SetGlobalBool("Blackhole", false)
	for k, v in ipairs(player_GetAll()) do
		v:SetFOV(100, 3.5)
	end
	for k, v in pairs(ents.FindByClass("prop_*")) do
		local phys = v:GetPhysicsObject()

		if phys:IsValid() then
			phys:EnableCollisions(true)
			phys:SetMass(50000)

			local physCount = v:GetPhysicsObjectCount()
			if physCount > 1 then
				for num = 0, physCount - 1 do
				curPhys = v:GetPhysicsObjectNum(num)
					if curPhys:IsValid() then
						curPhys:EnableCollisions(true)
						curPhys:SetMass(50000)
					end
				end
			end
		end
	end

	timer.Simple(0.1, function()
		BroadcastLua("BlackholeReplaceTextures()")
	end)

	timer.Simple(60, function()
		BroadcastLua("LocalPlayer():ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0, 255 ), 23, 999 )")
	end)

	timer.Simple(83, function()
		RunConsoleCommand("changelevel", SM.BlackholeMap)
	end)
end

function ENT:Think()
	if !IsValid(self.Entity) then return end

	local base = self.BlackholePowerBase
	
	for k, v in ipairs( ents_FindInSphere( self.Entity:GetPos(), 2^63 ) ) do
		if IsValid( v ) then
			if v:GetClass() != "blackhole" then
				local phys = v:GetPhysicsObject()
				local dif = v:GetPos() - self.Entity:GetPos()
				local ran = dif:Length()

				v:SetCollisionGroup( COLLISION_GROUP_WORLD )
				
				if phys:IsValid() then
					local forceApplied = ( dif * ( (v:GetClass() == "prop_ragdoll" and base * (self.BlackholePower*0.2) or base*0.2) / ran ) ) * phys:GetMass() * self.BlackholePower
					phys:ApplyForceCenter( forceApplied )
					phys:EnableCollisions(false)
					phys:SetMass(self.BaseMass * (self.BlackholePower*(self.BlackholePower*3)))
					phys:EnableGravity(false)

					local physCount = v:GetPhysicsObjectCount()
					if physCount > 1 then
						for num = 0, physCount - 1 do
						curPhys = v:GetPhysicsObjectNum(num)
							if curPhys:IsValid() then
								curPhys:EnableCollisions(false)
								curPhys:SetMass(self.BaseMass)
								curPhys:EnableGravity(false)
							end
						end
					end
				end
			end
		end
	end

	if GAMEMODE_NAME == "zombiesurvival" then
		if GAMEMODE:GetWaveActive() then
			GAMEMODE:SetWaveEnd(CurTime() + math.random(200, 2000))
		else
			GAMEMODE:SetWaveStart(CurTime() + math.random(200, 2000))
		end
	end

	self.FOVMax = math_min(self.FOVMax + 0.033, 180)
	self.FOVMin = math_min(self.FOVMin + 0.033, 170)

	self.BlackholePower = self.BlackholePower * 1.00125

	for k, v in ipairs(player_GetHumans()) do		
		v:SetFOV(math_random(self.FOVMin, self.FOVMax))
	end

	if self.BlackholeDuration <= CurTime() then
		self:Remove()
	end

	self:NextThink(CurTime())
	return true
end