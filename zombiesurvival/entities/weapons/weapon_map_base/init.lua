INC_SERVER()

SWEP.Undroppable = true
SWEP.SourceDrop = true

function SWEP:OnDrop()
	local filterStart, filterEnd = string.find( game.GetMap():lower(), "ze_ffvii_mako_reactor" )
	if filterStart then
		local children = self:GetChildren()
		if #children > 0 then
			local phys = self:GetPhysicsObject()
			if IsValid( phys ) then
				phys:EnableMotion(false)
			end
			GAMEMODE:CenterNotifyAll(COLOR_GREEN, self:GetDTString(2) .. " has dropped "..GAMEMODE.MateriaButtonTranslations[children[#children-1].FixedKeyValues.parentname].."!")
			PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..self:GetDTString(2) .. " has dropped a ZE Weapon. ("..GAMEMODE.MateriaButtonTranslations[children[#children-1].FixedKeyValues.parentname]..")")
		end
		
		self:SetDTString(1, "")
		self:SetDTString(2, "Not Found")
	end
end