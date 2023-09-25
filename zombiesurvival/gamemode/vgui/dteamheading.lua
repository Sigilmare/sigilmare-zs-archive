local PANEL = {}
PANEL.m_Team = 0
PANEL.NextRefresh = 0
PANEL.RefreshTime = 2

function PANEL:Init()
	self.m_TeamNameLabel = EasyLabel(self, " ", "ZSScoreBoardHeading", color_black)
	self.m_TeamCountLabel = EasyLabel(self, " ", "ZSScoreBoardHeading", color_black)

	self:InvalidateLayout()
end

function PANEL:Think()
	if RealTime() >= self.NextRefresh then
		self.NextRefresh = RealTime() + self.RefreshTime
		self:RefreshContents()
	end
end

function PANEL:PerformLayout()
	self.m_TeamNameLabel:Center()

	self.m_TeamCountLabel:AlignRight(16)
	self.m_TeamCountLabel:CenterVertical()
end

function PANEL:RefreshContents()
	local teamid = self:GetTeam()

	self.m_TeamNameLabel:SetText(team.GetName(teamid))
	self.m_TeamNameLabel:SetTextColor(team.GetColor(teamid))
	self.m_TeamNameLabel:SizeToContents()

	self.m_TeamCountLabel:SetText(team.NumPlayers(teamid))
	self.m_TeamCountLabel:SetTextColor(team.GetColor(teamid))
	self.m_TeamCountLabel:SizeToContents()

	self:InvalidateLayout()
end

function PANEL:Paint()
	local wid, hei = self:GetWide(), self:GetTall()
	local teamid = self:GetTeam()
	
	local mul = 2.5

	if teamid == TEAM_HUMAN then
		surface.SetDrawColor(team.GetColor(teamid).r / mul, team.GetColor(teamid).g / mul, team.GetColor(teamid).b / mul, 240)
		surface.DrawRect(0, 0, wid, hei)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(0, 0, wid, hei)
	elseif teamid == TEAM_UNDEAD then
		surface.SetDrawColor(team.GetColor(teamid).r / mul, team.GetColor(teamid).g / mul, team.GetColor(teamid).b / mul, 240)
		surface.DrawRect(0, 0, wid, hei)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(0, 0, wid, hei)
	else
		surface.SetDrawColor(0, 0, 0, 180)
		surface.DrawRect(0, 0, wid, hei)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(0, 0, wid, hei)
	end
	return true
end

function PANEL:SetTeam(teamid)
	self.m_Team = teamid
end
function PANEL:GetTeam() return self.m_Team end

vgui.Register("DTeamHeading", PANEL, "Panel")
