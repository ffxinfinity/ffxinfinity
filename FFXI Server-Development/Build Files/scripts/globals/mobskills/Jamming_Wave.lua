---------------------------------------------
--  Jamming Wave
--
--  Description: Silence Area of Effect (16.0')
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Ignores shadows
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
    local typeEffect = EFFECT_SILENCE;

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1, 0, math.random(30, 60)));
    return typeEffect;
end;
