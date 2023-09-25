hook.Add("PostPlayerSpawnHuman", "MapProfile", function(pl)
    pl:StripWeapons()
    pl:StripAmmo()
    pl:Give("weapon_zs_boomstick_b1")
    pl:GiveAmmo(1000, "buckshot")
end)

hook.Add("OnWaveStart", "MapProfile", function()
    for i=1, 3 do
        PrintMessageColor({Color(255, 165, 0), "PREMIUM MAP PROFILES BROUGHT TO YOU BY SIGILMARE"})
    end
end)

hook.Add("InitPostEntityMap", "MapProfile", function()
    util.RemoveAll("prop_ammo")
    util.RemoveAll("prop_weapon")
end)