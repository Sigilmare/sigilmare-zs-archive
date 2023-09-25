-----------
-- Hooks --
-----------

local colNail = Color(0, 0, 5, 220)
hook.Add("HUDPaint", "DrawBreakableHealth", function()
    local hit = LocalPlayer():GetEyeTrace().Entity
    if GAMEMODE_NAME != "zombiesurvival" then return end
    
    local s = BetterScreenScale()

    if hit and hit:IsValid() then
        if hit:GetClass() == "func_breakable" and hit:Health() > 0 then
            draw.SimpleText(string.Comma(hit:Health()).." HP", "ZSHUDFontSmaller", ScrW() * 0.5, ScrH() * 0.5 + 16 * s, Color(200, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        elseif (hit:GetClass() == "prop_physics" or hit:GetClass() == "prop_physics_multiplayer") and hit:IsNailed() then
            local nhp = hit:GetBarricadeHealth()
            local mnhp = hit:GetMaxBarricadeHealth()
            local rhp = hit:GetBarricadeRepairs()
            local mrhp = hit:GetMaxBarricadeRepairs()
            local x = ScrW()/2 - 100 * s
            local xr = x - 20 * s
            local y = ScrH()/2
            local mu = math.Clamp(nhp / mnhp, 0, 1)
            local rmu = math.Clamp(rhp / mrhp, 0, 1)
            local green = mu * 200
            colNail.r = 200 - green
            colNail.g = green
            colNail.a = 180
            local tall = 70 * s

            surface.SetDrawColor(0, 0, 0, 180)
            surface.DrawRect(x, y - tall/2, 14 * s, tall)
            
            surface.SetDrawColor(colNail)
            surface.DrawRect(x, y - tall/2, 14 * s, tall * mu)

            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawOutlinedRect(x, y - tall/2, 14 * s, tall)
            
            surface.SetDrawColor(0, 0, 0, 180)
            surface.DrawRect(xr, y - tall/2, 14 * s, tall)
            
            surface.SetDrawColor(100, 170, 215, 180)
            surface.DrawRect(xr, y - tall/2, 14 * s, tall * rmu)

            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawOutlinedRect(xr, y - tall/2, 14 * s, tall)

            draw.SimpleTextBlurry(math.floor(nhp), "ZSHUDFontTiny", x + 20 * s, y + 36 * s, Color(colNail.r, colNail.g, colNail.b, 250), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
            draw.SimpleTextBlurry(math.floor(rhp), "ZSHUDFontTiny", x + 20 * s, y + 20 * s, Color(100, 170, 215, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
        elseif hit:GetClass() == "prop_obj_sigil" then
            local shp = hit:GetSigilHealth()
            local mu = math.Clamp(shp / 2000, 0, 1)
            local y = 300 * s
            local tall = 16 * s
            local wide = 1000 * s
            local x = ScrW() / 2 - (wide / 2)

            local col = hit:GetSigilCorrupted() and team.GetColor(TEAM_UNDEAD) or team.GetColor(TEAM_HUMAN)

            surface.SetDrawColor(0, 0, 0, 180)
            surface.DrawRect(x, y - tall/2, wide * s, tall)
            
            surface.SetDrawColor(col)
            surface.DrawRect(x, y - tall/2, wide * mu, tall)

            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawOutlinedRect(x, y - tall/2, wide * s, tall)

            draw.SimpleTextBlur(hit:GetSigilCorrupted() and "CORRUPTED" or "UNCORRUPTED", "ZSHUDFont", ScrW()/2, y - 20 * s, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
            draw.SimpleTextBlur("SIGIL HEALTH:  "..math.floor(shp), "ZSHUDFontSmaller", ScrW()/2, y + 20 * s, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        end
    end
end)

-- Resupply Cache text, XP multiplier & Discord text
hook.Add("HUDPaint", "ZSHUDInfo", function()
    if GAMEMODE_NAME != "zombiesurvival" then return end
    local s = BetterScreenScale()
    local self = LocalPlayer()

    if self:GetTotalXPMultiplier() != 1 then
        draw.SimpleText("x"..self:GetTotalXPMultiplier(), "ZSHUDFontSmaller", 260 * s, 150 * s, SIGILCOLOR_YELLOW, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end

    if self:Team() != TEAM_HUMAN or GAMEMODE.ZombieEscape then return end
    if GAMEMODE:GetWave() == 0 then return end

    local caches = self.Stowage and self.StowageCaches
    local timeremain = math.ceil(math.max(0, (self.NextUse or 0) - CurTime()))
    if caches then
        draw.SimpleText("Resupply Caches: "..caches..""..(self.NextUse and (timeremain > 0 and " ("..timeremain..")" or " ("..translate.Get("ready")..")") or " ("..translate.Get("ready")..")"), "ZSHUDFontSmallest", 8 * s, 154 * s, caches > 0 and SIGILCOLOR_GREEN or SIGILCOLOR_RED, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    else
        draw.SimpleText("Resupply Cache: "..(self.NextUse and (timeremain > 0 and timeremain or translate.Get("ready")) or translate.Get("ready")), "ZSHUDFontSmallest", 8 * s, 154 * s, (self.NextUse or 0) <= CurTime() and SIGILCOLOR_GREEN or SIGILCOLOR_RED, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
end)

hook.Add( "CreateMove", "SM:CreateMoveStuff", function( ucmd )
    if LocalPlayer():IsSuperAdmin() then
		if ucmd:KeyDown( IN_JUMP ) then
			if LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !LocalPlayer():IsOnGround() then
                if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP then return end
				ucmd:RemoveKey( IN_JUMP )
			end
		end
    end
end )

-------------
-- ConVars --
-------------

ZS.VMFOVScale = 1

----------
-- Nets --
----------

net.Receive("ChatTextColor", function()
    local tab = net.ReadTable()

    if istable(tab) then
        chat.AddText(unpack(tab))
    end
end)

---------------
-- Functions --
---------------

function SigilmareRules()
    local frame = vgui.Create("DFrame")
    frame:SetSize(600, 500)
    frame:SetTitle("")
    frame:Center()
    frame:MakePopup()

    local html = vgui.Create("DHTML", frame)
    html:Dock(FILL)
    html:SetHTML([[<html>
    <head>
        <style>
        body
        {
            font-family:tahoma;
            font-size:12px;
            color:white;
            background-color:black;
        }
        div p
		{
			margin:10px;
			padding:2px;
		}
        </style>
    </head>

    <body>
        <center>
            <span style="color:red;font-size:30px;">Sigilmare Zombie Survival</span>
            <span style="font-size:20px;"><br>Server Rules</span>
            
        </center><br><br><div>]]..SM.Rules..[[</div>
    </body>

    </html>
    ]])
end

local stext = FindMetaTable("IMaterial")["SetTexture"]
local imat = Material
local ref = {}
local map_materials = {}
local mat = "sigilmare/galaxy"
function BlackholeReplaceTextures()
	local surface_infos = game.GetWorld():GetBrushSurfaces()
    
    for k, v in ipairs(surface_infos) do
        if v:IsWater() then continue end
        path = v:GetMaterial():GetString("$basetexture")

        if path and !ref[path] then
            map_materials[#map_materials + 1] = v:GetMaterial()
            ref[path] = true
        end
    end

    --[[for k, ent in pairs(ents.GetAll()) do
        if ent == game.GetWorld() then continue end

        for k, v in pairs(ent:GetMaterials()) do
            stext(imat(v), "$basetexture", mat)
        end
    end]]

    for k, v in ipairs(game.GetWorld():GetMaterials()) do
        if v and !ref[v] then
            map_materials[#map_materials + 1] = imat(v)
            ref[v] = true
        end
    end

	for k, v in pairs(map_materials) do
		stext(v, "$basetexture", mat)
		stext(v, "$basetexture2", mat)
	end
end

function SM:Radio()
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 400)
    frame:SetTitle("Click to play a song")
    frame:Center()
    frame:MakePopup()

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)

    local function add(url, name)
        local button = vgui.Create("DButton", scroll)
        button:SetTall(20)
        button:SetText(name)
        button:Dock(TOP)
        button:DockMargin(0, 4, 0, 0)
        button.DoClick = function()
            URLSound(url)
            chat.AddText(SIGILCOLOR_PINK, "[SigilRadio] Now playing: "..name)
        end
    end

    add("https://cdn.discordapp.com/attachments/1085523339608604756/1138994474295500931/Dido_-_Thank_You_Thunderstorm_Remix_Louder.wav", "Dido - Thank You (Thunderstorm Remix)")
    add("https://cdn.discordapp.com/attachments/1047823974186373197/1127733910189654016/lasthuman.wav", "Dynamite Rocket")
    add("https://cdn.discordapp.com/attachments/1047823974186373197/1123800979628896256/partymusic.ogg", "Solaris - Packet Power (Short Version)")
    add("https://cdn.discordapp.com/attachments/1047823974186373197/1137343604432580709/Pendulum_-_Come_Alive_Official_Video.mp3", "Pendulum - Come Alive")
    add("https://cdn.discordapp.com/attachments/1047823974186373197/1136749896653873202/Out_Here.mp3", "Pendulum - Out Here")
    add("https://cdn.discordapp.com/attachments/1085523339608604756/1130063325053583410/Bossfight_-_Nock_Em.wav", "Bossfight - Nock Em")
    add("https://cdn.discordapp.com/attachments/1085523339608604756/1134545986467942511/Archetype_-_Castle_Crashers.wav", "Helix6 - Archetype")
    add("https://cdn.discordapp.com/attachments/1085523339608604756/1139105405780381737/ONTIVA.COM_Muzzy_-_Play_ft._UK_ID-320k_Filtered_Instrumental.mp3", "MUZZ - Play")
    add("https://cdn.discordapp.com/attachments/1085523339608604756/1139105867439026236/DaniwellP_-_Nyanyanyanyanyanyanya_Nyan_Cat_minus.mp3", "DaniwellP - Nyan Cat Instrumental (Extended Version)")
end

function ZS:Essentials()
    local frame = vgui.Create("DFrame")
end

function SM:Credits()
    local s = BetterScreenScale()
    if not LocalPlayer():IsSuperAdmin() then return end
    
    local frame = vgui.Create("DFrame")
    frame:SetSize(700 * s, 600 * s)
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(panel, w, h)
        surface.SetDrawColor(0, 0, 0, 180)
        surface.DrawRect(0, 0, w, h)
    
        surface.SetDrawColor(HSVToColor(( CurTime() * 100 ) % 360, 1, 1 ))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)

    local function Category(txt, col)
        local pnl = vgui.Create("DButton", scroll)
        pnl:SetTall(50 * s)
        pnl:Dock(TOP)
        pnl:DockMargin(0, 4 * s, 0, 0)
        pnl:SetCursor("arrow")
        pnl:SetEnabled(false)
        pnl:SetText(txt or "Undefined")
        pnl:SetFont("ZSHUDFont")
        pnl:SetTextColor(col and col or color_white)
        pnl.Paint = function() end
    end

    local function Credit(steamid, text, manual, hidebutton)
        local pnl = vgui.Create("DPanel", scroll)
        pnl:SetTall(50 * s)
        pnl:Dock(TOP)
        pnl:DockMargin(0, 4 * s, 0, 0)
        pnl:DockPadding(4 * s, 4 * s, 4 * s, 4 * s)
        pnl:InvalidateParent()
        pnl.Paint = function(panel, w, h)
            surface.SetDrawColor(0, 0, 0, 240)
            surface.DrawRect(0, 0, w, h)
        end

        local Avatar = vgui.Create( "AvatarImage", pnl )
        Avatar:SetSize( pnl:GetTall() - 8 * s, pnl:GetTall() )
        Avatar:Dock(LEFT)
        Avatar:SetSteamID(steamid or "0", pnl:GetTall() - 8 * s)

        if steamid and not hidebutton then
            local name3 = vgui.Create("DButton", pnl)
            name3:SetFont("ZSHUDFontTiny")
            name3:SetText("Steam Profile")
            name3:SizeToContents()
            name3:Dock(RIGHT)
            name3:DockMargin(4 * s, pnl:GetTall() - 24 * s, 0, 0)
            name3.Paint = function(panel, w, h) end
            name3.DoClick = function()
                gui.OpenURL("https://steamcommunity.com/profiles/"..steamid)
            end
        end

        local name = vgui.Create("DLabel", pnl)
        name:SetFont("ZSHUDFontSmallest")
        if manual then
            name:SetText(manual)
            name:SizeToContents()
        else
            steamworks.RequestPlayerInfo(steamid or "0", function(sname)
                name:SetText(sname)
                name:SizeToContents()
            end)
        end
        name:Dock(TOP)
        name:DockMargin(4 * s, 0, 0, 0)
        name:SetTextColor(Color(255, 255, 200))

        local name2 = vgui.Create("DLabel", pnl)
        name2:SetText(text or "No description provided")
        name2:SizeToContents()
        name2:Dock(TOP)
        name2:DockMargin(4 * s, 4 * s, 0, 0)
    end

    Category("Sigilmare Credits", COLOR_RED)

    Category("Staff Members")
    Credit("76561198171603670", "Owner")

    Category("Supporters")
    Credit("76561199383437034", "Purchased complete Custom Playermodel package")
    Credit("76561198954126987", "Thank you to our lovely Discord server boosters! <3", "Discord Server Boosters", true)

    Category("Contributors")
    Credit("76561198171603670", "Initial server development")
    Credit("76561198024593456", "Skill menu ovehaul, permission to use Sunrust assets")
    Credit("76561198173242654", "Juggernaut (hero) concept, roaster rock sounds", "HellsGamers Zombie Survival")
    Credit("76561198360395363", "D3bot overhaul, health HUD model, code contributions")
    Credit("76561198414685833", "D3bot navmeshes, code contributions")
    Credit("76561198813576981", "D3bot navmeshes")
    Credit("76561198009166019", "Weapon re-animations")
    Credit("76561198204846671", "Weapon re-animations")
    Credit(nil, "Help us find Troop's Profile! - Weapon re-animations")
    Credit("76561198237158014", "Weapon re-animations")
    Credit("76561199028844983", "SCK creations")
end