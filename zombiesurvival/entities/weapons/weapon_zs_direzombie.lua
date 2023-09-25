AddCSLuaFile()

SWEP.PrintName = "Dire Zombie"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 36
SWEP.MeleeForceScale = 1.25

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:PlayAlertSound()
	self:PlayAttackSound()
end

function SWEP:PlayIdleSound()
	self:GetOwner():EmitSound("npc/zombie_poison/pz_alert"..math.random(2)..".wav", 75, math.random(110, 120))
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/zombie/zombie_pain"..math.random(4, 5)..".wav", 70, math.Rand(110, 120))
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local mat = Material("models/skeleton/skeleton_bloody")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(mat)
end
