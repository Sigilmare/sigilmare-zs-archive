SM = SM or {}

---------------
-- Blackhole --
---------------

SM.BlackholeNodesMaps = {}
SM.BlackholeNodes = {
    ["gm_construct"] = Vector(-1930, 1975, 2351),
	["zs_alexg_metro_v4a"] = Vector(-393, 1153, -452),
	["zs_lighthouse_revived_v1b"] = Vector(1743, 2404, 3225),
}

for map, vec in pairs(SM.BlackholeNodes) do
    table.insert(SM.BlackholeNodesMaps, map)
end

------------
-- Colors --
------------

SM.UserGroups = {
    ["user"] 			= {"User", Color(255, 255, 255)},
    ["serverbooster"] 	= {"Server Booster", Color(244, 127, 255)},
	["tester"]			= {"Tester", Color(113, 130, 70)},
    ["contributor"] 	= {"Contributor", Color(202, 72, 255)},
	["donator"]			= {"Donator", Color(0, 160, 255)},
    ["tmod"] 			= {"Trial Moderator", Color(166, 219, 255)},
    ["mod"] 			= {"Moderator", Color(109, 195, 246)},
    ["smod"] 			= {"Senior Moderator", Color(105, 169, 255)},
    ["xadmin"] 			= {"Administrator", Color(255, 61, 61)},
    ["hadmin"] 			= {"Head Administrator", Color(235, 0, 0)},
    ["superadmin"] 		= {"Owner", Color(255, 0, 0)}
} 

SIGILCOLOR_GREEN = Color(47, 251, 47)
SIGILCOLOR_RED = Color(251, 47, 47)
SIGILCOLOR_BLUE = Color(47, 47, 251)
SIGILCOLOR_PINK = Color(251, 47, 251)
SIGILCOLOR_YELLOW = Color(251, 251, 47)
SIGILCOLOR_ORANGE = Color(251, 147, 47)
SIGILCOLOR_CYAN = Color(47, 251, 251)
SIGILCOLOR_BLACK = Color(47, 47, 47)
SIGILCOLOR_GRAY = Color(200, 200, 200)

SIGILCOLOR_COMMON = Color(150, 150, 150)
SIGILCOLOR_UNCOMMON = Color(133, 207, 137)
SIGILCOLOR_RARE = Color(107, 196, 255)
SIGILCOLOR_EPIC = Color(194, 108, 208)
SIGILCOLOR_LEGENDARY = Color(255, 197, 0)
SIGILCOLOR_EXOTIC = Color(255, 71, 57)

NZSCOLOR_COMMON_C = "<c=150,150,150>"
NZSCOLOR_UNCOMMON_C = "<c=133,207,137>"
NZSCOLOR_RARE_C = "<c=107,196,255>"
NZSCOLOR_EPIC_C = "<c=194,108,208>"
NZSCOLOR_LEGENDARY_C = "<c=255,197,0>"
NZSCOLOR_EXOTIC_C = "<c=255,71,57>"

SIGILCOLOR_ZSXP = Color(165, 214, 167)
SIGILCOLOR_DISASTER = Color(203, 22, 14)
SIGILCOLOR_AETHER = Color(128, 222, 234)
SIGILCOLOR_CREDITS = Color(255, 245, 157)
SIGILCOLOR_TOKENS = Color(245, 205, 98)
SIGILCOLOR_CASES = Color(245, 125, 98)

----------
-- Maps --
----------

SM.PlayableMaps = {}
SM.MapDownloads = {
    ["gm_construct"]    			= {Bots = true, MinPlayers = 8},
	["zs_obj_finger_defeater_v3"] 	= {ID = "1711798430", Bots = true, MinPlayers = 12},

	["ze_ffvii_mako_reactor_v5_4e1"]		= {ID = "2965317638", Bots = true, MinPlayers = 12},
    ["zs_alexg_metro_v4a"]					= {ID = "2965317638", Bots = true},
	["zs_antarctic_hospital_revivedv2"]		= {ID = "2965317638", Bots = true},
	["zs_cliffside_night"]					= {ID = "2965317638", Bots = true},
	["zs_lighthouse_revived_v1b"]   		= {ID = "2965317638", Bots = true},
	["zs_the_last_resource_v1"]   			= {ID = "2965317638", Bots = true},

	["zs_abstractum_v1"]		= {ID = "3015033730", Bots = true},
    ["zs_krusty_krab_v4"]		= {ID = "3015033730", Bots = true},
	["zs_last_day_z2_fpsv4"]	= {ID = "3015033730", Bots = true},
	["zs_lost_base_v3"]			= {ID = "3015033730", Bots = true},
	["zs_obj_tantibus_v9"]  	= {ID = "3015033730", Bots = true, MinPlayers = 8},
	["zs_poolside_b4"]   		= {ID = "3015033730", Bots = true},

	["zs_abandoned_mall_v10"] = {ID = "3032790605", Bots = true},
	["zs_obj_6_nights_v12"] = {ID = "3032790605", Bots = true, MinPlayers = 6},
	["zs_onett_v7ps"] = {ID = "3032790605", Bots = true},
	["zs_parkhouse_v2"] = {ID = "3032790605", Bots = true},
	["zs_purple_v1"] = {ID = "3032790605", Bots = true},
	["zs_the_pub_final7"] = {ID = "3032790605", Bots = true},
}

for _, data in pairs(SM.MapDownloads) do
    if data.Bots then
        --if _ == game.GetMap() then continue end

        table.insert(SM.PlayableMaps, _)
    end
end

------------------
-- Server Rules --
------------------

SM.Rules = [[
	<p>Sigilmare Zombie Survival is a server to have fun with friends or community members in a safe and friendly environment for everyone. This means that in order to play on this server, you must follow our rules to ensure the safety of our players.</p>

	<p>Zombie-maining is allowed, but we have some rules put in place with it. Refer to rule 13 for more information.</p>

	<p>We use a simple punishment strike system and these strikes are unremovable from your ZS account. Strikes come under multiple different categories:<ul>
		<li>Chat Mute Strike</li>
		<li>Voice Mute Strike</li>
		<li>Aegis Ban Strike</li>
		<li>Hammer Ban Strike</li>
		<li>Nest Ban Strike</li>
		<li>Pickup Ban Strike</li>
        <li>Spray Ban Strike</li>
		<li>Zombie Ban Strike</li>
		<li>Server Ban Strike</li>
	</ul>

	<p>1. No racism, homophobia, paedophilia, discrimination, etc.<br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Spray Ban Strike, Server Ban Strike</span></p>

	<p>2. No chat spamming, chat flooding or voice spamming<br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Server Ban Strike</span></p>

	<p>3. No NSFW/NSFL content at all of any kind<br>
	<span style="font-size:10px;color:gray;">This includes sexual remarks, profile pictures, profile banners, etc. This also includes softcore/cropped porn. Any kind of gore and/or animal cruelty is strictly forbidden.</span><br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Spray Ban, Server Ban Strike</span></p>

	<p>4. No advertising/scamming/self-promoting of any kind<br>
	<span style="font-size:10px;color:gray;">This includes sending scam messages, promoting things by you, etc.</span><br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Spray Ban Strike, Server Ban Strike</span></p>

	<p>5. No impersonation<br>
	<span style="font-size:10px;color:gray;">This includes claiming stolen artwork/creations as your own, impersonating a staff member/high rank, etc.</span><br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Server Ban Strike</span></p>

    <p>6. No doxing of any kind<br>
	<span style="font-size:10px;color:gray;">This includes sending IP loggers and/or any sort of personal information of a member without their consent.</span><br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Spray Ban Strike, Server Ban Strike</span></p>

    <p>7. Do not encourage spamming, rioting or participation in raids<br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Spray Ban Strike, Server Ban Strike</span></p>

    <p>8. The only language allowed on this server is English<br>
	<span style="font-size:10px;color:gray;">Speaking any other language will lead to you getting punished. This does not apply towards player sprays.</span><br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike</span></p>

    <p>9. Do not grief your team in any way<br>
	<span style="font-size:10px;color:gray;">This includes prop-killing, destroying props, creating bad flesh creeper nests, un-nailing barricades, etc.</span><br>
	<span style="font-size:10px;color:orange;">Aegis Ban Strike, Hammer Ban Strike, Nest Ban Strike, Pickup Ban Strike, Server Ban Strike</span></p>

    <p>10. Do not cross-team for an unfair advantage<br>
	<span style="font-size:10px;color:gray;">Teaming as a non-harmful zombie is allowed but using it to your advantage such as climbing walls by standing ontop of a climbing Fast Zombie will lead to you getting punished.</span><br>
	<span style="font-size:10px;color:orange;">Server Ban Strike</span></p>

    <p>11. Situations not mentioned here will be dealt with on a case-by-case basis<br>

    <p>12. HAVE COMMON SENSE, DON'T BE STUPID!<br>
	<span style="font-size:10px;color:gray;">If you think something is against the rules or isn't allowed, don't do it!</span><br>
	<span style="font-size:10px;color:orange;">Chat Mute Strike, Voice Mute Strike, Aegis Ban Strike, Hammer Ban Strike, Nest Ban Strike, Pickup Ban Strike, Spray Ban Strike, Zombie Ban Strike, Server Ban Strike</span></p>

	<p>13. Zombie-maining is allowed but under certain circumstances<br>
	<span style="font-size:10px;color:gray;">This includes not zombie maining every round for a long duration, not zombie maining with the intent of ruining the experience of others for a long duration, and not zombie maining with the intent of forcing rounds to be lost for for a long duration.</span><br>
	<span style="font-size:10px;color:orange;">Zombie Ban Strike, Server Ban Strike</span></p>
]]