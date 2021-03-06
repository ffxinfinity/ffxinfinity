---------------------------------------------
--  Osmosis
--
--  Description: Steals an enemy's HP and one beneficial status effect. Ineffective against undead.
--  Type: Magical
---------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------

function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)

    local effect = target:stealStatusEffect();

    if(effect ~= nil and mob:hasStatusEffect(effect:getType()) == false) then
        -- add to myself
        mob:addStatusEffect(effect:getType(), effect:getPower(), effect:getTickCount(), effect:getDuration());
    end

	local dmgmod = 1;
	local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg()*5,ELE_DARK,dmgmod,TP_MAB_BONUS,1);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_DARK,MOBPARAM_IGNORE_SHADOWS);


    if(target:isUndead() == false) then
        target:delHP(dmg);
        mob:addHP(dmg);
        skill:setMsg(MSG_DRAIN_HP);
    else
        skill:setMsg(MSG_NO_EFFECT);
    end

	return dmg;
end;
