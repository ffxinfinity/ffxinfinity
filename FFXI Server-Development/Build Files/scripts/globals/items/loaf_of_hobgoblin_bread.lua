-----------------------------------------
-- ID: 4328
-- Item: loaf_of_hobgoblin_bread
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 10
-- Vitality 3
-- Charisma -7
-- Health Regen While Healing 2
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
local result = 0;
	if (target:hasStatusEffect(EFFECT_FOOD) == true) then
		result = 246;
	end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addStatusEffect(EFFECT_FOOD,0,0,3600,4328);
end;

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_HP, 10);
	target:addMod(MOD_VIT, 3);
	target:addMod(MOD_CHR, -7);
	target:addMod(MOD_HPHEAL, 2);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_HP, 10);
	target:delMod(MOD_VIT, 3);
	target:delMod(MOD_CHR, -7);
	target:delMod(MOD_HPHEAL, 2);
end;
