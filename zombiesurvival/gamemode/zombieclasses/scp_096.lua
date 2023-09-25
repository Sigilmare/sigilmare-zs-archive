CLASS.Hidden = true
CLASS.Disabled = true
CLASS.Unlocked = true

CLASS.SCP = true

CLASS.KnockbackScale = 0

CLASS.Name = "SCP-096"
CLASS.TranslationName = "SCP-096"

CLASS.Model = Model("models/cpthazama/scp/096.mdl")

CLASS.Health = 100000
CLASS.Speed = 47.85
CLASS.SWEP = "weapon_zs_scp096"

CLASS.NoFallDamage = true

CLASS.Points = 0

local math_min = math.min

local ACT_IDLE = ACT_IDLE
local ACT_WALK = ACT_WALK
local ACT_IDLE_RELAXED = ACT_IDLE_RELAXED
local ACT_RUN = ACT_RUN

function CLASS:Move(pl, move)
	local wep = pl:GetActiveWeapon()
	if not wep.GetWalkState or not wep.GetIdleState then return end

	if wep and wep:IsValid() then
		if wep:GetIdleState() == "IdleSit" or wep:GetIdleState() == "Raging" then
			move:SetMaxSpeed(1)
			move:SetMaxClientSpeed(1)
			return
		end

		if wep:GetWalkState() == "Walk" then
			move:SetMaxSpeed(47.85)
			move:SetMaxClientSpeed(47.85)
		elseif wep:GetWalkState() == "Run" then
			move:SetMaxSpeed(700)
			move:SetMaxClientSpeed(700)
		else
			move:SetMaxSpeed(47.85)
			move:SetMaxClientSpeed(47.85)
		end
	end
end

function CLASS:CalcMainActivity(pl, velocity)
	local wep = pl:GetActiveWeapon()
	if not wep.GetWalkState or not wep.GetIdleState then return end

	if wep and wep:IsValid() then
		if velocity:Length2DSqr() <= 1 then
			if wep:GetIdleState() == "IdleSit" then
				return ACT_IDLE_RELAXED, -1
			elseif wep:GetIdleState() == "Idle" then
				return ACT_IDLE, -1
			elseif wep:GetIdleState() == "Raging" or wep:GetIdleState() == "Rage" then
				return 1, pl:LookupSequence("aggro")
			else
				return ACT_IDLE, -1
			end
		end

		if wep:GetWalkState() == "Run" then
			return ACT_RUN, -1
		elseif wep:GetWalkState() == "Walk" then
			return ACT_WALK, -1
		else
			return ACT_WALK, -1
		end
	end
end

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	return true
end

function CLASS:DoAnimationEvent(pl, event, data)
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MELEE_ATTACK1, true)
		return ACT_INVALID
	end
end

function CLASS:UpdateAnimation(pl, velocity, maxseqgroundspeed)
	local len2d = velocity:Length2D()
	if len2d > 1 then
		pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed, 1))
	else
		pl:SetPlaybackRate(1)
	end

	return true
end

function CLASS:OnSpawned(pl)
	pl.Select096Spawn = true
	pl.SCP096State = "IdleSit"
end