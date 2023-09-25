util.AddNetworkString("NetD3botCommandControl")
util.AddNetworkString("NetD3botCommandUnControl")

net.Receive( "NetD3botCommandControl", function( len, ply )
	RunConsoleCommand( "d3bot", "control", ply:Name() )
	PrintMessage(HUD_PRINTCENTER, ply:Name().." has gone AFK")
end)

net.Receive( "NetD3botCommandUnControl", function( len, ply )
	RunConsoleCommand( "d3bot", "uncontrol", ply:Name() )
	PrintMessage(HUD_PRINTCENTER, ply:Name().." has returned")

	local playerAng = ply:GetAngles()
	timer.Simple( 0.5, function()
		ply:SetEyeAngles( Angle( playerAng.x, playerAng.y, 0 ) )
	end)
end)