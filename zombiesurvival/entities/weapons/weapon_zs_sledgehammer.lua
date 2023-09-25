AddCSLuaFile()

SWEP.PrintName = "Sledgehammer"
SWEP.Description = "A heavy, but powerful melee weapon. A target struck by the force of it will receive considerable knockback."

if CLIENT then
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_sledgehammer/c_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/sigilmare/zs/c_sledgehammer/w_sledgehammer.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 75
SWEP.MeleeRange = 64
SWEP.MeleeSize = 1.75
SWEP.MeleeKnockBack = 270

SWEP.Primary.Delay = 1.3

SWEP.Tier = 2

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingRotation = Angle(0, -15, -60)
SWEP.SwingOffset = Vector(5, -15, 10)
SWEP.SwingTime = 0.75
SWEP.SwingHoldType = "melee"

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.1, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.1, 1)

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 45))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_canister_impact_hard"..math.random(3)..".wav", 75, math.Rand(86, 90))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav", 75, math.Rand(86, 90))
end
