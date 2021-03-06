---------------------------------------------------
-- Berserk
-- Berserk Ability.
---------------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------------

function OnMobSkillCheck(target,mob,skill)
    if(mob:getHPP() <= 60) then
        return 0;
    end
    return 1;
end;

function OnMobWeaponSkill(target, mob, skill)
    local typeEffect = EFFECT_INVINCIBLE;
    MobBuffMove(mob, typeEffect, 1, 0, 30);

    skill:setMsg(MSG_USES);
    return typeEffect;
end;
