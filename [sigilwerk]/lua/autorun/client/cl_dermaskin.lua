local function SleekPaint(panel, w, h)
    surface.SetDrawColor(30, 30, 40, 180)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(color_black)
    surface.DrawOutlinedRect(0, 0, w, h)
end

function SM:UIOpen()
    MySelf:EmitSound("buttons/button24.wav", 100, 200, 1, CHAN_STATIC)
end

function SM:UIClose()
    MySelf:EmitSound("buttons/button24.wav", 100, 180, 1, CHAN_STATIC)
end

function SM:Message(strTitle, strText, strButtonText)
    SM:UIOpen()

	local Window = vgui.Create( "DFrame" )
	Window:SetTitle( strTitle or "" )
	Window:SetDraggable( false )
	Window:ShowCloseButton( false )
	Window:SetBackgroundBlur( true )
	Window:SetDrawOnTop( true )
    Window.Paint = function(panel, w, h)
        Derma_DrawBackgroundBlur(panel)
		surface.SetDrawColor(30, 30, 40, 180)
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(color_black)
		surface.DrawOutlinedRect(0, 0, w, h)
    end

	local InnerPanel = vgui.Create( "Panel", Window )

	local Text = vgui.Create( "DLabel", InnerPanel )
	Text:SetText( strText or "" )
	Text:SizeToContents()
	Text:SetContentAlignment( 5 )
	Text:SetTextColor( color_white )

	local ButtonPanel = vgui.Create( "DPanel", Window )
	ButtonPanel:SetTall( 30 )
	ButtonPanel:SetPaintBackground( false )

	local Button = vgui.Create( "DButton", ButtonPanel )
	Button:SetText( strButtonText or "OK" )
	Button:SizeToContents()
	Button:SetTall( 20 )
	Button:SetWide( Button:GetWide() + 20 )
	Button:SetPos( 5, 5 )
	Button.DoClick = function() Window:Close() SM:UIClose() end
    Button.Paint = SleekPaint

	ButtonPanel:SetWide( Button:GetWide() + 10 )

	local w, h = Text:GetSize()

	Window:SetSize( w + 50, h + 25 + 45 + 10 )
	Window:Center()

	InnerPanel:StretchToParent( 5, 25, 5, 45 )

	Text:StretchToParent( 5, 5, 5, 5 )

	ButtonPanel:CenterHorizontal()
	ButtonPanel:AlignBottom( 8 )

	Window:MakePopup()
	Window:DoModal()
	return Window

end