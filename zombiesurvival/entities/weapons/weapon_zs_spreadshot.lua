AddCSLuaFile()

SWEP.Base = "weapon_zs_baseshotgun"

SWEP.PrintName = "'Spreadshot' Shotgun"
SWEP.Description = "A fast-firing shotgun with moderate damage output. SCK by Snowstorm."

if CLIENT then
	SWEP.ViewModelFlip = false

	SWEP.HUD3DPos = Vector(1.3, -2, 1)
	SWEP.HUD3DAng = Angle(180, 0, 0)
	SWEP.HUD3DScale = 0.02
	SWEP.HUD3DBone = "gun"

    SWEP.VElements = {
        ["barrel"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0, -2, 9.5), angle = Angle(0, 0, 0), size = Vector(0.06, 0.06, 0.3), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["fabric"] = { type = "Model", model = "models/mechanics/solid_steel/box_beam_4.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(-0.1, -0.2, -12.5), angle = Angle(6.792, 1, 90), size = Vector(0.125, 0.01, 0.45), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["fabric+"] = { type = "Model", model = "models/mechanics/solid_steel/box_beam_4.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0, -1.25, -6.2), angle = Angle(0, 0, 83), size = Vector(0.125, 0.01, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["frontsight"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0.125, -3, 22.25), angle = Angle(0, 90, -90), size = Vector(0.02, 0.06, 0.04), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["magtube"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0, -0.6, 16.5), angle = Angle(0, 0, 0), size = Vector(0.04, 0.04, 0.175), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["main"] = { type = "Model", model = "", bone = "gun", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["muzzle"] = { type = "Model", model = "models/props_trainstation/trashcan_indoor001b.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0, -2, 24), angle = Angle(0, 0, 0), size = Vector(0.075, 0.075, 0.075), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["rail"] = { type = "Model", model = "models/props_trainstation/pole_448Connection002b.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0, -3, 16), angle = Angle(0, 0, 180), size = Vector(0.03, 0.03, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["rearsight"] = { type = "Model", model = "models/props_wasteland/panel_leverHandle001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0, -4, 0), angle = Angle(115, 90, 0), size = Vector(0.05, 0.05, 0.05), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["receiver"] = { type = "Model", model = "models/phxtended/bar1x45a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0.6, -2.4, -4.5), angle = Angle(0, 180, 90), size = Vector(0.2, 0.3, 0.2), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["scrap"] = { type = "Model", model = "models/props_junk/vent001_chunk6.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(0, -2.7, -8.65), angle = Angle(0, -20, 90), size = Vector(0.5, 0.4, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["stock"] = { type = "Model", model = "models/phxtended/tri2x1solid.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "main", pos = Vector(-0.6, -2.5, -13), angle = Angle(90, 0, 180), size = Vector(0.15, 0.1, 0.2), color = Color(218, 218, 218, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} }
    }
    
    SWEP.WElements = {
        ["barrel"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0, -2, 9.5), angle = Angle(0, 0, 0), size = Vector(0.06, 0.06, 0.3), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["fabric"] = { type = "Model", model = "models/mechanics/solid_steel/box_beam_4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(-0.1, -0.2, -12.5), angle = Angle(6.792, 1, 90), size = Vector(0.125, 0.01, 0.45), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["fabric+"] = { type = "Model", model = "models/mechanics/solid_steel/box_beam_4.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0, -1.25, -6.2), angle = Angle(0, 0, 83), size = Vector(0.125, 0.01, 0.3), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["frontsight"] = { type = "Model", model = "models/phxtended/tri1x1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0.125, -3, 22.25), angle = Angle(0, 90, -90), size = Vector(0.02, 0.06, 0.04), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["magtube"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0, -0.6, 16.5), angle = Angle(0, 0, 0), size = Vector(0.04, 0.04, 0.175), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["main"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.5, 1, -2.5), angle = Angle(0, -90, -100), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["muzzle"] = { type = "Model", model = "models/props_trainstation/trashcan_indoor001b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0, -2, 24), angle = Angle(0, 0, 0), size = Vector(0.075, 0.075, 0.075), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["rail"] = { type = "Model", model = "models/props_trainstation/pole_448Connection002b.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0, -3, 16), angle = Angle(0, 0, 180), size = Vector(0.03, 0.03, 0.03), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["receiver"] = { type = "Model", model = "models/phxtended/bar1x45a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0.6, -2.4, -4.5), angle = Angle(0, 180, 90), size = Vector(0.2, 0.3, 0.2), color = Color(109, 109, 109, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["scrap"] = { type = "Model", model = "models/props_junk/vent001_chunk6.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(0, -2.7, -8.65), angle = Angle(0, -20, 90), size = Vector(0.5, 0.4, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
        ["stock"] = { type = "Model", model = "models/phxtended/tri2x1solid.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "main", pos = Vector(-0.6, -2.5, -13), angle = Angle(90, 0, 180), size = Vector(0.15, 0.1, 0.2), color = Color(218, 218, 218, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} }
    }
end

SWEP.HoldType = "shotgun"

SWEP.ViewModel = "models/weapons/sigilmare/c_supershorty_reanim.mdl"
SWEP.WorldModel = "models/weapons/w_supershorty.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Shotgun.NPC_Single")
SWEP.Primary.Damage = 9
SWEP.Primary.NumShots = 7
SWEP.Primary.Delay = 0.45

SWEP.Primary.ClipSize = 7
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "buckshot"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ReloadDelay = 0.6

SWEP.ReloadSpeed = 1.4

SWEP.ConeMax = 6
SWEP.ConeMin = 3

SWEP.WalkSpeed = SPEED_SLOWER

SWEP.PumpSound = Sound("Weapon_M3.Pump")
SWEP.ReloadSound = Sound("Weapon_Shotgun.Reload")

SWEP.PumpActivity = ACT_SHOTGUN_PUMP

SWEP.Tier = 2

SWEP.FireAnimSpeed = 1.5

function SWEP:StopReloading()
    self:SetDTFloat(3, 0)
    self:SetDTBool(2, false)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 0.75)

    -- do the pump stuff if we need to
    if self:Clip1() > 0 then
        if self.PumpActivity then
            self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
            self:ProcessReloadAnim()
        end
    end
end

function SWEP:EmitFireSound()
    self:EmitSound("weapons/shotgun/shotgun_cock.wav", 70, 200, 1, CHAN_AUTO)
    self:EmitSound("weapons/shotgun/shotgun_fire7.wav", 70, 120, 1, CHAN_AUTO)
end