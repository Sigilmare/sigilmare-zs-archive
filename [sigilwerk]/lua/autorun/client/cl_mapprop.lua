function SWEPPropInput(ent)
    surface.PlaySound("nightrally/ui/buttons/open.ogg")

    local wide, tall = math.min(ScrW(), 300), math.min(ScrH(), 150)
    local frame = vgui.Create("DFrame")
    frame:SetSize(wide, tall)
    frame:SetTitle("")
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(panel, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 180))
    end
    frame.OnClose = function()
        surface.PlaySound("nightrally/ui/buttons/close.ogg")
    end

    local y = 32
    local label = vgui.Create("DLabel", frame)
    label:SetText("Map Profile SWEPs")
    label:SetFont("GModNotify")
    label:SetColor(Color(255, 255, 255))
    label:SizeToContents()
	label:SetPos(wide * 0.5 - label:GetWide() * 0.5, y)
	y = y + label:GetTall() + 8

	local list = vgui.Create("DPanelList", frame)
	list:EnableVerticalScrollbar()
	list:EnableHorizontal(false)
	list:SetSize(wide - 24, tall - y - 12)
	list:SetPos(12, y)
	list:SetPadding(8)
	list:SetSpacing(4)

    local check = vgui.Create("DCheckBoxLabel", frame)
	check:SetText("Include weapon ammo")
	check:SizeToContents()
    list:AddItem(check)

    local check2 = vgui.Create("DCheckBoxLabel", frame)
	check2:SetText("Ignore use")
	check2:SizeToContents()
    list:AddItem(check2)
    
    local txt = vgui.Create("DTextEntry", frame)
    txt:SetPlaceholderText("Input SWEP classname")
    txt:SetTextColor(Color(255, 255, 255))
    txt:SizeToContents()
    txt.Paint = function(panel, w, h)
        if ( panel.m_bBackground ) then
            if ( panel:HasFocus() ) then
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
            else
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 180))
            end
        end
        -- Hack on a hack, but this produces the most close appearance to what it will actually look if text was actually there
        if ( panel.GetPlaceholderText && panel.GetPlaceholderColor && panel:GetPlaceholderText() && panel:GetPlaceholderText():Trim() != "" && panel:GetPlaceholderColor() && ( !panel:GetText() || panel:GetText() == "" ) ) then
            local oldText = panel:GetText()
            local str = panel:GetPlaceholderText()
            if ( str:StartWith( "#" ) ) then str = str:sub( 2 ) end
            str = language.GetPhrase( str )
            panel:SetText( str )
            panel:DrawTextEntryText( panel:GetPlaceholderColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
            panel:SetText( oldText )
            return
        end
        panel:DrawTextEntryText( panel:GetTextColor(), panel:GetHighlightColor(), panel:GetCursorColor() )
    end
    txt.OnEnter = function(panel, text)
        SetClipboardText("local ent = ents.Create( \"prop_weapon\" )\nent:SetWeaponType( \""..text.."\" )\n"..(check2:GetChecked() and "ent:SetKeyValue(\"ignoreuse\", \"1\")\n" or "")..(check:GetChecked() and "ent:SetShouldRemoveAmmo(false)\n" or "").."ent:SetPos( Vector("..tostring( math.Round(ent:GetPos().x, 2)..", "..math.Round(ent:GetPos().y, 2)..", "..math.Round(ent:GetPos().z, 2) )..") )\nent:SetAngles( Angle("..tostring( math.Round(ent:GetAngles().x, 2)..", "..math.Round(ent:GetAngles().y, 2)..", "..math.Round(ent:GetAngles().z, 2) )..") )\nent:Spawn()")
        frame:Close()
        chat.AddText(Color(20, 255, 20), "Copied SWEP prop code to clipboard! "..tostring(ent).." "..text)
    end
    list:AddItem(txt)
end

net.Receive("nZSPhysProp", function()
    local ent = net.ReadEntity()

    if ent:IsValid() then
        SetClipboardText("local ent = ents.Create( \"prop_physics\" )\nent:SetModel( \""..ent:GetModel().."\" )\n"..(ent:GetMaterial() ~= "" and "ent:SetMaterial( \""..ent:GetMaterial().."\" )\n" or "").."ent:SetPos( Vector("..tostring( math.Round(ent:GetPos().x, 2)..", "..math.Round(ent:GetPos().y, 2)..", "..math.Round(ent:GetPos().z, 2) )..") )\nent:SetAngles( Angle("..tostring( math.Round(ent:GetAngles().x, 2)..", "..math.Round(ent:GetAngles().y, 2)..", "..math.Round(ent:GetAngles().z, 2) )..") )\nent:Spawn()")
        chat.AddText(Color(20, 255, 20), "Copied physics prop code to clipboard! "..tostring(ent).." "..ent:GetModel())
    else
        chat.AddText(Color(255, 20, 20), "Please look at a valid physics prop.")
        SetClipboardText(" ")
    end
end)

net.Receive("nZSSWEPProp", function()
    local ent = net.ReadEntity()

    if ent:IsValid() then
        SWEPPropInput(ent)
    else
        chat.AddText(Color(255, 20, 20), "Please look at a valid physics prop.")
        SetClipboardText(" ")
    end
end)

net.Receive("nZSBlackholeNode", function()
    local ply = net.ReadEntity()

    SetClipboardText("[\""..game.GetMap().."\"] = Vector("..tostring( math.floor(ply:GetPos().x + ply:GetCurrentViewOffset().x)..", "..math.floor(ply:GetPos().y + ply:GetCurrentViewOffset().y)..", "..math.floor(ply:GetPos().z + ply:GetCurrentViewOffset().z) ).."),")
    chat.AddText(Color(20, 255, 20), "Copied blackhole node code to clipboard!")
end)

net.Receive("nZSSigilNode", function()
    local ent = net.ReadEntity()

    SetClipboardText("Vector("..tostring(ent:GetPos().x..", "..ent:GetPos().y..", "..ent:GetPos().z).."),\n")
    chat.AddText(Color(20, 255, 20), "Copied sigil node code to clipboard!")
end)