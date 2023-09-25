local include = include
local CurTime = CurTime
local ParticleEmitter = ParticleEmitter
local math_random = math.random
local Vector = Vector
local math_Rand = math.Rand

include("shared.lua")

ENT.NextGas = 0
ENT.NextSound = 0

function ENT:Think()
	if GAMEMODE.ZombieEscape then return end
end

function ENT:Draw()
	if GAMEMODE.ZombieEscape or CurTime() < self.NextGas then return end

	local pos = self:GetPos()

	local emitter = ParticleEmitter(pos)
	
	for i=1, 2 do
		local particle = emitter:Add("noxctf/sprite_bloodspray"..math_random(8), pos)
		particle:SetVelocity(Vector( math_Rand( -500, 500 ), math_Rand( -500, 500 ),  math_Rand( -500, 500 ) ))
		particle:SetDieTime(0.5)
		particle:SetStartAlpha(255)  
		particle:SetEndAlpha(0)
		particle:SetStartSize(1000)
		particle:SetEndSize(1000)
		particle:SetRollDelta(math_Rand(-32, 32))
		particle:SetColor(math_random(70, 120), math_random(20, 70), math_random(150, 200))
	end

	local particle = emitter:Add("noxctf/sprite_bloodspray"..math_random(8), pos)
	particle:SetVelocity(Vector( math_Rand( -1500, 1500 ), math_Rand( -1500, 1500 ),  math_Rand( -1500, 1500 ) ))
	particle:SetDieTime(1)
	particle:SetStartAlpha(200)  
	particle:SetEndAlpha(0)
	particle:SetStartSize(1000)
	particle:SetEndSize(1000)
	particle:SetRollDelta(math_Rand(-32, 32))
	particle:SetColor(0, 0, 0)

	emitter:Finish()
end
