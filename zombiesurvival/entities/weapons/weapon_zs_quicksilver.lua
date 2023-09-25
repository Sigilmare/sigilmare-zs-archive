AddCSLuaFile()
DEFINE_BASECLASS("weapon_zs_base")

SWEP.PrintName = "'Quicksilver' Semi-Auto Rifle"
SWEP.Description = "A semi automatic sniper rifle. Has good fire rate, large clip size and a decent damage per shot."

SWEP.Slot = 3
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "ar2"

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_g3sg1_reanim.mdl"
SWEP.WorldModel = "models/weapons/w_snip_g3sg1.mdl"
SWEP.UseHands = true

SWEP.Primary.Sound = Sound("Weapon_G3SG1.Single")
SWEP.Primary.Damage = 78.5
SWEP.Primary.NumShots = 1
SWEP.Primary.Delay = 0.38

SWEP.Primary.ClipSize = 10
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "357"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.Primary.Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW
SWEP.ReloadGesture = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN

SWEP.ConeMax = 6.5
SWEP.ConeMin = 0

SWEP.WalkSpeed = SPEED_SLOW

SWEP.Tier = 4

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_FIRE_DELAY, -0.05)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Mercurial' Birdshot Rifle", "Fires a spread of less accurate shots that deal more total damage", function(wept)
	wept.Primary.Damage = wept.Primary.Damage / 5
	wept.Primary.NumShots = 6
	wept.ConeMin = 3
end)

function SWEP:IsScoped()
	return self:GetIronsights() and self.fIronTime and self.fIronTime + 0.25 <= CurTime()
end

function SWEP:SendReloadAnimation()
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	else
		self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
	end
end

if CLIENT then
	SWEP.IronsightsMultiplier = 0.25

	function SWEP:GetViewModelPosition(pos, ang)
		if GAMEMODE.DisableScopes then return end

		if self:IsScoped() then
			return pos + ang:Up() * 256, ang
		end

		return BaseClass.GetViewModelPosition(self, pos, ang)
	end

	function SWEP:DrawHUDBackground()
		if GAMEMODE.DisableScopes then return end

		if self:IsScoped() then
			self:DrawRegularScope()
		end
	end
end
