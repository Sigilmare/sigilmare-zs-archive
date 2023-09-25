PSKILL_REPAIRMAN1 = 500
PSKILL_REPAIRMAN2 = 501
PSKILL_REPAIRMAN3 = 502
PSKILL_REPAIRMAN4 = 503
PSKILL_REPAIRMAN5 = 504

local GOOD = "^"..COLORID_GREEN
local BAD = "^"..COLORID_RED

GM:AddSkill(PSKILL_REPAIRMAN1, "Repairman I",  GOOD.."+4% repair rate",  -20, -2, {SKILL_NONE},        TREE_P_DEFENCE, 1)
GM:AddSkill(PSKILL_REPAIRMAN2, "Repairman II", GOOD.."+5% repair rate",  -20, -1, {PSKILL_REPAIRMAN1}, TREE_P_DEFENCE, 2)
GM:AddSkill(PSKILL_REPAIRMAN3, "Repairman II", GOOD.."+6% repair rate",  -20,  0, {PSKILL_REPAIRMAN2}, TREE_P_DEFENCE, 3)
GM:AddSkill(PSKILL_REPAIRMAN4, "Repairman IV", GOOD.."+7% repair rate",  -20,  1, {PSKILL_REPAIRMAN3}, TREE_P_DEFENCE, 4)
GM:AddSkill(PSKILL_REPAIRMAN5, "Repairman V",  GOOD.."+8% repair rate",  -20,  2, {PSKILL_REPAIRMAN4}, TREE_P_DEFENCE, 5)

GM:AddSkillModifier(PSKILL_REPAIRMAN1, SKILLMOD_REPAIRRATE_MUL, 0.04)
GM:AddSkillModifier(PSKILL_REPAIRMAN2, SKILLMOD_REPAIRRATE_MUL, 0.05)
GM:AddSkillModifier(PSKILL_REPAIRMAN3, SKILLMOD_REPAIRRATE_MUL, 0.06)
GM:AddSkillModifier(PSKILL_REPAIRMAN4, SKILLMOD_REPAIRRATE_MUL, 0.07)
GM:AddSkillModifier(PSKILL_REPAIRMAN5, SKILLMOD_REPAIRRATE_MUL, 0.08)