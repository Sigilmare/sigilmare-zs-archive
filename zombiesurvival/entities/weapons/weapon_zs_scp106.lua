AddCSLuaFile()

SWEP.PrintName = "SCP-106"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 65
SWEP.MeleeForceScale = 0
SWEP.MeleeDelay = 0
SWEP.SwingAnimSpeed = 5

SWEP.Primary.Delay = 2

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:PlayAlertSound()
	self:PlayAttackSound()
end

function SWEP:PlayMissSound()
end

function SWEP:PlayHitSound()
end

function SWEP:PlayIdleSound()
	if SERVER then
		BroadcastLua([[surface.PlaySound("sigilmare/scp/106/laugh.wav")]])
	end
end

function SWEP:PlayAttackSound()
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("models/cpthazama/scp/106/106")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end
