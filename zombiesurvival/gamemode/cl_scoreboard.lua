local ScoreBoard

function GM:ScoreboardShow()
	gui.EnableScreenClicker(true)
	PlayMenuOpenSound()

	if not ScoreBoard then
		ScoreBoard = vgui.Create("ZSScoreBoard")
	end

	local screenscale = BetterScreenScale()

	ScoreBoard:SetSize(math.min(1200, ScrW() * 0.65) * math.max(1, screenscale), ScrH() * 0.85)
	ScoreBoard:Center()
	ScoreBoard:SetVisible(true)
end

function GM:ScoreboardRebuild()
	self:ScoreboardHide()
	ScoreBoard = nil
end

function GM:ScoreboardHide()
	gui.EnableScreenClicker(false)

	if ScoreBoard then
		PlayMenuCloseSound()
		ScoreBoard:SetVisible(false)
	end
end

local PANEL = {}

PANEL.RefreshTime = 1
PANEL.NextRefresh = 0
PANEL.m_MaximumScroll = 0

local function BlurPaint(self)
	draw.SimpleTextBlurry(self:GetValue(), self.Font, 0, 0, self:GetTextColor())

	return true
end

function PANEL:Init()
	self.NextRefresh = RealTime() + 0.1

	self.m_ServerNameLabel = vgui.Create("DLabel", self)
	self.m_ServerNameLabel.Font = "ZSHUDFont"
	self.m_ServerNameLabel:SetFont(self.m_ServerNameLabel.Font)
	self.m_ServerNameLabel:SetText("Sigilmare | discord.gg/sigilmare")
	self.m_ServerNameLabel:SetTextColor(SIGILCOLOR_RED)
	self.m_ServerNameLabel:SizeToContents()
	self.m_ServerNameLabel:NoClipping(true)

	self.m_ServerNameLabel2 = vgui.Create("DLabel", self)
	self.m_ServerNameLabel2.Font = "ZSHUDFontSmall"
	self.m_ServerNameLabel2:SetFont(self.m_ServerNameLabel2.Font)
	self.m_ServerNameLabel2:SetText(game.GetMap().." - "..util.ToMinutesSecondsCD(CurTime()))
	self.m_ServerNameLabel2:SetTextColor(COLOR_GRAY)
	self.m_ServerNameLabel2:SizeToContents()
	self.m_ServerNameLabel2:NoClipping(true)

	self.m_HumanHeading = vgui.Create("DTeamHeading", self)
	self.m_HumanHeading:SetTeam(TEAM_HUMAN)

	self.m_ZombieHeading = vgui.Create("DTeamHeading", self)
	self.m_ZombieHeading:SetTeam(TEAM_UNDEAD)

	self.ZombieList = vgui.Create("DScrollPanel", self)
	self.ZombieList.Team = TEAM_UNDEAD

	self.HumanList = vgui.Create("DScrollPanel", self)
	self.HumanList.Team = TEAM_HUMAN

	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	local screenscale = math.max(0.95, BetterScreenScale())

	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.5 - self.m_ServerNameLabel:GetWide() * 0.5), 12)

	self.m_ServerNameLabel2:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel2:GetWide(), self:GetWide() * 0.5 - self.m_ServerNameLabel2:GetWide() * 0.5), 32 - self.m_ServerNameLabel2:GetTall() / 2)
	self.m_ServerNameLabel2:MoveAbove(self.m_HumanHeading, 12)

	self.m_HumanHeading:SetSize(self:GetWide() / 2 - 32, 28 * screenscale)
	self.m_HumanHeading:SetPos(self:GetWide() * 0.25 - self.m_HumanHeading:GetWide() * 0.5, 130 * screenscale - self.m_HumanHeading:GetTall())

	self.m_ZombieHeading:SetSize(self:GetWide() / 2 - 32, 28 * screenscale)
	self.m_ZombieHeading:SetPos(self:GetWide() * 0.75 - self.m_ZombieHeading:GetWide() * 0.5, 130 * screenscale - self.m_ZombieHeading:GetTall())

	self.HumanList:SetSize(self:GetWide() / 2 - 24, self:GetTall() - 150 * screenscale)
	self.HumanList:AlignBottom(16 * screenscale)
	self.HumanList:AlignLeft(8 * screenscale)

	self.ZombieList:SetSize(self:GetWide() / 2 - 24, self:GetTall() - 150 * screenscale)
	self.ZombieList:AlignBottom(16 * screenscale)
	self.ZombieList:AlignRight(16 * screenscale)
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:RefreshScoreboard()
	end
end

local texRightEdge = surface.GetTextureID("gui/gradient")
local texCorner = surface.GetTextureID("zombiesurvival/circlegradient")
local texDownEdge = surface.GetTextureID("gui/gradient_down")
function PANEL:Paint()
	local wid, hei = self:GetSize()
	local barw = 64

	surface.SetDrawColor(0, 0, 0, 180)
	surface.DrawRect(0, 0, wid, hei)

	surface.SetDrawColor(0, 0, 0)
	surface.DrawOutlinedRect(0, 0, wid, hei)
end

function PANEL:GetPlayerPanel(pl)
	for _, panel in pairs(self.PlayerPanels) do
		if panel:IsValid() and panel:GetPlayer() == pl then
			return panel
		end
	end
end

function PANEL:CreatePlayerPanel(pl)
	local curpan = self:GetPlayerPanel(pl)
	if curpan and curpan:IsValid() then return curpan end

	if pl:Team() == TEAM_SPECTATOR then return end

	local panel = vgui.Create("ZSPlayerPanel", pl:Team() == TEAM_UNDEAD and self.ZombieList or self.HumanList)
	panel:SetPlayer(pl)
	panel:Dock(TOP)
	panel:DockMargin(8, 2, 8, 2)

	self.PlayerPanels[pl] = panel

	return panel
end

function PANEL:RefreshScoreboard()
	self.m_ServerNameLabel:SetText("Sigilmare | discord.gg/sigilmare")
	self.m_ServerNameLabel:SizeToContents()
	self.m_ServerNameLabel:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel:GetWide(), self:GetWide() * 0.5 - self.m_ServerNameLabel:GetWide() * 0.5), 32 - self.m_ServerNameLabel:GetTall() / 1)

	self.m_ServerNameLabel2:SetText(game.GetMap().." - "..util.ToMinutesSecondsCD(CurTime()))
	self.m_ServerNameLabel2:SizeToContents()
	self.m_ServerNameLabel2:SetPos(math.min(self:GetWide() - self.m_ServerNameLabel2:GetWide(), self:GetWide() * 0.5 - self.m_ServerNameLabel2:GetWide() * 0.5), 32 - self.m_ServerNameLabel2:GetTall() / 3)

	if self.PlayerPanels == nil then self.PlayerPanels = {} end

	for pl, panel in pairs(self.PlayerPanels) do
		if not panel:IsValid() or pl:IsValid() and pl:IsSpectator() then
			self:RemovePlayerPanel(panel)
		end
	end

	for _, pl in pairs(player.GetAllActive()) do
		self:CreatePlayerPanel(pl)
	end
end

function PANEL:RemovePlayerPanel(panel)
	if panel:IsValid() then
		self.PlayerPanels[panel:GetPlayer()] = nil
		panel:Remove()
	end
end

vgui.Register("ZSScoreBoard", PANEL, "Panel")

PANEL = {}

PANEL.RefreshTime = 1

PANEL.m_Player = NULL
PANEL.NextRefresh = 0

local function MuteDoClick(self)
	local pl = self:GetParent():GetPlayer()
	if pl:IsValid() then
		pl:SetMuted(not pl:IsMuted())
		self:GetParent().NextRefresh = RealTime()
	end
end

GM.ZSFriends = {}
--[[hook.Add("Initialize", "LoadZSFriends", function()
	if file.Exists(GAMEMODE.FriendsFile, "DATA") then
		GAMEMODE.ZSFriends = Deserialize(file.Read(GAMEMODE.FriendsFile)) or {}
	end
end)]]

local function ToggleZSFriend(self)
	if MySelf.LastFriendAdd and MySelf.LastFriendAdd + 2 > CurTime() then return end

	local pl = self:GetParent():GetPlayer()
	if pl:IsValid() then
		if GAMEMODE.ZSFriends[pl:SteamID()] then
			GAMEMODE.ZSFriends[pl:SteamID()] = nil
		else
			GAMEMODE.ZSFriends[pl:SteamID()] = true
		end

		self:GetParent().NextRefresh = RealTime()

		net.Start("zs_zsfriend")
			net.WriteString(pl:SteamID())
			net.WriteBool(GAMEMODE.ZSFriends[pl:SteamID()])
		net.SendToServer()

		MySelf.LastFriendAdd = CurTime()
		--file.Write(GAMEMODE.FriendsFile, Serialize(GAMEMODE.ZSFriends))
	end
end

net.Receive("zs_zsfriendadded", function()
	local pl = net:ReadEntity()
	pl.ZSFriendAdded = net:ReadBool()
end)

local function AvatarDoClick(self)
	local pl = self.PlayerPanel:GetPlayer()
	if pl:IsValidPlayer() then
		pl:ShowProfile()
	end
end

local function empty() end

function PANEL:Init()
	local screenscale = math.max(0.95, BetterScreenScale())
	self:SetTall(40 * screenscale)

	self.m_AvatarButton = self:Add("DButton", self)
	self.m_AvatarButton:SetText(" ")
	self.m_AvatarButton:SetSize(40 * screenscale, 40 * screenscale)
	self.m_AvatarButton:Center()
	self.m_AvatarButton.DoClick = AvatarDoClick
	self.m_AvatarButton.Paint = empty
	self.m_AvatarButton.PlayerPanel = self

	self.m_Avatar = vgui.Create("AvatarImage", self.m_AvatarButton)
	self.m_Avatar:SetSize(40 * screenscale, 40 * screenscale)
	self.m_Avatar:SetVisible(false)
	self.m_Avatar:SetMouseInputEnabled(false)

	self.m_SpecialImage = vgui.Create("DImage", self)
	self.m_SpecialImage:SetSize(16, 16)
	self.m_SpecialImage:SetMouseInputEnabled(true)
	self.m_SpecialImage:SetVisible(false)

	self.m_ClassImage = vgui.Create("DImage", self)
	self.m_ClassImage:SetSize(32 * screenscale, 32 * screenscale)
	self.m_ClassImage:SetMouseInputEnabled(false)
	self.m_ClassImage:SetVisible(false)

	self.m_PlayerLabel = EasyLabel(self, " ", "ZSHUDFontTiny", COLOR_WHITE)
	self.m_ScoreLabel = EasyLabel(self, " ", "ZSScoreBoardPlayerSmall", COLOR_WHITE)
	self.m_RemortLabel = EasyLabel(self, " ", "ZSScoreBoardPlayerSmaller", COLOR_WHITE)

	self.m_PingMeter = vgui.Create("DPingMeter", self)
	self.m_PingMeter.PingBars = 5

	self.m_Mute = vgui.Create("DImageButton", self)
	self.m_Mute.DoClick = MuteDoClick

	self.m_Friend = vgui.Create("DImageButton", self)
	self.m_Friend.DoClick = ToggleZSFriend
end

local colTemp = Color(255, 255, 255, 200)
function PANEL:Paint()
	local col = color_black_alpha220
	local mul = 0.5
	local pl = self:GetPlayer()
	if pl:IsValid() then
		col = team.GetColor(pl:Team())

		if self.m_Flash then
			mul = 0.6 + math.abs(math.sin(RealTime() * 6)) * 0.4
		elseif pl == MySelf then
			mul = 0.8
		end
	end

	if self.Hovered then
		mul = math.min(0.9, mul * 1.5)
	end

	colTemp.r = col.r * mul
	colTemp.g = col.g * mul
	colTemp.b = col.b * mul
	surface.SetDrawColor(colTemp)
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

	return true
end

function PANEL:DoClick()
	local pl = self:GetPlayer()
	if pl:IsValid() then
		gamemode.Call("ClickedPlayerButton", pl, self)
	end
end

function PANEL:PerformLayout()
	local pl = self:GetPlayer()
	if not IsValid(pl) then return end

	local screenscale = BetterScreenScale()

	self.m_AvatarButton:AlignLeft(16)
	self.m_AvatarButton:CenterVertical()

	self.m_PlayerLabel:SizeToContents()
	self.m_PlayerLabel:MoveRightOf(self.m_AvatarButton, 4)
	self.m_PlayerLabel:CenterVertical()

	self.m_ScoreLabel:SizeToContents()
	self.m_ScoreLabel:SetPos(self:GetWide() * 0.55 - self.m_ScoreLabel:GetWide() / 2, 0)
	self.m_ScoreLabel:CenterVertical()

	self.m_SpecialImage:CenterVertical()

	self.m_ClassImage:SetSize(32, 32)
	if pl == LocalPlayer() then
		self.m_ClassImage:MoveLeftOf(self.m_PingMeter, 4)
	elseif not pl:IsBot() then
		self.m_ClassImage:MoveLeftOf(self.m_Friend, 4)
	end
	self.m_ClassImage:CenterVertical()

	local pingsize = self:GetTall() - 12

	self.m_PingMeter:SetSize(pingsize, pingsize)
	self.m_PingMeter:AlignRight(2)
	self.m_PingMeter:CenterVertical()

	self.m_Mute:SetSize(16, 16)
	self.m_Mute:MoveLeftOf(self.m_PingMeter, 4)
	self.m_Mute:CenterVertical()

	self.m_Friend:SetSize(16, 16)
	self.m_Friend:MoveLeftOf(self.m_Mute, 4)
	self.m_Friend:CenterVertical()

	self.m_RemortLabel:SizeToContents()
	if pl == LocalPlayer() then
		if pl:Team() == TEAM_HUMAN then
			self.m_RemortLabel:MoveLeftOf(self.m_PingMeter, 4)
		else
			self.m_RemortLabel:MoveLeftOf(self.m_ClassImage, 4)
		end
	elseif pl:Team() == TEAM_ZOMBIE then
		self.m_RemortLabel:MoveLeftOf(self.m_ClassImage, 4)
	elseif pl:Team() == TEAM_HUMAN then
		self.m_RemortLabel:MoveLeftOf(self.m_Friend, 4)
	end
	self.m_RemortLabel:CenterVertical()
end

function PANEL:RefreshPlayer()
	local pl = self:GetPlayer()
	if not pl:IsValid() then
		self:Remove()
		return
	end

	local namelengthLimit = 22

	local name = pl:Name()
	if #name > namelengthLimit then
		name = string.sub(name, 1, namelengthLimit-1).."-"
	end
	self.m_PlayerLabel:SetText(name)
	self.m_PlayerLabel:SetAlpha(240)

	if pl:Team() == TEAM_UNDEAD then
		self.m_ScoreLabel:SetText(pl:Frags().." / 3")
	elseif pl:Team() == TEAM_HUMAN then
		self.m_ScoreLabel:SetText(pl:GetPoints().." / "..pl:GetNWInt("ZSFrags"))
	end

	self.m_ScoreLabel:SetColor(pl:GetZSRemortLevel() > 0 and SIGILCOLOR_AETHER or SIGILCOLOR_ZSXP)
	self.m_ScoreLabel:SetAlpha(240)

	local rlvl = pl:GetZSRemortLevel()
	local lvl = pl:GetZSLevel()

	self.m_RemortLabel:SetText("Level " .. lvl.."  Prestige " .. rlvl)
	self.m_RemortLabel:SetColor(pl:GetZSRemortLevel() > 0 and SIGILCOLOR_AETHER or SIGILCOLOR_ZSXP)
	self.m_RemortLabel:SetAlpha(240)
	
	self.m_PlayerLabel:SetText(name)
	self.m_PlayerLabel:SetColor(pl:GetZSRemortLevel() > 0 and SIGILCOLOR_AETHER or SIGILCOLOR_ZSXP)
	self.m_PlayerLabel:SetAlpha(240)

	if pl:Team() == TEAM_ZOMBIE then
		self.m_ClassImage:SetVisible(true)
		self.m_ClassImage:SetImage(pl:GetZombieClassTable().Icon)
		self.m_ClassImage:SetImageColor(pl:GetZombieClassTable().IconColor or color_white)
	else
		self.m_ClassImage:SetVisible(false)
	end

	if pl == MySelf then
		self.m_Mute:SetVisible(false)
		self.m_Friend:SetVisible(false)
	else
		if pl:IsMuted() then
			self.m_Mute:SetImage("icon16/sound_mute.png")
		else
			self.m_Mute:SetImage("icon16/sound.png")
		end

		self.m_Friend:SetColor(pl.ZSFriendAdded and COLOR_LIMEGREEN or COLOR_GRAY)
		self.m_Friend:SetImage(GAMEMODE.ZSFriends[pl:SteamID()] and "icon16/heart_delete.png" or "icon16/heart.png")
	end

	if pl:Team() == TEAM_HUMAN then
		self:SetZPos(-pl:GetNWInt("ZSFrags"))
	elseif pl:Team() == TEAM_UNDEAD then
		self:SetZPos(-pl:Frags())	
	end

	if pl:Team() ~= self._LastTeam then
		self._LastTeam = pl:Team()
		self:SetParent(self._LastTeam == TEAM_HUMAN and ScoreBoard.HumanList or ScoreBoard.ZombieList)
	end

	if pl:IsBot() then
		self.m_Mute:SetVisible(false)
		self.m_Friend:SetVisible(false)
		self.m_RemortLabel:SetVisible(false)
		self.m_PingMeter:SetVisible(false)
		self.m_ScoreLabel:SetVisible(false)
		self.m_ClassImage:AlignRight(2)
	end

	self:InvalidateLayout()
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:RefreshPlayer()
	end
end

function PANEL:SetPlayer(pl)
	self.m_Player = pl or NULL

	if pl:IsValidPlayer() then
		if(pl:IsBot()) then
			pl.zs_avid = pl.zs_avid or "7656119"..tostring( 7960265728+math.random( 1, 200000000 ) )
			self.m_Avatar:SetSteamID(pl.zs_avid)
		else
			self.m_Avatar:SetPlayer(pl)
		end
		
		self.m_Avatar:SetVisible(true)

		if gamemode.Call("IsSpecialPerson", pl, self.m_SpecialImage) then
			self.m_SpecialImage:SetVisible(true)
		else
			self.m_SpecialImage:SetTooltip()
			self.m_SpecialImage:SetVisible(false)
		end

		--self.m_Flash = (pl:IsStaffMember())
	else
		self.m_Avatar:SetVisible(false)
		self.m_SpecialImage:SetVisible(false)
	end

	self.m_PingMeter:SetPlayer(pl)

	self:RefreshPlayer()
end

function PANEL:GetPlayer()
	return self.m_Player
end

vgui.Register("ZSPlayerPanel", PANEL, "Button")
