---------------------------------------------
--  Rock Smash
--
--  Description: Damages a single target. Additional effect: Petrification
--  Type: Physical
--  Utsusemi/Blink absorb: 1 shadow
--  Range: Melee
--  Notes:
---------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------

function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)

	local numhits = 1;
	local accmod = 2;
	local dmgmod = 3;
	local info = MobPhysicalMove(mob,target,skill,numhits,accmod,dmgmod,TP_NO_EFFECT);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_PHYSICAL,MOBPARAM_BLUNT,info.hitslanded);

	local typeEffect = EFFECT_PETRIFICATION;
	local power = math.random(25, 40) + mob:getMainLvl()/3;

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 1, 0, power);

	target:delHP(dmg);
	return dmg;
end;
