--------------------------------------
-- 	Spell: Boost-CHR
-- 	Boosts targets CHR stat
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

    if(target:hasStatusEffect(EFFECT_CHR_DOWN) == true) then
        target:delStatusEffect(EFFECT_CHR_DOWN);
    else
        target:addStatusEffect(EFFECT_CHR_BOOST,power,0,duration);
    end
end;
