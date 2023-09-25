AddCSLuaFile()

SWEP.PrintName = "'KG-9' AA-12"
SWEP.Description = "Relatively accurate, clip loaded, fast-firing automatic shotgun."

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70

	SWEP.ShowViewModel = false

	SWEP.VElements = {
		["prop1"] = { type = "Model", model = "models/hunter/blocks/cube2x8x1.mdl", bone = "v_weapon.AK47_Clip", rel = "", pos = Vector(-0.146, 3.717, 0.39), angle = Angle(92.83, 90.566, -89.807), size = Vector(0.03, 0.02, 0.02), color = Color(150, 150, 150, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop10"] = { type = "Model", model = "models/mechanics/roboticslarge/f2.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.22, -5.278, -7.568), angle = Angle(-0.203, -1.082, -87.652), size = Vector(0.01, 0.03, 0.03), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop11"] = { type = "Model", model = "models/mechanics/roboticslarge/d1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-1.128, -5.539, -12.15), angle = Angle(-85.28, 120.848, 31.844), size = Vector(0.03, 0.03, 0.03), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop12"] = { type = "Model", model = "models/mechanics/robotics/k2.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.554, -6.023, -0.4), angle = Angle(-88.302, 89.534, -89.806), size = Vector(0.04, 0.04, 0.04), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop13"] = { type = "Model", model = "models/mechanics/roboticslarge/a1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.692, -5.382, -5.074), angle = Angle(4.528, 2.264, -54.34), size = Vector(0.03, 0.03, 0.03), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop14"] = { type = "Model", model = "models/mechanics/robotics/claw_guide2.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.035, -6.909, -15.587), angle = Angle(-0.008, 176.858, -87.663), size = Vector(0.035, 0.035, 0.035), color = Color(150, 150, 150, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop15"] = { type = "Model", model = "models/props_phx/wheels/747wheel.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.041, -4.037, -2.162), angle = Angle(24.906, 90.566, -90.302), size = Vector(0.03, 0.03, 0.03), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop2"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.246, -4.147, 2.445), angle = Angle(4.528, 90.566, -90.566), size = Vector(0.1, 0.14, 0.03), color = Color(150, 150, 150, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop2+"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.177, -5.113, -9.874), angle = Angle(4.528, 90.566, -90.566), size = Vector(0.1, 0.14, 0.03), color = Color(150, 150, 150, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop2++"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.336, -3.205, 14.099), angle = Angle(4.528, 90.566, -90.566), size = Vector(0.1, 0.14, 0.03), color = Color(150, 150, 150, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop3"] = { type = "Model", model = "models/hunter/blocks/cube075x2x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.859, 0.811, -0.315), angle = Angle(0, 168.828, -86.95), size = Vector(0.05, 0.05, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop4"] = { type = "Model", model = "models/mechanics/solid_steel/steel_beam_4.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.123, -0.112, -2.311), angle = Angle(90.566, 90.566, -89.794), size = Vector(0.06, 0.03, 0.05), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop5"] = { type = "Model", model = "models/mechanics/robotics/claw.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.027, -1.414, -2.076), angle = Angle(66.718, -90.059, 89.518), size = Vector(0.09, 0.03, 0.03), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop6"] = { type = "Model", model = "models/hunter/plates/plate05.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.148, -4.91, -19.294), angle = Angle(0, -2.264, -86.038), size = Vector(0.3, 0.3, 0.3), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop7"] = { type = "Model", model = "models/mechanics/robotics/g3.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.51, -6.14, 1.362), angle = Angle(-172.075, 83.774, -97.358), size = Vector(0.03, 0.03, 0.03), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop7+"] = { type = "Model", model = "models/mechanics/robotics/g3.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.275, -6.401, 2.563), angle = Angle(-33.962, 92.83, -86.038), size = Vector(0.03, 0.03, 0.03), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop8"] = { type = "Model", model = "models/mechanics/robotics/foot.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.247, -6.432, -5.39), angle = Angle(-88.302, 2.264, -88.302), size = Vector(0.05, 0.05, 0.05), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["prop9"] = { type = "Model", model = "models/mechanics/articulating/arm_base_b.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.875, -6.645, -15.576), angle = Angle(-0.19, -0.503, -83.774), size = Vector(0.06, 0.06, 0.06), color = Color(100, 100, 100, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_ak47_reanim.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("weapons/xm1014/xm1014-1.wav")
SWEP.Primary.Damage = 38
SWEP.Primary.NumShots = 3
SWEP.Primary.Delay = 0.2

SWEP.Primary.ClipSize = 8
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 4
SWEP.ConeMin = 2

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.Tier = 6

function SWEP:SecondaryAttack()
end

function SWEP:EmitFireSound()
	self:EmitSound(self.Primary.Sound, 75, math.random(245, 255), 0.7)
	self:EmitSound("weapons/shotgun/shotgun_fire6.wav", 75, math.random(245, 255), 0.6, CHAN_WEAPON + 20)
end

function SWEP:SendReloadAnimation()
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	else
		self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
	end
end