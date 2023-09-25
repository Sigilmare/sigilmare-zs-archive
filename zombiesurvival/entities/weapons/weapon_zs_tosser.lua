AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Tosser' SMG"
SWEP.Description = "A relatively simple SMG with a decent fire rate and reload speed."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 60
end

sound.Add({
	name = "Weapon_SMG1_Reanim.Clipout",
	channel = CHAN_ITEM,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = {"sigilmare/weapons/smg1_reanim/smg1_clipout.wav"}
})

sound.Add({
	name = "Weapon_SMG1_Reanim.Clipin",
	channel = CHAN_ITEM,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = {"sigilmare/weapons/smg1_reanim/smg1_clipin.wav"}
})

sound.Add({
	name = "Weapon_SMG1_Reanim.Boltclick",
	channel = CHAN_ITEM,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = {"sigilmare/weapons/smg1_reanim/smg1_boltclick.wav"}
})

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_smg1_reanim_v3.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.Primary.Sound = Sound("Weapon_AR2.NPC_Single")
SWEP.Primary.Damage = 14
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.15

SWEP.Primary.ClipSize = 24
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.IdleActivity = 0

SWEP.ReloadSpeed = 0.78
SWEP.FireAnimSpeed = 0.55

SWEP.ConeMax = 4.5
SWEP.ConeMin = 2.5

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.015)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Thrower' Burst SMG", "Increased damage but makes the tosser burst fire", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 1.1
	wept.Primary.Delay = wept.Primary.Delay * 3.9
	wept.Primary.BurstShots = 3

	wept.PrimaryAttack = function(self)
		if not self:CanPrimaryAttack() then return end

		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())
		self:EmitFireSound()

		self:SetNextShot(CurTime())
		self:SetShotsLeft(self.Primary.BurstShots)

		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end

	wept.Think = function(self)
		BaseClass.Think(self)

		local shotsleft = self:GetShotsLeft()
		if shotsleft > 0 and CurTime() >= self:GetNextShot() then
			self:SetShotsLeft(shotsleft - 1)
			self:SetNextShot(CurTime() + self:GetFireDelay()/6)

			if self:Clip1() > 0 and self:GetReloadFinish() == 0 then
				self:EmitFireSound()
				self:TakeAmmo()
				self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())

				self.IdleAnimation = CurTime() + self:SequenceDuration()
			else
				self:SetShotsLeft(0)
			end
		end
	end
end)

function SWEP:SendReloadAnimation()
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	else
		self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
	end
end

function SWEP:SetNextShot(nextshot)
	self:SetDTFloat(5, nextshot)
end

function SWEP:GetNextShot()
	return self:GetDTFloat(5)
end

function SWEP:SetShotsLeft(shotsleft)
	self:SetDTInt(1, shotsleft)
end

function SWEP:GetShotsLeft()
	return self:GetDTInt(1)
end
