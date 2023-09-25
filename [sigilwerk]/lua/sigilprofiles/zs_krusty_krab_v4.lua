GM.CustomSigilNodes = {
    Vector(2164.5380859375, 626.68249511719, 0.03125011920929),
    Vector(2188.7202148438, -35.194702148438, 0.03125),
    Vector(2185.1149902344, -217.93695068359, 0.03125),
}

hook.Add("InitPostEntityMap", "MapProfile", function()
    if GAMEMODE_NAME == "zombiesurvival" then
        GAMEMODE:CreateCustomSigils()
    end
end)