-----------------------------------------
-- Spell: Yurin: Ichi
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
	target:delStatusEffect(EFFECT_INHIBIT_TP);
	effect = target:getStatusEffect(EFFECT_INHIBIT_TP);
	
	-- The power is unknown.
	target:addStatusEffect(EFFECT_INHIBIT_TP,EFFECT_INHIBIT_TP,10,0,180);
	spell:setMsg(230);
	
	return EFFECT_INHIBIT_TP;
end;