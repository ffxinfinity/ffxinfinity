--------------------------------------
-- 	Spell: Gain-DEX
-- 	Boosts targets DEX stat
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

    if(enchanceSkill <309)then
        power = 5
    elseif(enchanceSkill >=309 and enchanceSkill <=319)then
    	power = 6
    elseif(enchanceSkill >=320 and enchanceSkill <=329)then
    	power = 7
    elseif(enchanceSkill >=330 and enchanceSkill <=339)then
    	power = 8
    elseif(enchanceSkill >=340 and enchanceSkill <=349)then
    	power = 9
    elseif(enchanceSkill >=350 and enchanceSkill <=359)then
    	power = 10
    elseif(enchanceSkill >=360 and enchanceSkill <=369)then
    	power = 11
    elseif(enchanceSkill >=370 and enchanceSkill <=379)then
    	power = 12
    elseif(enchanceSkill >=380 and enchanceSkill <=389)then
    	power = 13
    elseif(enchanceSkill >=390 and enchanceSkill <=399)then
    	power = 14
    elseif(enchanceSkill >=400 and enchanceSkill <=409)then
    	power = 15
    elseif(enchanceSkill >=410 and enchanceSkill <=419)then
    	power = 16
    elseif(enchanceSkill >=420 and enchanceSkill <=429)then
    	power = 17
    elseif(enchanceSkill >=430 and enchanceSkill <=439)then
    	power = 18
    elseif(enchanceSkill >=440 and enchanceSkill <=449)then
    	power = 19
    elseif(enchanceSkill >=450 and enchanceSkill <=459)then
    	power = 20
    elseif(enchanceSkill >=460 and enchanceSkill <=469)then
    	power = 21
    elseif(enchanceSkill >=470 and enchanceSkill <=479)then
    	power = 22
    elseif(enchanceSkill >=480 and enchanceSkill <=489)then
    	power = 23
    elseif(enchanceSkill >=480 and enchanceSkill <=499)then
    	power = 24
    else
    	power = 25
    end

    if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
        duration = duration * 3;
    end

    if(target:hasStatusEffect(EFFECT_DEX_DOWN) == true) then
        target:delStatusEffect(EFFECT_DEX_DOWN);
    else
        target:addStatusEffect(EFFECT_DEX_BOOST,power,0,duration);
    end
end;
