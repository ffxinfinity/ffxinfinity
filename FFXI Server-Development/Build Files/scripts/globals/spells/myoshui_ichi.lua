-----------------------------------------
-- Spell: Myoshui: Ichi
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
	target:delStatusEffect(EFFECT_SUBTLE_BLOW_PLUS);
	effect = target:getStatusEffect(EFFECT_SUBTLE_BLOW_PLUS);
	
	-- The power is unknown.
	target:addStatusEffect(EFFECT_SUBTLE_BLOW_PLUS,EFFECT_SUBTLE_BLOW_PLUS,10,0,180);
	spell:setMsg(230);
	
	return EFFECT_SUBTLE_BLOW_PLUS;
end;