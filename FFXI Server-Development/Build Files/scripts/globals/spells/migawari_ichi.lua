-----------------------------------------
-- Spell: Migawari: Ichi
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
	target:delStatusEffect(EFFECT_MIGAWARI);
	effect = target:getStatusEffect(EFFECT_MIGAWARI);
	
	target:addStatusEffect(EFFECT_MIGAWARI,EFFECT_MIGAWARI,0,0,60);
	spell:setMsg(230);
	
	return EFFECT_MIGAWARI;
end;