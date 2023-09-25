AddCSLuaFile()

SWEP.PrintName = "SCP-106"

SWEP.Base = "weapon_zs_zombie"

SWEP.MeleeDamage = 2000
SWEP.MeleeForceScale = 0
SWEP.MeleeDelay = 0.33
SWEP.MeleeReach = 200
SWEP.SwingAnimSpeed = 1.8

SWEP.Secondary.Automatic = false

SWEP.Primary.Delay = 0.5

AccessorFuncDT(SWEP, "WalkState", "String", 1)
AccessorFuncDT(SWEP, "IdleState", "String", 2)

function SWEP:Initialize()
	self:SetWalkState("Walk")
	self:SetIdleState("Idle")

	self.BaseClass.Initialize(self)
end

function SWEP:PlayHitSound()
end

function SWEP:PlayMissSound()
end

function SWEP:PlayAttackSound()
end

function SWEP:Reload()
	if IsFirstTimePredicted() then
		if CLIENT then
			SCP096Panel()
			RunConsoleCommand("-reload")
		end
	end
end

function SWEP:SecondaryAttack()
end

if SERVER then
	util.AddNetworkString("SCP096Anim")
	local isplaying = false

	net.Receive("SCP096Anim", function(len, ply)
		local anim = net.ReadString()

		if anim == "Sit" then
			if ply:GetActiveWeapon():GetIdleState() != "IdleSit" then
				ply:DoAnimationEvent(ACT_CROUCH)
				ply:SetJumpPower(1)
			end
			if not isplaying then
				song("https://cdn.discordapp.com/attachments/1085523339608604756/1152671791702102156/096.ogg")
				isplaying = true 
				timer.Create("096Cry", 33, 1, function()
					isplaying = false
				end)
			end
			timer.Simple(0.5, function()
				ply:GetActiveWeapon():SetIdleState("IdleSit")
			end)
		elseif anim == "Stand" then
			if ply:GetActiveWeapon():GetIdleState() != "Idle" then
				ply:DoAnimationEvent(ACT_JUMP)
				ply:SetJumpPower(1)
			end
			if not isplaying then
				song("https://cdn.discordapp.com/attachments/1085523339608604756/1152671791702102156/096.ogg")
				isplaying = true 
				timer.Create("096Cry", 33, 1, function()
					isplaying = false
				end)
			end
			timer.Simple(0.5, function()
				ply:GetActiveWeapon():SetIdleState("Idle")
				ply:GetActiveWeapon():SetWalkState("Walk")
			end)
		elseif anim == "SitRage" then
			ply:DoAnimationEvent(ACT_GLIDE)
			song("https://cdn.discordapp.com/attachments/1085523339608604756/1145425460411518976/096_Triggered.wav")
			timer.Simple(0.5, function()
				ply:GetActiveWeapon():SetIdleState("Raging")
				ply:GetActiveWeapon():SetWalkState("Run")
			end)
			isplaying = false
			for k, v in ipairs(player.GetHumans()) do
				timer.Simple(0.25, function()
					v:SetFOV(170, 0.25)
					timer.Simple(0.25, function()
						v:SetFOV(100, 6)
					end)
				end)
			end
		elseif anim == "StandRage" then
			ply:DoAnimationEvent(ACT_SPECIAL_ATTACK1)
			song("https://cdn.discordapp.com/attachments/1085523339608604756/1145425460411518976/096_Triggered.wav")
			timer.Simple(0.5, function()
				ply:GetActiveWeapon():SetIdleState("Raging")
				ply:GetActiveWeapon():SetWalkState("Run")
			end)
			isplaying = false
		elseif anim == "Rage" then
			ply:DoAnimationEvent(ACT_SPECIAL_ATTACK2)
			timer.Simple(0.5, function()
				ply:GetActiveWeapon():SetIdleState("Rage")
				ply:GetActiveWeapon():SetWalkState("Run")
				ply:SetJumpPower(500)
				song("https://cdn.discordapp.com/attachments/1047823974186373197/1145399976885764134/SCP-096_Chase_Theme_Old_V2_10_Minutes.ogg")
			end)
			isplaying = false
		end
	end)
end

if not CLIENT then return end

function SWEP:ViewModelDrawn()
	render.ModelMaterialOverride(0)
end

local matSheet = Material("models/cpthazama/scp/096/096")
function SWEP:PreDrawViewModel(vm)
	render.ModelMaterialOverride(matSheet)
end

function SCP096Panel()
	local frame = vgui.Create("DFrame")
	frame:SetSize(600, 100)
	frame:Center()
	frame:MakePopup()

	local button = vgui.Create("DButton", frame)
	button:SetText("Sit")
	button:SetFont("ZSHUDFontSmaller")
	button:SizeToContents()
	button:Dock(LEFT)
	button:DockMargin(0, 0, 4, 0)
	button.DoClick = function()
		net.Start("SCP096Anim")
			net.WriteString("Sit")
		net.SendToServer()
		frame:Close()
	end
	button.Paint = function(panel, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color_black_alpha180)
	end

	local button = vgui.Create("DButton", frame)
	button:SetText("Stand")
	button:SetFont("ZSHUDFontSmaller")
	button:SizeToContents()
	button:Dock(LEFT)
	button:DockMargin(0, 0, 4, 0)
	button.DoClick = function()
		net.Start("SCP096Anim")
			net.WriteString("Stand")
		net.SendToServer()
		frame:Close()
	end
	button.Paint = function(panel, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color_black_alpha180)
	end

	local button = vgui.Create("DButton", frame)
	button:SetText("SitRage")
	button:SetFont("ZSHUDFontSmaller")
	button:SizeToContents()
	button:Dock(LEFT)button:DockMargin(0, 0, 4, 0)
	button.DoClick = function()
		net.Start("SCP096Anim")
			net.WriteString("SitRage")
		net.SendToServer()
		frame:Close()
	end
	button.Paint = function(panel, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color_black_alpha180)
	end

	local button = vgui.Create("DButton", frame)
	button:SetText("StandRage")
	button:SetFont("ZSHUDFontSmaller")
	button:SizeToContents()
	button:Dock(LEFT)button:DockMargin(0, 0, 4, 0)
	button.DoClick = function()
		net.Start("SCP096Anim")
			net.WriteString("StandRage")
		net.SendToServer()
		frame:Close()
	end
	button.Paint = function(panel, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color_black_alpha180)
	end

	local button = vgui.Create("DButton", frame)
	button:SetText("Rage")
	button:SetFont("ZSHUDFontSmaller")
	button:SizeToContents()
	button:Dock(LEFT)
	button.DoClick = function()
		net.Start("SCP096Anim")
			net.WriteString("Rage")
		net.SendToServer()
		frame:Close()
	end
	button.Paint = function(panel, w, h)
		draw.RoundedBox(4, 0, 0, w, h, color_black_alpha180)
	end
end