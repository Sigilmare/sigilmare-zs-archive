AddCSLuaFile()

SWEP.PrintName = "Repairs Welder"

if CLIENT then
end

SWEP.Base = "weapon_zs_hammer"

SWEP.HoldType = "revolver"

SWEP.MeleeDamage = 6 --40

SWEP.Primary.Delay = 0.2

SWEP.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.WorldModel = "models/weapons/w_toolgun.mdl"

SWEP.MeleeRange = 70

SWEP.AllowQualityWeapons = false

SWEP.NoHitSoundFlesh = true

SWEP.NoGlassWeapons = true

function SWEP:SetNextAttack()
	local owner = self:GetOwner()
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
end

if SERVER then
	function SWEP:OnMeleeHit(hitent, hitflesh, tr)
		if not hitent:IsValid() then return end
	
		local owner = self:GetOwner()
	
		if hitent.HitByHammer and hitent:HitByHammer(self, owner, tr) then
			return
		end
	
		if hitent:IsNailed() then
			local healstrength = 1
			if math.floor(hitent:GetBarricadeRepairs()) >= math.floor(hitent:GetMaxBarricadeRepairs()) then return end
	
			hitent:SetBarricadeRepairs(math.min(hitent:GetBarricadeRepairs() + 1, hitent:GetMaxBarricadeRepairs()))
			self:PlayRepairSound(hitent)
			--gamemode.Call("PlayerRepairedObject", owner, hitent, healed, self)
	
			local effectdata = EffectData()
				effectdata:SetOrigin(tr.HitPos)
				effectdata:SetNormal(tr.HitNormal)
				effectdata:SetMagnitude(1)
			util.Effect("welder_repair", effectdata, true, true)

			local effectdata = EffectData()
			effectdata:SetOrigin(tr.HitPos)
			effectdata:SetNormal(tr.HitNormal)
			util.Effect("hit_charon", effectdata)

			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

			owner:AddPoints(0.1)
	
			return true
		end
	end
end

function SWEP:PostHitUtil(owner, hitent, dmginfo, tr, vel)
	hitent:DispatchTraceAttack(dmginfo, tr, owner:GetAimVector())

	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos)
	effectdata:SetNormal(tr.HitNormal)
	util.Effect("hit_charon", effectdata)

	if SERVER then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	end

	if self.MeleeFlagged then self.IsMelee = nil end
end

function SWEP:PlayHitSound()
end

function SWEP:PlayHitFleshSound()
end

function SWEP:PlaySwingSound()
end

function SWEP:SecondaryAttack()
end

if not CLIENT then return end

function SWEP:DrawHUD()
	if GetGlobalBool("classicmode") then return end
	self:DrawCrosshairDot()
end