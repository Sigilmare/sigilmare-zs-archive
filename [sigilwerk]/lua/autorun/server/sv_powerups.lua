local math_random = math.random
local math_rand = math.Rand
local math_min = math.min

local colToHex = {
    [SIGILCOLOR_COMMON] = 0x969696,
    [SIGILCOLOR_UNCOMMON] = 0x85cf89,
    [SIGILCOLOR_RARE] = 0x6bc4ff,
    [SIGILCOLOR_EPIC] = 0xc26cd0,
    [SIGILCOLOR_LEGENDARY] = 0xffc500,
    [SIGILCOLOR_EXOTIC] = 0xff4739
}

local statuses = {
    "strengthdartboost",
    "healdartboost",
    "medrifledefboost",
    "renegade"
}

local statusesNames = {
    ["strengthdartboost"] = "Strength Boost",
    ["healdartboost"] = "Speed Boost",
    ["medrifledefboost"] = "Defence Boost",
    ["renegade"] = "Renegade Boost"
}

local gold = Color(212,175,55)
local function Msg(caller, col, nam, rarity, duration)
    if duration then
        PrintMessageColor({gold, "[Power-Ups] <avatar="..caller:SteamID().."> ", team.GetColor(caller:Team()), caller:Name(), color_white, " just received ", col, nam, color_white, " for ", col, duration.." ("..rarity..")"})

        Discord.Backend.API:Send(
            Discord.OOP:New('Message'):SetChannel('Relay'):SetEmbed({
                color = colToHex[col],
                title = "Power-Ups",
                description = caller:Name().." just received "..nam.." for "..duration.." ("..rarity..")"
            }):ToAPI()
        )
    else
        PrintMessageColor({gold, "[Power-Ups] <avatar="..caller:SteamID().."> ", team.GetColor(caller:Team()), caller:Name(), color_white, " just received ", col, nam.." ("..rarity..")"})

        Discord.Backend.API:Send(
            Discord.OOP:New('Message'):SetChannel('Relay'):SetEmbed({
                color = colToHex[col],
                title = "Power-Ups",
                description = caller:Name().." just received "..nam.." ("..rarity..")"
            }):ToAPI()
        )
    end
end

local function CommonBam()
    BroadcastLua([[LocalPlayer():EmitSound("sigilmare/special.wav", 0, 100, 1, CHAN_STATIC)]])
end
local function UncommonBam()
    BroadcastLua([[LocalPlayer():EmitSound("sigilmare/special.wav", 0, 105, 1, CHAN_STATIC)]])
end
local function RareBam()
    BroadcastLua([[LocalPlayer():EmitSound("sigilmare/special.wav", 0, 110, 1, CHAN_STATIC)]])
end
local function EpicBam()
    BroadcastLua([[LocalPlayer():EmitSound("sigilmare/special.wav", 0, 115, 1, CHAN_STATIC)]])
end
local function LegendaryBam()
    BroadcastLua([[LocalPlayer():EmitSound("sigilmare/special.wav", 0, 120, 1, CHAN_STATIC)]])
end
local function ExoticBam()
    BroadcastLua([[LocalPlayer():EmitSound("sigilmare/special.wav", 0, 125, 1, CHAN_STATIC)]])
end

function PowerUpsExotic(caller, silent)
    --[[if not silent then
        ExoticBam()
    end

    BroadcastLua("LocalPlayer():EmitSound(\"sigilmare/sfx/powerups/nuke_pickup.wav\", 0)")
    timer.Simple(2, function() BroadcastLua("LocalPlayer():EmitSound(\"sigilmare/vo/announcer/kaboom"..math_random(2)..".wav\", 0)") end)
    BroadcastLua("LocalPlayer():ScreenFade(SCREENFADE.IN, Color(255, 255, 255, 255), 1.2, 0.2)")
    ParticleEffect("dusty_explosion_rockets", caller and caller:GetPos() or Vector(0, 0, 0), angle_zero)

    local players = team.GetPlayers(TEAM_ZOMBIE)
    for i=1, #players do
        timer.Simple(i*math_rand(0.45, 0.5), function()
            if not players[i] then return end
            if not players[i]:IsValid() then return end

            if players[i]:Alive() then
                players[i]:EmitSound("sigilmare/sfx/powerups/nuke_die.wav")
                players[i]:TakeDamage(math_min(players[i]:Health()*2, 9999), caller and caller or game.GetWorld())
                if players[i]:Alive() then
                    players[i]:Kill()
                end
            end
        end)
    end

    Msg(caller, SIGILCOLOR_EXOTIC, "KA-BOOM!", "Exotic")]]

    if not silent then
        BroadcastLua([[URLSound("https://cdn.discordapp.com/attachments/1085523339608604756/1139093347873607710/deathmachine.wav")]])
    end

    timer.Simple(2, function()
        if caller and caller:IsValid() and not caller:HasWeapon("weapon_zs_deathmachine") then
            caller:Give("weapon_zs_deathmachine")
        end
    end)
    timer.Simple(30, function()
        if caller and caller:IsValid() and caller:HasWeapon("weapon_zs_deathmachine") then
            caller:StripWeapon("weapon_zs_deathmachine")
        end
    end)

    Msg(caller, SIGILCOLOR_EXOTIC, "Death Machine", "Exotic", "30 seconds")
end

function PowerUpsLegendary(caller, silent)
    if not silent then
        LegendaryBam()
    end

    local pick = statuses[math.random(#statuses)]
    caller:GiveStatus(pick, 120)
    caller:CenterNotify(gold, {killicon = "weapon_zs_trinket"}, " Power-Ups ", COLOR_GREEN, "buffed you with "..statusesNames[pick].." for 120 seconds")

    Msg(caller, SIGILCOLOR_LEGENDARY, statusesNames[pick], "Legendary", "120 seconds")
end

function PowerUpsEpic(caller, silent)
    if not silent then
        EpicBam()
    end

    local pick = statuses[math.random(#statuses)]
    caller:GiveStatus(pick, 90)
    caller:CenterNotify(gold, {killicon = "weapon_zs_trinket"}, " Power-Ups ", COLOR_GREEN, "buffed you with "..statusesNames[pick].." for 90 seconds")

    Msg(caller, SIGILCOLOR_EPIC, statusesNames[pick], "Epic", "90 seconds")
end

function PowerUpsRare(caller, silent)
    if not silent then
        RareBam()
    end

    local pick = statuses[math.random(#statuses)]
    caller:GiveStatus(pick, 60)
    caller:CenterNotify(gold, {killicon = "weapon_zs_trinket"}, " Power-Ups ", COLOR_GREEN, "buffed you with "..statusesNames[pick].." for 60 seconds")

    Msg(caller, SIGILCOLOR_RARE, statusesNames[pick], "Rare", "60 seconds")
end

function PowerUpsUncommon(caller, silent)
    if not silent then
        UncommonBam()
    end

    local pick = statuses[math.random(#statuses)]
    caller:GiveStatus(pick, 30)
    caller:CenterNotify(gold, {killicon = "weapon_zs_trinket"}, " Power-Ups ", COLOR_GREEN, "buffed you with "..statusesNames[pick].." for 30 seconds")

    Msg(caller, SIGILCOLOR_UNCOMMON, statusesNames[pick], "Uncommon", "30 seconds")
end

function PowerUpsCommon(caller, silent)
    if not silent then
        CommonBam()
    end

    local pick = caller:GetResupplyAmmoType()
    local ammoAmount = GAMEMODE.AmmoCache[pick] * GAMEMODE:GetWave()

    caller:GiveAmmo(ammoAmount, pick, true)

    caller:CenterNotify(gold, {killicon = GAMEMODE.AmmoIcons[pick]}, " Power-Ups ", COLOR_GREEN, "gave you "..ammoAmount.." "..GAMEMODE.AmmoNames[pick])

    Msg(caller, SIGILCOLOR_COMMON, ammoAmount.." "..GAMEMODE.AmmoNames[pick], "Common")
end

--[[ook.Add("PostHumanKilledZombie", "PowerUpsHKZ", function(pl, attacker, inflictor, dmginfo, assistpl, assistamount, headshot)
    if attacker.RisenAsHero then return end

    if math_random(3200) == 1 then
        PowerUpsExotic(attacker)

    elseif math_random(1600) == 1 then
        PowerUpsLegendary(attacker)

    elseif math_random(800) == 1 then
        PowerUpsEpic(attacker)

    elseif math_random(400) == 1 then
        PowerUpsRare(attacker)

    elseif math_random(200) == 1 then
        PowerUpsUncommon(attacker)

    elseif math_random(100) == 1 then
        PowerUpsCommon(attacker)

    end
end)]]