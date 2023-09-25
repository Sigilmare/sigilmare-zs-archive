INC_SERVER()

function ENT:Initialize()
	self.DieTime = CurTime() + 10

	self:SetModel("models/khrcw2/ins2rpg7rocket.mdl")
	self:PhysicsInitSphere(1)
	self:SetSolid(SOLID_VPHYSICS)

	self:SetupGenericProjectile(false)
end

function ENT:Think()
	if self.PhysicsData then
		self:Explode()
	end

	if self.Exploded then
		local pos = self:GetPos()

		local effectdata = EffectData()
			effectdata:SetOrigin(pos)
		util.Effect("Explosion", effectdata)

		self:Remove()
	elseif self.DieTime <= CurTime() then
		self:Explode()
	end
end

function ENT:Explode()
	if self.Exploded then return end
	self.Exploded = true

	local owner = self:GetOwner()
	if owner:IsValidHuman() then
		local pos = self:GetPos()

		local source = self:ProjectileDamageSource()
		util.BlastDamagePlayer(source, owner, pos, 256, self.ProjDamage, DMG_ALWAYSGIB)
	end
end

function ENT:PhysicsCollide(data, phys)
	self.PhysicsData = data
	self:NextThink(CurTime())
end
