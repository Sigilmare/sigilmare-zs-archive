AddCSLuaFile()

SWEP.PrintName = "Mega Masher"

if CLIENT then
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70

	SWEP.ShowViewModel = true
	SWEP.ShowWorldModel = true
	SWEP.VElements = {
		["base2"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "ValveBiped.Bip01", rel = "base", pos = Vector(12, 0, 0), angle = Angle(0, 90, 270), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/iBeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.706, 2.761, -22), angle = Angle(13, -12.5, 0), size = Vector(0.15, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01", rel = "base", pos = Vector(-5, 0, 0), angle = Angle(0, 270, 90), size = Vector(0.4, 0.4, 0.4), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}

	SWEP.WElements = {
		["base2"] = { type = "Model", model = "models/props_wasteland/buoy01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(12, 0, 0), angle = Angle(0, 90, 270), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base"] = { type = "Model", model = "models/props_junk/iBeam01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12, 3, -25), angle = Angle(0, 0, 0), size = Vector(0.15, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["base3"] = { type = "Model", model = "models/props_borealis/bluebarrel001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "base", pos = Vector(-5, 0, 0), angle = Angle(0, 90, 270), size = Vector(0.4, 0.4, 0.4), color = Color(255, 0, 0, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "melee2"

SWEP.DamageType = DMG_CLUB

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_sledgehammer/c_sledgehammer.mdl"
SWEP.WorldModel = "models/weapons/sigilmare/zs/c_sledgehammer/w_sledgehammer.mdl"
SWEP.UseHands = true

SWEP.MeleeDamage = 190
SWEP.MeleeRange = 75
SWEP.MeleeSize = 4
SWEP.MeleeKnockBack = 420

SWEP.Primary.Delay = 2.25

SWEP.WalkSpeed = SPEED_SLOWEST * 0.7

SWEP.SwingRotation = Angle(0, -15, -60)
SWEP.SwingOffset = Vector(5, -15, 10)
SWEP.SwingTime = 1.33
SWEP.SwingHoldType = "melee"

SWEP.Tier = 3

SWEP.AllowQualityWeapons = true

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_MELEE_IMPACT_DELAY, -0.15, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.15, 1)

function SWEP:PlaySwingSound()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav", 75, math.random(20, 25))
end

function SWEP:PlayHitSound()
	self:EmitSound("vehicles/v8/vehicle_impact_heavy"..math.random(4)..".wav", 80, math.Rand(95, 105))
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("physics/flesh/flesh_bloody_break.wav", 80, math.Rand(90, 100))
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	--if IsFirstTimePredicted() then
		local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.HitNormal)
			util.Effect("explosion", effectdata)
	--end
end
