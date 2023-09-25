local cl_vm_lag_scale = math.huge

local function VectorMA( start, scale, direction, dest )
	dest.x = start.x + direction.x * scale
	dest.y = start.y + direction.y * scale
	dest.z = start.z + direction.z * scale
end

local function CalcViewModelLag(vm, origin, angles, original_angles)
	local vOriginalOrigin = Vector(origin.x, origin.y, origin.z);
	local vOriginalAngles = Angle(angles.x, angles.y, angles.z);

	vm.m_vecLastFacing = vm.m_vecLastFacing or angles:Forward()

	local forward = angles:Forward();

	if (FrameTime() != 0.0) then
		local vDifference = forward - vm.m_vecLastFacing;

		local flSpeed = 1;

		local flDiff = vDifference:Length();
		if ( (flDiff > cl_vm_lag_scale) and (cl_vm_lag_scale > 0.0) ) then
			local flScale = flDiff / cl_vm_lag_scale;
			flSpeed = flSpeed * flScale;
		end

		VectorMA(vm.m_vecLastFacing, flSpeed * FrameTime(), vDifference, vm.m_vecLastFacing);

		vm.m_vecLastFacing:Normalize()
		VectorMA(origin, 2, vDifference * -2, origin);
	end

	local right, up;
	right = original_angles:Right()
	up = original_angles:Up()

	local pitch = original_angles[1];

	if (pitch > 140.0) then
		pitch = pitch - 180.0;
	elseif (pitch < -180.0) then
		pitch = pitch + 180.0;
	end

	if (cl_vm_lag_scale == 0.0) then
		origin = vOriginalOrigin;
		angles = vOriginalAngles;
	end

	VectorMA(origin, -pitch * 0.010, forward, origin);
	VectorMA(origin, -pitch * 0.02, right,	origin);
	VectorMA(origin, -pitch * 0.02, up, origin);
end


local function doLag(weapon, vm, oldPos, oldAng, pos, ang)
	if (IsValid(weapon) and weapon.GetIronSights and weapon:GetIronSights()) then
		vm.m_vecLastFacing = ang:Forward()
	else
		CalcViewModelLag(vm, pos, ang, oldAng)
	end
end

hook.Add("CalcViewModelView", "HL2ViewModelSway", doLag)