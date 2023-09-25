local PANEL = {}

function PANEL:Init()
	self:SetSize( 400, 74 )
	self:DockPadding( 5, 5, 5, 5 )

	self.Avatar = vgui.Create( "AvatarImage", self )
	self.Avatar:Dock( LEFT )
	self.Avatar:DockMargin( 0, 0, 5, 0 )
	self.Avatar:SetSize( 64, 64 )

	self.KilledBy = vgui.Create( "DLabel", self )
	self.KilledBy:Dock( TOP )
	self.KilledBy:SetText( "You were killed by" )
	self.KilledBy:SetFont("ZSHUDFontSmallest")
	self.KilledBy:SetColor( color_white )

	self.Name = vgui.Create( "DLabel", self )
	self.Name:Dock( FILL )
	self.Name:SetFont( "ZSHUDFontSmall" )
	self.Name:SetText( "" )
	self.Name:SetColor( color_white )

	self.Weapon = vgui.Create( "DLabel", self )
	self.Weapon:Dock( BOTTOM )
	self.Weapon:SetText( "..." )
	self.Weapon:SetColor( Color(255, 255, 0) )
	self.Weapon:SetFont("ZSHUDFontSmallest")
end

function PANEL:SetPlayer( pl )
	self.Avatar:SetPlayer( pl, 64 )
	self.Name:SetText( pl:Name() )
	self.Name:SetColor( team.GetColor( pl:Team() ) )
end

function PANEL:SetWeapon( wep )
	if not IsValid( wep ) then return end

	if inventory and wep:GetNWBool( "InventoryWeapon" ) then
		local name = wep:GetNWString( "WeaponName" )
		local quality = wep:GetNWInt( "WeaponQuality" )

		if quality > 1 then
			name = inventory.GetQualityName( quality ) .. " " .. name
		end

		self.Weapon:SetText( name )
		self.Weapon:SetColor( inventory.GetQualityColor( quality ) )
	else
		self.Weapon:SetText( wep.PrintName or language.GetPhrase( wep:GetClass() ) )
	end
end

function PANEL:Paint( w, h )
	draw.RoundedBox( 4, 0, 0, w, h, Color( 0, 0, 0, 180 ) )
end

vgui.Register( "KillNotification", PANEL )