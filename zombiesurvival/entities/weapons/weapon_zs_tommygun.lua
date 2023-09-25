AddCSLuaFile()

SWEP.PrintName = "'Sigilmare' Tommy Gun"
SWEP.Description = "Sigilmare's very own Tommy Gun. Originally obtained via tokens; is now available for everyone."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.Undroppable = false

SWEP.ViewModel = "models/weapons/sigilmare/c_tommygun.mdl"
SWEP.WorldModel = "models/weapons/sigilmare/w_tfa_m1921_tmmygn.mdl"
SWEP.UseHands = true

SWEP.Primary.Damage = 33
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.125

SWEP.Primary.ClipSize = 50
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 5.75
SWEP.ConeMin = 0.75

SWEP.AllowQualityWeapons = true

SWEP.Tier = 6

SWEP.WalkSpeed = SPEED_NORMAL

function SWEP:EmitFireSound()
	self:EmitSound("sigilmare/weapons/tommygun/fire.ogg", 0, 100, 0.35, CHAN_STATIC)
end