SWEP.PrintName = "Item"

SWEP.AnimPrefix = "none"
SWEP.HoldType = "normal"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.DrawCrosshair = false
SWEP.Primary.Sound = Sound("")

SWEP.WorldModel	= "models/weapons/w_crowbar.mdl"

SWEP.WalkSpeed = SPEED_NORMAL

function SWEP:Initialize()
end

function SWEP:Equip()
	local owner = self:GetOwner()
	local children = self:GetChildren()

	if GAMEMODE.ZombieEscape then
		if #children > 0 then
			local name = children[#children-1].FixedKeyValues.parentname
			
			GAMEMODE:CenterNotifyAll(COLOR_GREEN, owner:GetName() .. " has picked up "..GAMEMODE.MateriaButtonTranslations[name].."!")
			PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..owner:GetName() .. " has picked up a ZE Weapon. ("..GAMEMODE.MateriaButtonTranslations[name]..")")
			if SERVER then
				local filterStart, filterEnd = string.find( game.GetMap():lower(), "ze_ffvii_mako_reactor" )
				if filterStart then
					if self:GetDTString(1) ~= name then
						self:SetDTString(1, name )
					end
					if self:GetDTString(1) ~= owner:Nick() then
						self:SetDTString(2, owner:Nick() )
					end
				end
				gamemode.Call("nZEWeaponPickup", owner, self)
			end
		end
	end
end

function SWEP:SetWeaponHoldType()
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Deploy()
	if SERVER then
		local owner = self:GetOwner()

		if GAMEMODE.ZombieEscape then
			owner:SelectWeapon("weapon_zs_zeknife")
		else
			owner:SelectWeapon("weapon_zs_fists")
		end
	end
	return true
end

function SWEP:CanPrimaryAttack()
	return false
end

function SWEP:CanSecondaryAttack()
	return false
end
