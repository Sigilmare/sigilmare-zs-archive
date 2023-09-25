AddCSLuaFile()

SWEP.PrintName = "'Cody' Dual Desert Eagles"
SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70

	SWEP.ShowViewModel = false

	SWEP.VElements = {
		["deagle"] = { type = "Model", model = "models/weapons/cstrike/c_pist_deagle.mdl", bone = "v_weapon.elite_right", rel = "", pos = Vector(6.27404, -5.73288, -22.06656), angle = Angle(89.746, 2.423, -92.113), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["deagle+"] = { type = "Model", model = "models/weapons/cstrike/c_pist_deagle.mdl", bone = "v_weapon.elite_left", rel = "", pos = Vector(6.178, -6.032, -21.957), angle = Angle(89.682, 2.545, -92.082), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["mag"] = { type = "Model", model = "models/hunter/blocks/cube025x125x025.mdl", bone = "v_weapon.magazine_right", rel = "", pos = Vector(0.411, -2.525, -0.009), angle = Angle(-0.642, 0.89, 8.289), size = Vector(0.067, 0.073, 0.127), color = Color(72, 72, 72, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} },
		["mag+"] = { type = "Model", model = "models/hunter/blocks/cube025x125x025.mdl", bone = "v_weapon.magazine_left", rel = "", pos = Vector(0.411, -2.525, -0.009), angle = Angle(-0.642, 0.89, 8.289), size = Vector(0.067, 0.073, 0.127), color = Color(72, 72, 72, 255), surpresslightning = false, material = "metal2", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "duel"

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_elite_reanim.mdl"
SWEP.WorldModel = "models/weapons/w_pist_elite.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_Deagle.Single")
SWEP.Primary.Damage = 57
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.16

SWEP.Primary.ClipSize = 14
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ConeMax = 3.4
SWEP.ConeMin = 1.25

SWEP.Tier = 6

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 2)

function SWEP:SecondaryAttack()
end

function SWEP:SendWeaponAnimation()
	self:SendWeaponAnim(self:Clip1() % 2 == 0 and ACT_VM_PRIMARYATTACK or ACT_VM_SECONDARYATTACK)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.FireAnimSpeed)
end

function SWEP:SendReloadAnimation()
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	else
		self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
	end
end

if not CLIENT then return end

function SWEP:GetTracerOrigin()
	local owner = self:GetOwner()
	if owner:IsValid() then
		local vm = owner:GetViewModel()
		if vm and vm:IsValid() then
			local attachment = vm:GetAttachment((self:Clip1() % 2 - 1) + 3)
			if attachment then
				return attachment.Pos
			end
		end
	end
end
