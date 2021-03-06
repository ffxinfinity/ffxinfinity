-----------------------------------------
-- ID: 4361
-- Item: nebimonite
-- Food Effect: 5Min, Mithra only
-----------------------------------------
-- Dexterity -3
-- Vitality 2
-- Defense % 12.9
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
local result = 0;
	if (target:getRace() ~= 7) then
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
	target:addStatusEffect(EFFECT_FOOD,0,0,300,4361);
end;

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_DEX, -3);
	target:addMod(MOD_VIT, 2);
	target:addMod(MOD_DEFP, 12.9);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_DEX, -3);
	target:delMod(MOD_VIT, 2);
	target:delMod(MOD_DEFP, 12.9);
end;
