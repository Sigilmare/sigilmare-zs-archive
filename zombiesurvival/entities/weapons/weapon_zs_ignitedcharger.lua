AddCSLuaFile()

DEFINE_BASECLASS("weapon_zs_zombie")

SWEP.PrintName = "Ignited Charger"

SWEP.ViewModel = Model("models/weapons/v_pza.mdl")

SWEP.MeleeDelay = 0.8
SWEP.MeleeDamage = 35
SWEP.BleedDamage = 15
SWEP.MeleeDamageVsProps = 41
SWEP.Primary.Delay = 1.5

SWEP.SwingAnimSpeed = 0.6

SWEP.ChargeDamage = 40
SWEP.ChargeDamageVsPlayerMul = 0.6666
SWEP.ChargeReach = 26
SWEP.ChargeSize = 12
SWEP.ChargeStartDelay = 0.8
SWEP.ChargeDelay = 2
SWEP.ChargeRecovery = 0.75
SWEP.ChargeTime = 4
SWEP.ChargeAccel = 0.5
SWEP.ChargeKnockdown = 3

SWEP.Secondary.Automatic = false

SWEP.NextAllowCharge = 0
function SWEP:Think()
	BaseClass.Think(self)

	local curtime = CurTime()
	local owner = self:GetOwner()

	if self.NextAllowJump and self.NextAllowJump <= curtime then
		self.NextAllowJump = nil

		owner:ResetJumpPower()
	end

	if self:IsCharging() then
		if owner:WaterLevel() >= 2 or CurTime() > self:GetChargeStart() + self.ChargeTime  then
			self:StopCharge()
		elseif IsFirstTimePredicted() then
			local dir = owner:GetVelocity()
			dir:Normalize()

			local chargemul = math.min(self:GetCharge(), owner:GetVelocity():LengthSqr() / 193600)
			local traces = owner:CompensatedZombieMeleeTrace(self.ChargeReach, self.ChargeSize, owner:WorldSpaceCenter(), dir)
			local damage = self:GetDamage(self:GetTracesNumPlayers(traces), self.ChargeDamage * chargemul)

			local attacker = self:GetOwner()

			local hit = false
			for _, trace in ipairs(traces) do
				if not trace.Hit then continue end

				if trace.HitWorld then
					if trace.HitNormal.z < 0.8 then
						hit = true
						self:MeleeHitWorld(trace)
					end
				else
					local ent = trace.Entity
					if ent and ent:IsValid() and not ent:IsProjectile() then
						hit = true
						self:MeleeHit(ent, trace, damage * (ent:IsPlayer() and self.ChargeDamageVsPlayerMul or ent.PounceWeakness or 1) * (self:IsChargeCritical() and not ent:IsPlayer() and 2 or 1), 1)
						if ent:IsPlayer() then
							if SERVER then
								ent:Ignite(3)
								for __, fire in pairs(ents.FindByClass("entityflame")) do
									if fire:IsValid() and fire:GetParent() == ent then
										fire:SetOwner(attacker)
										fire:SetPhysicsAttacker(attacker)
										fire.AttackerForward = attacker
									end
								end
							end
							ent:ThrowFromPositionSetZ(trace.StartPos, 120 * chargemul + owner:GetVelocity():Length() * 0.5)
							if CurTime() >= (ent.NextKnockdown or 0) and self:IsChargeCritical() then
								ent:GiveStatus("knockdown", self.ChargeKnockdown * chargemul)
								ent.NextKnockdown = CurTime() + 4 * chargemul
							end
						end
					end
				end
			end

			if not self.CriticalCharge and self:IsChargeCritical() then
				self:PlayCriticalChargeStartSound()
				self.CriticalCharge = true
			end

			if hit then
				if SERVER then
					self:GetOwner():EmitSound("physics/flesh/flesh_strider_impact_bullet3.wav")
					self:GetOwner():EmitSound("npc/zombie_poison/pz_warn1.wav", 75, math.random(40, 50))
				end
				self:StopCharge()
			end
		end
	elseif self:GetChargeStart() > 0 and CurTime() > self:GetChargeStart() then
		self:StartCharge()
	elseif self.m_ViewAngles then
		self.m_ViewAngles = nil
	end

	self:NextThink(curtime)
	return true
end

function SWEP:PlayCriticalChargeStartSound()
	if SERVER then
		self:GetOwner():EmitSound("npc/zombie_poison/pz_throw3.wav", 75, math.random(50, 55))
	end
end

function SWEP:Move(mv)
	local charge = self:GetCharge()

	if self:GetChargeStart() > 0 and charge <= 0 then
		mv:SetMaxSpeed(0)
		mv:SetMaxClientSpeed(0)
	elseif charge > 0 then
		mv:SetForwardSpeed(10000)
		mv:SetSideSpeed(mv:GetSideSpeed() * 0.1)

		local mul = 1 + charge * 1 + (self:IsChargeCritical() and 1 or 0)
		mv:SetMaxSpeed(mv:GetMaxSpeed() * mul)
		mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() * mul)
	end
end

function SWEP:PrimaryAttack()
	if self:IsCharging() or self:GetChargeStart() > 0 then return end

	BaseClass.PrimaryAttack(self)
end

function SWEP:MeleeHit(ent, trace, damage, forcescale)
	if not ent:IsPlayer() and not (self:IsCharging() or self:GetChargeStart() > 0) then
		damage = self.MeleeDamageVsProps
	end

	BaseClass.MeleeHit(self, ent, trace, damage, forcescale)
end

function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if SERVER and ent:IsPlayer() and not (self:IsCharging() or self:GetChargeStart() > 0) then
		local bleed = ent:GiveStatus("bleed")
		if bleed and bleed:IsValid() then
			bleed:AddDamage(self.BleedDamage)
			bleed.Damager = self:GetOwner()
			ent:Ignite(3)
			for __, fire in pairs(ents.FindByClass("entityflame")) do
				if fire:IsValid() and fire:GetParent() == ent then
					fire:SetOwner(attacker)
					fire:SetPhysicsAttacker(attacker)
					fire.AttackerForward = attacker
				end
			end
		end
	end

	BaseClass.ApplyMeleeDamage(self, ent, trace, damage)
end

function SWEP:SecondaryAttack()
	if self:IsCharging() or self:GetChargeStart() > 0 then return end

	if self:GetOwner():IsOnGround() then
		if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or CurTime() < self.NextAllowCharge then return end

		self:SetNextPrimaryFire(math.huge)
		self:SetChargeStart(CurTime() + self.ChargeStartDelay)

		self:GetOwner():ResetJumpPower()
		if IsFirstTimePredicted() then
			self:PlayChargeStartSound()
		end
	end
end

function SWEP:StartCharge()
	if self:IsCharging() then return end

	local owner = self:GetOwner()
	if owner:IsOnGround() then
		self:SetCharging(true)

		self.m_ViewAngles = owner:EyeAngles()

		if IsFirstTimePredicted() then
			self:PlayChargeSound()
		end
		owner:SetAnimation(PLAYER_JUMP)
	else
		self:SetNextSecondaryFire(CurTime())
		self.m_ViewAngles = nil
		self.NextAllowJump = CurTime()
		self.NextAllowCharge = CurTime() + self.ChargeDelay
		self:SetNextPrimaryFire(CurTime() + self.ChargeRecovery)
		self:GetOwner():ResetJumpPower()
	end
end

function SWEP:PlayChargeSound()
	self:EmitSound("npc/ichthyosaur/attack_growl1.wav", 75, math.random(80, 85), nil, CHAN_AUTO)
end

function SWEP:PlayChargeStartSound()
	self:EmitSound("npc/fast_zombie/leap1.wav", 75, math.random(50, 60), nil, CHAN_AUTO)
end

function SWEP:StopCharge()
	if not self:IsCharging() then return end

	self:SetChargeStart(0)
	self:SetCharging(false)
	self:SetNextSecondaryFire(CurTime())
	self.m_ViewAngles = nil
	self.NextAllowJump = CurTime() + 0.25
	self.NextAllowCharge = CurTime() + self.ChargeDelay
	self:SetNextPrimaryFire(CurTime() + self.ChargeRecovery)
	self:GetOwner():ResetJumpPower()
	self.CriticalCharge = nil
end

function SWEP:Reload()
	BaseClass.SecondaryAttack(self)
end

function SWEP:OnRemove()
	self.Removing = true

	local owner = self:GetOwner()
	if owner and owner:IsValid() then
		owner:ResetJumpPower()
	end

	BaseClass.OnRemove(self)
end

function SWEP:Holster()
	local owner = self:GetOwner()
	if owner and owner:IsValid() then
		owner:ResetJumpPower()
	end

	BaseClass.Holster(self)
end

function SWEP:ResetJumpPower(power)
	if self.Removing then return end

	if self.NextAllowJump and CurTime() < self.NextAllowJump or self:IsCharging() or self:GetChargeStart() > 0 then
		return 1
	end
end

function SWEP:PlayAttackSound()
	self:EmitSound("npc/antlion_guard/angry"..math.random(3)..".wav", 75, math.random(65, 70))
end

function SWEP:PlayAlertSound()
	self:GetOwner():EmitSound("npc/combine_gunship/gunship_moan.wav", 75, math.random(80, 85))
end
SWEP.PlayIdleSound = SWEP.PlayAlertSound

function SWEP:SetChargeStart(time)
	self:SetDTFloat(1, time)
end

function SWEP:GetChargeStart()
	return self:GetDTFloat(1)
end

function SWEP:GetCharge()
	if self:GetChargeStart() == 0 then return 0 end

	return math.Clamp((CurTime() - self:GetChargeStart()) / self.ChargeAccel, 0, 1)
end

function SWEP:IsChargeCritical()
	if not self:IsCharging() then return false end

	return CurTime() >= self:GetChargeStart() + self.ChargeTime * 0.5
end

function SWEP:SetCharging(charging)
	self:SetDTBool(2, charging)
end

function SWEP:GetCharging()
	return self:GetDTBool(2)
end
SWEP.IsCharging = SWEP.GetCharging

if not CLIENT then return end

SWEP.ViewModelFOV = ZS.VMFOVScale * 48

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local mat = Material("models/onfire")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(mat)
end

