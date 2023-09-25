hook.Add("Think", "SMStoreThink", function()
	local pan = GAMEMODE.StoreInterface
	if pan and pan:IsValid() and pan:IsVisible() then
		local mx, my = input.GetCursorPos()
		local x, y = pan:GetPos()
		if mx < x or my < y or mx > x + pan:GetWide() or my > y + pan:GetTall() then
			pan:Close()
		end
	end
end)

function CreateCustomFonts()
    local screenscale = BetterScreenScale()

	surface.CreateFont("SMStoreGreet", {font = "Calibri", size = 36 * screenscale, weight = 1000, antialias = true})
    surface.CreateFont("SMStoreSmallGreet", {font = "Calibri", size = 24 * screenscale, weight = 1000, antialias = true})
    surface.CreateFont("SMStoreSmall", {font = "Calibri", size = 20 * screenscale, weight = 1000, antialias = true})
    surface.CreateFont("SMStoreSmaller", {font = "Calibri", size = 18 * screenscale, weight = 1000, antialias = true})
    surface.CreateFont("SMStoreSmallest", {font = "Calibri", size = 16 * screenscale, weight = 1000, antialias = true})
    surface.CreateFont("SMStoreTiny", {font = "Calibri", size = 22 * screenscale, weight = 1000, antialias = true})

    surface.CreateFont("DefaultFontLargeScale", {font = "tahoma", size = 16 * screenscale, weight = 0, antialias = false})
    surface.CreateFont("DefaultFontScale", {font = "tahoma", size = 13 * screenscale, weight = 500, antialias = false})
end

hook.Add("Initialize", "LoadCustomFonts", function()
    CreateCustomFonts()
end)

local function SleekPaint(panel, w, h)
    surface.SetDrawColor(30, 30, 40, 180)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(color_black)
    surface.DrawOutlinedRect(0, 0, w, h)
end

function SM:Store()
    if GAMEMODE.StoreInterface and GAMEMODE.StoreInterface:IsValid() then
		input.SetCursorPos(ScrW() / 2, ScrH() / 2)
		return
	end

    CreateCustomFonts()

    SM:UIOpen()
    input.SetCursorPos(ScrW() / 2, ScrH() / 2)

    local lp, s = LocalPlayer(), BetterScreenScale()

    local emergency = vgui.Create("DButton")
    emergency:SetSize(150, 32)
    emergency:SetText("Emergency Close")

    local frame = vgui.Create("DFrame")
    frame:SetSize(1200 * s, 800 * s)
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame:SetTitle("")
    frame:Center()
    frame:MakePopup()
    frame:SetBackgroundBlur(true)
    frame.Paint = SleekPaint

    frame.OnClose = function()
        SM:UIClose()
        if emergency then
            emergency:Remove()
        end
    end

    emergency:CenterHorizontal()
    emergency:MoveAbove(frame, 16)
    emergency.DoClick = function()
        emergency:Remove()
        frame:Close()
    end

    local pnlTop = vgui.Create("DPanel", frame)
    pnlTop:SetSize(frame:GetWide(), 44 * s)
    pnlTop.Paint = SleekPaint

    local time = os.time()
    local date = os.date("%I:%M %p - %x", time)

    local topText = vgui.Create("DLabel", pnlTop)
    topText:SetText(date)
    topText:SetFont("SMStoreSmallGreet")
    topText:SizeToContents()
    topText:AlignLeft(16 * s)
    topText:CenterVertical()

    local titleText = vgui.Create("DLabel", pnlTop)
    titleText:SetText("Sigilmare Store")
    titleText:SetTextColor(color_white)
    titleText:SetFont("SMStoreGreet")
    titleText:SizeToContents()
    titleText:Center()

    local policyButton = vgui.Create("DButton", pnlTop)
    policyButton:SetText("Store Policies")
    policyButton:SetTextColor(SIGILCOLOR_RED)
    policyButton:SetFont("SMStoreSmallGreet")
    policyButton:SizeToContents()
    policyButton:CenterVertical()
    policyButton:MoveLeftOf(titleText, 90 * s)
    policyButton.Paint = function(panel, w, h)
        surface.SetDrawColor(90, 0, 0, 180)
        surface.DrawRect(0, 0, w, h)
    
        surface.SetDrawColor(color_black)
        surface.DrawOutlinedRect(0, 0, w, h)
    end
    policyButton.DoClick = function()
        SM:Message("Before you continue...", [[
            Sigilmare Store Policies

            Before using the Sigilmare Store, you must agree to these policies.
            These policies exist to ensure you are using this system correctly.

            1. No refunds under any circumstance
            When you buy an item from the Sigilmare Store with in-real-life (IRL) currency you cannot
            receive a refund under any circumstance or if you have received a server ban.

            2. No abusing the system
            Do not abuse the system in any way with the intent of breaking it or ruining
            the server's currency. You will swiftly receive a permanent server ban if caught.

            3. Agree to our policy
            You must agree to our policy to use the Sigilmare Store.
            By clicking "OK", you agree to these policies.
        ]], "I agree to the Sigilmare Store Policy")
    end

    local aetherText = vgui.Create("DLabel", pnlTop)
    aetherText:SetText(LocalPlayer():GetNWInt("Aether").." Aether")
    aetherText:SetTextColor(SIGILCOLOR_AETHER)
    aetherText:SetFont("SMStoreGreet")
    aetherText:SizeToContents()
    aetherText:AlignRight(16 * s)
    aetherText:CenterVertical()

    local pnlCat = vgui.Create("DPanel", frame)
    pnlCat:SetSize(frame:GetWide(), 44 * s)
    pnlCat:MoveBelow(pnlTop, 4 * s)
    pnlCat.Paint = SleekPaint

    local storeCat = vgui.Create("DButton", pnlCat)
    storeCat:SetText("Store")
    storeCat:SetFont("SMStoreGreet")
    storeCat:SetTextColor(SIGILCOLOR_GREEN)
    storeCat:SetSize(128 * s, 36 * s)
    storeCat:SetPos(4 * s, 4 * s)
    storeCat.Paint = SleekPaint

    local casesCat = vgui.Create("DButton", pnlCat)
    casesCat:SetText("Cases")
    casesCat:SetFont("SMStoreGreet")
    casesCat:SetTextColor(SIGILCOLOR_CASES)
    casesCat:SetSize(128 * s, 36 * s)
    casesCat:SetPos(4 * s, 4 * s)
    casesCat:MoveRightOf(storeCat, 4 * s)
    casesCat.Paint = SleekPaint

    local storePnl = vgui.Create("DScrollPanel", frame)
    storePnl:SetSize(frame:GetWide() - 8 * s, 700 * s)
    storePnl:MoveBelow(pnlCat, 4 * s)
    storePnl:AlignLeft(4 * s)
    storePnl.Paint = SleekPaint

    local casesPnl = vgui.Create("DScrollPanel", frame)
    casesPnl:SetSize(frame:GetWide() - 8 * s, 700 * s)
    casesPnl:MoveBelow(pnlCat, 4 * s)
    casesPnl:AlignLeft(4 * s)
    casesPnl:SetVisible(false)
    casesPnl.Paint = SleekPaint

    CasesPanel(lp, s, casesPnl)

    -- Playermodel
    local playermodelPnl = vgui.Create("DPanel", storePnl)
    playermodelPnl:SetSize(300 * s, 450 * s)
    playermodelPnl:SetPos(4 * s, 4 * s)
    playermodelPnl.Paint = SleekPaint

    local plymdl_model = vgui.Create("DModelPanel", playermodelPnl)
    plymdl_model:SetSize(playermodelPnl:GetWide(), playermodelPnl:GetWide())
    plymdl_model:SetModel("models/player/group01/male_04.mdl")
    plymdl_model:SetFOV(35)
    local mins, maxs = plymdl_model:GetEntity():GetRenderBounds()
    plymdl_model:SetCamPos(mins:Distance(maxs) * Vector(1.15, 0.75, 0.5))
    plymdl_model:SetLookAt((mins + maxs) / 2)
    plymdl_model:SetCursor("arrow")
    local matMdl = Material("models/shiny")
    plymdl_model.Paint = function(self, w, h)
        if ( !IsValid( self.Entity ) ) then return end

        SleekPaint(self, w, h)

        local x, y = self:LocalToScreen( 0, 0 )
    
        self:LayoutEntity( self.Entity )
    
        local ang = self.aLookAngle
        if ( !ang ) then
            ang = ( self.vLookatPos - self.vCamPos ):Angle()
        end
    
        cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )
    
        render.SuppressEngineLighting( true )
        render.SetLightingOrigin( self.Entity:GetPos() )
        render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
        render.SetColorModulation( self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255 )
        render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) ) -- * surface.GetAlphaMultiplier()
        render.SetColorModulation(0, 0, 0)
        render.ModelMaterialOverride(matMdl)
    
        for i = 0, 6 do
            local col = self.DirectionalLight[ i ]
            if ( col ) then
                render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
            end
        end
    
        self:DrawModel()
    
        render.SuppressEngineLighting( false )
        render.SetColorModulation(1, 1, 1)
        render.ModelMaterialOverride()
        cam.End3D()
    
        self.LastPaint = RealTime()
    end
    local num = math.random(4)
    function plymdl_model:LayoutEntity(ent)
        ent:SetSequence(ent:LookupSequence("pose_standing_01"))
        plymdl_model:RunAnimation()
        ent:SetAngles(Angle(0, RealTime()*50,  0))
        ent:SetMaterial(ent:GetMaterial())
        ent:SetColor(Color(0, 0, 0))
    end

    local pmTitle = vgui.Create("DLabel", playermodelPnl)
    pmTitle:SetText("Custom Playermodel")
    pmTitle:SetTextColor(SIGILCOLOR_YELLOW)
    pmTitle:SetFont("SMStoreGreet")
    pmTitle:SizeToContents()
    pmTitle:MoveBelow(plymdl_model, 2 * s)
    pmTitle:CenterHorizontal()

    local pmDesc = vgui.Create("DLabel", playermodelPnl)
    pmDesc:SetText("£10 - Base Model")
    pmDesc:SetFont("SMStoreSmallGreet")
    pmDesc:SizeToContents()
    pmDesc:MoveBelow(pmTitle, 2 * s)
    pmDesc:AlignLeft(16 * s)

    local pmDesc2 = vgui.Create("DLabel", playermodelPnl)
    pmDesc2:SetText("+ £2.5 - View Model Hands")
    pmDesc2:SetFont("SMStoreSmallGreet")
    pmDesc2:SizeToContents()
    pmDesc2:MoveBelow(pmDesc, 2 * s)
    pmDesc2:AlignLeft(16 * s)

    local pmDesc3 = vgui.Create("DLabel", playermodelPnl)
    pmDesc3:SetText("+ £2.5 - Voice Sets")
    pmDesc3:SetFont("SMStoreSmallGreet")
    pmDesc3:SizeToContents()
    pmDesc3:MoveBelow(pmDesc2, 2 * s)
    pmDesc3:AlignLeft(16 * s)

    local pmBuy = vgui.Create("DButton", playermodelPnl)
    pmBuy:SetText("Purchase")
    pmBuy:SetTextColor(Color(50, 150, 50))
    pmBuy:SetFont("SMStoreSmallGreet")
    pmBuy:SetSize(playermodelPnl:GetWide(), 26 * s)
    pmBuy:CenterHorizontal()
    pmBuy:AlignBottom()
    pmBuy.Paint = SleekPaint
    pmBuy.DoClick = function()
        SM:Message(nil, "You need to contact @sigilmare on Discord for custom playermodels.")
    end

    storeCat.DoClick = function()
        storePnl:SetVisible(true)
        casesPnl:SetVisible(false)
        MySelf:EmitSound("garrysmod/ui_return.wav", 100, 100, 1, CHAN_STATIC)
    end

    casesCat.DoClick = function()
        storePnl:SetVisible(false)
        casesPnl:SetVisible(true)
        MySelf:EmitSound("garrysmod/ui_return.wav", 100, 100, 1, CHAN_STATIC)
    end

    GAMEMODE.StoreInterface = frame
end

function CasesPanel(lp, s, parent)
    local modelpnl = vgui.Create("DPanel", parent)
    modelpnl:SetSize(300 * s, 500 * s)
    modelpnl:SetPos(4 * s, 4 * s)
    modelpnl.Paint = SleekPaint

    local entity

    local plymdl_model = vgui.Create("DModelPanel", modelpnl)
    plymdl_model:SetSize(modelpnl:GetWide(), modelpnl:GetWide())
    plymdl_model:SetModel("models/Items/ammocrate_ar2.mdl")
    plymdl_model:SetFOV(50)
    local mins, maxs = plymdl_model:GetEntity():GetRenderBounds()
    plymdl_model:SetCamPos(mins:Distance(maxs) * Vector(1.15, 0.75, 0.5))
    plymdl_model:SetLookAt((mins + maxs) / 2)
    plymdl_model:SetCursor("arrow")
    plymdl_model.Paint = function(self, w, h)
        if ( !IsValid( self.Entity ) ) then return end

        SleekPaint(self, w, h)

        local x, y = self:LocalToScreen( 0, 0 )
    
        self:LayoutEntity( self.Entity )
    
        local ang = self.aLookAngle
        if ( !ang ) then
            ang = ( self.vLookatPos - self.vCamPos ):Angle()
        end
    
        cam.Start3D( self.vCamPos, ang, self.fFOV, x, y, w, h, 5, self.FarZ )
    
        render.SuppressEngineLighting( true )
        render.SetLightingOrigin( self.Entity:GetPos() )
        render.ResetModelLighting( self.colAmbientLight.r / 255, self.colAmbientLight.g / 255, self.colAmbientLight.b / 255 )
        render.SetColorModulation( self.colColor.r / 255, self.colColor.g / 255, self.colColor.b / 255 )
        render.SetBlend( ( self:GetAlpha() / 255 ) * ( self.colColor.a / 255 ) ) -- * surface.GetAlphaMultiplier()
    
        for i = 0, 6 do
            local col = self.DirectionalLight[ i ]
            if ( col ) then
                render.SetModelLighting( i, col.r / 255, col.g / 255, col.b / 255 )
            end
        end
    
        self:DrawModel()
    
        render.SuppressEngineLighting( false )
        cam.End3D()
    
        self.LastPaint = RealTime()
    end
    function plymdl_model:LayoutEntity(self)
        entity = self
    end

    local pmTitle = vgui.Create("DLabel", modelpnl)
    pmTitle:SetText("Experience Case")
    pmTitle:SetTextColor(SIGILCOLOR_CASES)
    pmTitle:SetFont("SMStoreGreet")
    pmTitle:SizeToContents()
    pmTitle:MoveBelow(plymdl_model, 2 * s)
    pmTitle:CenterHorizontal()

    local cmn = vgui.Create("DLabel", modelpnl)
    cmn:SetText("Common                         50%")
    cmn:SetFont("SMStoreTiny")
    cmn:SetTextColor(SIGILCOLOR_COMMON)
    cmn:SizeToContents()
    cmn:MoveBelow(pmTitle)
    cmn:AlignLeft(16 * s)

    local uncmn = vgui.Create("DLabel", modelpnl)
    uncmn:SetText("Uncommon                    34%")
    uncmn:SetFont("SMStoreTiny")
    uncmn:SetTextColor(SIGILCOLOR_UNCOMMON)
    uncmn:SizeToContents()
    uncmn:MoveBelow(cmn)
    uncmn:AlignLeft(16 * s)

    local rr = vgui.Create("DLabel", modelpnl)
    rr:SetText("Rare                                  12%")
    rr:SetFont("SMStoreTiny")
    rr:SetTextColor(SIGILCOLOR_RARE)
    rr:SizeToContents()
    rr:MoveBelow(uncmn)
    rr:AlignLeft(16 * s)

    local epc = vgui.Create("DLabel", modelpnl)
    epc:SetText("Epic                                   2.5%")
    epc:SetFont("SMStoreTiny")
    epc:SetTextColor(SIGILCOLOR_EPIC)
    epc:SizeToContents()
    epc:MoveBelow(rr)
    epc:AlignLeft(16 * s)

    local lgndry = vgui.Create("DLabel", modelpnl)
    lgndry:SetText("Legendary                       1%")
    lgndry:SetFont("SMStoreTiny")
    lgndry:SetTextColor(SIGILCOLOR_LEGENDARY)
    lgndry:SizeToContents()
    lgndry:MoveBelow(epc)
    lgndry:AlignLeft(16 * s)

    local extc = vgui.Create("DLabel", modelpnl)
    extc:SetText("Exotic                                0.5%")
    extc:SetFont("SMStoreTiny")
    extc:SetTextColor(SIGILCOLOR_EXOTIC)
    extc:SizeToContents()
    extc:MoveBelow(lgndry)
    extc:AlignLeft(16 * s)

    local nextbuy = CurTime()

    local pmBuy = vgui.Create("DButton", modelpnl)
    if lp:GetNWInt("Aether") < 150 then
        pmBuy:SetText("Not enough Aether!")
        pmBuy:SetTextColor(Color(150, 50, 50))
        pmBuy:SetEnabled(false)
    else
        pmBuy:SetText("Purchase - A$150")
        pmBuy:SetTextColor(Color(50, 150, 50))
    end
    pmBuy:SetFont("SMStoreSmallGreet")
    pmBuy:SetSize(modelpnl:GetWide(), 26 * s)
    pmBuy:CenterHorizontal()
    pmBuy:AlignBottom()
    pmBuy.Paint = SleekPaint
    pmBuy.DoClick = function()
        if CurTime() < nextbuy or not lp:IsSuperAdmin() then return end

        entity:ResetSequence("close")
        surface.PlaySound("items/ammocrate_open.wav")

        timer.Simple(0.5, function()
            net.Start("Store.BuyEXPCase")
                net.WriteEntity(LocalPlayer())
            net.SendToServer()

            timer.Simple(0.5, function()
                if not IsValid(modelpnl) then return end

                entity:ResetSequence("open")
                surface.PlaySound("items/ammocrate_close.wav")
            end)
        end)

        nextbuy = CurTime() + 1.5
    end
end

-- Resupply Cache text, XP multiplier & Discord text
hook.Add("HUDPaint", "AetherInfo", function()
    if GAMEMODE_NAME != "zombiesurvival" then return end
    local s = BetterScreenScale()
    local self = LocalPlayer()
    local time = os.time()
    local date = os.date("%I:%M:%S %p", time)

    local h = 300

    draw.RoundedBox(0, 5 * s, 300 * s, 115 * s, 250 * s, color_black_alpha180)
    draw.SimpleText("SM ZS Account", "DefaultFontLargeScale", 10 * s, h * s, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    h = h + 16
    draw.SimpleText("Aether: "..self:GetNWInt("Aether"), "DefaultFontScale", 10 * s, h * s, SIGILCOLOR_AETHER, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    h = h + 12
    draw.SimpleText("Rank: "..(SM.UserGroups[self:GetUserGroup()] and SM.UserGroups[self:GetUserGroup()][1] or "Undefined"), "DefaultFontScale", 10 * s, h * s, (SM.UserGroups[self:GetUserGroup()] and SM.UserGroups[self:GetUserGroup()][2] or color_white), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    h = h + 24
    draw.SimpleText("Punishments", "DefaultFontLargeScale", 10 * s, h * s, SIGILCOLOR_RED, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    if not self:IsChatMuted() and not self:IsVoiceMuted() and not self:IsAegisBanned() and not self:IsHammerBanned() and not self:IsNestBanned() and not self:IsPickupBanned() and not self:IsSprayBanned() and not self:IsZombieBanned() then
        h = h + 16
        draw.SimpleText("None, you're clean!", "DefaultFontScale", 10 * s, h * s, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    else
        if self:GetPunishments() > 0 then
            h = h + 4
        end
        if self:IsChatMuted() then
            h = h + 12
            draw.SimpleText("Chat Muted", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
        if self:IsVoiceMuted() then
            h = h + 12
            draw.SimpleText("Voice Muted", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
        if self:IsAegisBanned() then
            h = h + 12
            draw.SimpleText("Aegis Banned", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
        if self:IsHammerBanned() then
            h = h + 12
            draw.SimpleText("Hammer Banned", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
        if self:IsNestBanned() then
            h = h + 12
            draw.SimpleText("Nest Banned", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
        if self:IsPickupBanned() then
            h = h + 12
            draw.SimpleText("Pickup Banned", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
        if self:IsSprayBanned() then
            h = h + 12
            draw.SimpleText("Spray Banned", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
        if self:IsZombieBanned() then
            h = h + 12
            draw.SimpleText("Zombie Banned", "DefaultFontScale", 10 * s, h * s, COLOR_GRAY, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        end
    end

    draw.SimpleText(date, "DefaultFontLargeScale", 10 * s, 548 * s, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
end)