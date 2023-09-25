util.AddNetworkString("ChatTextColor")
util.AddNetworkString("noaimm")

net.Receive("noaimm", function(len, ply) ply:GetActiveWeapon().ConeMin = 0 ply:GetActiveWeapon().ConeMax = 0 ply:PrintMessage(HUD_PRINTCENTER, "Noaim done on weapon") end)

-----------
-- Hooks --
-----------

-- Load rules
hook.Add("PlayerFullyLoad", "Util:ShowRules", function(pl)
    pl:SendLua("SigilmareRules()")
end)

-- Advertise Discord server
hook.Add("EndRound", "Advert:Discord", function()
	if GAMEMODE.ZombieEscape then return end

	PrintMessageColor({SIGILCOLOR_RED, "[Sigilmare] ", color_white, "Had fun this round and want to join our community? Consider joining our ", Color(88, 101, 242), "Discord", color_white, " server by typing ", Color(88, 101, 242), "!discord", color_white, " in chat!"})
end)

---------------
-- Functions --
---------------

-- Prints a chat message supporting colors
function PrintMessageColor(...)
    if istable(...) then
        net.Start("ChatTextColor")
            net.WriteTable(...)
        net.Broadcast()
    else
        error("Must have inputs inside of a table")
    end
end

timer.Create("NameLabelAdvert", 120, 0, function()
    PrintMessageColor({SIGILCOLOR_RED, "[Tips] ", color_white, "Want a ", SIGILCOLOR_ZSXP, "+15% XP", color_white, " boost? Just put ", SIGILCOLOR_CYAN, "[Sigilmare] ", color_white, " in your Steam username or put ", SIGILCOLOR_CYAN, "[SM] ", color_white, "for a smaller ", SIGILCOLOR_ZSXP, "+5% XP", color_white, " boost"})
end)

function NukeProtocol(pl)
    GAMEMODE:CenterNotify({CustomTime = 25}, pl, " just started the ", COLOR_RED, "Alpha Warhead ", color_white, "detonation sequence!")
    for k, v in pairs(team.GetPlayers(TEAM_HUMAN)) do
        if v:Team() == TEAM_UNDEAD then
            v:CenterNotify({CustomTime = 25}, COLOR_RED, "DON'T LET THE ALPHA WARHEAD DETONATE IN TIME!")
        else
            v:CenterNotify({CustomTime = 25}, COLOR_RED, "SURVIVE UNTIL THE ALPHA WARHEAD DETONATES! NOW IS YOUR LAST HOPE!")
        end
    end
    song("https://cdn.discordapp.com/attachments/1085523339608604756/1152680062945083564/nuke.wav")

    timer.Create("StartCountdown", 25, 1, function()
        for k, v in ipairs(player.GetHumans()) do
            v:SetFOV(120, 2)
        end
        timer.Simple(2, function()
            timer.Create("FOVScaler", 0.1, 0, function()
                for k, v in ipairs(player.GetHumans()) do
                    if v:GetFOV() != 120 then
                        v:SetFOV(120)
                    end
                end
            end)
        end)
    end)
end