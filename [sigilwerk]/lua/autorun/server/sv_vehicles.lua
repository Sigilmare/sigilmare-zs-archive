function SpawnJeepAt(pl)
	local car = ents.Create("prop_vehicle_jeep")
	car:SetModel("models/buggy.mdl")
	car:SetKeyValue("vehiclescript", "scripts/vehicles/jeep_test.txt")
	car:SetPos(pl:GetPos())
	car:Spawn()
	car:Activate()
end

function SpawnAirboatAt(pl)
	local car = ents.Create("prop_vehicle_airboat")
	car:SetModel("models/airboat.mdl")
	car:SetKeyValue("vehiclescript", "scripts/vehicles/airboat.txt")
	car:SetPos(pl:GetPos())
	car:Spawn()
	car:Activate()
end

function SpawnSeatAt(pl)
	local car = ents.Create("prop_vehicle_airboat")
	car:SetModel("models/airboat.mdl")
	car:SetKeyValue("vehiclescript", "scripts/vehicles/airboat.txt")
	car:SetPos(pl:GetPos())
	car:Spawn()
	car:Activate()
end

function SpawnCraneAt(pl)
	local MAGNET_MASS_SCALE = 500 

	local Crane = ents.Create("prop_vehicle_crane")
	if not IsValid(Crane) then return end
	CraneID = "zs"
	Crane:SetName("crane"..CraneID)

	Crane.Frame = ents.Create("prop_dynamic")
	if IsValid(Crane.Frame) then
		Crane.Frame:SetModel("models/cranes/crane_frame.mdl")
		Crane.Frame:SetPos(pl:GetPos())
		Crane.Frame:SetAngles(Angle(0,90,0))
		Crane.Frame:Spawn()
		Crane.Frame:Activate()
		Crane.Frame:SetSolid(SOLID_VPHYSICS)
		Crane.Frame:PhysicsInit(SOLID_VPHYSICS)
		Crane.Frame:SetMoveType(MOVETYPE_NONE)

		Crane.Frame.Interior = ents.Create("prop_dynamic")
		if IsValid(Crane.Frame.Interior) then
			Crane.Frame.Interior:SetModel("models/cranes/crane_frame_interior.mdl")
			Crane.Frame.Interior:SetPos(Crane.Frame:GetPos())
			Crane.Frame.Interior:Spawn()
			Crane.Frame.Interior:Activate()
			Crane.Frame.Interior:SetSolid(SOLID_NONE)
			Crane.Frame.Interior:SetMoveType(MOVETYPE_NONE)
			Crane.Frame.Interior:SetParent(Crane.Frame)
			Crane.Frame.Interior:AddEffects(EF_BONEMERGE)
		end
	else
		Crane:Remove()
		return
	end

	Crane:SetModel("models/Cranes/crane_docks.mdl")
	Crane:SetSaveValue("vehiclescript","scripts/vehicles/crane.txt")
	Crane:SetPos(Crane.Frame:GetPos()+Crane.Frame:GetUp()*(Crane.Frame:OBBMaxs().z-25))
	Crane:SetAngles(Crane.Frame:GetAngles())
	local CraneTipPos = Crane:GetAttachment(Crane:LookupAttachment("cable_tip")).Pos

	Crane.Magnet = ents.Create("phys_magnet")
	if IsValid(Crane.Magnet) then
		Crane.Magnet:SetName("magnet"..CraneID)
		Crane.Magnet:SetModel("models/props_wasteland/cranemagnet01a.mdl")
		Crane.Magnet:SetPos(CraneTipPos-Vector(0,0,500))
		Crane.Magnet:SetSolid(SOLID_VPHYSICS)
		Crane.Magnet:PhysicsInit(SOLID_VPHYSICS)
		Crane.Magnet:SetMoveType(MOVETYPE_VPHYSICS)

		Crane.Magnet:SetKeyValue("massScale",MAGNET_MASS_SCALE) --This stops it from swinging wildly in the air. Change it higher to lower its swing more
		--[[ Additional params
		Crane.Magnet:SetSaveValue("maxobjects",0)
		Crane.Magnet:SetSaveValue("forcelimit",0)
		Crane.Magnet:SetSaveValue("torquelimit",0)
		Crane.Magnet:SetSaveValue("overridescript","damping,0.2,rotdamping,0.2,inertia,0.3")
		]]
		Crane.Magnet:Spawn()
		Crane.Magnet:Activate()

		local phys = Crane.Magnet:GetPhysicsObject()
		if IsValid(phys) then
			phys:Wake()
			phys:EnableMotion(true) -- Unfreeze magnet
		end

		--Crane:SetSaveValue("m_hCraneMagnet",Crane.Magnet)
		--Crane:SetSaveValue("m_iszMagnetName",Crane.Magnet:GetName())
		Crane:SetKeyValue("magnetname",Crane.Magnet:GetName()) -- Magnet will be attached by entity-name, and not entity-handle.
		
	else
		Crane:Remove()
		Crane.Frame:Remove()
		return
	end

	Crane:Spawn()
	Crane:Activate() -- Attach magnet to crane (create crane_tip, rope, constraints)
	Crane:SetSolid(SOLID_BBOX)
	Crane:SetMoveType(MOVETYPE_NOCLIP)

	Crane:CallOnRemove("RemoveCraneParts",function()
		if IsValid(Crane.Frame.Interior) then
			Crane.Frame.Interior:Remove()
		end

		if IsValid(Crane.Frame) then
			Crane.Frame:Remove()
		end
		
		if IsValid(Crane.Magnet) then
			Crane.Magnet:Remove()
		end

		if IsValid(Crane:GetInternalVariable("m_hCraneMagnet")) then
			Crane:GetInternalVariable("m_hCraneMagnet"):Remove()
		end

		if IsValid(Crane:GetInternalVariable("m_hRope")) then
			Crane:GetInternalVariable("m_hRope"):Remove()
		end

		if IsValid(Crane:GetInternalVariable("m_hCraneTip")) then
			Crane:GetInternalVariable("m_hCraneTip"):Remove()
		end
	end)
end