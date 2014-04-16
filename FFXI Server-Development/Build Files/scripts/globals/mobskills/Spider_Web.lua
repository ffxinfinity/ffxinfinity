---------------------------------------------------
-- Spider Web
-- Entangles all targets in an area of effect.
---------------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------------

function OnMobSkillCheck(target,mob,skill)
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local typeEffect = EFFECT_SLOW;
	local power = 300;

	skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, power, 0, duration));

	return typeEffect;
end;
