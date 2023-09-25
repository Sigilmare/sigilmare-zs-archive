
	local PANEL = {}

	local matGlow = Material("sprites/glow04_noz")
	local texDownEdge = surface.GetTextureID("gui/gradient_down")
	local colHealth = Color(0, 0, 0, 240)

	local function ContentsPaint(self)
		local lp = LocalPlayer()
		if lp:IsValid() then
		local screenscale = BetterScreenScale()
		local health = math.max(lp:Health(), 0)
		local healthperc = math.Clamp(health / lp:GetMaxHealthEx(), 0, 1)
		local wid, hei = 300 * screenscale, 18 * screenscale

		colHealth.r = (1 - healthperc) * 180
		colHealth.g = healthperc * 180
		colHealth.b = 0

		local x = 18 * screenscale
		local y = 115 * screenscale

		local subwidth = healthperc * wid

		draw.SimpleTextBlurry(health, "ZSHUDFont", x + wid + 57 * screenscale, y + 8 * screenscale, colHealth, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(x + 45, y, wid, hei)

		surface.SetDrawColor(colHealth.r * 0.6, colHealth.g * 0.6, colHealth.b, 160)
		surface.SetTexture(texDownEdge)
		surface.DrawTexturedRect(x + 47, y + 1, subwidth - 4, hei - 2)
		surface.SetDrawColor(colHealth.r * 0.6, colHealth.g * 0.6, colHealth.b, 30)
		surface.DrawRect(x + 47, y + 1, subwidth - 4, hei - 2)

		surface.SetMaterial(matGlow)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x + 47 + subwidth - 6, y + 1 - hei/2, 4, hei * 2)

		local phantomhealth = math.max(lp:GetPhantomHealth(), 0)
		healthperc = math.Clamp(phantomhealth / lp:GetMaxHealthEx(), 0, 1)

		colHealth.r = 100
		colHealth.g = 90
		colHealth.b = 80
		local phantomwidth = healthperc * wid

		surface.SetDrawColor(colHealth.r, colHealth.g, colHealth.b, 160)
		surface.SetTexture(texDownEdge)
		surface.DrawTexturedRect(x + 47 + subwidth - 4, y + 1, phantomwidth, hei - 2)
		surface.SetDrawColor(colHealth.r, colHealth.g, colHealth.b, 30)
		surface.DrawRect(x + 47 + subwidth - 4, y + 1, phantomwidth, hei - 2)

		local armor = lp:Armor()
		x = 18 * screenscale
		y = 142 * screenscale
		wid, hei = 240 * screenscale, 14 * screenscale

		healthperc = math.Clamp(armor / (lp:GetMaxArmor() or 100), 0, 1)
		colHealth.r = 100
		colHealth.g = 255
		colHealth.b = 255

		subwidth = healthperc * wid

		draw.SimpleTextBlurry(armor, "ZSHUDFontSmall", x + wid + 60 * screenscale, y + 8 * screenscale, colHealth, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		surface.SetDrawColor(0, 0, 0, 230)
		surface.DrawRect(x + 45, y, wid, hei)

		surface.SetDrawColor(colHealth.r * 0.6, colHealth.g * 0.6, colHealth.b, 160)
		surface.SetTexture(texDownEdge)
		surface.DrawTexturedRect(x + 47, y + 1, subwidth - 4, hei - 2)
		surface.SetDrawColor(colHealth.r * 0.5, colHealth.g * 0.5, colHealth.b, 30)
		surface.DrawRect(x + 47, y + 1, subwidth - 4, hei - 2)

		surface.SetMaterial(matGlow)
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawTexturedRect(x + 47 + subwidth - 6, y + 1 - hei/2, 4, hei * 2)
	end
end

function PANEL:Init()
	self:DockMargin(0, 0, 0, 0)
	self:DockPadding(0, 0, 0, 0)
	local contents = vgui.Create("Panel", self)
	contents:Dock(FILL)
	contents.Paint = ContentsPaint
	timer.Simple(1, function()
		self.HealthModel = vgui.Create("Panel", self)
		self.HealthModel:Dock(LEFT)
	end)
	self:ParentToHUD()
	self:InvalidateLayout()
end

function PANEL:PerformLayout()
	local screenscale = BetterScreenScale()
	self:SetSize(screenscale * 528, screenscale * 168)
	self:AlignLeft()
	self:AlignBottom()
end

local matGradientLeft = CreateMaterial("gradient-l", "UnlitGeneric", {["$basetexture"] = "vgui/gradient-l", ["$vertexalpha"] = "1", ["$vertexcolor"] = "1", ["$ignorez"] = "1", ["$nomip"] = "1"})
function PANEL:Paint(w, h)
	local y = h * 0.6
	h = h - y
	surface.SetDrawColor(0, 0, 0, 180)
	surface.DrawRect(0, y, w * 0.4, h + 1)
	surface.SetMaterial(matGradientLeft)
	surface.DrawTexturedRect(w * 0.4, y, w * 0.6, h + 1)
	--surface.DrawLine(0, y, w, y)
	surface.SetDrawColor(0, 0, 0, 250)
	surface.SetMaterial(matGradientLeft)
	surface.DrawTexturedRect(0, y, w, 1)
	return true
end

vgui.Register("ZSHealthArea", PANEL, "Panel")

local PANEL = {}
PANEL.ModelLow = 0
PANEL.ModelHigh = 72
PANEL.BarricadeGhosting = 0

function PANEL:Init()
	self:SetAnimSpeed(0)
	self:SetFOV(55)
end

local function LowestAndHighest(ent)
	local lowest
	local highest
	local basepos = ent:GetPos()
	for i=0, ent:GetBoneCount() - 1 do
		local bonepos, boneang = ent:GetBonePosition(i)
		if bonepos and bonepos ~= basepos then
			if lowest == nil then
				lowest = bonepos.z
				highest = bonepos.z
			else
				lowest = math.min(lowest, bonepos.z)
				highest = math.max(highest, bonepos.z)
			end
		end
	end
	highest = (highest or 1) + ent:GetModelScale() * 8
	return lowest or 0, highest
end

function PANEL:Think()
	local lp = LocalPlayer()
	if lp:IsValid() then
		if not self.Health then self.Health = LocalPlayer():GetMaxHealth() end
		self.Health = math.Clamp(lp:Health() / lp:GetMaxHealth(), 0, 1)
		self.BarricadeGhosting = math.Approach(self.BarricadeGhosting or 0, lp:IsBarricadeGhosting() and 1 or 0, FrameTime() * 5)
		local model = lp:GetModel()
		local ent = self.Entity
		if not ent or not ent:IsValid() or model ~= ent:GetModel() then
			if IsValid(self.OverrideEntity) then
				self.OverrideEntity:Remove()
				self.OverrideEntity = nil
			end
			self:SetModel(model)
		end
		local overridemodel = lp.status_overridemodel
		if overridemodel and overridemodel:IsValid() then
			if IsValid(self.Entity) and not IsValid(self.OverrideEntity) then
				self.OverrideEntity = ClientsideModel(overridemodel:GetModel(), RENDER_GROUP_OPAQUE_ENTITY)
				if IsValid(self.OverrideEntity) then
					self.OverrideEntity:SetPos(self.Entity:GetPos())
					self.OverrideEntity:SetParent(self.Entity)
					self.OverrideEntity:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL))
					self.OverrideEntity:SetNoDraw(true)
				end
			end
		elseif self.OverrideEntity and self.OverrideEntity:IsValid() then
			self.OverrideEntity:Remove()
			self.OverrideEntity = nil
		end
		ent = self.Entity
		if ent and ent:IsValid() then
			ent:SetSequence(lp:GetSequence())
			ent:SetPoseParameter("move_x", lp:GetPoseParameter("move_x") * 2 - 1)
			ent:SetPoseParameter("move_y", lp:GetPoseParameter("move_y") * 2 - 1)
			ent:SetCycle(lp:GetCycle())
			local modellow, modelhigh = LowestAndHighest(ent)
			self.ModelLow = math.Approach(self.ModelLow, modellow, FrameTime() * 256)
			self.ModelHigh = math.Approach(self.ModelHigh, modelhigh, FrameTime() * 256)
			self.ModelHigh = math.max(self.ModelLow + 1, self.ModelHigh)
		end
	end
end

function PANEL:OnRemove()
	if IsValid(self.Entity) then
		self.Entity:Remove()
	end
	if IsValid(self.OverrideEntity) then
		self.OverrideEntity:Remove()
	end
end

local matWhite = Material("models/debug/debugwhite")
local matGlow = Material("sprites/glow04_noz")
local matShadow = CreateMaterial("zshealthhudshadow", "UnlitGeneric", {["$basetexture"] = "decals/simpleshadow", ["$vertexalpha"] = "1", ["$vertexcolor"] = "1"})
local colShadow = Color(20, 20, 20, 230)
function PANEL:Paint()
	local ent = self.OverrideEntity or self.Entity
	if not ent or not ent:IsValid() then return end
	local lp = LocalPlayer()
	if not lp:IsValid() then return end
	
	local bss = BetterScreenScale()
	--local w,h = 120 * bss, 120 * bss
	local x, y = 0, ScrH() - 120 
	local w, h = 120, 120
	local health = self.Health
	local entpos = ent:GetPos()
	local mins, maxs = lp:OBBMins(), lp:OBBMaxs()
	maxs.z = maxs.x * 4.5
	local campos = mins:Distance(maxs) * Vector(0, -0.9, 0.4)
	local lookat = (mins + maxs) / 2
	local ang = (lookat - campos):Angle()
	local modelscale = lp:GetModelScale()
	if ent:GetModelScale() ~= modelscale then
		ent:SetModelScale(modelscale, 0)
	end
	self:LayoutEntity(ent)
	render.ModelMaterialOverride(matWhite)
	render.SuppressEngineLighting(true)
	cam.IgnoreZ(true)
	cam.Start3D(campos - ang:Forward() * 16, ang, self.fFOV * 0.75, x, y, w, h, 5, 4096)
		render.OverrideDepthEnable(true, false)
		render.SetColorModulation(0, 0, self.BarricadeGhosting)
		ent:DrawModel()
		render.OverrideDepthEnable(false)
	cam.End3D()
	cam.Start3D(campos - ang:Forward() * 16, ang, math.min(46.75, self.fFOV * 0.755 + (((lp.MaxBloodArmor or 10) / lp:GetBloodArmor()) * 1)), x, y, w, h, 5, 4096)
		render.OverrideDepthEnable(true, false)
		render.SetColorModulation(lp:GetBloodArmor() > 0 and 0.6 or 0, 0, 0)
		ent:DrawModel()
		render.OverrideDepthEnable(false)
	cam.End3D()
	cam.Start3D(campos, ang, self.fFOV, x, y, w, h, 5, 4096)
	render.SetMaterial(matShadow)
	render.DrawQuadEasy(entpos, Vector(0, 0, 1), 45, 90, colShadow)
	render.SetLightingOrigin(entpos)
	render.ResetModelLighting(0.2, 0.2, 0.2)
	render.SetModelLighting(BOX_FRONT, 0.8, 0.8, 0.8)
	render.SetModelLighting(BOX_TOP, 0.8, 0.8, 0.8)
	if health == 1 then
		render.SetColorModulation(0, 0.6, 0)
		ent:DrawModel()
	elseif health == 0 then
		render.SetColorModulation(0, 0, 0)
		ent:DrawModel()
	else
		local normal = Vector(0, 0, 1)
		local pos = entpos + Vector(0, 0, self.ModelLow * (1 - health) + self.ModelHigh * health)
		render.EnableClipping(true)
		render.PushCustomClipPlane(normal, normal:Dot(pos))
		render.SetColorModulation(health > 0.5 and 0.6 or (0.7 + math.sin(CurTime() * math.pi * 2) * 0.2), 0, 0)
		ent:DrawModel()
		render.PopCustomClipPlane()
		normal = normal * -1
		render.PushCustomClipPlane(normal, normal:Dot(pos))
		render.SetColorModulation(0, 0.6, 0)
		ent:DrawModel()
		render.PopCustomClipPlane()
		render.EnableClipping(false)
	end
	cam.End3D()
	render.ModelMaterialOverride()
	render.SuppressEngineLighting(false)
	render.SetColorModulation(1, 1, 1)
	cam.IgnoreZ(false)
end

function PANEL:LayoutEntity(ent)
	self:RunAnimation()
end

vgui.Register("ZSHealthModelPanel", PANEL, "DModelPanel")