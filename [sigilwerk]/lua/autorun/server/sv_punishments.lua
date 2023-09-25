local meta = FindMetaTable("Player")
local VaultFolder = "[punishments]"

function PunishmentShouldSaveVault(pl)
	return not pl:IsBot()
end

function PunishmentShouldLoadVault(pl)
	return not pl:IsBot()
end

function PunishmentGetVaultFile(pl)
	local steamid = pl:SteamID64() or "invalid"

	return VaultFolder.."/"..steamid:sub(-2).."/"..steamid..".txt"
end

function PunishmentLoadVault(pl)
	if not PunishmentShouldLoadVault(pl) then return end

	local filename = PunishmentGetVaultFile(pl)
	if file.Exists(filename, "DATA") then
		local contents = file.Read(filename, "DATA")
		if contents and #contents > 0 then
			contents = Deserialize(contents)
			if contents then
				pl:SetNWBool("Punishment.ChatMuted", contents.Punishment_ChatMuted)
				pl:SetNWBool("Punishment.VoiceMuted", contents.Punishment_VoiceMuted)
				pl:SetNWBool("Punishment.AegisBanned", contents.Punishment_AegisBanned)
				pl:SetNWBool("Punishment.HammerBanned", contents.Punishment_HammerBanned)
				pl:SetNWBool("Punishment.NestBanned", contents.Punishment_NestBanned)
				pl:SetNWBool("Punishment.PickupBanned", contents.Punishment_PickupBanned)
				pl:SetNWBool("Punishment.ZombieBanned", contents.Punishment_ZombieBanned)
			end
		end
	end
end

function PunishmentSaveVault(pl)
	if not PunishmentShouldSaveVault(pl) then return end

	local tosave = {
        Punishment_ChatMuted = pl:GetNWBool("Punishment.ChatMuted"),
        Punishment_VoiceMuted = pl:GetNWBool("Punishment.VoiceMuted"),
        Punishment_AegisBanned = pl:GetNWBool("Punishment.AegisBanned"),
        Punishment_HammerBanned = pl:GetNWBool("Punishment.HammerBanned"),
		Punishment_NestBanned = pl:GetNWBool("Punishment.NestBanned"),
		Punishment_PickupBanned = pl:GetNWBool("Punishment.PickupBanned"),
		Punishment_ZombieBanned = pl:GetNWBool("Punishment.ZombieBanned")
	}

	local filename = PunishmentGetVaultFile(pl)
	file.CreateDir(string.GetPathFromFilename(filename))
	file.Write(filename, Serialize(tosave))
end

hook.Add("PlayerInitialSpawnRound", "Punishment:Setup2", function(pl)
    PunishmentLoadVault(pl)
end)

------------------------
-- Punishment Handles --
------------------------

hook.Add( "PlayerSpray", "DisablePlayerSpray", function( ply )
	if ply:IsSprayBanned() then
		ply:CenterNotify(COLOR_RED, "You are spray banned.")
		return true
	else
		PrintMessageColor({SIGILCOLOR_RED, "[Sprays] <avatar="..ply:SteamID().."> ", team.GetColor(ply:Team()), ply:Name(), color_white, " sprayed a decal at ", SIGILCOLOR_CYAN, math.floor(ply:GetPos().x).." "..math.floor(ply:GetPos().y).." "..math.floor(ply:GetPos().z)})
		return false
	end
end )

hook.Add("DisallowHumanPickup", "Punishment:Pickup", function(pl, ent)
	return pl:IsPickupBanned()
end)

hook.Add("PlayerSay", "Punishment:ChatMute", function(ply, text)
	if GAMEMODE.LockDownChat then
		ply:SendLua([[chat.AddText(COLOR_RED, "You cannot converse during a chat lockdown.")]])
		return ""
	end

    if ply:IsChatMuted() then
        ply:CenterNotify(COLOR_RED, "You are chat muted!")
        return ""
    end
end)

hook.Add("PlayerCanHearPlayersVoice", "Punishment:VoiceMute", function(listener, talker)
    return not talker:IsVoiceMuted()
end)

hook.Add("PostPlayerSpawnZombie", "Punsihment:ZombieBanned", function(pl)
	if pl:IsZombieBanned() and GAMEMODE:GetWave() < 3 then
		if pl:GetZombieClassTable().Name == "Crow" then return end
		timer.Simple(0, function()
			pl:Kill()
			pl:CenterNotify(COLOR_RED, "You are zombie banned and cannot play until wave 3.")
		end)
	end
end)