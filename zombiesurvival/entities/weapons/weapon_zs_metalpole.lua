AddCSLuaFile()

SWEP.PrintName = "Metal Pole"
SWEP.Description = "A long metal pole that has very high range"

if CLIENT then
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["stick"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.298, 2.714, -69.622), angle = Angle(6.007, -12.897, 0.199), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	 
	SWEP.WElements = {
		["stick"] = { type = "Model", model = "models/props_c17/signpole001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-1.8, 5.593, -62.531), angle = Angle(-3.487, -16.876, -4.964), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/props_c17/signpole001.mdl"
SWEP.UseHands = true

SWEP.HoldType = "melee2"

SWEP.MeleeDamage = 120
SWEP.MeleeRange = 120
SWEP.MeleeSize = 2

SWEP.Primary.Delay = 0.75

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.SwingTime = 0.4
SWEP.SwingRotation = Angle(0, -20, -40)
SWEP.SwingOffset = Vector(10, 0, 0)
SWEP.SwingHoldType = "melee"

SWEP.DamageType = DMG_CLUB

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_RANGE, 3)

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(35, 40))
end

function SWEP:PlayHitSound()
	self:EmitSound("physics/metal/metal_solid_impact_bullet"..math.random(4)..".wav")
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/body/body_medium_break"..math.random(2, 4)..".wav")
end
