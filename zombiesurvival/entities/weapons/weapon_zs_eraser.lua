AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Eraser' Tactical Pistol"
SWEP.Description = "Damage increases as remaining bullets decrease."
SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_fiveseven_reanim.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/ar2/npc_ar2_altfire.wav")
SWEP.Primary.Damage = 23.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.15

SWEP.Primary.ClipSize = 12
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 2.5
SWEP.ConeMin = 1.25

SWEP.ReloadSpeed = 1
SWEP.HeadshotMulti = 2

SWEP.Tier = 2

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.1, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_HEADSHOT_MULTI, 0.07)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Cleanser' Tactical Pistol", "Less reload speed, accuracy and headshot multiplier but gains increased damage per wave", function(wept)
	wept.ConeMax = wept.ConeMax * 1.7
	wept.ConeMin = wept.ConeMin * 2.1
	wept.ReloadSpeed = wept.ReloadSpeed * 0.7
	wept.HeadshotMulti = wept.HeadshotMulti * 0.9

	wept.BulletCallback = function(attacker, tr, dmginfo)
		dmginfo:SetDamage(dmginfo:GetDamage() + dmginfo:GetDamage() * GAMEMODE:GetWave()/15)
	end
end)

function SWEP:EmitFireSound()
	self:EmitSound("weapons/fiveseven/fiveseven-1.wav", 75, 80 + (1 - (self:Clip1() / self.Primary.ClipSize)) * 30, 0.8, 21)
	self:EmitSound(self.Primary.Sound, 75, 130 + (1 - (self:Clip1() / self.Primary.ClipSize)) * 70, 0.75, 22)
end

function SWEP:ShootBullets(dmg, numbul, cone)
	dmg = dmg + dmg * (1 - self:Clip1() / self.Primary.ClipSize)

	BaseClass.ShootBullets(self, dmg, numbul, cone)
end

function SWEP:SendWeaponAnimation()
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	else
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_EMPTY)
	end
	self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)
end

function SWEP:SendReloadAnimation()
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	else
		self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
	end
end