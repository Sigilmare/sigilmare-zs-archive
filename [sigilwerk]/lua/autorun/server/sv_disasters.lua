function Blackhole(buyer, changemap)
    if not changemap then
        changemap = "gm_construct"
    end

    if SM.BlackholeUsed then
        buyer:PrintMessage(HUD_PRINTTALK, "[Blackhole] Cannot create Blackhole: Blackhole has already been called.")
        return
    end

    if SM.BlackholeNodes[game.GetMap()] then
        SM.BlackholeUsed = true

        BroadcastLua("MySelf:EmitSound(\"sigilmare/disasters/blackhole.wav\", 0, 100, 1, CHAN_STATIC)")

        if engine.ActiveGamemode() == "zombiesurvival" then
            if buyer then
                GAMEMODE:CenterNotify(SIGILCOLOR_DISASTER, {font = "ZSHUDFontSmall"}, buyer:Name().." just called a Blackhole!")
            end
            GAMEMODE:SaveAllVaults()
        end

        timer.Simple(1.1, function()
            RunConsoleCommand("ulx","ragdoll","*")

            local ent = ents.Create("blackhole")
            ent:SetPos(SM.BlackholeNodes[game.GetMap()])
            SM.BlackholeMap = changemap
            ent:Spawn()
        end)
    else
        buyer:PrintMessage(HUD_PRINTTALK, "[Blackhole] Cannot create Blackhole: No Blackhole node supported for current map. Please contact Sigilmare if you want this map supported.")
    end
end