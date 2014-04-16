-----------------------------------------
-- Spell: Kakka: Ichi
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
	target:delStatusEffect(EFFECT_STORE_TP);
	effect = target:getStatusEffect(EFFECT_STORE_TP);
	
	target:addStatusEffect(EFFECT_STORE_TP,EFFECT_STORE_TP,10,0,180);
	spell:setMsg(230);
	
	return EFFECT_STORE_TP;
end;