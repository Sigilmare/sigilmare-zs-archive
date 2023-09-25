SWEP.PrintName = "Death Machine"

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/c_physcannon.mdl"
SWEP.WorldModel = "models/weapons/w_physics.mdl"
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false
SWEP.UseHands = false

SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.09

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Automatic = true

SWEP.ConeMax = 2
SWEP.ConeMin = 1

SWEP.Recoil = 0

SWEP.Tier = 6

SWEP.WalkSpeed = 160
SWEP.FireAnimSpeed = 1

SWEP.Undroppable = true

SWEP.AllowQualityWeapons = false

function SWEP:Initialize()
	self.BaseClass.Initialize(self)

	self.ChargeSound = CreateSound(self, "sigilmare/weapons/deathmachine/fire_loop2.wav")
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	if not self:GetSpooling() then
		self:SetSpooling(true)
	else
		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

		self.ChargeSound:PlayEx(1, 100)

		self:EmitFireSound()
		--self:TakeAmmo()
		self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:TakeAmmo()
	self:TakeCombinedPrimaryAmmo(1)
end

function SWEP:CanPrimaryAttack()
	if self:GetOwner():IsHolding() then
		return false
	end

	return self:GetNextPrimaryFire() <= CurTime()
end

function SWEP:CanSecondaryAttack()
end

function SWEP:EmitFireSound()
end

function SWEP:Reload()
end

function SWEP:Holster()
	self.ChargeSound:Stop()

	return self.BaseClass.Holster(self)
end

function SWEP:OnRemove()
	self.ChargeSound:Stop()
end

function SWEP:SetSpool(spool)
	self:SetDTFloat(9, spool)
end

function SWEP:GetSpool()
	return self:GetDTFloat(9)
end

function SWEP:SetSpooling(isspool)
	self:SetDTBool(1, isspool)
end

function SWEP:GetSpooling()
	return self:GetDTBool(1)
end

function SWEP:GetFireDelay()
	return self.BaseClass.GetFireDelay(self) - (self:GetSpool() * 0.15)
end

function SWEP:CheckSpool()
	if self:GetSpooling() then
		if not self:GetOwner():KeyDown(IN_ATTACK) then
			self:SetSpooling(false)
			self:GetOwner():ResetSpeed()
			self:EmitSound("sigilmare/weapons/deathmachine/fire_stop.wav", 75, 100, 0.3)
		else
			self:SetSpool(math.min(self:GetSpool() + FrameTime() * 1, 0.5))
		end
	else
		self:SetSpool(math.max(0, self:GetSpool() - FrameTime() * 1))
		self.ChargeSound:Stop()
	end
end
