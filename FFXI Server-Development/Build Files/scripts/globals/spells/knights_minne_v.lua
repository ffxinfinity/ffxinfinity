-----------------------------------------
-- Spell: Knight's Minne IV
-- Grants Defense bonus to all allies.
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)

	local sItem = caster:getEquipID(2);
	local sLvl = caster:getSkillLevel(40); -- Gets skill level of Singing

	if (sLvl < 228) then -- If your skill level is below 228 you are stuck at the minimum
		power = 50 + caster:getMerit(MERIT_MINNE_EFFECT);
	end

	if (sLvl >= 228 and sLvl <= 290) then -- If your above 227 skill then you get the bonus of 1 more defense for every 3 skill
		sBoost = math.floor((sLvl - 228)/3);
		power = 50 + sBoost + caster:getMerit(MERIT_MINNE_EFFECT);
	end

	if(sLvl >= 291) then -- The bonus caps at skill 222
		power = 62 + caster:getMerit(MERIT_MINNE_EFFECT);
	end

	if(caster:getObjType() == TYPE_PC) then
		if (sLvl < 228) then -- If your skill level is below 228 you are stuck at the minimum
			power = 50 + caster:getMerit(MERIT_MINNE_EFFECT);
		end
	
		if (sLvl >= 228 and sLvl <= 290) then -- If your above 227 skill then you get the bonus of 1 more defense for every 3 skill
			sBoost = math.floor((sLvl - 228)/3);
			power = 50 + sBoost + caster:getMerit(MERIT_MINNE_EFFECT);
		end
	
		if(sLvl >= 291) then -- The bonus caps at skill 222
			power = 62 + caster:getMerit(MERIT_MINNE_EFFECT);
		end
	end

	if(sItem == 17373 or sItem == 17354) then -- Maple Harp +1 or Harp will add 3 more
		power = power + 3;
	end

	if(sItem == 17374) then -- Harp +1 gives 5 more
		power = power + 5;
	end

	-- Until someone finds a way to delete Effects by tier we should not allow bard spells to stack.
	-- Since all the tiers use the same effect buff it is hard to delete a specific one.
	target:delStatusEffect(EFFECT_MINNE);
	target:addStatusEffect(EFFECT_MINNE,power,0,120);
	return EFFECT_MINNE;
end;