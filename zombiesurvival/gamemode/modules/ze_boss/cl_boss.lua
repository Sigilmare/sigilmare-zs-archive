if string.sub(string.lower(game.GetMap()), 1, 3) ~= "ze_" then return end

--ZE Boss system from https://github.com/samuelmaddock/zombie-escape
--Modifcations and fixes by https://github.com/mka0207

local BossEntities = {}
local LastBossUpdate = RealTime()
local BossGlowColor = Color(129, 180, 30, 180)

local gradientUp = surface.GetTextureID("VGUI/gradient_up")
local maxBarHealth = 100
local deltaVelocity = 0.08 -- [0-1]
local bw = 12 -- bar segment width
local padding = 2
local colGreen = Color( 129, 215, 30, 255 )
local colDarkGreen = Color( 50, 83, 35, 255 )
local colDarkRed = Color( 132, 43, 24, 255 )
local curPercent = nil
local BG_Color = Color( 25, 25, 25, 120 )

hook.Add( "PostDrawTranslucentRenderables", "ZE.BossHealthDisplay", function( bDepth, bSkybox )

	-- If we are drawing in the skybox, bail
	if ( bSkybox ) then return end
	
	for k, boss in pairs(BossEntities) do
		if !IsValid(boss.Ent) or boss.Health <= 1 then BossEntities[k] = nil return end
		if (LocalPlayer():GetPos() - boss.Ent:GetPos()):Length() > 4096 then return end
		
		local w, h = 400, 25
		local x, y = 0, 0
		
		local eyepos = EyePos()
		local ang = ( eyepos - boss.Ent:GetPos() ):Angle()
		ang:RotateAroundAxis(ang:Right(), 230)
		ang:RotateAroundAxis(ang:Up(), 90)
		
		cam.Start3D2D( boss.Ent:LocalToWorld( Vector( 400, 0, boss.Ent:OBBMaxs().z + 100 ) ), ang, 1 )
			-- Let's do some calculations first
			maxBarHealth = (boss.MaxHealth > 999) and 1000 or 100
			local name = boss.Name and boss.Name or "BOSS"
			local totalHealthBars = math.ceil(boss.MaxHealth / maxBarHealth)
			local curHealthBar = math.floor(boss.Health / maxBarHealth)
			local percent = (boss.Health - curHealthBar*maxBarHealth) / maxBarHealth
			local hpfraction = math.Clamp( boss.Health, 0, boss.MaxHealth ) / maxBarHealth
			
			curPercent = !curPercent and 1 or math.Approach(curPercent, percent, math.abs(curPercent-percent)*0.08)

			-- Boss name
			surface.SetFont("ZSHUDFontSmaller")
			local tw, th = surface.GetTextSize(name)
			local x3, y3 = x-(w/2), y + h - padding*0.7 --*2
			local w3, h3 = tw + padding*4, th + padding
			--draw.RoundedBox( 0, x3, y3, w3, h3, BG_Color )
			draw.SimpleText(name, "ZSHUDFontSmaller", x3 + padding*2, y3 + padding, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
			
			-- Boss health bar segments
			local rw, rh = (bw + padding)*totalHealthBars + padding, th + padding
			local x4, y4 = x+(w/2)-rw, y + h - padding*2
			--draw.RoundedBox( 0, x4, y4, rw, rh, BG_Color )

			for i=0,totalHealthBars-1 do
				local col = (i<curHealthBar) and colGreen or BG_Color
				draw.RoundedBox( 0, x4 + (bw + padding)*i + padding, y4 + padding*3, bw, bw + padding*2, col )
			end

			-- Health bar background
			draw.RoundedBox( 0, x-(w/2), y, w, h, BG_Color )

			-- Boss health bar
			local x2, y2 = x-(w/2) + padding, y + padding
			local w2, h2 = w - padding*2, h - padding*2
			--draw.RoundedBox( 0, x2, y2, w2, h2, Color( 0, 0, 0, 100 ) ) -- dark green background
			draw.RoundedBox( 0, x2, y2, w*curPercent - padding*2, h2, Color(255*(1 - hpfraction),255*hpfraction,0,255) )

			surface.SetDrawColor(0,0,0,100)
			surface.SetTexture(gradientUp)
			surface.DrawTexturedRect( x2, y2, w2, h2 )

		cam.End3D2D()
	end
end )

local function RecieveBossSpawn()

	local index = net.ReadFloat()
	local name = net.ReadString()
	
	local boss = BossEntities[index]
	if !boss then
		BossEntities[index] = {}
		boss = BossEntities[index]
		boss.Ent = Entity(index)
		boss.Name = string.upper(name)
		boss.bSpawned = true

		if CVars.BossDebug:GetInt() > 0 then
			Msg("BOSS SPAWN\n")
			Msg("\tName: " .. name .. "\n")
			Msg("\tEntity: " .. tostring(BossEntities[index].Ent) .. "\n")
		end
	end


end
net.Receive( "BossSpawn", RecieveBossSpawn )

local function RecieveBossUpdate()

	local index = net.ReadFloat()
	local health, maxhealth = net.ReadFloat(), net.ReadFloat()
	
	local boss = BossEntities[index]
	if !boss then
		if CVars.BossDebug:GetInt() > 0 then
			Msg("Received boss update for non-existant boss.\n")
		end
		BossEntities[index] = {}
		boss = BossEntities[index]
		boss.Ent = Entity(index)
	end
	
	boss.Health = health
	boss.MaxHealth = maxhealth
	if CVars.BossDebug:GetInt() > 0 then
		Msg("BOSS UPDATE\n")
		Msg("\tEntity: " .. tostring(BossEntities[index].Ent) .. "\n")
		Msg("\tHealth: " .. health .. "\n")
		Msg("\tMaxHealth: " .. boss.MaxHealth .. "\n")
	end

	LastBossUpdate = RealTime()

end
net.Receive( "BossTakeDamage", RecieveBossUpdate )

local function RecieveBossDefeated()

	local index = net.ReadFloat()
		
	if !BossEntities[index] then
		if CVars.BossDebug:GetInt() > 0 then
			Msg("Warning: Received boss death for non-existant boss!\n")
		end
	else
		if CVars.BossDebug:GetInt() > 0 then
			Msg("BOSS DEATH\n")
			Msg("\tEntity: " .. tostring(BossEntities[index].Ent) .. "\n")
		end
		BossEntities[index] = nil
	end
	
end
net.Receive( "BossDefeated", RecieveBossDefeated )