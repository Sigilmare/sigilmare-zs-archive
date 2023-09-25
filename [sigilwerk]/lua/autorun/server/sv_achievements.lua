local table_HasValue = table.HasValue
local pairs = pairs
local ipairs = ipairs
local player_GetHumans = player.GetHumans
local team_GetColor = team.GetColor
local table_insert = table.insert

hook.Add("AfterStatsLoaded", "ACH:LoadAchievements", function(pl)
    pl.AchievedAlready = {}

    for id, item in pairs(ACH.Achievements) do
        if pl and pl:IsValid() and pl:GetNWInt(item.NWInt) >= item.Goal then
            table.insert(pl.AchievedAlready, id, id)
        end
    end
end)

hook.Add("Think", "ACH:Handler", function(pl)
    if GAMEMODE.ZombieEscape or GAMEMODE.ObjectiveMap then return end
    
    for _, hply in ipairs(player_GetHumans()) do
        for id, item in ipairs(ACH.Achievements) do
            if hply.AchievedAlready and hply:GetNWInt(item.NWInt) >= item.Goal and not table_HasValue(hply.AchievedAlready, id) then
                hply:CenterNotify(Color(0, 150, 0), "(Achievements) ", color_white, "You achieved ", SIGILCOLOR_YELLOW, item.Name, color_white, " for ", SIGILCOLOR_AETHER, item.Aether.." Aether", color_white, " and ", SIGILCOLOR_ZSXP, (item.XP or "?").." XP", SIGILCOLOR_YELLOW, " ("..item.Description..")")
                PrintMessageColor({Color(0, 150, 0), "[Achievements] <avatar="..hply:SteamID().."> ", team_GetColor(hply:Team()), hply:Name(), color_white, " achieved ", SIGILCOLOR_YELLOW, item.Name, color_white, " for ", SIGILCOLOR_AETHER, item.Aether.." Aether", color_white, " and ", SIGILCOLOR_ZSXP, (item.XP or "?").." XP", SIGILCOLOR_YELLOW, " ("..item.Description..")"})

                Discord.Backend.API:Send(
                    Discord.OOP:New('Message'):SetChannel('Achievements'):SetEmbed({
                        color = 0x009600,
                        title = "Achievements",
                        description = hply:Name().." achieved **"..item.Name.."** for `"..item.Aether.." Aether` and `"..item.XP.." XP` ("..item.Description..")"
                    }):ToAPI()
                )

                hply:AddAether(item.Aether)
                GAMEMODE:SaveVault(hply)
                StatsSaveVault(hply)

                table_insert(hply.AchievedAlready, id, id)
                BroadcastLua([[MySelf:EmitSound("sigilmare/achievement.ogg", 0, 100, 1, CHAN_STATIC)]])
            end
        end
    end
end)