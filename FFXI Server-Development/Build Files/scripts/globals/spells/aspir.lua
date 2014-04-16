-----------------------------------------
-- Spell: Aspir
-- Drain functions only on skill level!!
-----------------------------------------

require("scripts/globals/magic");
require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	--calculate raw damage (unknown function  -> only dark skill though) - using http://www.bluegartr.com/threads/44518-Drain-Calculations
	-- also have small constant to account for 0 dark skill
	dmg = 5 + 0.375 * (caster:getSkillLevel(DARK_MAGIC_SKILL) + caster:getMod(79 + DARK_MAGIC_SKILL));
	--get resist multiplier (1x if no resist)
	resist = applyResistance(caster,spell,target,caster:getStat(MOD_INT)-target:getStat(MOD_INT),DARK_MAGIC_SKILL,1.0);
	--get the resisted damage
	dmg = dmg*resist;
	--add on bonuses (staff/day/weather/jas/mab/etc all go in this function)
	dmg = addBonuses(caster,spell,target,dmg);
	--add in target adjustment
	dmg = adjustForTarget(target,dmg);
	--add in final adjustments

	if(target:isUndead()) then
		spell:setMsg(75); -- No effect
		return dmg;
	end

	if(target:getMP() > dmg) then
		caster:addMP(dmg);
		target:delMP(dmg);
	else
		dmg = target:getMP();
		caster:addMP(dmg);
		target:delMP(dmg);
	end

	spell:setMsg(228); --change msg to 'xxx mp drained from the yyyy.'
	return dmg;
end;