--------------------------------------
-- 	Spell: Boost-VIT
-- 	Boosts targets VIT stat
--------------------------------------
 
require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
    enchanceSkill = caster:getSkillLevel(34);

    duration = 300;

    if(enchanceSkill >300)then
        power = 5 + (0.1 * (enchanceSkill - 300));
    else
    	power = 5;
    end

    if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
        duration = duration * 3;
    end

    if(target:hasStatusEffect(EFFECT_VIT_DOWN) == true) then
        target:delStatusEffect(EFFECT_VIT_DOWN);
    else
        target:addStatusEffect(EFFECT_VIT_BOOST,power,0,duration);
    end
end;
