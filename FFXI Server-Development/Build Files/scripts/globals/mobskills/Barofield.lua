---------------------------------------------
--  Barofield
--
--  Description: Deals Wind damage to enemies within a fan-shaped area. Additional effect: Weight 
--  Type: Magical
--  Ignores Shadows
--  Range: 15' Cone
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
    return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local dmgmod = 1.25;
	local info = MobMagicalMove(mob,target,skill,mob:getWeaponDmg() * 2,ELE_WIND,dmgmod,TP_MAB_BONUS,1);
	local dmg = MobFinalAdjustments(info.dmg,mob,skill,target,MOBSKILL_MAGICAL,MOBPARAM_WIND,MOBPARAM_IGNORE_SHADOWS);

   MobStatusEffectMove(mob, target, EFFECT_WEIGHT, 50, 0, 60);

	target:delHP(dmg);
	return dmg;
end;
