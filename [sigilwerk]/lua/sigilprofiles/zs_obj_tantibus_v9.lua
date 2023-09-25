hook.Add("PostPlayerSpawnHuman", "MapProfile1", function(pl)
    pl:StripWeapons()
    pl:StripAmmo()
    if pl:IsBot() then return end
    pl:Give("weapon_zs_medicalkit_a5")
    pl:Give("weapon_zs_zeknife")
    pl:GiveAmmo(9999, "battery")
    pl:GiveAmmo(5000, "buckshot")
    pl:AddInventoryItem("trinket_featherfallframe")
end)

hook.Add("InitPostEntityMap", "MapProfile4", function()
    GAMEMODE.TantiStage = 0
end)

hook.Add("OnWaveStart", "MapProfile3", function()
    timer.Create("MapProfileTimer", 60, 5, function()
        if GAMEMODE.TantiStage == 0 then
            timer.Create("TantiModifierTimer", 1, 59, function()
                for _, pl in ipairs(team.GetPlayers(TEAM_ZOMBIE)) do
                    pl:SetWalkSpeed(175)
                end
            end)
            PrintMessageColor({Color(255, 0, 0), "Zombies advance! Walk speed: 175"})
            GAMEMODE.TantiStage = 1
            BroadcastLua([[MySelf:EmitSound("npc/zombie_poison/pz_alert1.wav", 0, 100, 1, CHAN_STATIC)]])
        elseif GAMEMODE.TantiStage == 1 then
            timer.Create("TantiModifierTimer", 1, 59, function()
                for _, pl in ipairs(team.GetPlayers(TEAM_ZOMBIE)) do
                    pl:SetWalkSpeed(200)
                end
            end)
            PrintMessageColor({Color(255, 0, 0), "Zombies advance! Walk speed: 200"})
            GAMEMODE.TantiStage = 2
            BroadcastLua([[MySelf:EmitSound("npc/zombie_poison/pz_alert1.wav", 0, 90, 1, CHAN_STATIC)]])
            for k, v in pairs(ents.FindByClass("prop_weapon")) do
                v:Remove()
            end
            timer.Simple(1, function()
                for _, pl in pairs(team.GetPlayers(TEAM_HUMAN)) do
                    pl:Give("weapon_zs_boomstick_b2")
                end
            end)
        elseif GAMEMODE.TantiStage == 2 then
            timer.Create("TantiModifierTimer", 1, 59, function()
                for _, pl in ipairs(team.GetPlayers(TEAM_ZOMBIE)) do
                    pl:SetWalkSpeed(225)
                end
            end)
            PrintMessageColor({Color(255, 0, 0), "Zombies advance! Walk speed: 225"})
            GAMEMODE.TantiStage = 3
            BroadcastLua([[MySelf:EmitSound("npc/zombie_poison/pz_alert1.wav", 0, 80, 1, CHAN_STATIC)]])
        elseif GAMEMODE.TantiStage == 3 then
            timer.Create("TantiModifierTimer", 1, 59, function()
                for _, pl in ipairs(team.GetPlayers(TEAM_ZOMBIE)) do
                    pl:SetWalkSpeed(250)
                end
            end)
            PrintMessageColor({Color(255, 0, 0), "Zombies advance! Walk speed: 250"})
            GAMEMODE.TantiStage = 4
            BroadcastLua([[MySelf:EmitSound("npc/zombie_poison/pz_alert1.wav", 0, 70, 1, CHAN_STATIC)]])
        elseif GAMEMODE.TantiStage == 4 then
            timer.Create("TantiModifierTimer", 1, 59, function()
                for _, pl in ipairs(team.GetPlayers(TEAM_ZOMBIE)) do
                    pl:SetWalkSpeed(275)
                end
            end)
            PrintMessageColor({Color(255, 0, 0), "Zombies advance! Walk speed: 275"})
            GAMEMODE.TantiStage = 5
            BroadcastLua([[MySelf:EmitSound("npc/zombie_poison/pz_alert1.wav", 0, 60, 1, CHAN_STATIC)]])
        end
    end)
end)

hook.Add("EndRound", "MapProfile2", function()
    if timer.Exists("MapProfileTimer") then
        timer.Remove("MapProfileTimer")
    end
    if timer.Exists("TantiModifierTimer") then
        timer.Remove("TantiModifierTimer")
    end
end)