---------------------------------------------------
-- Aerial Wheel
-- Deals a ranged attack to a single target. Additional effect: stun
---------------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------------

function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local numhits = 1;
	local accmod = 0.7;
	local dmgmod = 2;
	local info = MobRangedMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_RANGED,MOBPARAM_PIERCE,info.hitslanded);

	local typeEffect = EFFECT_STUN;
	MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, 4);

	target:delHP(dmg);
	return dmg;
end;
