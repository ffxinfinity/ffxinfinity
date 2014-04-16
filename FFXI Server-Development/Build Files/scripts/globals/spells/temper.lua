-----------------------------------------
--	Spell: TEMPER
-----------------------------------------

require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
	enhskill = caster:getSkillLevel(ENHANCING_MAGIC_SKILL);
	final = 0;
	duration = 180;
	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster:getID() == target:getID()) then
		duration = duration * 3;
	end

	if(enhskill<=360) then
		final = 5;
	elseif(enhskill>360) then
		final = math.floor((enhskill - 360)/10) + 5;
	else
		print("Warning: Unknown enhancing magic skill for Temper.");
	end

	if(final>20) then
		final = 20;
	end

	if(target:hasStatusEffect(EFFECT_IFRIT_S_FAVOR)) then
		oldeffect = target:getStatusEffect(EFFECT_IFRIT_S_FAVOR);
		if(oldeffect:getPower()<=final) then --overwrite
			target:delStatusEffect(EFFECT_IFIRIT_S_FAVOR);
			target:addStatusEffect(EFFECT_IFRIT_S_FAVOR,final,0,duration);
			spell:setMsg(0);
		else --no effect
			spell:setMsg(75);
		end
	else
		target:addStatusEffect(EFFECT_IFRIT_S_FAVOR,final,0,duration);
		spell:setMsg(0);
	end

	return EFFECT_IFRIT_S_FAVOR;
end;