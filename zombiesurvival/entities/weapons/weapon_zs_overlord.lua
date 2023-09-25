DEFINE_BASECLASS("weapon_zs_base")
AddCSLuaFile()

SWEP.PrintName = "'Overlord' Pulse Pistol"
SWEP.Description = "A combine officers pulse pistol. Has a custom burst mode that activates when sighted in."

SWEP.Slot = 1
SWEP.SlotPos = 0

if CLIENT then
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = true

	SWEP.VElements = {
		["Base"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.base", rel = "", pos = Vector(0.4, 0.5, -1), angle = Angle(0, 0, -4.528), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Lapis-Body"] = { type = "Model", model = "models/props_combine/eli_pod.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Base", pos = Vector(0, 0.245, -3.844), angle = Angle(-80, 90, 0), size = Vector(0.07, 0.08, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/items/combine_rifle_cartridge01", skin = 0, bodygroup = {} },
		["Lapis-Body1"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Base", pos = Vector(0.24, -0.7, 6.038), angle = Angle(86, -90, 179), size = Vector(0.01, 0.018, 0.015), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Lapis-Body2"] = { type = "Model", model = "models/Items/combine_rifle_cartridge01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Base", pos = Vector(0.011, -1.051, -2.026), angle = Angle(-87.17, 90, -180), size = Vector(0.5, 0.7, 0.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Lapis-Body3"] = { type = "Model", model = "models/props_combine/combine_train02a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Base", pos = Vector(0, -0.976, 4.7), angle = Angle(0, -180, 85), size = Vector(0.017, 0.02, 0.007), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/items/combine_rifle_cartridge01", skin = 0, bodygroup = {} },
		["Lapis-Body4"] = { type = "Model", model = "models/props_combine/combinetrain01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Base", pos = Vector(0, 1.092, 4.678), angle = Angle(5, 90, 0), size = Vector(0.006, 0.015, 0.02), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Lapis-Gun"] = { type = "Model", model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.base", rel = "Base", pos = Vector(0.91, -1.043, 1.871), angle = Angle(-81.509, -13.585, -88.302), size = Vector(1.2, 1.1, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Lapis-Laser"] = { type = "Model", model = "models/hunter/tubes/tube1x1x8.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Base", pos = Vector(0.064, 2.013, 9.057), angle = Angle(-0.002, 0.012, 4.513), size = Vector(0, 0, 0), color = Color(0, 0, 0, 0), surpresslightning = false, material = "model_color", skin = 0, bodygroup = {} },
		["Lapis-Sides1"] = { type = "Model", model = "models/props_combine/combine_fence01b.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Lapis-Body3", pos = Vector(0.607, 2.791, -0.438), angle = Angle(90.566, -90, 0), size = Vector(0.06, 0.06, 0.06), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["Lapis-Sides2"] = { type = "Model", model = "models/props_combine/combine_fence01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "Lapis-Body3", pos = Vector(-0.6, 2.791, -0.438), angle = Angle(90.566, -90, 0), size = Vector(0.06, 0.06, 0.06), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["LaserGlow"] = { type = "Sprite", sprite = "sprites/animglow02", bone = "ValveBiped.Bip01_Spine4", rel = "Lapis-Laser", pos = Vector(0, 0, 1.006), size = { x = 5, y = 5 }, color = Color(0, 161, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
	}
	
	SWEP.ViewModelBoneMods = {
		["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(0, 0, 0), pos = Vector(0, -200, -200), angle = Angle(0, 0, 0) }
	}
end

SWEP.Base = "weapon_zs_base"

SWEP.HoldType = "pistol"

SWEP.ViewModel = "models/weapons/sigilmare/zs/c_smg1_reanim_v3.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.Primary.Damage = 22
SWEP.Primary.NumShots = 1
SWEP.Primary.BurstShots = 3 --The burst fire code is taken from the m4 burst
SWEP.Primary.Delay = 0.4

SWEP.Primary.ClipSize = 15
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pulse"
GAMEMODE:SetupDefaultClip(SWEP.Primary)

SWEP.ReloadSpeed = 1

SWEP.ConeMax = 3
SWEP.ConeMin = 1

SWEP.Tier = 2

SWEP.IdleActivity = 0

SWEP.TracerName = "AR2Tracer"

function SWEP:SendReloadAnimation()
	if self:Clip1() > 0 then
		self:SendWeaponAnim(ACT_VM_RELOAD)
	else
		self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
	end
end

SWEP.Think = function(self)
	BaseClass.Think(self)

	local shotsleft = self:GetShotsLeft()

	if not self:GetIronsights() then -- Setting up burst delay here

		self:SetShotsLeft(0)
		self:SetShooting(0)
		self.Primary.Delay = 0.22

	else

		self.Primary.Delay = 0.45

	end

	if shotsleft < 1 then
		self:SetShooting(0)
	end

	if shotsleft > 0 and CurTime() >= self:GetNextShot() then
		self:SetShooting(1)
		self:SetShotsLeft(shotsleft - 1)
		self:SetNextShot(CurTime() + self:GetFireDelay()/5)

		if self:Clip1() > 0 and self:GetReloadFinish() == 0 then
			self:EmitFireSound()
			self:TakeAmmo()
			self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())

			self.IdleAnimation = CurTime() + self:SequenceDuration()
		else
			self:SetShotsLeft(0)
			self:SetShooting(0)
		end
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	if not self:GetIronsights() then

		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())

		self:EmitFireSound()
		self:TakeAmmo()
		self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	else

		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())
		self:EmitFireSound()

		self:SetNextShot(CurTime())
		self:SetShotsLeft(self.Primary.BurstShots)

		self.IdleAnimation = CurTime() + self:SequenceDuration()

	end
end

function SWEP:EmitFireSound()
	self:EmitSound("weapons/stunstick/alyx_stunner"..math.random(2)..".wav", 75, math.random(130, 160), nil, CHAN_WEAPON + 20)
	self:EmitSound("weapons/ar2/fire1.wav", 75, math.random(70, 110))
end

function SWEP:GetCone() --I tried using BaseClass:GetCone() here to shorten the code but it gives errors. -Cylo
	local owner = self:GetOwner()

	local shotsleft = self:GetShotsLeft()

	local basecone = self.ConeMin
	local conedelta = self.ConeMax - basecone

	local orphic = not owner.Orphic and 1 or self:GetIronsights() and 0.9 or 1.1
	local tiervalid = (self.Tier or 1) <= 3
	local spreadmul = (owner.AimSpreadMul or 1) - ((tiervalid and owner:HasTrinket("refinedsub")) and 0.27 or 0)

	if owner.TrueWooism then
		return (basecone + conedelta * (0.5 + (3-shotsleft) * 0.15 * self:GetShooting()) ^ self.ConeRamp) * spreadmul * orphic
	end

	if not owner:OnGround() or self.ConeMax == basecone then return self.ConeMax + (3-shotsleft) * 1 * self:GetShooting() end --added value is the burst fire cone.

	local multiplier = math.min(owner:GetVelocity():Length() / self.WalkSpeed, 1) * 0.3

	local ironsightmul = 0.25 * (owner.IronsightEffMul or 1)
	local ironsightdiff = 0.25 - ironsightmul
	multiplier = multiplier + ironsightdiff

	if not owner:Crouching() then multiplier = multiplier + 0.25 end
	if not self:GetIronsights() then multiplier = multiplier + ironsightmul end
	if self:GetIronsights() then multiplier = multiplier + (3-shotsleft) * 0.3 * self:GetShooting() end -- we calculate burst fire here

	
	return (basecone + conedelta * (self.FixedAccuracy and 0.6 or multiplier) ^ self.ConeRamp) * spreadmul * orphic
end

function SWEP:ShootBullets(dmg, numbul, cone)
	dmg = dmg + (dmg * 1/5 * (3 - self:GetShotsLeft()) ) * self:GetShooting() --We run the burstfire calculation here.

	BaseClass.ShootBullets(self, dmg, numbul, cone)
end

function SWEP:SetConsShots(shots)
	if shots < 5 then
	 self:SetDTInt(9, shots)
	else
	 self:SetDTInt(9, 5)
	end

end


function SWEP:GetConsShots()
	return self:GetDTInt(9)
end


function SWEP:EmitReloadFinishSound()
	self:EmitSound("buttons/combine_button3.wav", 75, math.random(130, 140), 1, CHAN_STATIC)
end

function SWEP:EmitDryFireSound()
	self:EmitSound("buttons/combine_button2.wav", 75, math.random(130, 140), 1, CHAN_STATIC)
end

function SWEP:SetNextShot(nextshot)
	self:SetDTFloat(5, nextshot)
end

function SWEP:GetNextShot()
	return self:GetDTFloat(5)
end

function SWEP:SetShotsLeft(shotsleft)
	self:SetDTInt(1, shotsleft)
end

function SWEP:GetShotsLeft()
	return self:GetDTInt(1)
end

function SWEP:SetShooting(num) --Created due to the shotsleft starting with a 0 instead of a 3
	self:SetDTInt(7, num)
end

function SWEP:GetShooting()
	return self:GetDTInt(7)
end


--REMANTLE--

GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_RELOAD_SPEED, 0.05, 1)
GAMEMODE:AttachWeaponModifier(SWEP, WEAPON_MODIFIER_CLIP_SIZE, 3)
GAMEMODE:AddNewRemantleBranch(SWEP, 1, "'Watcher' Auto Pulse Pistol", "Automatic conversion kit. Damage increases the more shots you fire.", function(wept)
	wept.ConeMax = wept.ConeMax * 1.5
	wept.ConeMin = wept.ConeMin * 1.2

	wept.Primary.Automatic = true
	wept.Primary.Damage = wept.Primary.Damage - 0.9
	wept.Primary.ClipSize = 20
	wept.Primary.Delay = 0.15

	function wept:GetCone() --Instead of a burst we use GetConsShots now.
		local owner = self:GetOwner()
	
		local basecone = self.ConeMin
		local conedelta = self.ConeMax - basecone
	
		local orphic = not owner.Orphic and 1 or self:GetIronsights() and 0.9 or 1.1
		local tiervalid = (self.Tier or 1) <= 3
		local spreadmul = (owner.AimSpreadMul or 1) - ((tiervalid and owner:HasTrinket("refinedsub")) and 0.27 or 0)
	
		if owner.TrueWooism then
			return (basecone + conedelta * (0.5 + (self:GetConsShots() / 10)) ^ self.ConeRamp) * spreadmul * orphic
		end
	
		if not owner:OnGround() or self.ConeMax == basecone then return self.ConeMax + (self:GetConsShots() / 10)end
	
		local multiplier = math.min(owner:GetVelocity():Length() / self.WalkSpeed, 1) * 0.5
	
		local ironsightmul = 0.25 * (owner.IronsightEffMul or 1)
		local ironsightdiff = 0.25 - ironsightmul
		multiplier = multiplier + ironsightdiff
	
		if not owner:Crouching() then multiplier = multiplier + 0.25 end
		if not self:GetIronsights() then multiplier = multiplier + ironsightmul end
	
		return (basecone + conedelta * (self.FixedAccuracy and 0.6 or multiplier + (self:GetConsShots() / 10)) ^ self.ConeRamp) * spreadmul * orphic
	end

	function wept:Think()

		local owner = self:GetOwner()

		
		if !owner:KeyDown(IN_ATTACK) then --Used to set consecutives.
			self:SetConsShots(0)
		end

		if !self:Clip1() == 0 then
			self:SetConsShots(0) 
		end

		if self:GetIronsights() and not self:GetOwner():KeyDown(IN_ATTACK2) then
			self:SetIronsights(false)
		end
	
		if self:GetReloadFinish() > 0 then
			if CurTime() >= self:GetReloadFinish() then
				self:FinishReload()
			end
		elseif self.IdleAnimation and self.IdleAnimation <= CurTime() then
			self.IdleAnimation = nil
			self:SendWeaponAnim(self.IdleActivity)
		end
	end

	function wept:ShootBullets(dmg, numbul, cone)
		dmg = dmg + dmg * 1/100 * self:GetConsShots() --We run the consecutive fire calculation here.
	
		BaseClass.ShootBullets(self, dmg, numbul, cone)
	end

	function wept:PrimaryAttack()
		if not self:CanPrimaryAttack() then return end

		local consshots = self:GetConsShots()
	
		self:SetNextPrimaryFire(CurTime() + self:GetFireDelay())
		self:SetConsShots(consshots + 1)
		
		self:EmitFireSound()
		self:TakeAmmo()
		self:ShootBullets(self.Primary.Damage, self.Primary.NumShots, self:GetCone())
		self.IdleAnimation = CurTime() + self:SequenceDuration()
	end

end)
