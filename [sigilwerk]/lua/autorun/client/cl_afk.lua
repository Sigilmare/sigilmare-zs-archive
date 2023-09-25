local delaytime = CurTime()
local checkfordelay = 1
local AFKTimer = 0
local AFKCounter = true
local AFK_TimeUntilAFK = 300
local AFK_EnableAutoAFK = true
hook.Add( "Move", "AFKSystem", function( ply, mv )
    if AFKCounter and ply:Team() == TEAM_UNDEAD then
        if delaytime + checkfordelay < CurTime() and !ply:IsBot() then
            if mv:GetButtons() == 0 then
                AFKTimer = AFKTimer + 1
            else
                AFKTimer = 0
            end
            delaytime = CurTime()
        end
        
        if AFK_EnableAutoAFK == true then
            if AFKTimer == AFK_TimeUntilAFK then
                net.Start( "NetD3botCommandControl" ) net.SendToServer()
                AFKTimer = 0
                AFKCounter = false
            end
        end
    elseif AFKCounter == false then
        if ply:KeyPressed(IN_MOVELEFT) or ply:KeyPressed(IN_MOVERIGHT) or ply:KeyPressed(IN_FORWARD) or ply:KeyPressed(IN_BACK) or ply:Team() == TEAM_HUMAN then
            net.Start( "NetD3botCommandUnControl" ) net.SendToServer()
            AFKCounter = true
        end
    end
end)
function AFKWarning()
    AFKCounter = false
end
hook.Add("HUDPaint", "ShowAFKMessahe", function()
    if AFKCounter == false then
        draw.RoundedBox(0, 0, 0, ScrW(), ScrH(), Color(0, 0, 0, 0 ))
        draw.SimpleTextBlur("AFK", "ZSHUDFont", ScrW() / 2, ScrH() / 2, COLOR_GRAY, TEXT_ALIGN_CENTER)
        draw.SimpleTextBlur("Move to return", "ZSHUDFontSmall", ScrW() / 2, ScrH() / 2 + 50, COLOR_GRAY, TEXT_ALIGN_CENTER)
    end
end)