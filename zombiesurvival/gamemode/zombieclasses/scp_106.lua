CLASS.Hidden = true
CLASS.Disabled = true
CLASS.Unlocked = true

CLASS.SCP = true

CLASS.Name = "SCP-106"
CLASS.TranslationName = "SCP-106"

CLASS.Model = Model("models/cpthazama/scp/106.mdl")

CLASS.Health = 100000
CLASS.Speed = 100
CLASS.SWEP = "weapon_zs_scp106"

CLASS.NoFallDamage = true

CLASS.Ambience = "scp106amb"

CLASS.Points = 0

CLASS.BloodColor = -1

local math_random = math.random
local math_min = math.min
local util_Decal = util.Decal
local Vector = Vector
local util_TraceLine = util.TraceLine
local MASK_NPCWORLDSTATIC = MASK_NPCWORLDSTATIC

local ACT_IDLE = ACT_IDLE
local ACT_WALK = ACT_WALK
local STEPSOUNDTIME_NORMAL = STEPSOUNDTIME_NORMAL
local STEPSOUNDTIME_WATER_FOOT = STEPSOUNDTIME_WATER_FOOT
local STEPSOUNDTIME_ON_LADDER = STEPSOUNDTIME_ON_LADDER
local STEPSOUNDTIME_WATER_KNEE = STEPSOUNDTIME_WATER_KNEE

function CLASS:CalcMainActivity(pl, velocity)
	if velocity:Length2DSqr() <= 1 then
		return ACT_IDLE, -1
	end

	return ACT_WALK_STIMULATED, -1
end

function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	pl:EmitSound("sigilmare/scp/106/step"..math_random(3)..".wav", 80)
	if iFoot == 0 then
		local tr = util_TraceLine({
			start = pl:GetBonePosition(11),
			endpos = pl:GetBonePosition(11) -Vector(0,0,10),
			filter = pl,
			mask = MASK_NPCWORLDSTATIC
		})
		if tr.HitWorld then
			util_Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		end
	else
		local tr = util_TraceLine({
			start = pl:GetBonePosition(7),
			endpos = pl:GetBonePosition(7) -Vector(0,0,10),
			filter = pl,
			mask = MASK_NPCWORLDSTATIC
		})
		if tr.HitWorld then
			util_Decal("Scorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
		end
	end

	return true
end

function CLASS:PlayerStepSoundTime(pl, iType, bWalking)
	if iType == STEPSOUNDTIME_NORMAL or iType == STEPSOUNDTIME_WATER_FOOT then
		return 750
	elseif iType == STEPSOUNDTIME_ON_LADDER then
		return 750
	elseif iType == STEPSOUNDTIME_WATER_KNEE then
		return 750
	end

	return 750
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
		pl:SetPlaybackRate(math_min(len2d / maxseqgroundspeed * 1.65, 1.65))
	else
		pl:SetPlaybackRate(1)
	end

	return true
end

function CLASS:OnSpawned(pl)
	pl:DoAnimationEvent(ACT_JUMP)
	timer.Create("SCP106Spawn", 0.05, 69, function()
		pl:DoAnimationEvent(ACT_JUMP)
	end)
	if SERVER then
		pl:CreateAmbience("scp106amb")
		timer.Create("SCP106Theme", 11, 1, function()
			if pl and pl:IsValid() and pl:Team() == TEAM_ZOMBIE and pl:Alive() and pl:GetZombieClassTable().Name  == "SCP-106" then
				BroadcastLua([[surface.PlaySound("sigilmare/scp/106/theme.wav")]])
			end
		end)
		BroadcastLua([[surface.PlaySound("sigilmare/scp/106/spawn.wav")]])
	end
end