AddCSLuaFile()

SWEP.PrintName = "'Showstopper' RPG-7"
SWEP.Description = "Only the chosen are allowed to sustain such power."

SWEP.Slot = 2
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.SwayScale = 1
	SWEP.BobScale = 0

	SWEP.WElements = {
		["element_name"] = { type = "Model", model = "models/khrcw2/w_ins2rpg7.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.553, 0.048, -2.141), angle = Angle(-8.391, -10, 176.636), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
end

SWEP.Base = "weapon_zs_baseproj"

if SERVER then
	SWEP.Primary.Projectile = "projectile_rpg7"
	SWEP.Primary.ProjVelocity = 3500
end

SWEP.HoldType = "rpg"

SWEP.ShowWorldModel = false

SWEP.ViewModel = "models/khrcw2/ins2rpg7.mdl"
SWEP.WorldModel = "models/khrcw2/w_ins2rpg7.mdl"
SWEP.UseHands = false

SWEP.Primary.Sound = Sound("weapons/ins2rpg7/rpg7_fp.wav")
SWEP.Primary.Delay = 0.5
SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "impactmine"
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Damage = 620

SWEP.Primary.ClipSize = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "impactmine"
SWEP.Primary.DefaultClip = 99999

SWEP.FireAnimSpeed = 0.5

SWEP.IdleActivity = 0

SWEP.ReloadSpeed = 1

SWEP.ConeMax = 0
SWEP.ConeMin = 0

SWEP.WalkSpeed = 160

SWEP.Tier = 6

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.1, 1)

function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)
end

function SWEP:SendReloadAnimation()
	local r = 33.5 * self:GetReloadSpeedMultiplier() * self.ReloadSpeed
	local id = self:GetOwner():SteamID()

	if not SERVER then return end

	timer.Create("RPG7Reload1"..id, 5 / r, 1, function()
		if self and self:IsValid() then
			self:EmitSound("weapons/ins2rpg7/handling/rpg7_fetch.wav", 70, 100, 1, CHAN_STATIC)
		end
	end)

	timer.Create("RPG7Reload2"..id, 81 / r, 1, function()
		if self and self:IsValid() then
			self:EmitSound("weapons/ins2rpg7/handling/rpg7_load1.wav", 70, 100, 1, CHAN_STATIC)
		end
	end)

	timer.Create("RPG7Reload3"..id, 101 / r, 1, function()
		if self and self:IsValid() then
			self:EmitSound("weapons/ins2rpg7/handling/rpg7_load2.wav", 70, 100, 1, CHAN_STATIC)
		end
	end)

	timer.Create("RPG7Reload4"..id, 140 / r, 1, function()
		if self and self:IsValid() then
			self:EmitSound("weapons/ins2rpg7/handling/rpg7_endgrab.wav", 70, 100, 1, CHAN_STATIC)
		end
	end)

	self:SendWeaponAnim(ACT_VM_RELOAD)
end

function SWEP:Holster()
	local id = self:GetOwner():SteamID()
	if timer.Exists("RPG7Reload1"..id) then
		timer.Remove("RPG7Reload1"..id)
	end

	if timer.Exists("RPG7Reload2"..id) then
		timer.Remove("RPG7Reload2"..id)
	end

	if timer.Exists("RPG7Reload3"..id) then
		timer.Remove("RPG7Reload3"..id)
	end

	if timer.Exists("RPG7Reload4"..id) then
		timer.Remove("RPG7Reload4"..id)
	end

	return true
end