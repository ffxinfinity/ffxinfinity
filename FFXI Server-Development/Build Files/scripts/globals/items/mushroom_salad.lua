-----------------------------------------
-- ID: 5678
-- Item: mushroom_salad
-- Food Effect: 180Min, All Races
-----------------------------------------
-- MP 85
-- Agility 6
-- Mind 6
-- Strength -5
-- Vitality -5
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
result = 0;
	if (target:hasStatusEffect(EFFECT_FOOD) == true) then
		result = 246;
	end
return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	target:addStatusEffect(EFFECT_FOOD,0,0,10800,5678);
end;

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_MP, 85);
	target:addMod(MOD_AGI, 6);
	target:addMod(MOD_MND, 6);
	target:addMod(MOD_STR, -5);
	target:addMod(MOD_VIT, -5);
	
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_MP, 85);
	target:delMod(MOD_AGI, 6);
	target:delMod(MOD_MND, 6);
	target:delMod(MOD_STR, -5);
	target:delMod(MOD_VIT, -5);
end;
