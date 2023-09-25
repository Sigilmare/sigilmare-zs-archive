include("shared.lua")

SWEP.Slot = 2
SWEP.SlotPos = 0

SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 150

SWEP.HUD3DBone = "Base"
SWEP.HUD3DPos = Vector(3, -0.5, -13)
SWEP.HUD3DAng = Angle(180, 0, 0)
SWEP.HUD3DScale = 0.03

SWEP.VElements = {
	["barrel1+"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-14.094, 0, -2.274), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1+++++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-14.094, -2.057, 0.998), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "Base", rel = "", pos = Vector(2.502, 1.71, 0.43), angle = Angle(-90, 90.875, 0), size = Vector(0.5, 1.041, 0.903), color = Color(95, 95, 95, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["triangle++++"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-22.296, 0, 0), angle = Angle(180, 180, 0), size = Vector(0.949, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["triangle+++"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-20.307, 0, 0), angle = Angle(180, 180, 0), size = Vector(0.949, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-14.094, 2.056, 0.998), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["triangle+++++"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-24.285, 0, 0), angle = Angle(180, 180, 0), size = Vector(0.949, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["circle1+"] = { type = "Model", model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "handle", pos = Vector(9.253, -1.787, -0.245), angle = Angle(0, 180, 0), size = Vector(0.052, 0.1, 0.1), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-14.094, 0, 2.216), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["triangle++"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-11.82, 0, 0), angle = Angle(180, 180, 0), size = Vector(2.15, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["circle1"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "handle", pos = Vector(0.708, 0, 0), angle = Angle(0, 0, 0), size = Vector(2.135, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1+++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-14.094, 2.056, -1.323), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1++++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "circle1", pos = Vector(-14.094, -2.057, -1.323), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
}

SWEP.WElements = {
	["barrel1+"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-14.094, 0, 2.216), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["triangle+"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-11.82, 0, 0), angle = Angle(180, 180, 0), size = Vector(2.15, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["handle"] = { type = "Model", model = "models/props_wasteland/panel_leverhandle001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.549, 0.56, 4.052), angle = Angle(177.938, 3.655, 0), size = Vector(0.5, 1.041, 0.903), color = Color(95, 95, 95, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel1++++++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-14.094, -2.057, 0.998), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["triangle+++"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-22.296, 0, 0), angle = Angle(180, 180, 0), size = Vector(0.949, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-14.094, 0, -2.274), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["circle1+"] = { type = "Model", model = "models/props_citizen_tech/steamengine001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(9.253, -1.787, -0.245), angle = Angle(0, 180, 0), size = Vector(0.052, 0.1, 0.1), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["circle1"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "handle", pos = Vector(0.708, 0, 0), angle = Angle(0, 0, 0), size = Vector(2.135, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["triangle++++"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-24.285, 0, 0), angle = Angle(180, 180, 0), size = Vector(0.949, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["triangle++"] = { type = "Model", model = "models/XQM/panel360.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-20.307, 0, 0), angle = Angle(180, 180, 0), size = Vector(0.949, 0.143, 0.143), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1+++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-14.094, 2.056, 0.998), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1++++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-14.094, 2.056, -1.323), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} },
	["barrel1+++++"] = { type = "Model", model = "models/mechanics/wheels/wheel_rugged_24.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "circle1", pos = Vector(-14.094, -2.057, -1.323), angle = Angle(90, 0, 0), size = Vector(0.054, 0.054, 3.535), color = Color(100, 100, 100, 255), surpresslightning = false, material = "models/props_canal/metalwall005b", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(1, 0, 9), angle = Angle(0, 0, 0) },
	["Base"] = { scale = Vector(1, 1, 1), pos = Vector(-12.412, -2.212, -0.42), angle = Angle(0, 0, 0) }
}

SWEP.LastVel = 0

SWEP.IronSightsPos = Vector(1.24, 0, 2.359)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:Think()
	self:CheckSpool()
end

local colBG = Color(16, 16, 16, 90)
local colRed = Color(220, 0, 0, 230)
local colWhite = Color(220, 220, 220, 230)

function SWEP:Draw2DHUD()
	local screenscale = BetterScreenScale()

	local wid, hei = 180 * screenscale, 64 * screenscale
	local x, y = ScrW() - wid - screenscale * 128, ScrH() - hei - screenscale * 72
	local spare = self:GetPrimaryAmmoCount()

	draw.RoundedBox(16, x, y, wid, hei, colBG)
	draw.SimpleTextBlurry("∞", "ZSHUDFontBig", x + wid * 0.5, y + hei * 0.5, spare == 0 and colRed or colWhite, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	local rotators = self.VElements["circle1"].angle
	local vel = Lerp(0.1, self.LastVel, self:GetSpool() * FrameTime() * 6000)
	rotators.r = rotators.r + vel

	self.LastVel = vel
end

function SWEP:Draw3DHUD(vm, pos, ang)
end

local ghostlerp = 0
function SWEP:CalcViewModelView(vm, oldpos, oldang, pos, ang)
	local Offset = self.IronSightsPos
	if self.IronSightsAng then
		ang = Angle(ang.p, ang.y, ang.r)
		ang:RotateAroundAxis(ang:Right(), self.IronSightsAng.x)
		ang:RotateAroundAxis(ang:Up(), self.IronSightsAng.y)
		ang:RotateAroundAxis(ang:Forward(), self.IronSightsAng.z)
	end

	pos = pos - ang:Forward() * 30 + ang:Right() * 0 + ang:Up() * 10

	ghostlerp = math.max(0, ghostlerp - FrameTime() * 3)

	if ghostlerp > 0 then
		pos = pos - 35.5 * ghostlerp * ang:Up()
		ang:RotateAroundAxis(ang:Right(), 70 * ghostlerp)
	end

	return pos, ang
end
