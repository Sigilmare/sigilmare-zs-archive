ACH = ACH or {}

ACH.Achievements = {}

ACHCAT_HUMAN = 1
ACHCAT_ZOMBIE = 2

ACHSUBCAT_HUMAN_KILLS = 1
ACHSUBCAT_HUMAN_ASSISTS = 2
ACHSUBCAT_HUMAN_HEADSHOTS = 3
ACHSUBCAT_HUMAN_TOTALDAMAGE  = 4

ACH.ItemCategories = {
	[ACHCAT_HUMAN] = {
		Name = "Human",
		Icon = "icon16/user.png"
	},

	[ACHCAT_ZOMBIE] = {
		Name = "Zombie",
		Icon = "icon16/user_green.png"
	}
}

ACH.ItemSubCategories = {
	[ACHCAT_HUMAN] = {
		[ACHSUBCAT_HUMAN_KILLS] = {
			Name = "Kills",
			Icon = "icon16/gun.png"
		},

		[ACHSUBCAT_HUMAN_ASSISTS] = {
			Name = "Assists",
			Icon = "icon16/bomb.png"
		},

		[ACHSUBCAT_HUMAN_HEADSHOTS] = {
			Name = "Headshots",
			Icon = "icon16/stop.png"
		},

		[ACHSUBCAT_HUMAN_TOTALDAMAGE] = {
			Name = "Total Damage",
			Icon = "icon16/gun.png"
		}
	},

	[ACHCAT_ZOMBIE] = {}
}

function ACH:AddAchievement(nwint, name, desc, cat, subcat, goal, aether, xp)
    local tab = {NWInt = nwint, Name = name or "?", Description = desc, Category = cat, SubCategory = subcat, Goal = goal, Aether = aether, XP = xp}

	ACH.Achievements[#ACH.Achievements + 1] = tab

	return tab
end

local r = {
	40, 40, 80, 150, 250, 500, 750, 1000, 1250, 1500,
	1750, 2000, 2250, 2500, 2750, 3000, 3250, 3500, 3750, 4000,

}

ACH:AddAchievement("HStats.ZombiesKilled", 				"Just Getting Started", 	"Kill 10 zombies", 								ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			10, 	r[2], 	r[2]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Newbie Survivor", 			"Kill 25 zombies", 								ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			25, 	r[3], 	r[3]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Rookie Survivor", 			"Kill 50 zombies", 								ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			50,		r[4], 	r[4]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Mediocre Survivor", 		"Kill 100 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			100,	r[5], 	r[5]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Advanced Survivor", 		"Kill 250 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			250,	r[6], 	r[6]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Skilled Survivor", 		"Kill 500 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			500,	r[7], 	r[7]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Semi-God Survivor", 		"Kill 750 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			750,	r[8], 	r[8]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Godlike Survivor", 		"Kill 1000 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			1000,	r[9], 	r[9]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Extreme Survivor", 		"Kill 1500 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			1500,	r[10], 	r[10]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"The Chosen Survivor", 		"Kill 2000 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			2000,	r[11], 	r[11]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Zombies.. Must.. Die..",	"Kill 2500 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			2500,	r[12], 	r[12]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Zombieslayer", 			"Kill 3000 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			3000,	r[13], 	r[13]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Human Addict", 			"Kill 4000 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			4000,	r[14], 	r[14]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"ZS Obsessed", 				"Kill 5000 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			5000,	r[15], 	r[15]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Worthy Survivor", 			"Kill 6250 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			6250,	r[16], 	r[16]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"No Life Survivor", 		"Kill 7500 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			7500,	r[17], 	r[17]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"Master Survivor", 			"Kill 8750 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			8750,	r[18], 	r[18]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"The True Survivor", 		"Kill 10000 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			10000,	r[19], 	r[19]/2)
ACH:AddAchievement("HStats.ZombiesKilled", 				"God's Survivor", 			"Kill 12500 zombies", 							ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_KILLS, 			12500,	r[20], 	r[20]/2)

ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Backup Survivor I",		"Assist 3 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		3,		r[2],	r[2]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Backup Survivor II",		"Assist 7 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		7,		r[3],	r[3]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Backup Survivor III",		"Assist 15 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		15,		r[4],	r[4]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Backup Survivor IV",		"Assist 25 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		25,		r[5],	r[5]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Backup Survivor V",		"Assist 45 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		45,		r[6],	r[6]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Supportsman I",			"Assist 80 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		80,		r[7],	r[7]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Supportsman II",			"Assist 140 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		140,	r[8],	r[8]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Supportsman III",			"Assist 215 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		215,	r[9],	r[9]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Supportsman IV",			"Assist 325 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		325,	r[10],	r[10]/2)
ACH:AddAchievement("HStats.ZombiesKilledAssists",		"Supportsman V",			"Assist 470 zombie kills",						ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_ASSISTS,		470,	r[11],	r[11]/2)

ACH:AddAchievement("HStats.ZombiesKilledHeadshots",		"Bullseye I",				"Kill 5 zombies with a headshot",				ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_HEADSHOTS,		5,		r[2],	r[2]/2)

ACH:AddAchievement("HStats.DamageToZombies",			"Undead Damager I",			"Deal 1000 damage to zombies", 					ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_TOTALDAMAGE,	1000,	r[2],	r[2]/2)
ACH:AddAchievement("HStats.DamageToZombies",			"Undead Damager II",		"Deal 5000 damage to zombies", 					ACHCAT_HUMAN,	ACHSUBCAT_HUMAN_TOTALDAMAGE,	5000,	r[3],	r[3]/2)