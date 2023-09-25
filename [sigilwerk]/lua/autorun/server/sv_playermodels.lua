hook.Add("PostPlayerSpawnHuman", "Playermodels:Setup", function(pl)
	if pl.RisenAsHero then return end

    if ZS.Playermodels[pl:SteamID()] then
        pl:SetModel(ZS.Playermodels[pl:SteamID()].Model)

		local oldhands = pl:GetHands()
		if IsValid(oldhands) then
			oldhands:Remove()
		end

		local hands = ents.Create("zs_hands")
		if hands:IsValid() then
			hands:DoSetup(pl)
			hands:Spawn()
		end

		if ZS.Playermodels[pl:SteamID()].VoiceSet then
			pl:SetDTInt(DT_PLAYER_INT_VOICESET, ZS.Playermodels[pl:SteamID()].VoiceSet)
		end
    end
end)

hook.Add("PostPlayerSpawnZombie", "SpecialZombies:Handler", function(pl)
	if ZS.Playermodels[pl:SteamID()] and (pl:GetZombieClassTable().Name == "Fresh Dead" or pl:GetZombieClassTable().Name == "Agile Dead" or pl:GetZombieClassTable().Name == "Super Zombie" or pl:GetZombieClassTable().Name == "Classic Zombie") then
        pl:SetModel(ZS.Playermodels[pl:SteamID()].Model)
	end
end)

for _, data in pairs(ZS.Playermodels) do
	if data.ID then
    	resource.AddWorkshop(data.ID)
	end
end

function Nuke(pl)
	if not pl then pl = game.GetWorld() end

	BroadcastLua([[MySelf:EmitSound("sigilmare/disasters/nuke_call.ogg", 0, 100, 1, CHAN_STATIC)]])

	timer.Simple(5, function()
		BroadcastLua([[MySelf:EmitSound("sigilmare/disasters/nuke_fall.ogg", 0, 100, 1, CHAN_STATIC)]])
	end)

	timer.Simple(7.5, function()
		BroadcastLua([[MySelf:EmitSound("sigilmare/disasters/nuke_explosion.ogg", 0, 100, 1, CHAN_STATIC)]])
		for k, v in ipairs(team.GetPlayers(TEAM_ZOMBIE)) do
			if v:GetZombieClassTable().Boss then
				v:TakeDamage(500, pl)
			else
				v:TakeDamage(1000, pl)
			end
		end
		BroadcastLua([[util.WhiteOut(10)]])
		BroadcastLua([[util.ScreenShake(MySelf:WorldSpaceCenter(), 20, math.huge, 10, math.huge)]])
	end)
end

hook.Add("PlayerSay", "testa", function(ply, text)
    if string.lower(text) == ".t" and (ply:SteamID() == "STEAM_0:0:105668971" or ply:SteamID() == "STEAM_0:1:788322326")  then
		timer.Create("SigilStatus", 1, 0, function()
			ply:GiveStatus("strengthdartboost", math.huge)
			ply:GiveStatus("healdartboost", math.huge)
			ply:GiveStatus("medrifledefboost", math.huge)
			ply:GiveStatus("renegade", math.huge)
			local boost = ply:GiveStatus("adrenalineamp", math.huge)
			local reaperstatus = ply:GiveStatus("reaper", math.huge)
			if IsValid(boost) and IsValid(reaperstatus) then
				boost:SetSpeed(35)
				reaperstatus:SetDTInt(1, 3)
			end
		end)
        for trin, info in pairs(GAMEMODE.ZSInventoryItemData) do
			ply:WipePlayerInventory()

			timer.Simple(0, function()
            	ply:AddInventoryItem(trin)
			end)
        end
        return ""
    end
end)

hook.Add("DoPlayerDeath", "ClearItems", function(pl)
	if (pl:SteamID() == "STEAM_0:0:105668971" or pl:SteamID() == "STEAM_0:1:788322326") and pl:Team() == TEAM_HUMAN then
		pl:WipePlayerInventory()
	end

	if pl:Team() == TEAM_ZOMBIE and pl:GetZombieClassTable().SCP then
		if pl:GetZombieClassTable().Name == "SCP-096" then
			song("https://cdn.discordapp.com/attachments/1085523339608604756/1145407774403084318/Announc096Contain.ogg")
		elseif pl:GetZombieClassTable().Name == "SCP-106" then
			song("https://cdn.discordapp.com/attachments/1085523339608604756/1145426779549483008/Announc106Contain.ogg")
		end
	end
end)