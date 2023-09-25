AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Harmony' Pulse Railgun"
SWEP.Description = "A zombie shredding machine that consumes a fuckton of ammo."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 100

	SWEP.VElements = {
		["prop1"] = { type = "Model", model = "models/combine_camera/combine_camera.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(21.298, 1.557, -6.753), angle = Angle(-5.844, -85.325, -92.338), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop2"] = { type = "Model", model = "models/combine_room/combine_monitor002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.714, 1.557, -4.676), angle = Angle(75.973, 1.169, 1.169), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop3"] = { type = "Model", model = "models/combine_room/combine_monitor003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.064, 3.635, -0.519), angle = Angle(-97.014, 8.182, 10.519), size = Vector(0.019, 0.019, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop4"] = { type = "Model", model = "models/dav0r/thruster.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.909, -3.636, -5.715), angle = Angle(-90, 8.182, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop5"] = { type = "Model", model = "models/combine_turrets/ground_turret.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, 0), angle = Angle(0, 0, 0), size = Vector(0.432, 0.301, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	 
	SWEP.WElements = {
		["prop1"] = { type = "Model", model = "models/combine_camera/combine_camera.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(21.298, 1.557, -6.753), angle = Angle(-5.844, -85.325, -92.338), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop2"] = { type = "Model", model = "models/combine_room/combine_monitor002.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.714, 1.557, -4.676), angle = Angle(75.973, 1.169, 1.169), size = Vector(0.041, 0.041, 0.041), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop3"] = { type = "Model", model = "models/combine_room/combine_monitor003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.064, 3.635, -0.519), angle = Angle(-97.014, 8.182, 10.519), size = Vector(0.019, 0.019, 0.019), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop4"] = { type = "Model", model = "models/dav0r/thruster.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.909, -3.636, -5.715), angle = Angle(-90, 8.182, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop5"] = { type = "Model", model = "models/combine_turrets/ground_turret.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.596, 1.557, 0), angle = Angle(0, 0, 0), size = Vector(0.432, 0.301, 0.497), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.UseHands = true

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.CSMuzzleFlashes = false

SWEP.ReloadSound = Sound("Weapon_SMG1.Reload")
SWEP.Primary.Sound = Sound("Airboat.FireGunHeavy")
SWEP.Primary.Damage = 19
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.05

SWEP.ReloadSpeed = 0.3

SWEP.Primary.ClipSize = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 1.5
SWEP.ConeMin = 1

SWEP.WalkSpeed = SPEED_SLOWEST

SWEP.Tier = 6

SWEP.PointsMultiplier = GAMEMODE.PulsePointsMultiplier

SWEP.TracerName = "AR2Tracer"

SWEP.FireAnimSpeed = 1
SWEP.LegDamage = 3

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.014, 1)

function SWEP.BulletCallback(attacker, tr, dmginfo)
	local ent = tr.Entity
	if ent:IsValidZombie() then
		local activ = attacker:GetActiveWeapon()
		ent:AddLegDamageExt(activ.LegDamage, attacker, activ, SLOWTYPE_PULSE)
	end

	if IsFirstTimePredicted() then
		util.CreatePulseImpactEffect(tr.HitPos, tr.HitNormal)
	end
end