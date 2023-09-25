-- 

GM:AddBoss("Bahamut", "bahamut", "bahamut_vida") -- Bahamut, dragon thing

hook.Add("EntityKeyValue", "ChangeSettings", function(ent, key, value)
	if not TrueFixRound then
		GAMEMODE.KatanaDamageNum = 100
		GAMEMODE.MKStageNumber = 1
		GAMEMODE.Ex3Once = 0
		GAMEMODE.StartBridgeRotate = false
		TrueFixRound = true
	end

	-- Only Focus Replay to Extreme 2 if it's win at end of extreme 2.
	if ent:GetName() == "trigger_n_e2" and ent:GetClass() == "trigger_once" then
		if key == "OnStartTouch" then
			if value == "dificultad_inicio_extremo2,Enable,,0,-1" then
				return ",,,,"
			end
		end
	end

	-- buff electro materia dmg
	if ent:GetName() == "rayo_hurt" and ent:GetClass() == "trigger_hurt" then
		if key == "damage" then
			if value == "2" then
				return "50"
			end
		end
	elseif ent:GetName() == "rayo_hurt2" and ent:GetClass() == "trigger_hurt" then
		if key == "damage" then
			if value == "2" then
				return "50"
			end
		end
	elseif ent:GetName() == "rayo_hurt3" and ent:GetClass() == "trigger_hurt" then
		if key == "damage" then
			if value == "2" then
				return "50"
			end
		end
	end

	-- another fire materia buff
	if ent:GetName() == "fuego_a1" and ent:GetClass() == "trigger_hurt" then
		if key == "damage" then
			if value == "2" then
				return "32"
			end
		elseif key == "damagecap" then
			if value == "20" then
				return "32"
			end
		end
	elseif ent:GetName() == "fuego_a2" and ent:GetClass() == "trigger_hurt" then
		if key == "damage" then
			if value == "2" then
				return "32"
			end
		elseif key == "damagecap" then
			if value == "20" then
				return "32"
			end
		end
	elseif ent:GetName() == "fuego_a3" and ent:GetClass() == "trigger_hurt" then
		if key == "damage" then
			if value == "2" then
				return "32"
			end
		elseif key == "damagecap" then
			if value == "20" then
				return "32"
			end
		end
	end
	
	--Enable the bridge destruction
	if ent:GetClass() == "logic_auto" then
		if key == "OnNewGame" then
			if value == "trigger_n_d3,Kill,,0,-1" then
				if GAMEMODE.MKStageNumber == 2 then
					return ",,,,"
				else
					return "trigger_n_d3,Kill,,0,-1"
				end
			end
		end
	end

	--Prevent people from dying in bunkers if bridge is enabled.
	if ent:GetName() == "path_1x" and ent:GetClass() == "path_track" then
		if key == "OnPass" then
			if value == "meteoro,Enable,,0,-1" then
				return ",,,,"
			end
		end
	end

	-- Remove these "RemoveHealth" at end part.
	if ent:GetName() == "case4ex" and ent:GetClass() == "trigger_hurt" then
		if key == "OnStartTouch" then
			if value == "bahamutend1,RemoveHealth,150,0,-1" then
				return ",,,,"
			end
		end
	end

	if ent:GetName() == "case3ex" and ent:GetClass() == "trigger_hurt" then
		if key == "OnStartTouch" then
			if value == "bahamutend1,RemoveHealth,150,0,-1" then
				return ",,,,"
			end
		end
	end

	if ent:GetName() == "case2ex" and ent:GetClass() == "trigger_hurt" then
		if key == "OnStartTouch" then
			if value == "bahamutend1,RemoveHealth,150,0,-1" then
				return ",,,,"
			end
		end
	end

	if ent:GetName() == "case1ex" and ent:GetClass() == "trigger_hurt" then
		if key == "OnStartTouch" then
			if value == "bahamutend1,RemoveHealth,150,0,-1" then
				return ",,,,"
			end
		end
	end
	
	--Prevent extreme 2 sounds from playing on ex3.
	if ent:GetName() == "boton2" and ent:GetClass() == "func_button" then
		if key == "OnPressed" then
			if value == "cancion_3_extra,FireUser1,,0,10" then
				if GAMEMODE.MKStageNumber == 2 then
					return ",,,,"
				elseif GAMEMODE.MKStageNumber == 1 then
					return "cancion_3_extra,FireUser1,,0,10"
				end
			end
		end
	end
	if ent:GetName() == "post_bridgedoor" and ent:GetClass() == "func_button" then
		if key == "OnPressed" then
			if value == "cancion_1,Volume,0,0,-1" then
				if GAMEMODE.MKStageNumber == 2 then
					return ",,,,"
				elseif GAMEMODE.MKStageNumber == 1 then
					return "cancion_1,Volume,0,0,-1"
				end
			elseif value == "cancion_2,FireUser1,,0,-1" then
				if GAMEMODE.MKStageNumber == 2 then
					return ",,,,"
				elseif GAMEMODE.MKStageNumber == 1 then
					return "cancion_2,FireUser1,,0,-1"
				end
			end
		end
	end
	if ent:GetName() == "post_bombplanted" and ent:GetClass() == "trigger_once" then
		if key == "OnStartTouch" then
			if value == "cancion_3,PlaySound,,10,-1" then
				if GAMEMODE.MKStageNumber == 2 then
					return ",,,,"
				elseif GAMEMODE.MKStageNumber == 1 then
					return "cancion_3,PlaySound,,10,-1"
				end
			end
		elseif key == "OnUser1" then
			if value == "cancion_1_extra,Volume,0,10,-1" then
				if GAMEMODE.MKStageNumber == 2 then
					return "cancion_1_extra,Volume,0,10,-1"
				elseif GAMEMODE.MKStageNumber == 1 then
					return ",,,,"
				end
			end
		end
	end
	if ent:GetName() == "cancion_1_extra" and ent:GetClass() == "ambient_generic" then
		if key == "OnUser1" then
			if value == "cancion_1_extra,Volume,0,10,-1" then
				if GAMEMODE.MKStageNumber == 2 then
					return "cancion_1_extra,Volume,0,10,-1"
				elseif GAMEMODE.MKStageNumber == 1 then
					return ",,,,"
				end
			end
		end
	end
	if ent:GetName() == "bahamut_vida" and ent:GetClass() == "math_counter" then
		if key == "OnHitMin" then

			if value == "ex3_music2,PlaySound,,0,1" then
				if GAMEMODE.MKStageNumber == 2 then
					return "ex3_music2,PlaySound,,0,1"
				elseif GAMEMODE.MKStageNumber == 1 then
					return ",,,,"
				end
			elseif value == "ex3_music2,FireUser1,,0,1" then
				if GAMEMODE.MKStageNumber == 2 then
					return "ex3_music2,FireUser1,,0,1"
				elseif GAMEMODE.MKStageNumber == 1 then
					return ",,,,"
				end
			end
		end
	end


	--[[if ent:GetName() == "ex3_music2" and ent:GetClass() == "ambient_generic" then
		if key == "OnUser1" then
			if value == "ex3_music2,PlaySound,,0,1" then
				if GAMEMODE.MKStageNumber == 2 then
					return "ex3_music2,PlaySound,,0,1"
				elseif GAMEMODE.MKStageNumber == 1 then
					return ",,,,"
				end
			elseif value == "ex3_music2,FireUser1,,0,1" then
				if GAMEMODE.MKStageNumber == 2 then
					return "ex3_music2,FireUser1,,0,1"
				elseif GAMEMODE.MKStageNumber == 1 then
					return ",,,,"
				end
			end
		end
	end]]
	
	-- Change Timer
	if ent:GetName() == "comienza_huida" and ent:GetClass() == "trigger_once" then
		if key == "OnStartTouch" then
			if value == "huida_e,Trigger,,0.5,-1" then
				return "huida_e,Trigger,,10,-1"
			end
		end
	end
	
	if ent:GetName() == "trigger_extreme2_ex" and ent:GetClass() == "logic_relay" then
		if key == "OnTrigger" then
			if value == "baha_vida,Disable,,0.75,1" then
				return ",,,,"
			end
		end
	end
	
	--Increase bahamut health so its harder.
	if ent:GetName() == "extreme2_trigger12" and ent:GetClass() == "logic_relay" then
		if key == "OnTrigger" then
			if value == "bahamut_vida,Multiply,1.9,0,-1" then
				if GAMEMODE.MKStageNumber == 1 then
					return "bahamut_vida,Multiply,2,0.0,-1"
				elseif GAMEMODE.MKStageNumber == 2 then
					return "bahamut_vida,Multiply,2.3,0.0,-1"
				end
			end
		end
	end
end)

-------------------- Settings --------------------

-- Make sure if timer is not exist then start the katana blade spinning.
local Timer = 0
local TimerRotBridge = 90
local TimerRotBridgeTroll = 90
if not timer.Exists( "BladeVectorLoop" ) then
	timer.Create("BladeVectorLoop", 0.01, 0, function()
		if GAMEMODE.MKStageNumber>=2 then
			Timer = Timer + 2 * GAMEMODE.MKStageNumber
			for _, ent in ipairs(ents.GetAll()) do
				if ent:GetName() == "sephiroth_c1" or ent:GetName() == "sephiroth_c2" or ent:GetName() == "sephiroth_c3" or ent:GetName() == "sephiroth_c4" then
					ent:SetAngles(Angle(0,0,Timer))
				end
			end
		end

		if GAMEMODE.MKStageNumber>=2 then
			if GAMEMODE.StartBridgeRotate then
				if TimerRotBridge>0 then
					TimerRotBridge = TimerRotBridge - 1
					for _, ent in ipairs(ents.GetAll()) do
						if ent:GetName() == "puente_1" then
							ent:SetAngles(Angle(0,TimerRotBridge,0))
						end
					end
				--[[elseif TimerRotBridge<-15 then
					if not timer.Exists( "TrollBridge" ) then
						timer.Create("TrollBridge", 4, 1, function()
							for _, ent in pairs(ents.GetAll()) do
								if ent:GetName() == "puente_1" then
									ent:SetAngles(Angle(0,0,0))
								end
							end
						end)
					end]]
				end
			end
		end
	end)
end

function ForceEnableKatanaEx1()
	for _, ent in ipairs(ents.GetAll()) do
		if ent:GetName() == "extreme2_trigger11" then
			ent:Fire("Enable","",4)
		end
	end
end

function SetupStage()
	if GAMEMODE.MKStageNumber==0 then
		GAMEMODE.KatanaDamageNum = 100
		--ForceEnableKatanaEx1()
	elseif GAMEMODE.MKStageNumber==1 then
		GAMEMODE.KatanaDamageNum = 100
	elseif GAMEMODE.MKStageNumber==2 then
		GAMEMODE.KatanaDamageNum = 45

		for _, ent in ipairs(ents.GetAll()) do
			if ent:GetName()=="pieza_b2" then
				ent:Remove() -- Disable Pipe
			elseif ent:GetName()=="escal" then
				ent:Remove()
			elseif ent:GetName() == "puente_1" then
				ent:SetAngles(Angle(0,90,0))
			elseif ent:GetName() == "canciones_extreme2_1" then
				ent:Remove()
			elseif ent:GetName() == "canciones_extreme2_2" then
				ent:Remove()
			--elseif ent:GetName() == "cancion_3" then
				--ent:Remove()
			elseif ent:GetName() == "cancion_3_extra" then
				ent:Remove()
			--elseif ent:GetName() == "cancion_1" then
				--ent:Remove()
			elseif ent:GetName() == "cancion_2" then
				ent:Remove()
			elseif ent:GetName() == "normal_1de2" then
				ent:Remove()
			elseif ent:GetName() == "bahamut" then
				ent:SetColor(Color(0, 255, 255, 255))
				ent:SetMaterial("FFVII/COWBELL")
			end
		end
	end
end

-- InitPosEntity
hook.Add("InitPostEntityMap", "ChangeStuff", function()
	--Increase Round Limit
	GAMEMODE.RoundLimit = 2
	SetGlobalInt( "round_limit", GAMEMODE.RoundLimit )
	
	--Prevent mapvote from happening early
	GAMEMODE.IgnoreMapVotePrecaution = true
	
	--Prevent default ZE trigger_hurt based EndRound.
	GAMEMODE.ZE_EndRoundFix = true

	SetupStage()
	
	for k,v in ipairs( player.GetAll() ) do
		v:ConCommand("stopsound")
	end

	--GAMEMODE.ZombieSpeedMultiplier = 1.05
	
	--Train EX3 sign display.
	if GAMEMODE.MKStageNumber == 2 then
		for _, ents in ipairs( ents.FindByName("AvisoExt2") ) do 
			ents:Fire("Toggle","",0.1)
		end
		for _, ents in ipairs( ents.FindByName("Ext3") ) do 
			ents:Fire("Toggle","",0.1)
		end
		ents.FindByName("win_counter")[1]:Fire("SetValue", "1", 0)
		ents.FindByName("cloud")[1]:Fire("kill", 1)
	--elseif GAMEMODE.MKStageNumber == 1 then
		--ents.FindByName("ex3_music2")[1]:Remove()
	end
	
	timer.Simple(2, function()
		GAMEMODE.DynamicSpawning = false
	end )

	--removed if bridge is destroyed.
	if GAMEMODE.MKStageNumber == 2 then
		ents.FindByName("trigger_n_d3_ex")[1]:Remove()
	end
	
	-- Boss HP display
	local boss_hp_entity = ents.FindByName("bahamut_vida")[1]
	boss_hp_entity:SetDTInt( 1, boss_hp_entity.FixedKeyValues.startvalue )
	boss_hp_entity:SetDTInt( 2, boss_hp_entity.FixedKeyValues.max )
	boss_hp_entity:SetDTInt( 3, boss_hp_entity.FixedKeyValues.min )
	--Current Value, changes.
	boss_hp_entity:SetDTInt( 4, boss_hp_entity.FixedKeyValues.startvalue )
		
	--Prevent elevator from being blocked by players.
	--[[local _SpawnFlags = tostring(
		bit.bor(
			2,
			16
		)
	 )
	ents.FindByName("ascensort")[1]:SetKeyValue( "spawnflags", _SpawnFlags )]]
end)

hook.Add("RestartRound", "DeleteShizy", function()
	GAMEMODE.Ex3Once = 0 -- Reset Value
	GAMEMODE.StartBridgeRotate = false -- stop bridge rotate
	TimerRotBridge = 90 -- restart
	
	if ROUNDWINNER and (ROUNDWINNER == TEAM_HUMAN) then
		if not GAMEMODE.MKStageNumber then
			GAMEMODE.MKStageNumber = 1
		elseif GAMEMODE.MKStageNumber<= 1 then
			GAMEMODE.MKStageNumber = GAMEMODE.MKStageNumber+1
		end
	end
end)

--- The player is taken damage by a blade after the door is open.
hook.Add("EntityTakeDamage", "MateriaUltima", function( target, dmginfo )
local dmgent = dmginfo:GetInflictor()
	if dmgent~=nil and dmgent:GetName()=="case1ex" or dmgent:GetName()=="case2ex" or dmgent:GetName()=="case3ex" or dmgent:GetName()=="case4ex" then
		dmginfo:SetDamage(GAMEMODE.KatanaDamageNum)
		dmginfo:SetMaxDamage(GAMEMODE.KatanaDamageNum)
	end

	-- Boss hitbox bullet damage
	if not target:IsPlayer() and not target:IsWorld() then
		if target:GetName() == "bahamutend1" then
			dmginfo:ScaleDamage(1.5)
		elseif target:GetName()=="bahamutend" then
			dmginfo:ScaleDamage(2.5)
		elseif target:GetName()=="glassT" then
			dmginfo:ScaleDamage(10)
		end
	end
end)

-- fall dmg enable
--[[hook.Add("OnPlayerHitGround", "ZE.OnPlayerHitGround", function(pl, inwater, hitfloater, speed)
	local damage = (0.1 * (speed - (525 * (pl.HasSuperJump or 1)))) ^ 1.45
		if math.floor(damage) > 0 then
			pl:TakeSpecialDamage(damage, DMG_FALL, game.GetWorld(), game.GetWorld(), pl:GetPos())
			pl:EmitSound("player/pl_fallpain"..(math.random(2) == 1 and 3 or 1)..".wav")
		endF
	return true
end)]]

function OnceBladeEx1n2()
	if not GAMEMODE.MKStageNumber==1 then return end
	for _, ent in pairs(ents.GetAll()) do
		if ent:GetName() == "sephiroth_c1" then
			ent:Fire("StartForward","",4)
		elseif ent:GetName() == "espad" then
			ent:Fire("PlaySound","",4)
		end
	end
end

function OnceBladeEx3()
	if not GAMEMODE.MKStageNumber==2 then return end

	for _, ent in ipairs(ents.GetAll()) do
		if ent:GetName() == "sephiroth_c1" then
			ent:Fire("StartForward","",4)
		elseif ent:GetName() == "espad" then
			ent:Fire("PlaySound","",4)
		elseif ent:GetName() == "sephiroth_c2" then
			ent:Fire("StartForward","",6)
		elseif ent:GetName() == "sephiroth_c3" then
			ent:Fire("StartForward","",8)
		elseif ent:GetName() == "sephiroth_c4" then  -- add extra katana if you want.
			ent:Fire("StartForward","",10)
		end
	end

	GAMEMODE:CenterNotifyAll(COLOR_WHITE,"The bridge will start to rotate in 30 seconds!")
	timer.Simple( 30, function() GAMEMODE.StartBridgeRotate = true end)
end

function FinalBladeEx3()
	if not GAMEMODE.MKStageNumber==2 then return end

	for _, ent in ipairs(ents.GetAll()) do
		if ent:GetName() == "trigger_extreme" then
			ent:Fire("Enable","",1)
			ent:Fire("Trigger","",5)
		end
	end
end

hook.Add("AcceptInput", "StuffMako", function( ent, input, activator, caller, value )
	local classname = ent:GetClass()

	--After Boss Music
	--[[if ent:GetName()=="bahamut_s1" and classname == "ambient_generic" and input== "PlaySound" and caller:GetName() == "bahamut_vida" then
		if GAMEMODE.MKStageNumber==2 then
			ents.FindByName("ex3_music1")[1]:Fire("Volume", "0", 0)
			timer.Simple( 0.5, function() 
				ents.FindByName("ex3_music2")[1]:Fire("PlaySound")
			end )
		end
	end]]

	--1=startvalue, 2=max, 3=min, 4=current
	if classname == "math_counter" and ent:GetName() == "bahamut_vida" then
		if input == "Subtract" then
			--print(value)
			ent:SetDTInt( 4, math.Clamp( ent:GetDTInt(4) - value, ent:GetDTInt(3), ent:GetDTInt(2) ) )
			--print( "Bahamut HP :"..ent:GetDTInt(4) )
			
			--Handle HP Bar networking functions.
			GAMEMODE:BossDamageTaken(ent, activator)
			if ent:GetDTInt(4) == 0 then
				GAMEMODE:BossDeath(ent, activator)
			end
		elseif input == "Add" then
			ent:SetDTInt( 4, math.Clamp( ent:GetDTInt(4) + value, ent:GetDTInt(3), ent:GetDTInt(2) ) )
			GAMEMODE:BossDamageTaken(ent, activator)
			--print( ent:GetDTInt(4) )
		elseif input == "Divide" then
			ent:SetDTInt( 4, math.Clamp( ent:GetDTInt(4) / value, ent:GetDTInt(3), ent:GetDTInt(2) ) )
			--print( ent:GetDTInt(4) )
		elseif input == "Multiply" then
			ent:SetDTInt( 4, math.Clamp( ent:GetDTInt(4) * value, ent:GetDTInt(3), ent:GetDTInt(2) ) )
			--print( ent:GetDTInt(4) )
		elseif input == "SetValue" then
			ent:SetDTInt( 4, value )
			--print( ent:GetDTInt(4) )
		elseif input == "SetHitMax" then
			ent:SetDTInt( 2, value )
			--print( ent:GetDTInt(2) )
		elseif input == "SetHitMin" then
			ent:SetDTInt( 3, value )
			--print( ent:GetDTInt(3) )
		end
	end
	
	--[[if classname == "point_template" and ent:GetName() == "crrr" then
		if input == "ForceSpawn" then
			print("touched sephi!")
			for _, ents in ipairs( ents.FindByClass("trigger_hurt" ) ) do 
				if ents.FixedKeyValues.parentname == "sephiroth_c2_ex" then
					print('fired')
					ents:Fire("Enable","",0)
					ents:Fire("Trigger","",0)
				end
			end	
		end
	end]]

	-- Wave Start stuff
	if classname == "logic_waves" then
		if input == "onwavestart" and value == 1 then
			--Set Electro Max Uses
			local electro_swep = ents.FindByName( "rayo_bot" )[1]:GetParent()
			electro_swep:SetDTInt(1, 3 )
			
			--Freeze materias so they don't get stuck or bug out.
			timer.Simple(2,function()
				for _, ents in ipairs( ents.FindByClass("weapon_elite") ) do
					local children = ents:GetChildren()
					if #children > 0 then
						local phys = ents:GetPhysicsObject()
						if IsValid( phys ) then
							phys:EnableMotion(false)
						end
					end
				end
			end)

			if GAMEMODE.MKStageNumber == 1 then
				GAMEMODE:CenterNotifyAll(COLOR_WHITE,"DIFFICULTY = EXTREME 2")
			elseif GAMEMODE.MKStageNumber == 2 then
			
				--Extreme 3 Starting Music
				--[[for k,v in ipairs( player.GetAll() ) do
					v:ConCommand("stopsound")
				end
				timer.Simple( 0.1, function() 
					ents.FindByName("ex3_music1")[1]:Fire("PlaySound")
				end )]]
				
				GAMEMODE:CenterNotifyAll(COLOR_CYAN,"DIFFICULTY = EXTREME 3")
			end
		end
	end
	
	--ELECTRO
	if classname == "math_counter" and ent:GetName() == "rayo_balas" then
		if input == "Subtract" and value == "1" then
			local electro_swep = ents.FindByName( "rayo_bot" )[1]:GetParent()
			electro_swep:SetDTInt(1, electro_swep:GetDTInt(1) - value )
			if electro_swep:GetDTInt(1) == 0 then
				electro_swep:SetDTFloat(1, CurTime() + 55.0)
			end
			
			-- Let everyone know who casted.
			local owner = electro_swep:GetOwner()
			if activator:IsValid() and activator == owner then
				if activator:IsValid() and activator == owner then
					local electro = ents.FindByName( "rayo_bot" )[1]
					GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_electro"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[electro.FixedKeyValues.parentname],{killicon = "mako_electro"})
					PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[electro.FixedKeyValues.parentname])
				end
			end
		end
	end
	if classname == "logic_compare" and ent:GetName() == "rayo_relay" then
		if input == "SetCompareValue" then
			local electro_swep = ents.FindByName( "rayo_bot" )[1]:GetParent()
	
			if value == "2" then
				electro_swep:SetDTInt(1, 3)
			elseif value == "0" then
				electro_swep:SetDTFloat(1, 0)
			end
		end
	end
	
	--EARTH
	if classname == "logic_compare" and ent:GetName() == "tierra_relay" then
		if input == "SetCompareValue" and value == "1" then
			local earth_swep = ents.FindByName( "crear_tierra1" )[1]:GetParent()
			
			if earth_swep:IsValid() then
				-- Set our cool down timer.
				earth_swep:SetDTFloat(1, CurTime() + 55.0)
				
				-- Reset our materias timer.
				timer.Simple( 55, function()
					if earth_swep:IsValid() then
						earth_swep:SetDTFloat(1, 0)
					end
				end )
				
				-- Let everyone know who casted.
				local owner = earth_swep:GetOwner()
				if owner and owner:IsValid() then
					if activator:IsValid() and activator == owner then
						GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_earth"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[earth_swep.FixedKeyValues.targetname],{killicon = "mako_earth"})
						PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[earth_swep.FixedKeyValues.targetname])
					end
				end
			end
		end
	end
	
	--HEAL
	if classname == "logic_compare" and ent:GetName() == "cura_relay" then
		if input == "SetCompareValue" and value == "1" then
			local heal_swep = ents.FindByName( "cura_f" )[1]:GetParent()
			
			if heal_swep:IsValid() then
				-- Set our cool down timer.
				heal_swep:SetDTFloat(1, CurTime() + 50.0)
				
				-- Reset our materias timer.
				timer.Simple( 50, function()
					if heal_swep:IsValid() then
						heal_swep:SetDTFloat(1, 0)
					end
				end )
				
				-- Let everyone know who casted.
				local owner = heal_swep:GetOwner()
				if owner and owner:IsValid() then
					if activator:IsValid() and activator == owner then
						GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_heal"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[heal_swep.FixedKeyValues.targetname],{killicon = "mako_heal"})
						PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[heal_swep.FixedKeyValues.targetname])
					end
				end
			end
		end
	end
	
	--ICE
	if classname == "logic_compare" and ent:GetName() == "hielo_relay" then
		if input == "SetCompareValue" and value == "1" then
			local ice_swep = ents.FindByName( "hielo_f" )[1]:GetParent()
			
			if ice_swep:IsValid() then
				-- Set our cool down timer.
				ice_swep:SetDTFloat(1, CurTime() + 55.0)
				
				-- Reset our materias timer.
				timer.Simple( 55, function()
					if ice_swep:IsValid() then
						ice_swep:SetDTFloat(1, 0)
					end
				end )
				
				-- Let everyone know who casted.
				local owner = ice_swep:GetOwner()
				if owner and owner:IsValid() then
					if activator:IsValid() and activator == owner then
						GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_ice"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[ice_swep.FixedKeyValues.targetname],{killicon = "mako_ice"})
						PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[ice_swep.FixedKeyValues.targetname])
					end
				end
			end
		end
	end
	
	--GRAVITY
	if classname == "logic_compare" and ent:GetName() == "gravedad_relay" then
		if input == "SetCompareValue" and value == "1" then
			local grav_swep = ents.FindByName( "gravedad_f" )[1]:GetParent()
			
			if grav_swep:IsValid() then
				-- Set our cool down timer.
				grav_swep:SetDTFloat(1, CurTime() + 55.0)
				
				-- Reset our materias timer.
				timer.Simple( 55, function()
					if grav_swep:IsValid() then
						grav_swep:SetDTFloat(1, 0)
					end
				end )
				
				-- Let everyone know who casted.
				local owner = grav_swep:GetOwner()
				if owner and owner:IsValid() then
					if activator:IsValid() and activator == owner then
						GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_gravity"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[grav_swep.FixedKeyValues.targetname],{killicon = "mako_gravity"})
						PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[grav_swep.FixedKeyValues.targetname])
					end
				end
			end
		end
	end
	
	--FIRE
	if classname == "logic_compare" and ent:GetName() == "magia_relay" then
		if input == "SetCompareValue" and value == "1" then
			local fire_swep = ents.FindByName( "fuego_f" )[1]:GetParent()
			
			if fire_swep:IsValid() then
				-- Set our cool down timer.
				fire_swep:SetDTFloat(1, CurTime() + 55.0)
				
				-- Reset our materias timer.
				timer.Simple( 55, function()
					if fire_swep:IsValid() then
						fire_swep:SetDTFloat(1, 0)
					end
				end )
				
				-- Let everyone know who casted.
				local owner = fire_swep:GetOwner()
				if owner and owner:IsValid() then
					if activator:IsValid() and activator == owner then
						GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_fire"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[fire_swep.FixedKeyValues.targetname],{killicon = "mako_fire"})
						PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[fire_swep.FixedKeyValues.targetname])
					end
				end
			end
		end
	end
	
	--WIND
	if classname == "logic_compare" and ent:GetName() == "viento_relay" then
		if input == "SetCompareValue" and value == "1" then
			local wind_swep = ents.FindByName( "viento_f" )[1]:GetParent()
			
			if wind_swep:IsValid() then
				-- Set our cool down timer.
				wind_swep:SetDTFloat(1, CurTime() + 55.0)
				
				-- Reset our materias timer.
				timer.Simple( 55, function()
					if wind_swep:IsValid() then
						wind_swep:SetDTFloat(1, 0)
					end
				end )
				
				-- Let everyone know who casted.
				local owner = wind_swep:GetOwner()
				if owner and owner:IsValid() then
					if activator:IsValid() and activator == owner then
						GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_wind"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[wind_swep.FixedKeyValues.targetname],{killicon = "mako_wind"})
						PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[wind_swep.FixedKeyValues.targetname])
					end
				end
			end
		end
	end
	
	--ULTIMA
	if classname == "logic_relay" and ent:GetName() == "ultima_relay" then
		if input == "Trigger" then
			local ult_swep = ents.FindByName( "ultima_f" )[1]:GetParent()
			
			if ult_swep:IsValid() then
				-- Set our cool down timer.
				ult_swep:SetDTFloat(1, CurTime() + 20.0)
				
				-- Reset our materias timer.
				timer.Simple( 20, function()
					if ult_swep:IsValid() then
						ult_swep:SetDTFloat(1, 0)
					end
				end )
				
				-- Let everyone know who casted.
				local owner = ult_swep:GetOwner()
				if owner and owner:IsValid() then
					if activator:IsValid() and activator == owner then
						GAMEMODE:CenterNotifyAll(COLOR_WHITE, {killicon = "mako_ultima"}, activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[ult_swep.FixedKeyValues.targetname],{killicon = "mako_ultima"})
						PrintMessage(HUD_PRINTCONSOLE, "[MATERIA] "..activator:GetName() .. " used "..GAMEMODE.MateriaButtonTranslations[ult_swep.FixedKeyValues.targetname])
					end
				end
			end
		end
	end

	if GAMEMODE.MKStageNumber<=2 then
		if ent:GetName() == "puerta5" and classname == "func_door" and input== "Open" then
			if GAMEMODE.Ex3Once == 0 then
			
				GAMEMODE.Ex3Once=GAMEMODE.Ex3Once+1
				
				--Create blades at bunker.
				if GAMEMODE.MKStageNumber==1 then
					OnceBladeEx1n2()
				elseif GAMEMODE.MKStageNumber==2 then
					OnceBladeEx3()
				end
			end
		elseif ent:GetName() == "sephi2" and classname == "trigger_once" and input== "Enable" then
			if GAMEMODE.Ex3Once <= 2 then
				GAMEMODE.Ex3Once=GAMEMODE.Ex3Once+1
				GAMEMODE.KatanaDamageNum = 999999
			end
		elseif ent:GetName() == "boton2" and classname == "func_button" and input== "Lock" then
			if GAMEMODE.MKStageNumber==2 then
				ents.FindByName("escal2")[1]:Fire("Break","",20)
			end
		elseif ent:GetName() == "cortes2" and classname == "logic_timer" and input== "Disable" then
			if GAMEMODE.MKStageNumber==2 then
				FinalBladeEx3()
			end
		end
	end
end)

hook.Add("EndRound", "MakoEventItems", function(Winner)
	--If humans win round 2, they can attempt extreme 3.
	if GAMEMODE.CurrentRound == 2 and Winner == TEAM_HUMAN and GAMEMODE.MKStageNumber == 1 then
		GAMEMODE.RoundLimit = 3
		GAMEMODE:CenterNotifyAll(COLOR_GREEN, "Extending game to Round 3!")
	end
	
	if Winner == TEAM_HUMAN then
		if GAMEMODE.MKStageNumber == 1 then
			GAMEMODE:CenterNotifyAll(COLOR_CYAN, "**EXTREME II COMPLETED!**")
		elseif GAMEMODE.MKStageNumber == 2 then
			GAMEMODE:CenterNotifyAll(COLOR_CYAN, "**EXTREME III COMPLETED!**")
		end
	elseif Winner == TEAM_UNDEAD then
		GAMEMODE:CenterNotifyAll(COLOR_RED, "**ONLY THE CHOSEN MAY SURVIVE...**")
	end
	
	if SH_POINTSHOP ~= nil then
		for k, Ply in ipairs( team.GetPlayers( TEAM_HUMAN ) ) do
			if !IsValid( Ply ) then continue end

			if Winner == TEAM_HUMAN then
				if GAMEMODE.MKStageNumber == 2 then
					if not Ply:SH_HasItem("makowings") then
						timer.Simple(0.1, function() Ply:EmitSound("weapons/physcannon/energy_disintegrate"..math.random(4, 5)..".wav", 135, 100) end)
						Ply:SendLua("util.WhiteOut(2)")
						util.ScreenShake(Ply:GetPos(), 50, 0.5, 1.5, 800)

						Ply:SH_AddItem("makowings")
						PrintMessage(HUD_PRINTTALK, Ply:Nick().." won Extreme 3 and was rewarded with the 'Fallen Angel Wings'!")
					end
				end
			end
		end
	end
end)