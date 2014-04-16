-----------------------------------------
-- Spell: Baramnesra
-----------------------------------------
require("scripts/globals/magic");
require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
	duration = getBarspellDuration(caster);
	power    = getBarspellPower(caster);
	if(caster:getObjType() == TYPE_PC) then
		power    = getBarspellPower(caster) + caster:getMerit(MERIT_BAR_SPELL_EFFECT);
	end
	
	if (caster:hasStatusEffect(EFFECT_COMPOSURE) == true and caster == target) then
		duration = duration * 3;
	end
    target:delStatusEffect(EFFECT_BARAMNESIA);
    target:addStatusEffect(EFFECT_BARAMNESIA,power,0,duration);
end;