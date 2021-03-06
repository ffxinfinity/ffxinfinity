-----------------------------------------
-- ID: 5152
-- Item: slice_of_buffalo_meat
-- Food Effect: 5Min, Galka only
-----------------------------------------
-- Strength 4
-- Agility -5
-- Intelligence -7
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
local result = 0;
	if (target:getRace() ~= 8) then
		result = 247;
	elseif (target:hasStatusEffect(EFFECT_FOOD) == true) then
		result = 246;
	end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addStatusEffect(EFFECT_FOOD,0,0,300,5152);
end;

-----------------------------------------
-- onEffectGain Action
-----------------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_STR, 4);
	target:addMod(MOD_AGI, -5);
	target:addMod(MOD_INT, -7);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_STR, 4);
	target:delMod(MOD_AGI, -5);
	target:delMod(MOD_INT, -7);
end;
