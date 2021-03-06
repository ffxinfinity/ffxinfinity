---------------------------------------------
--  Curse
--
--  Description: Inflicts a curse on all targets in an area of effect.
--  Type: Enfeebling
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 15' radial
--  Notes: Curse has a very long duration.
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local typeEffect = EFFECT_CURSE_I;

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 25, 0, 480));

	return typeEffect;
end;
