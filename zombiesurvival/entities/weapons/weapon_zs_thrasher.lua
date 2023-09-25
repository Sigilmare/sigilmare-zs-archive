AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Trasher' Scrap Cannon"
SWEP.Description = "A powerful scrap cannon made from parts of stuff."
SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 50

	SWEP.ShowViewModel = false

	SWEP.VElements = {
		["barrel"] = { type = "Model", model = "models/props_vehicles/carparts_muffler01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.007, 2.124, -1.272), angle = Angle(2.982, -7.418, 88.599), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["barrel2"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.15, 2.784, -2.987), angle = Angle(-85.307, -11.264, 83.377), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["clip1"] = { type = "Model", model = "models/props_lab/tpplugholder_single.mdl", bone = "v_weapon.p90_Clip", rel = "", pos = Vector(2.013, 0, 0), angle = Angle(0, 88.302, -89.946), size = Vector(0.198, 0.198, 0.198), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cos1"] = { type = "Model", model = "models/props_c17/streetsign004f.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.428, 2.253, -3.796), angle = Angle(2.967, -7.33, 176.896), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["holder"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.829, 0.942, -0.934), angle = Angle(47.951, 171.571, -88.705), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["holder2"] = { type = "Model", model = "models/props_c17/playground_teetertoter_stan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.167, 0.552, 0.421), angle = Angle(-89.153, -86.957, -71.527), size = Vector(0.3, 0.3, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["holder_idk"] = { type = "Model", model = "models/props_interiors/pot02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.838, 2.535, 0.147), angle = Angle(0.399, 172.265, -87.474), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["mag"] = { type = "Model", model = "models/props_c17/TrapPropeller_Engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.969, 1.284, -3.937), angle = Angle(-84.115, -73.286, 114.297), size = Vector(0.1, 0.123, 0.19), color = Color(254, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["main1"] = { type = "Model", model = "models/props_c17/TrapPropeller_Blade.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.815, -0.501, -3.731), angle = Angle(-71.988, 168.187, -97.458), size = Vector(0.123, 0.123, 0.764), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["main3"] = { type = "Model", model = "models/props_c17/TrapPropeller_Lever.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.562, 1.615, -8.193), angle = Angle(87.562, 165.22301, -82.649), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["main4"] = { type = "Model", model = "models/props_c17/chair_stool01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-9.165, -0.235, -5.585), angle = Angle(3.753, -95.359, -87.723), size = Vector(0.2, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["main5"] = { type = "Model", model = "models/Gibs/helicopter_brokenpiece_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.592, 3.01, -3.079), angle = Angle(6.177, -8.729, -71.442), size = Vector(0.099, 0.023, 0.04), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["main_idk"] = { type = "Model", model = "models/props_junk/ravenholmsign.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.831, -1.279, -3.979), angle = Angle(-20.625, 81.618, 177.468), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["prop"] = { type = "Model", model = "models/props_lab/tpplugholder_single.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-5.027, 0.764, -2.044), angle = Angle(85.175, -99.209, 1.987), size = Vector(-0.198, 0.443, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["stock1"] = { type = "Model", model = "models/props_c17/consolebox05a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-6.129, -0.289, -5.17), angle = Angle(-1.858, 172.45399, 0.83), size = Vector(0.3, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["stock2"] = { type = "Model", model = "models/props_c17/tools_wrench01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.522, 1.484, 2.912), angle = Angle(50.201, 174.306, -90.536), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["stock_idk"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.371, 2.08, -4.529), angle = Angle(42.287, -1.81, 81.131), size = Vector(0.102, 0.2, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["stock_idk+"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.648, 0.68, -5.532), angle = Angle(35.441, 172.252, -89.634), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["stock_idk++"] = { type = "Model", model = "models/props_junk/harpoon002a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.668, 0.631, -4.957), angle = Angle(35.441, 172.252, -89.634), size = Vector(0.1, 0.1, 0.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "smg"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"
SWEP.UseHands = true

SWEP.Primary.Damage = 61
SWEP.Primary.NumShots = 6
SWEP.Primary.Delay = 1.2

SWEP.Primary.ClipSize = 2
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 3
SWEP.ConeMin = 1.5

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SMG1

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 6

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.1)

function SWEP:EmitFireSound()
	self:EmitSound("weapons/zs_longarm/longarm_fire.ogg", 85, 60)
	self:EmitSound("weapons/357/357_fire3.wav", 85, 60, nil, CHAN_WEAPON + 20)
end