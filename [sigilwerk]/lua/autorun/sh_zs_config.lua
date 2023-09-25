ZS = ZS or {}
local meta = FindMetaTable("Player")

ZS.XPMul = 1

ZS.TimeLimit = 15 * 60
ZS.RoundLimit = 3

ZS.Playermodels = {
    ["STEAM_0:0:105668971"] = {
		Name = "Sigilmare",
		Model = "models/player/sunflowersp/cgss/yumemiriamupm.mdl",
		ArmsModel = "models/player/sunflowersp/cgss/c_arms/yumemiriamu_arms.mdl",
		VoiceSet = VOICESET_ZOMBIE,
	},

	["STEAM_0:0:711585653"] = {
		Name = "Rex",
		Model = "models/custom_models/skeleton_tophat.mdl",
		ArmsModel = "models/weapons/c_arms_skeleton.mdl",
		VoiceSet = VOICESET_ZOMBIE
	},
}

function meta:GetTotalXPMultiplier()
    local add = 0
    if string.StartsWith(self:Name(), "[Sigilmare]") then
        add = 0.15
    elseif string.StartsWith(self:Name(), "[SM]") then
        add = 0.05
    else
        add = 0
    end

    return ZS.XPMul + add
end

if SERVER then
    function song(link)
        BroadcastLua([[URLSound("]]..link..[[")]])
    end

    local meta = FindMetaTable("Player")
    function meta:CreateZSHands(armsmdl)
        local oldhands = self:GetHands()
		if IsValid(oldhands) then
			oldhands:Remove()
		end

		local hands = ents.Create("zs_hands")
		if hands:IsValid() then
            if armsmdl then
			    hands:DoSetup(self, armsmdl)
            else
                hands:DoSetup(self)
            end
			hands:Spawn()
		end
    end
end