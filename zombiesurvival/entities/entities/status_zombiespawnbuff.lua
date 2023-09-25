AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "status__base"

function ENT:Initialize()
	self.BaseClass.Initialize(self)

	self.Seed = math.Rand(0, 10)

	self:GetOwner().SpawnProtection = false
end

function ENT:PlayerSet(pl)
end

function ENT:OnRemove()
	self.BaseClass.OnRemove(self)

	self:GetOwner().SpawnProtection = false
end

function ENT:SetDie(fTime)
end
