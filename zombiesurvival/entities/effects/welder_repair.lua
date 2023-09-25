function EFFECT:Init(data)
	local pos = data:GetOrigin()
	local norm = data:GetNormal()
	local magnitude = data:GetMagnitude()

	local emitter = ParticleEmitter(pos)

	for i=1, math.random(16, 24) do
		local particle = emitter:Add("sprites/glow04_noz", pos)
		particle:SetVelocity((norm + VectorRand()):GetNormalized() * math.Rand(8, 24))
		particle:SetColor(100, 170, 215)
		particle:SetEndSize(math.Rand(2, 3) * math.max(magnitude, 0.1))
		particle:SetDieTime(math.Rand(0.2, 0.5))
		particle:SetStartSize(0)
		particle:SetStartAlpha(255)
		particle:SetEndAlpha(0)
		particle:SetRoll(math.Rand(0, 360))
		particle:SetRollDelta(math.Rand(-8, 8))
	end

	emitter:Finish() emitter = nil collectgarbage("step", 64)
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
