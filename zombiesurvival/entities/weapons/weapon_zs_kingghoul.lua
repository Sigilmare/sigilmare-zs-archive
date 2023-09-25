AddCSLuaFile()

SWEP.PrintName = "King Ghoul"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 40
SWEP.MeleeDamageVsProps = 120
SWEP.MeleeForceScale = 6
SWEP.Primary.Delay = 1.5

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsValidPlayer() then
		if SERVER then
			ent:AddBleedDamage(20, self:GetOwner())
		end
	end

	self.BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if not ent:IsPlayer() then
		damage = self.MeleeDamageVsProps
	end

	self.BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/zombie_poison/pz_warn1.wav", 100, math.Rand(20, 25))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:PlayAttackSound()
	self:EmitSound("npc/zombie_poison/pz_warn1.wav", 100, math.Rand(40, 50))
end

local PoisonPattern = {
	{-1, 0},
	{-0.66, 0},
	{-0.33, 0},
	{0, 0},
	{0, 1},
	{0, -1},
	{0.33, 0},
	{0.66, 0},
	{1, 0},
	{-0.5, -0.5},
	{-0.5, 0.5},
	{0.5, -0.5},
	{0.5, 0.5}
}

local function DoFleshThrow(owner, self)
	local startpos = owner:GetShootPos()
	local aimang = owner:EyeAngles()
	local ang

	for k, spr in pairs(PoisonPattern) do
		if k == "BaseClass" then continue end

		ang = Angle(aimang.p, aimang.y, aimang.r)
		ang:RotateAroundAxis(ang:Up(), spr[1] * 12.5)
		ang:RotateAroundAxis(ang:Right(), spr[2] * 5)
		local heading = ang:Forward()

		local ent = ents.Create("projectile_ghoulfleshbleed")
		if ent:IsValid() then
			ent:SetPos(startpos + heading * 8)
			ent:SetOwner(owner)
			ent:Spawn()

			local phys = ent:GetPhysicsObject()
			if phys:IsValid() then
				phys:SetVelocityInstantaneous(heading * 800)
			end
		end
	end

	owner:EmitSound(string.format("physics/body/body_medium_break%d.wav", math.random(2, 4)), 85, math.Rand(60, 70))
end


function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or IsValid(owner.FeignDeath) then return end

	self:SetNextSecondaryFire(CurTime() + 3)
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

	self:GetOwner():DoZombieEvent()
	self:EmitSound("npc/zombie_poison/pz_warn2.wav", 100, math.Rand(40, 50), 1, CHAN_STATIC)
	self:SendWeaponAnim(ACT_VM_HITCENTER)
	self.IdleAnimation = CurTime() + self:SequenceDuration()

	if SERVER then
		timer.Simple(0.7, function() DoFleshThrow(owner, self) end)
	end
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
	render.SetColorModulation(1, 1, 1)
end

local matSheet = Material("models/weapons/v_zombiearms/ghoulsheet")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
	render.SetColorModulation(0.4, 0, 0)
end
