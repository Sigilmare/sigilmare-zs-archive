INC_CLIENT()

function ENT:OnInitialize()
	local owner = self:GetOwner()
	if owner ~= MySelf then return end

	self.AmbientSound = CreateSound(self, "player/breathe1.wav")
	self.AmbientSound:Play()
	self.AmbientSound2 = CreateSound(self, "player/heartbeat1.wav")
	self.AmbientSound2:Play()
end

function ENT:OnRemove()
	local owner = self:GetOwner()
	if owner == MySelf then
		self.AmbientSound:Stop()
		self.AmbientSound2:Stop()
	end

	self.BaseClass.OnRemove(self)
end
