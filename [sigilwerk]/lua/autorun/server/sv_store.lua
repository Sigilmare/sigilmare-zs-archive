util.AddNetworkString("Store.BuyEXPCase")

local meta = FindMetaTable("Player")
local VaultFolder = "[Store]"

function StoreShouldSaveVault(pl)
	-- Always push accumulated points in to the vault if we have any.
	if pl:IsBot() or GAMEMODE.ZombieEscape then return false end

	if pl:GetNWInt("Aether") > 0 then
		return true
	end

	return false
end

function StoreShouldLoadVault(pl)
	return not pl:IsBot()
end

function StoreGetVaultFile(pl)
	local steamid = pl:SteamID64() or "invalid"

	return VaultFolder.."/"..steamid:sub(-2).."/"..steamid..".txt"
end

function StoreSaveAllVaults()
	for _, pl in pairs(player.GetAll()) do
		StoreSaveVault(pl)
	end
end

function StoreLoadVault(pl)
	if not StoreShouldLoadVault(pl) then return end

	local filename = StoreGetVaultFile(pl)
	if file.Exists(filename, "DATA") then
		local contents = file.Read(filename, "DATA")
		if contents and #contents > 0 then
			contents = Deserialize(contents)
			if contents then
				pl:SetNWInt("Aether", contents.Aether)
			end
		end
	end
end

function StoreSaveVault(pl)
	if not StoreShouldSaveVault(pl) then return end

	local tosave = {
		Aether = pl:GetNWInt("Sigilmare.Aether"),
	}

	local filename = StoreGetVaultFile(pl)
	file.CreateDir(string.GetPathFromFilename(filename))
	file.Write(filename, Serialize(tosave))
end

hook.Add("PostEndRound", "Store.Setup1", function(winner)
    StoreSaveAllVaults()
end)

hook.Add("PlayerInitialSpawnRound", "Store.Setup3", function(pl)
    StoreLoadVault(pl)

	hook.Call("AfterStoreLoaded", nil, pl)
end)

hook.Add("PlayerDisconnected", "Store.Setup4", function(pl)
    StoreSaveVault(pl)
end)

hook.Add("ShutDown", "Store.Setup5", function()
    StoreSaveAllVaults()
end)

function meta:AddAether(amount)
	self:SetNWInt("Aether", self:GetNWInt("Aether") + amount)
end

net.Receive("Store.BuyEXPCase", function()
    local pl = net.ReadEntity()
    local price = 150
    local chance = math.random(200)

	if pl:GetNWInt("Aether") < price then return end

    if chance <= 100 then
        local subchance = math.random(2)
        if subchance == 1 then
            pl:AddZSXP(30)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_COMMON_C..pl:Name().." just received 30 XP (Common) from an Experience Case!</c>")
        elseif subchance == 2 then
            pl:AddAether(30)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_COMMON_C..pl:Name().." just received 30 Aether (Common) from an Experience Case!</c>")
        end
		GAMEMODE:SaveVault(pl)
		pl:EmitSound("sigilmare/special.wav", 80, 100, 1, CHAN_STATIC)

    elseif chance > 100 and chance <= 168 then
        local subchance = math.random(2)
        if subchance == 1 then
            pl:AddZSXP(70)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_UNCOMMON_C..pl:Name().." just received 70 XP (Uncommon) from an Experience Case!</c>")
        elseif subchance == 2 then
            pl:AddAether(70)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_UNCOMMON_C..pl:Name().." just received 70 Aether (Uncommon) from an Experience Case!</c>")
        end
		GAMEMODE:SaveVault(pl)
		pl:EmitSound("sigilmare/special.wav", 80, 110, 1, CHAN_STATIC)

    elseif chance > 168 and chance <= 192 then
        local subchance = math.random(2)
        if subchance == 1 then
            pl:AddZSXP(240)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_RARE_C..pl:Name().." just received 240 XP (Rare) from an Experience Case!</c>")
        elseif subchance == 2 then
            pl:AddAether(240)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_RARE_C..pl:Name().." just received 240 Aether (Rare) from an Experience Case!</c>")
        end
		GAMEMODE:SaveVault(pl)
		pl:EmitSound("sigilmare/special.wav", 80, 120, 1, CHAN_STATIC)

    elseif chance > 192 and chance <= 197 then
        local subchance = math.random(2)
        if subchance == 1 then
            pl:AddZSXP(1200)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_EPIC_C..pl:Name().." just received 1,200 XP (Epic) from an Experience Case!</c>")
        elseif subchance == 2 then
            pl:AddAether(1200)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_EPIC_C..pl:Name().." just received 1,200 Aether (Epic) from an Experience Case!</c>")
        end
		GAMEMODE:SaveVault(pl)
		pl:EmitSound("sigilmare/special.wav", 80, 130, 1, CHAN_STATIC)

    elseif chance > 197 and chance <= 199 then
        local subchance = math.random(2)
        if subchance == 1 then
            pl:AddZSXP(2500)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_LEGENDARY_C..pl:Name().." just received 2,500 XP (Legendary) from an Experience Case!</c>")
        elseif subchance == 2 then
            pl:AddAether(2500)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_LEGENDARY_C..pl:Name().." just received 2,500 Aether (Legendary) from an Experience Case!</c>")
        end
		GAMEMODE:SaveVault(pl)
		pl:EmitSound("sigilmare/special.wav", 80, 140, 1, CHAN_STATIC)

    elseif chance == 200 then
        local subchance = math.random(2)
        if subchance == 1 then
            pl:AddZSXP(6000)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_EXOTIC_C..pl:Name().." just received 6,000 XP (Exotic) from an Experience Case!</c>")
        elseif subchance == 2 then
            pl:AddAether(6000)
            PrintMessage(HUD_PRINTTALK, NZSCOLOR_EXOTIC_C..pl:Name().." just received 6,000 Aether (Exotic) from an Experience Case!</c>")
        end
		GAMEMODE:SaveVault(pl)
		pl:EmitSound("sigilmare/special.wav", 80, 150, 1, CHAN_STATIC)
    end

    pl:AddAether(-price)
end)