function GetMapThumb(mapname)
    if file.Exists("maps/thumb/"..mapname..".png", "GAME") then
        return "maps/thumb/"..mapname..".png"
    else
        chat.AddText(SIGILCOLOR_RED, "Failed to get map icon for "..mapname)
        return "maps/thumb/noicon.png"
    end
end

function SM:OpenMapVote()
    local s = BetterScreenScale()

    local frame = vgui.Create( "DFrame" )
    frame:SetSize(1360 * s, 900 * s)
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:Center()
    frame.Paint = function(panel, w, h)
        surface.SetDrawColor(Color(0, 0, 0, 250))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(Color(0, 0, 0))
        surface.DrawOutlinedRect(0, 0, w, h)
    end
    frame:MakePopup()

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock( FILL )
    
    local list = vgui.Create("DIconLayout", scroll)
    list:Dock(FILL)
    list:DockMargin(4 * s, 0, 4 * s, 0)
    list:SetSpaceX(10 * s)
    list:SetSpaceY(10 * s)
    
    for _, map in pairs(SM.PlayableMaps) do
        local a = list:Add("DPanel")
        a:SetSize(256 * s, 256 * s)

        local b = vgui.Create("DImage", a)
        b:SetImage(GetMapThumb(map))
        b:SetSize(a:GetSize())

        local txtBG = vgui.Create("DPanel", b)
        txtBG:SetSize(b:GetWide(), 32 * s)
        txtBG:AlignBottom()
        txtBG.Paint = function(panel, w, h)
            surface.SetDrawColor(0, 0, 0, 230)
            surface.DrawRect(0, 0, w, h)
        end

        local txt = vgui.Create("DLabel", txtBG)
        txt:SetText(map)
        if #map <= 15 then
            txt:SetFont("ZSHUDFontSmallest")
        elseif #map > 15 and #map <= 18 then
            txt:SetFont("ZSHUDFontSmaller")
        elseif #map > 18 and #map <= 22 then
            txt:SetFont("ZSHUDFontSmallest")
        else
            txt:SetFont("ZSHUDFontTiny")
        end

        txt:SizeToContents()
        txt:Center()

        local button = vgui.Create("DButton", a)
        button:SetSize(a:GetSize())
        button:SetText("")
        if SM.MapDownloads[map].MinPlayers and #player.GetHumans() < SM.MapDownloads[map].MinPlayers then
            button:SetDisabled(true)
            button.Paint = function(panel, w, h)
                surface.SetDrawColor(0, 0, 0, 225)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleText("Need "..SM.MapDownloads[map].MinPlayers.." players", "ZSHUDFontSmaller", w/2, h/2, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        elseif SM.MapDownloads[map].Banned then
            button:SetDisabled(true)
            button.Paint = function(panel, w, h)
                surface.SetDrawColor(0, 0, 0, 225)
                surface.DrawRect(0, 0, w, h)

                draw.SimpleText("Unavailable", "ZSHUDFontSmall", w/2, h/2, COLOR_RED, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        else
            button.Paint = function() end
        end
        button.DoClick = function()
            net.Start("SM:MapVote.VotedFor")
                net.WriteUInt(_, 8)
            net.SendToServer()
            frame:Close()
        end
    end
end