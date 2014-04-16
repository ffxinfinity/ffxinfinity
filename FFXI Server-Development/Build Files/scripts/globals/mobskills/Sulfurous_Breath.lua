---------------------------------------------
-- Sulfurous_Breath
-- Deals Fire damage to enemies within a fan-shaped area.
-- Breath Attack
---------------------------------------------

require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");

---------------------------------------------------

function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)

    local dmgmod = MobBreathMove(mob, target, 0.2, 0.75, ELE_FIRE);

    local dmg = MobFinalAdjustments(dmgmod,mob,skill,target,MOBSKILL_BREATH,MOBPARAM_FIRE,MOBPARAM_IGNORE_SHADOWS);
	target:delHP(dmg);
	return dmg;
end
