util.AddNetworkString("sm_risehero")

function RiseHero(pl)
    if not pl or not pl:IsValid() or pl:Team() == TEAM_ZOMBIE then return end

    pl.RisenAsHero = true
    pl:SetDeaths(0)
    pl:SetPoints(0)
    pl:SetFrags(0)
    pl:SetNWInt("ZSFrags", 0)
    pl:DoHulls()
    pl:Spawn()
    pl:StripWeapons()
    pl:StripAmmo()
    pl:SetModel("models/mw2guy/riot/juggernaut.mdl")
    pl:CreateZSHands("models/tfusion/playermodels/mw3/c_arms_sp_juggernaut.mdl")
    pl:Give("weapon_zs_deathmachine")
    pl:Give("weapon_zs_showstopper")
    pl:Give("weapon_zs_harpoon_te")
    pl:SelectWeapon("weapon_zs_deathmachine")
    pl:SetMaxHealth(500)
    pl:SetHealth(pl:GetMaxHealth())
    pl:SetMaxArmor(1500)
    pl:SetArmor(pl:GetMaxArmor())
    pl:SetDTInt(DT_PLAYER_INT_VOICESET, VOICESET_ROASTER)
    local acts = {
        ACT_SIGNAL_FORWARD,
        ACT_GMOD_TAUNT_CHEER,
        ACT_GMOD_GESTURE_BECON
    }
    timer.Simple(0.5, function()
        if pl and pl:IsValid() then
            pl:DoAnimationEvent(acts[math.random(#acts)])
            BroadcastLua([[MySelf:EmitSound("sigilmare/hellsgamers/roaster/roaster_see]]..math.random(4)..[[.ogg", 0, 100, 1, CHAN_STATIC)]])
        end
    end)

    for k, v in ipairs(player.GetAll()) do
        v:Freeze(true)
        v:ConCommand("stopsound")
        if v:IsBot() then
            v:D3bot_Deinitialize()
        end
    end

    timer.Simple(5.25, function()
        for k, v in ipairs(player.GetAll()) do
            v:Freeze(false)
            if v:IsBot() then
                v:D3bot_InitializeOrReset()
            end
        end
        --song("https://cdn.discordapp.com/attachments/1085523339608604756/1146839028658876587/lasthuman_hd.ogg")
    end)

    net.Start("sm_risehero")
        net.WriteEntity(pl)
    net.Broadcast()

    GAMEMODE:CenterNotify({CustomTime = 5}, {font = "ZSHUDFontSmall"}, COLOR_CYAN, pl:Name(), color_white, " has risen as ", COLOR_RED, "Juggerrock!")
    GAMEMODE:CenterNotify({CustomTime = 5}, COLOR_RED, "He's slow but has a powerful Death Machine and Sledgehammer, his armor is also quite tough!")

    timer.Create("ZS:HeroIdle"..pl:SteamID(), 60, 0, function()
        pl:EmitSound("sigilmare/hellsgamers/roaster/roaster_idle1.ogg", 100, 100, 1, CHAN_STATIC)
    end)
end

hook.Add("OnLastHuman", "ZS:HeroHandler", function(pl)
    if #player.GetHumans() > 0 and math.random(1) == 1 then
        for k, v in ipairs(player.GetHumans()) do
            v:ConCommand("zs_beats 0")
            v:ConCommand("zs_playmusic 0")
        end
        RiseHero(pl)
        timer.Simple(5, function()
            if pl and pl:IsValid() and pl:Team() == TEAM_HUMAN then
                net.Start("zs_lasthuman")
                    net.WriteEntity(pl or NULL)
                net.Broadcast()
            end

            song("https://cdn.discordapp.com/attachments/1085523339608604756/1152617807054372954/Black_Mesa_-_Weve_Got_Hostiles_remix.wav")
        end)
    else
        net.Start("zs_lasthuman")
            net.WriteEntity(pl or NULL)
        net.Broadcast()

        --song("https://cdn.discordapp.com/attachments/1085523339608604756/1152617807054372954/Black_Mesa_-_Weve_Got_Hostiles_remix.wav")
    end
end)

hook.Add("PlayerDeath", "ZS:HeroDeath", function(pl)
    if pl.RisenAsHero then
        timer.Remove("ZS:HeroIdle"..pl:SteamID())
        pl.RisenAsHero = false
    end
end)