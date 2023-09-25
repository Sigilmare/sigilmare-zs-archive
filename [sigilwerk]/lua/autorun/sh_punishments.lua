local meta = FindMetaTable("Player")

function meta:SetChatMuted(val)
    self:SetNWBool("Punishment.ChatMuted", val)
    PunishmentSaveVault(self)
end

function meta:IsChatMuted()
    return self:GetNWBool("Punishment.ChatMuted") == true
end

function meta:SetVoiceMuted(val)
    self:SetNWBool("Punishment.VoiceMuted", val)
    PunishmentSaveVault(self)
end

function meta:IsVoiceMuted()
    return self:GetNWBool("Punishment.VoiceMuted") == true
end

function meta:SetAegisBanned(val)
    self:SetNWBool("Punishment.AegisBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsAegisBanned()
    return self:GetNWBool("Punishment.AegisBanned") == true
end

function meta:SetHammerBanned(val)
    self:SetNWBool("Punishment.HammerBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsHammerBanned()
    return self:GetNWBool("Punishment.HammerBanned") == true
end

function meta:SetNestBanned(val)
    self:SetNWBool("Punishment.NestBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsNestBanned()
    return self:GetNWBool("Punishment.NestBanned") == true
end

function meta:SetPickupBanned(val)
    self:SetNWBool("Punishment.PickupBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsPickupBanned()
    return self:GetNWBool("Punishment.PickupBanned") == true
end

function meta:SetSprayBanned(val)
    self:SetNWBool("Punishment.SprayBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsSprayBanned()
    return self:GetNWBool("Punishment.SprayBanned") == true
end

function meta:SetZombieBanned(val)
    self:SetNWBool("Punishment.ZombieBanned", val)
    PunishmentSaveVault(self)
end

function meta:IsZombieBanned()
    return self:GetNWBool("Punishment.ZombieBanned") == true
end

function meta:GetPunishments()
    return (self:IsChatMuted() and 1 or 0) + (self:IsVoiceMuted() and 1 or 0) + (self:IsAegisBanned() and 1 or 0) + (self:IsHammerBanned() and 1 or 0) + (self:IsNestBanned() and 1 or 0) + (self:IsPickupBanned() and 1 or 0) + (self:IsSprayBanned() and 1 or 0) + (self:IsZombieBanned() and 1 or 0)
end