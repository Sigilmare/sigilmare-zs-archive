AddCSLuaFile( "vgui/KillNotification.lua" )

util.AddNetworkString( "KillNotification" )
hook.Add( "PlayerDeath", "Killnotification", function( victim, inflictor, attacker )
	if not IsValid( attacker ) or victim == attacker or not attacker:IsPlayer() then
		return end

	net.Start( "KillNotification" )
		net.WriteEntity( attacker )
		net.WriteEntity( inflictor ~= attacker and inflictor or attacker:GetActiveWeapon() )
	net.Send( victim )
end )