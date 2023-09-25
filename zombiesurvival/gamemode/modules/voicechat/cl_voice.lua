--Based off Casual Bananas's Jail Break Voice Derma https://github.com/kurt-stolle/jailbreak/blob/master/gamemode/core/cl_voice.lua
--All modifications and updates by https://github.com/Mka0207/

-- Taken from wetmore's ZS github repo

surface.CreateFont("VoiceChatName", {
	font = "Open Sans", 
	extended = false,
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true
})
surface.CreateFont("VoiceChatRank", {
	font = "Open Sans", 
	extended = false,
	size = 16,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = false,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = true,
	additive = false,
	outline = true
})

local PANEL = {}
local PlayerVoicePanels = {}

local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local surface_DrawTexturedRect = surface.DrawTexturedRect
local draw_RoundedBox = draw.RoundedBox
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local team_GetColor = team.GetColor
local surface_GetTextSize = surface.GetTextSize
local string_lower = string.lower

function PANEL:Init()
	--Players name
	self.LabelName = vgui.Create( "DLabel", self )
	self.LabelName:SetFont( "VoiceChatName" )
	self.LabelName:Dock( FILL )
	self.LabelName:DockMargin( 5, 0, 0, 12 )
	self.LabelName:SetTextColor( Color( 255, 255, 255, 255 ) )
	-- self.LabelName.Paint = function(self,w,h)
		-- draw.SimpleTextBlurry(self:GetParent().ply:Nick(), "VoiceChatName", 0, 0, COLOR_WHITE, TEXT_ALIGN_LEFT)
	-- end
	
	--Players rank
	self.RankTitle = vgui.Create( "DLabel", self )
	self.RankTitle:SetFont( "VoiceChatRank" )
	self.RankTitle:Dock( FILL )
	self.RankTitle:DockMargin( 5, 0, 0, -20 )
	self.RankTitle:SetTextColor( Color( 255, 255, 255, 255 ) )

	--Players avatar
	self.Avatar = vgui.Create( "AvatarImage", self )
	self.Avatar:Dock( LEFT )
	self.Avatar:SetSize( 32, 32 )

	self.Color = color_transparent
	self.TitleCard = nil

	self:SetSize( 250, 32 + 8 )
	self:DockPadding( 2, 2, 2, 2 )
	self:DockMargin( 0, 2, 0, 2 )
	self:Dock( TOP )
end

function PANEL:Setup( ply )
	self.ply = ply
	self.LabelName:SetText( ply:Nick() )

	--Prevent incognito staff from being looked at.
	local incog = ply:GetNWBool( 'Admin_Incognito', false )
	if incog != true then
		self.Avatar:SetPlayer(ply)
		
		--Set rank label
		if ply.HasChatTag and ply:HasChatTag() then
			local Col = ply:GetChatTagColor()
			self.RankTitle:SetText( ply:GetChatTag() )
			self.RankTitle:SetTextColor( Col )
		else
			local DTag = SM.UserGroups[ string_lower( ply:GetUserGroup() ) ]
			if DTag then
				self.RankTitle:SetText( DTag[1]	)
				self.RankTitle:SetTextColor( DTag[2] )
			else
				self.RankTitle:SetText( "" )
			end
		end
		
		if ply.HasTitleCard and ply:HasTitleCard() then
			self.TitleCard = Material( ply:GetTitleCard() )
		end
	else
		self.Avatar:SetSteamID( ply:GetNWString('Profile'), 32 )
		self.RankTitle:SetText( "" )
	end
	
	self.Color = team_GetColor( ply:Team() )
	
	self:InvalidateLayout()
end

PANEL.lastw = 0
PANEL.lastName = ""

function PANEL:Paint( w, h )
	if ( !IsValid( self.ply ) ) then return end

	local cw = w
	w = self.lastw
	
	draw_RoundedBox( 0, 0, 0, 250, h, Color(50, 50, 50, 200 + self.ply:VoiceVolume() * 255 ) )
	if self.ply.HasTitleCard and self.ply:HasTitleCard() and self.TitleCard ~= nil then
		surface_SetDrawColor( 255, 255, 255, 255 )
		surface_SetMaterial( self.TitleCard )
		surface_DrawTexturedRect( 36, 0, 215, 40 )
	else
		local incog = self.ply:GetNWBool( 'Admin_Incognito', false )
		if incog != true then
			local DTag = SM.UserGroups[ string_lower( self.ply:GetUserGroup() ) ]
			surface_SetDrawColor( self.ply.HasChatTag and self.ply:HasChatTag() and self.ply:GetChatTagColor() or DTag and DTag[2] or self.ply:Alive() and team_GetColor( self.ply:Team() ) or team_GetColor(TEAM_SPECTATOR) )
		else
			surface_SetDrawColor( SM.UserGroups["user"][2] )
		end
		surface_DrawOutlinedRect( 36, h-2, 250, 2, 2 )
	end
	draw_RoundedBox( 0, 0, 0, 32 + 2 + 2, h, self.ply:Alive() and team_GetColor( self.ply:Team() ) or team_GetColor(TEAM_SPECTATOR) )
	
	--Stack our multiple voice panels
	if self.lastw != cw then
		local nick = self.ply:Nick()

		surface.SetFont( "GModNotify" )
		local w2, h2 = surface_GetTextSize( nick )
		w2 = w2 + 48
		self:SetSize( w2, h )
		self.lastw = w2

		if self.lastName != nick then
			self.LabelName:SetText( nick )
			self.lastName = nick
		end
	end
end

function PANEL:Think( )
	if ( self.fadeAnim ) then
		self.fadeAnim:Run()
	end
end

function PANEL:FadeOut( anim, delta, data )
	if ( anim.Finished ) then
	
		if ( IsValid( PlayerVoicePanels[ self.ply ] ) ) then
			PlayerVoicePanels[ self.ply ]:Remove()
			PlayerVoicePanels[ self.ply ] = nil
			return
		end
		
	return end
			
	self:SetAlpha( 255 - (255 * delta) )
end
derma.DefineControl( "VoiceNotify2", "", PANEL, "DPanel" )

--

function GM:PlayerStartVoice( ply )
	if ( !IsValid( g_VoicePanelList ) ) then return end
	
	-- There'd be an exta one if voice_loopback is on, so remove it.
	GAMEMODE:PlayerEndVoice( ply )

	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then

		if ( PlayerVoicePanels[ ply ].fadeAnim ) then
			PlayerVoicePanels[ ply ].fadeAnim:Stop()
			PlayerVoicePanels[ ply ].fadeAnim = nil
		end

		PlayerVoicePanels[ ply ]:SetAlpha( 255 )

		return;

	end

	if ( !IsValid( ply ) ) then return end

	local pnl = g_VoicePanelList:Add( "VoiceNotify2" )
	pnl:Setup( ply )
	
	PlayerVoicePanels[ ply ] = pnl
end

local function VoiceClean()
	for k, v in pairs( PlayerVoicePanels ) do
		if ( !IsValid( k ) ) then
			GAMEMODE:PlayerEndVoice( k )
		end
	end
end
timer.Create( "VoiceClean", 10, 0, VoiceClean )

function GM:PlayerEndVoice( ply )
	if ( IsValid( PlayerVoicePanels[ ply ] ) ) then
		if ( PlayerVoicePanels[ ply ].fadeAnim ) then return end

		PlayerVoicePanels[ ply ].fadeAnim = Derma_Anim( "FadeOut", PlayerVoicePanels[ ply ], PlayerVoicePanels[ ply ].FadeOut )
		PlayerVoicePanels[ ply ].fadeAnim:Start( 0.5 )
	end
end

local function CreateVoiceVGUI()
	local w, h = ScrW(), ScrH()
	
	g_VoicePanelList = vgui.Create( "DPanel" )
	g_VoicePanelList:ParentToHUD()
	g_VoicePanelList:SetPos( w-250, ScrH()/2 )
	g_VoicePanelList:SetSize( 250, ScrH()/2 )
	g_VoicePanelList:SetDrawBackground( false )
end

if IsValid( g_VoicePanelList ) then -- caused by autorefresh.
	g_VoicePanelList:Remove()
	CreateVoiceVGUI()
end

hook.Add( "InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI )