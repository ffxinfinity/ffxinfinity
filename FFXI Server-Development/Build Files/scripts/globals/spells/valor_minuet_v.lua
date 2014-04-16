-----------------------------------------
-- Spell: Valor Minuet IV
-- Grants Attack bonus to all allies.
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)

    local sItem = caster:getEquipID(2);
    local sLvl = caster:getSkillLevel(40); -- Gets skill level of Singing

    if (sLvl < 200) then -- If your skill level is below 200 you are stuck at the minimum
        power = 40;
    end

    if (sLvl >= 200 and sLvl <= 270) then -- If your above 201 skill then you get the bonus of 1 more attack for every 4 skill
        sBoost = math.floor((sLvl - 200)/4);
        power = 40 + sBoost;
    end

    if(sLvl >= 271) then -- The bonus caps at skill 271
        power = 72;
    end

    if(caster:getObjType() == TYPE_PC) then
    	if (sLvl < 200) then -- If your skill level is below 200 you are stuck at the minimum
	        power = 40 + caster:getMerit(MERIT_MINUET_EFFECT);
	    end
	
	    if (sLvl >= 200 and sLvl <= 270) then -- If your above 201 skill then you get the bonus of 1 more attack for every 4 skill
	        sBoost = math.floor((sLvl - 200)/4);
	        power = 40 + sBoost + caster:getMerit(MERIT_MINUET_EFFECT);
	    end
	
	    if(sLvl >= 271) then -- The bonus caps at skill 271
	        power = 72 + caster:getMerit(MERIT_MINUET_EFFECT);
	    end
    end

    if(sItem == 17344) then -- Cornette will add 3 more
        power = power + 3;
    end

    if(sItem == 17369 or sItem == 17846) then -- Cornette +1 and Cornette +2 give 5 more
        power = power + 5;
    end

    -- Until someone finds a way to delete Effects by tier we should not allow bard spells to stack.
    -- Since all the tiers use the same effect buff it is hard to delete a specific one.
    target:delStatusEffect(EFFECT_MINUET);
    target:addStatusEffect(EFFECT_MINUET,power,0,120);

    return EFFECT_MINUET;
end;