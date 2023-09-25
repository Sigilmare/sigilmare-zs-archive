function StatsMenuV1()
    local s, lp = BetterScreenScale(), LocalPlayer()
    surface.PlaySound("sigilmare/ui/buttons/open.ogg")

    local frame = vgui.Create("DFrame")
    frame:SetSize(600 * s, 500 * s)
    frame:SetTitle("")
    frame:Center()
    frame:MakePopup()
    frame.OnClose = function() surface.PlaySound("sigilmare/ui/buttons/close.ogg") end

    local sheet = vgui.Create("DPropertySheet", frame)
    sheet:Dock(FILL)

    --[[local cases = vgui.Create("DPanel", sheet)
    sheet:AddSheet("Cases Stats", cases, "icon16/key.png")

    local cscroll = vgui.Create("DScrollPanel", cases)
    cscroll:Dock( FILL )]]

    local hstats = vgui.Create("DPanel", sheet)
    sheet:AddSheet("Human Stats", hstats, "icon16/user.png")

    local hscroll = vgui.Create("DScrollPanel", hstats)
    hscroll:Dock( FILL )

    local zstats = vgui.Create("DPanel", sheet)
    sheet:AddSheet("Zombie Stats", zstats, "icon16/user_green.png")

    local zscroll = vgui.Create("DScrollPanel", zstats)
    zscroll:Dock( FILL )

    local leaderboard = vgui.Create("DPanel", sheet)
    sheet:AddSheet("Top Humans", leaderboard, "icon16/chart_bar.png")

    local lbscroll = vgui.Create("DScrollPanel", leaderboard)
    lbscroll:Dock( FILL )

    local spot = 1

    local function StatCat(parent, txt)
        a = parent:Add("DLabel")
        a:SetText(txt)
        a:SetTextColor(SIGILCOLOR_GREEN)
        a:SetFont("ZSHUDFont_34")
        a:SizeToContents()
        a:Dock(TOP)
        a:DockMargin(8, 0, 8, 0)
    end

    local function Stat(parent, arg1, arg2)
        a = parent:Add("DLabel")
        a:SetText(arg1..": "..string.Comma(math.floor(lp:GetNWInt(arg2))))
        a:SetFont("ZSHUDFont_20")
        a:SizeToContents()
        a:Dock(TOP)
        a:DockMargin(8, 0, 8, 0)
    end

    local function StatNoNWInt(parent, arg1, arg2)
        a = parent:Add("DLabel")
        a:SetText(arg1..": "..string.Comma(math.floor(arg2)))
        a:SetFont("ZSHUDFont_20")
        a:SizeToContents()
        a:Dock(TOP)
        a:DockMargin(8, 0, 8, 0)
    end

    local function StatFunc(parent, arg1, arg2)
        a = parent:Add("DLabel")
        a:SetText(arg1..": "..arg2)
        a:SetFont("ZSHUDFont_20")
        a:SizeToContents()
        a:Dock(TOP)
        a:DockMargin(8, 0, 8, 0)
    end

    local function Split(parent)
        a = parent:Add("DPanel")
        a:SetSize(0, 8)
        a:Dock(TOP)
        a:DockMargin(4, 4, 4, 2)
        a.Paint = function(panel, w, h)
            surface.SetDrawColor(30, 30, 30)
            surface.DrawRect(0, 0, w, h)
        end
    end

    local function Msg(parent, textcol, text)
        local button = parent:Add("DButton")
        button:SetDisabled(true)
        button:SetCursor("arrow")
        button:SetText(text)
        button:SetTextColor(textcol)
        button:SizeToContents()
        button:Dock(TOP)
        button:DockMargin(8, 6, 8, 6)
        button.Paint = function() end
    end

    local function LBStat(arg1, arg2, arg3)
        local topPlayers = player.GetHumans()
        table.sort( topPlayers, function(a, b) return a:GetNWInt(arg3) > b:GetNWInt(arg3) end )
        local topPly = topPlayers[spot]

        local lbpnl = lbscroll:Add("DPanel")
        lbpnl:SetSize(0, 56)
        lbpnl:Dock(TOP)
        lbpnl:DockMargin(8, 4, 8, 4)
        lbpnl.Paint = function(panel, w, h)
            surface.SetDrawColor(70, 70, 70)
            surface.DrawRect(0, 0, w, h)
        end

        local lbavatar = vgui.Create("AvatarImage", lbpnl)
        lbavatar:SetSize( 48, 48 )
        lbavatar:SetPos( 4, 4 )
        lbavatar:SetPlayer( topPly, 48 )

        local lbtext = vgui.Create("DLabel", lbpnl)
        lbtext:SetText(arg1)
        lbtext:SetFont("ZSHUDFontSmallest")
        lbtext:SetTextColor(SIGILCOLOR_YELLOW)
        lbtext:SizeToContents()
        lbtext:SetPos(0, 2)
        lbtext:MoveRightOf(lbavatar, 4)

        local lbdesc = vgui.Create("DLabel", lbpnl)
        lbdesc:SetText("Goes to "..(topPly ~= nil and topPly:Name() or "no one").." with "..(topPly ~= nil and string.Comma(math.floor(topPly:GetNWInt(arg3))) or "0").." "..arg2)
        lbdesc:SizeToContents()
        lbdesc:MoveRightOf(lbavatar, 4)
        lbdesc:MoveBelow(lbtext, 0)
    end

    local function LBStatZSLevel(arg1, arg2)
        local topPlayers = player.GetHumans()
        table.sort( topPlayers, function(a, b) return a:GetZSLevel() > b:GetZSLevel() end )
        local topPly = topPlayers[spot]

        local lbpnl = lbscroll:Add("DPanel")
        lbpnl:SetSize(0, 56)
        lbpnl:Dock(TOP)
        lbpnl:DockMargin(8, 4, 8, 4)
        lbpnl.Paint = function(panel, w, h)
            surface.SetDrawColor(70, 70, 70)
            surface.DrawRect(0, 0, w, h)
        end

        local lbavatar = vgui.Create("AvatarImage", lbpnl, "StatsLBAvatar")
        lbavatar:SetSize( 48, 48 )
        lbavatar:SetPos( 4, 4 )
        lbavatar:SetPlayer( topPly, 48 )

        local lbtext = vgui.Create("DLabel", lbpnl)
        lbtext:SetText(arg1)
        lbtext:SetFont("ZSHUDFontSmallest")
        lbtext:SetTextColor(SIGILCOLOR_YELLOW)
        lbtext:SizeToContents()
        lbtext:SetPos(0, 2)
        lbtext:MoveRightOf(lbavatar, 4)

        local lbdesc = vgui.Create("DLabel", lbpnl)
        lbdesc:SetText("Goes to "..(topPly ~= nil and topPly:Name() or "no one").." with "..(topPly ~= nil and string.Comma(math.floor(topPly:GetZSLevel())) or "0").." "..arg2)
        lbdesc:SizeToContents()
        lbdesc:MoveRightOf(lbavatar, 4)
        lbdesc:MoveBelow(lbtext, 0)
    end

    local function LBStatZSRemortLevel(arg1, arg2)
        local topPlayers = player.GetHumans()
        table.sort( topPlayers, function(a, b) return a:GetZSRemortLevel() > b:GetZSRemortLevel() end )
        local topPly = topPlayers[spot]

        local lbpnl = lbscroll:Add("DPanel")
        lbpnl:SetSize(0, 56)
        lbpnl:Dock(TOP)
        lbpnl:DockMargin(8, 4, 8, 4)
        lbpnl.Paint = function(panel, w, h)
            surface.SetDrawColor(70, 70, 70)
            surface.DrawRect(0, 0, w, h)
        end

        local lbavatar = vgui.Create("AvatarImage", lbpnl, "StatsLBAvatar")
        lbavatar:SetSize( 48, 48 )
        lbavatar:SetPos( 4, 4 )
        lbavatar:SetPlayer( topPly, 48 )

        local lbtext = vgui.Create("DLabel", lbpnl)
        lbtext:SetText(arg1)
        lbtext:SetFont("ZSHUDFontSmallest")
        lbtext:SetTextColor(SIGILCOLOR_YELLOW)
        lbtext:SizeToContents()
        lbtext:SetPos(0, 2)
        lbtext:MoveRightOf(lbavatar, 4)

        local lbdesc = vgui.Create("DLabel", lbpnl)
        lbdesc:SetText("Goes to "..(topPly ~= nil and topPly:Name() or "no one").." with "..(topPly ~= nil and string.Comma(math.floor(topPly:GetZSRemortLevel())) or "0").." "..arg2)
        lbdesc:SizeToContents()
        lbdesc:MoveRightOf(lbavatar, 4)
        lbdesc:MoveBelow(lbtext, 0)
    end

    local function LBStatZSXP(arg1, arg2)
        local topPlayers = player.GetHumans()
        table.sort( topPlayers, function(a, b) return a:GetZSXP() > b:GetZSXP() end )
        local topPly = topPlayers[spot]

        local lbpnl = lbscroll:Add("DPanel")
        lbpnl:SetSize(0, 56)
        lbpnl:Dock(TOP)
        lbpnl:DockMargin(8, 4, 8, 4)
        lbpnl.Paint = function(panel, w, h)
            surface.SetDrawColor(70, 70, 70)
            surface.DrawRect(0, 0, w, h)
        end

        local lbavatar = vgui.Create("AvatarImage", lbpnl, "StatsLBAvatar")
        lbavatar:SetSize( 48, 48 )
        lbavatar:SetPos( 4, 4 )
        lbavatar:SetPlayer( topPly, 48 )

        local lbtext = vgui.Create("DLabel", lbpnl)
        lbtext:SetText(arg1)
        lbtext:SetFont("ZSHUDFontSmallest")
        lbtext:SetTextColor(SIGILCOLOR_YELLOW)
        lbtext:SizeToContents()
        lbtext:SetPos(0, 2)
        lbtext:MoveRightOf(lbavatar, 4)

        local lbdesc = vgui.Create("DLabel", lbpnl)
        lbdesc:SetText("Goes to "..(topPly ~= nil and topPly:Name() or "no one").." with "..(topPly ~= nil and string.Comma(math.floor(topPly:GetZSXP())) or "0").." "..arg2)
        lbdesc:SizeToContents()
        lbdesc:MoveRightOf(lbavatar, 4)
        lbdesc:MoveBelow(lbtext, 0)
    end

    -- Cases Stats

    --[[Msg(cscroll, SIGILCOLOR_ORANGE, "More stats to be added!")

    StatCat(cscroll,                        "Cases")

    Stat(cscroll, "Aether",                 "Cases.Aether")
    Stat(cscroll, "Cases Opened",           "CStats.CasesOpened")

    Split(cscroll)
    StatCat(cscroll,                        "Retrievals")

    Stat(cscroll, "Commons",                "CStats.Commons")
    Stat(cscroll, "Uncommons",              "CStats.Uncommons")
    Stat(cscroll, "Rares",                  "CStats.Rares")
    Stat(cscroll, "Epics",                  "CStats.Epics")
    Stat(cscroll, "Legendaries",            "CStats.Legendaries")
    Stat(cscroll, "Exotics",                "CStats.Exotics")

    Split(cscroll)
    StatCat(cscroll,                        "Tokens")

    Stat(cscroll, "Nuclear Warheads",       CASES_TOKEN_NUCLEARWARHEAD)
    Stat(cscroll, "Blackholes",             CASES_TOKEN_BLACKHOLE)
    Stat(cscroll, "Tommy Guns",             CASES_TOKEN_TOMMYGUN)]]

    -- Human Stats

    Msg(hscroll, SIGILCOLOR_ORANGE, "More stats to be added!")

    StatCat(hscroll,                        "Combat")

    Stat(hscroll, "Zombies Killed",         "HStats.ZombiesKilled")
    Stat(hscroll, "Assists",                "HStats.ZombiesKilledAssists")
    Stat(hscroll, "Headshots",              "HStats.ZombiesKilledHeadshots")
    Stat(hscroll, "Total Damage",           "HStats.DamageToZombies")

    Split(hscroll)
    StatCat(hscroll,                        "Support")

    Stat(hscroll, "Object Repair Points",   "HStats.ObjectRepairPoints")

    Split(hscroll)
    StatCat(hscroll,                        "Survival")

    Stat(hscroll, "Points Earned",          "HStats.PointsEarned")
    Stat(hscroll, "Round Wins",             "HStats.RoundWins")
    Stat(hscroll, "Round Losses",           "HStats.RoundLosses")

    Split(hscroll)
    StatCat(hscroll,                        "SkillWeb")

    StatNoNWInt(hscroll, "Level", lp:GetZSLevel())
    StatNoNWInt(hscroll, "Remort Level", lp:GetZSRemortLevel())
    StatFunc(hscroll, "XP", string.Comma(math.floor(lp:GetZSXP())).." / "..string.Comma(math.floor(GAMEMODE:XPForLevel(lp:GetZSLevel() + 1))))

    -- Zombie Stats

    Msg(zscroll, SIGILCOLOR_ORANGE, "- To be added")

    -- Top Humans

    Msg(lbscroll, SIGILCOLOR_RED, "Only shows connected players")

    StatCat(lbscroll,                       "Combat")

    LBStat("Zombie Kills",                  "zombies killed!",          "HStats.ZombiesKilled")
    LBStat("Assists",                       "assists!",                 "HStats.ZombiesKilledAssists")
    LBStat("Headshots",                     "headshots!",               "HStats.ZombiesKilledHeadshots")
    LBStat("Total Damage",                  "total damage!",            "HStats.DamageToZombies")

    Split(lbscroll)
    StatCat(lbscroll,                       "Support")

    LBStat("Object Repair Points",          "object repair points!",    "HStats.ObjectRepairPoints")

    Split(lbscroll)
    StatCat(lbscroll,                       "Survival")
    
    LBStat("Points Earned",                 "points earned!",           "HStats.PointsEarned")
    LBStat("Round Wins",                    "round wins!",              "HStats.RoundWins")
    LBStat("Round Losses",                  "round losses!",            "HStats.RoundLosses")

    Split(lbscroll)
    StatCat(lbscroll,                       "SkillWeb")

    LBStatZSLevel("Level",                  "levels!")
    LBStatZSRemortLevel("Remort Level",     "remort levels!")
    LBStatZSXP("XP",                        "XP!")
end