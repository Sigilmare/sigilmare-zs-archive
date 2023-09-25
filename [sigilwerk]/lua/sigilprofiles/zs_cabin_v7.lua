GM.CustomSigilNodes = {
    Vector(733.44500732422, -345.13107299805, 8.03125),
    Vector(477.53454589844, 138.11781311035, 8.03125),
    Vector(765.52581787109, 101.87024688721, 8.03125)
}

hook.Add("InitPostEntityMap", "MapProfile", function()
    if GAMEMODE_NAME == "zombiesurvival" then
        GAMEMODE:CreateCustomSigils()
    end
end)