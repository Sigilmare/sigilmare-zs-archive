include( "vgui/KillNotification.lua" )

net.Receive( "KillNotification", function()
	local pl = net.ReadEntity()
	local wep = net.ReadEntity()

	if not IsValid( pl ) then return end

	local p = vgui.Create( "KillNotification" )
	p:SetPos( ScrW() / 2 - p:GetWide() / 2, ScrH() )	
	p:SetPlayer( pl )
	p:SetWeapon( wep )

	local x, y = p:GetPos()
	p:MoveTo( x, y - p:GetTall() - 225, 0.25 )

	timer.Simple( 3, function()
		p:MoveTo( x, y, 0.25, 0, -1, function()
			p:Remove()
		end )
	end )
end )