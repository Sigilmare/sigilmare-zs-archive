local math_random = math.random

util.AddNetworkString("nZSPhysProp")
util.AddNetworkString("nZSSWEPProp")
util.AddNetworkString("nZSBlackholeNode")
util.AddNetworkString("nZSSigilNode")

-----------------------------
-- Map Downloading/Loading --
-----------------------------

hook.Add("LoadNextMap", "MapHandler:LoadNextMap", function()
    BroadcastLua("SM:OpenMapVote()")

    timer.Simple(30, function()
        for k, v in SortedPairsByMemberValue(SM.MapVoteTable, "Votes", true) do
            PrintMessageColor({SIGILCOLOR_CYAN, v.Map.." has won with "..v.Votes.." total votes!"})

            timer.Simple(8, function()
                RunConsoleCommand("changelevel", v.Map)
            end)

            return
        end
    end)

    return true
end)

for _, mapid in pairs(SM.MapDownloads) do
    if game.GetMap() == _ and mapid.ID then
        resource.AddWorkshop(mapid.ID)
        break
    end
end

hook.Add("PlayerSay", "MapProfile.PlayerSay", function(ply, text)
    if string.lower(text) == "!loadmapprofile" then
        if ply:SteamID() ~= "STEAM_0:0:105668971" then return end

        game.CleanUpMap()

        if file.Exists("sigilprofiles/"..game.GetMap()..".lua", "LUA") then
            include("sigilprofiles/"..game.GetMap()..".lua")
            hook.Run("InitPostEntityMap")
        end

        PrintMessage(HUD_PRINTTALK, "Map profile loaded successfully!")

    elseif string.lower(text) == "!physprop" or string.lower(text) == "/physprop" then
        local ent = ply:GetEyeTrace().Entity
        if IsValid(ent) then
            ent:SetColor(SIGILCOLOR_GREEN)
        end

        net.Start("nZSPhysProp")
            net.WriteEntity(ent)
        net.Send(ply)

    elseif string.lower(text) == "!undo" or string.lower(text) == "/undo" then
        local ent = ply:GetEyeTrace().Entity
        if IsValid(ent) then
            ent:SetColor(Color(255, 255, 255))
        end

    elseif string.lower(text) == "!swepprop" or string.lower(text) == "/swepprop" then
        local ent = ply:GetEyeTrace().Entity

        net.Start("nZSSWEPProp")
            net.WriteEntity(ent)
        net.Send(ply)

    elseif string.lower(text) == "!blackholenode" or string.lower(text) == "/blackholenode" then

        net.Start("nZSBlackholeNode")
            net.WriteEntity(ply)
        net.Send(ply)

    elseif string.lower(text) == "!sigilnode" or string.lower(text) == "/sigilnode" then

        net.Start("nZSSigilNode")
            net.WriteEntity(ply)
        net.Send(ply)
    end
end)

-------------------
-- Rock The Vote --
-------------------

local currentVotes = 0
local OldHumanCount = 0
local votesNeeded = 0

local player_GetHumans = player.GetHumans

local HasVoted = HasVoted or {}

hook.Add("Think", "UpdateVotesNeeded", function()
    if #player_GetHumans() == OldHumanCount then
        return
    else
        OldHumanCount = #player_GetHumans()
        votesNeeded = math.ceil(0.66 * OldHumanCount)
        --currentVotes = math.max(currentVotes - 1, 0)
    end
end)

timer.Simple(300 - CurTime(), function()
    PrintMessageColor({SIGILCOLOR_GREEN, "Rock the vote is now enabled."})
end)

hook.Add("PlayerSay", "RTV:MapHandler", function(pl, text)
    if string.lower(text) == "!rtv" or string.lower(text) == "/rtv" then
        if CurTime() < 300 then
            pl:SendLua([[chat.AddText(SIGILCOLOR_RED, "Please wait 5 minutes after the map has loaded before rocking the vote")]])
            return ""
        elseif GAMEMODE:GetWave() > 1 then
            pl:SendLua([[chat.AddText(SIGILCOLOR_RED, "You cannot rock the vote past wave 1")]])
            return ""
        elseif table.HasValue(HasVoted, pl:SteamID()) then
            pl:SendLua([[chat.AddText(SIGILCOLOR_RED, "You have already rocked the vote")]])
            return ""
        end

        currentVotes = currentVotes + 1
        table.insert(HasVoted, pl:SteamID())
        PrintMessageColor({SIGILCOLOR_RED, "<avatar="..pl:SteamID().."> ", team.GetColor(pl:Team()), pl:Name(), color_white, " has just ", SIGILCOLOR_RED, "rocked the vote"})

        PrintTable(HasVoted)

        if votesNeeded == 1 then
            PrintMessageColor({color_white, "("..(votesNeeded - currentVotes).." more vote needed)"})
        elseif votesNeeded > 1 then
            PrintMessageColor({color_white, "("..(votesNeeded - currentVotes).." more votes needed)"})
        end

        if currentVotes >= votesNeeded then
            PrintMessageColor({SIGILCOLOR_CYAN, "Rock the vote passed!"})
            gamemode.Call("LoadNextMap")
        end

        return ""
    end
end)

----------------------
-- Map Vote Handler --
----------------------

util.AddNetworkString("SM:MapVote.VotedFor")

SM.MapVoteTable = {}
for map, id in pairs(SM.PlayableMaps) do
    table.insert(SM.MapVoteTable, {Map = id, Votes = 0})
end

net.Receive("SM:MapVote.VotedFor", function(len, ply)
    if ply.HasVotedFor then
        ply:SendLua([[chat.AddText(SIGILCOLOR_RED, "You have already voted for the next map.")]])
        return
    end
    local id = net.ReadUInt(8)

    ply.HasVotedFor = true
    if ply:IsSuperAdmin() then
        SM.MapVoteTable[id].Votes = SM.MapVoteTable[id].Votes + 2
        PrintMessageColor({team.GetColor(ply:Team()), "<avatar="..ply:SteamID().."> "..ply:Name(), color_white, " has voted for ", SIGILCOLOR_CYAN, SM.MapVoteTable[id].Map, SM.UserGroups["superadmin"][2], " (+100% owner bonus)"})
    elseif ply:IsUserGroup("donator") then
        SM.MapVoteTable[id].Votes = SM.MapVoteTable[id].Votes + 2
        PrintMessageColor({team.GetColor(ply:Team()), "<avatar="..ply:SteamID().."> "..ply:Name(), color_white, " has voted for ", SIGILCOLOR_CYAN, SM.MapVoteTable[id].Map, SM.UserGroups["donator"][2], " (+100% donator bonus)"})
    else
        SM.MapVoteTable[id].Votes = SM.MapVoteTable[id].Votes + 1
        PrintMessageColor({team.GetColor(ply:Team()), "<avatar="..ply:SteamID().."> "..ply:Name(), color_white, " has voted for ", SIGILCOLOR_CYAN, SM.MapVoteTable[id].Map})
    end
end)