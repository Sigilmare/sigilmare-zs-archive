AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "'Blaster' Shotgun"
SWEP.Description = "A basic shotgun that can deal significant amounts of damage at close range."

if CLIENT then
	SWEP.ViewModelFlip = false

	SWEP.HUD3DPos = Vector(1.3, -2, 1)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.02
	SWEP.HUD3DBone = "gun"
end

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/sigilmare/c_supershorty_reanim.mdl"
SWEP.WorldModel = "models/weapons/w_supershorty.mdl"
SWEP.UseHands = true

SWEP.ReloadDelay = 0.4

SWEP.Primary.Sound = Sound("Weapon_Shotgun.NPC_Single")
SWEP.Primary.Damage = 12
SWEP.Primary.NumShots = 7
SWEP.Primary.Delay = 0.7

SWEP.Primary.ClipSize = 6
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ReloadDelay = 0.6

SWEP.ConeMax = 8.75
SWEP.ConeMin = 5

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.PumpSound = Sound("Weapon_M3.Pump")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 1)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Blaster' Slug Gun", "Single accurate slug round, less total damage", function(wept)
	wept.Primary.Damage = wept.Primary.Damage * 5.5
	wept.Primary.NumShots = 1
	wept.ConeMin = wept.ConeMin * 0.15
	wept.ConeMax = wept.ConeMax * 0.3
end)

function SWEP:StopReloading()
    self:SetDTFloat(3, 0)
    self:SetDTBool(2, false)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 0.75)

    if self:Clip1() > 0 then
        self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
        self:ProcessReloadAnim()
    end
end