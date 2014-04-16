-----------------------------------------
-- ID: 5621
-- Item: Candy of Vanadiel
-- Item Effect: too many to list
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnItemCheck
-----------------------------------------

function onItemCheck(target)
	result = 0;
	-- printf("Checking for rage");
	raged = target:getStatusEffect(850);
	if ((raged ~= nil) or (target:hasStatusEffect(850) == true) or (target:hasStatusEffect(EFFECT_MEDICINE) == true)
		or (target:hasStatusEffect(EFFECT_WEAKNESS) == true)) then
		result = 111;
	end
	-- printf("result = %u", result);
	return result;
end;

-----------------------------------------
-- OnItemUse
-----------------------------------------

function onItemUse(target)
	-- printf("Adding Med");
	target:addStatusEffect(EFFECT_MEDICINE,0,0,1800,5621);

	-- printf("In OnItemUse");
end;

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	-- printf("Adding Rage");
	--target:addStatusEffect(850, EFFECT_MEDICINE, 0, 60);
	
	-- printf("In OnGainEffect");
	target:addTP(300);
	target:addMod(MOD_STR, 75);
	target:addMod(MOD_DEX, 75);
	target:addMod(MOD_VIT, 75);
	target:addMod(MOD_AGI, 75);
	target:addMod(MOD_INT, 75);
	target:addMod(MOD_MND, 75);
	target:addMod(MOD_CHR, 75);
	-- printf("Updating HP and MP");
	target:addMod(MOD_HPP, 20);
	target:addMod(MOD_MPP, 20);
	-- printf("Updating attack and magic");
	target:addMod(MOD_ATT, 20);
	target:addMod(MOD_RATT, 20);
	target:addMod(MOD_ACC, 20);
	target:addMod(MOD_RACC, 20);
	target:addMod(MOD_MATT, 20);
	target:addMod(MOD_MACC, 20);
	target:addMod(MOD_DEF, 20);
	target:addMod(MOD_MDEF, 20);
	-- printf("updating healing values");
	target:addMod(MOD_MPHEAL, 20);
	target:addMod(MOD_HPHEAL, 20);
	-- printf("adding haste regen refresh and tp");
	target:addMod(MOD_CRITHITRATE, 30);
	target:addMod(MOD_HASTE_MAGIC, 12);
	target:addMod(MOD_REGEN, 8);
	target:addMod(MOD_REFRESH, 8);
	target:addMod(MOD_STORETP, 25);
	-- printf("setting xp rates");
	target:setXPRate(7.0);
end;

-----------------------------------------
-- onEffectLose Action
-----------------------------------------

function onEffectLose(target,effect)
	-- printf("in onloseeffect");
	target:delMod(MOD_STR, 75);
	target:delMod(MOD_DEX, 75);
	target:delMod(MOD_VIT, 75);
	target:delMod(MOD_AGI, 75);
	target:delMod(MOD_INT, 75);
	target:delMod(MOD_MND, 75);
	target:delMod(MOD_CHR, 75);
	-- printf("modifying hp and mp");
	target:delMod(MOD_HPP, 20);
	target:delMod(MOD_MPP, 20);
	-- printf("modifying attack and magic");
	target:delMod(MOD_ATT, 20);
	target:delMod(MOD_RATT, 20);
	target:delMod(MOD_ACC, 20);
	target:delMod(MOD_RACC, 20);
	target:delMod(MOD_MATT, 20);
	target:delMod(MOD_MACC, 20);
	target:delMod(MOD_DEF, 20);
	target:delMod(MOD_MDEF, 20);
	-- printf("modifying healing values");
	target:delMod(MOD_MPHEAL, 20);
	target:delMod(MOD_HPHEAL, 20);
	-- printf("modifying haste regen refresh and tp");
	target:delMod(MOD_CRITHITRATE, 30);
	target:delMod(MOD_HASTE_MAGIC, 10);
	target:delMod(MOD_REGEN, 8);
	target:delMod(MOD_REFRESH, 8);
	target:delMod(MOD_STORETP, 25);
	-- printf("adding weakness");
	target:addStatusEffect(EFFECT_WEAKNESS,1,0,2700);
	target:rageEffectComplete();
	-- printf("resetting xp rates");
	target:setXPRate(1.0);
end;