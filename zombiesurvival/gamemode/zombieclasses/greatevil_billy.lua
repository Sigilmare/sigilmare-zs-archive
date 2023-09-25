CLASS.Hidden = true
CLASS.Disabled = true
CLASS.Unlocked = true

CLASS.Name = "Billy"
CLASS.TranslationName = "Billy"

CLASS.KnockbackScale = 0

CLASS.Health = 45000
CLASS.Speed = 85

CLASS.CanTaunt = true

CLASS.FearPerInstance = 1

CLASS.Points = 0

CLASS.SWEP = "weapon_zs_billyz"

CLASS.Model = Model("models/beef/beef_god/psycedelicum/beef_boy_pm.mdl")

local math_random = math.random
local math_min = math.min
local CurTime = CurTime

local ACT_HL2MP_SWIM_MELEE = ACT_HL2MP_SWIM_MELEE
local ACT_HL2MP_IDLE_CROUCH_MELEE = ACT_HL2MP_IDLE_CROUCH_MELEE
local ACT_HL2MP_WALK_CROUCH_MELEE = ACT_HL2MP_WALK_CROUCH_MELEE
local ACT_HL2MP_IDLE_MELEE = ACT_HL2MP_IDLE_MELEE
local ACT_HL2MP_RUN_ZOMBIE = ACT_HL2MP_RUN_ZOMBIE
local ACT_HL2MP_RUN_MELEE = ACT_HL2MP_RUN_MELEE

function CLASS:Move(pl, move)
	if pl:KeyDown(IN_SPEED) then
		move:SetMaxSpeed(250)
		move:SetMaxClientSpeed(250)
	end
end

function CLASS:PlayPainSound(pl)
	--pl:EmitSound("sigilmare/sfx/nunmassacre/scream"..math.random(9)..".wav", 80, 120)
	pl.NextPainSound = CurTime() + 0.5

	return true
end

function CLASS:PlayDeathSound(pl)
	pl:EmitSound("sigilmare/sfx/nunmassacre/scream9.wav", 80, 80)

	return true
end

local StepLeftSounds = {
	"npc/fast_zombie/foot1.wav",
	"npc/fast_zombie/foot2.wav"
}
local StepRightSounds = {
	"npc/fast_zombie/foot3.wav",
	"npc/fast_zombie/foot4.wav"
}
function CLASS:PlayerFootstep(pl, vFootPos, iFoot, strSoundName, fVolume, pFilter)
	if iFoot == 0 then
		pl:EmitSound(StepLeftSounds[math_random(#StepLeftSounds)], 70)
	else
		pl:EmitSound(StepRightSounds[math_random(#StepRightSounds)], 70)
	end

	return true
end

if not CLIENT then return end

CLASS.Icon = "zombiesurvival/killicons/butcher"