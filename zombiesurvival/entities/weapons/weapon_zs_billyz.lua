AddCSLuaFile()

SWEP.PrintName = "Billy"

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = ZS.VMFOVScale * 70

	SWEP.VElements = {
		["element_name"] = { type = "Model", model = "models/weapons/w_knife_t.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.159, 1.6, -5.358), angle = Angle(-5, 173.02, 5), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2a", skin = 0, bodygroup = {} }
	}
	

	SWEP.WElements = {
		["element_name"] = { type = "Model", model = "models/weapons/w_knife_t.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.159, 1.6, -5.358), angle = Angle(-5, 173.02, 5), size = Vector(1.5, 1.5, 1.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "metal2a", skin = 0, bodygroup = {} }
	}	
end

SWEP.Base = "weapon_zs_basemelee"

SWEP.HoldType = "grenade"

SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.UseHands = true

SWEP.ShowWorldModel = false
SWEP.ShowViewModel = false

SWEP.MeleeDamage = 20
SWEP.MeleeRange = 90
SWEP.MeleeSize = 1.5

SWEP.WalkSpeed = SPEED_FASTEST

SWEP.Primary.Delay = 1

SWEP.HitDecal = "Manhackcut"

SWEP.HitAnim = ACT_VM_PRIMARYATTACK
SWEP.MissAnim = ACT_VM_MISSCENTER

SWEP.NoHitSoundFlesh = true

SWEP.AllowQualityWeapons = false

function SWEP:PlaySwingSound()
	--self:EmitSound("weapons/knife/knife_slash"..math.random(2)..".wav")
end

function SWEP:PlayHitSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 80, 50, 1, CHAN_STATIC)
end

function SWEP:PlayHitFleshSound()
	self:EmitSound("ambient/machines/slicer"..math.random(4)..".wav", 80, 50, 1, CHAN_STATIC)
end

function SWEP:OnMeleeHit(hitent, hitflesh, tr)
	if SERVER and hitent:IsValid() and hitent:IsPlayer() then
		local bleed = hitent:GiveStatus("bleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(20)
			bleed.Damager = self:GetOwner()
		end
		hitent:GiveStatus("confusion")
	end
end

function SWEP:SecondaryAttack()
	self:EmitSound("sigilmare/sfx/nunmassacre/scream"..math.random(9)..".wav", 80, math.random(95, 105), 1, CHAN_STATIC)
	self:SetNextSecondaryFire(CurTime() + 1)
end

function SWEP:SetNextAttack()
	local owner = self:GetOwner()
	local armdelay = owner:GetMeleeSpeedMul()
	if owner:Health() > 30000 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * armdelay)
	elseif owner:Health() <= 30000 and owner:Health() > 15000 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 0.5 * armdelay)
	elseif owner:Health() <= 15000 and owner:Health() > 7500 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 0.25 * armdelay)
	elseif owner:Health() <= 7500 then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 0.1 * armdelay)
	end
end