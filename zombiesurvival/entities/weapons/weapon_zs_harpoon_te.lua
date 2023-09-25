AddCSLuaFile()

SWEP.PrintName = "MEGATON SUICIDE BOMB OF DESTRUCTION"
SWEP.Description = "Smoke a fat fucking joint"

if CLIENT then
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70
	SWEP.ViewModelFlip = false

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.UseHands = true

SWEP.HoldType = "camera"

SWEP.WalkSpeed = SPEED_FAST

SWEP.AllowQualityWeapons = false

function SWEP:PlaySwingSound()
end

function SWEP:PlayHitSound()
end

function SWEP:PlayHitFleshSound()
end

function SWEP:PrimaryAttack()
	if SERVER then
		util.BlastDamagePlayer(self, self:GetOwner(), self:GetOwner():WorldSpaceCenter(), 9999999, 99999, DMG_ALWAYSGIB)
		BroadcastLua("util.WhiteOut(8)")
		BroadcastLua([[RunConsoleCommand("stopsound")]])

		local scale = 0
		timer.Create("LerpTimescale", 0.2, 20, function()
			scale = scale + 0.05
			game.SetTimeScale(scale)
		end)
	end
	self:SetNextPrimaryFire(CurTime() + 10)
end