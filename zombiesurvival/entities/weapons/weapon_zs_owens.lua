AddCSLuaFile()

SWEP.PrintName = "'Owens' Handgun"
SWEP.Description = "A somewhat less accurate pistol that fires two shots that deal respectable total damage."

SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 60
end

sound.Add({
	name = "Weapon_Pistol_Reanim.Clipout",
	channel = CHAN_ITEM,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = {"sigilmare/weapons/pistol_reanim/pistol_clipout.wav"}
})

sound.Add({
	name = "Weapon_Pistol_Reanim.Clipin",
	channel = CHAN_ITEM,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = {"sigilmare/weapons/pistol_reanim/pistol_clipin.wav"}
})

sound.Add({
	name = "Weapon_Pistol_Reanim.Boltclick",
	channel = CHAN_ITEM,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = {"sigilmare/weapons/pistol_reanim/pistol_boltpull.wav"}
})

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_pistol_reanim_v2.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_AR2.Reload")
SWEP.Primary.Sound = Sound("Weapon_Pistol.NPC_Single")
SWEP.Primary.Damage = 14.2
SWEP.Primary.NumShots = 2
SWEP.Primary.Delay = 0.2

SWEP.Primary.ClipSize = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.ClipMultiplier = 12/10
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 4
SWEP.ConeMin = 2.5

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MAX_SPREAD, -0.46, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MIN_SPREAD, -0.22, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.0175, 1)

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