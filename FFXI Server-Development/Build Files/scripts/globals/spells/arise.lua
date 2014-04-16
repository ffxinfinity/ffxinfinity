-----------------------------------------
-- Spell: Arise
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell)
	target:sendRaise(3);
	target:delStatusEffect(EFFECT_RERAISE);
    	target:addStatusEffect(EFFECT_RERAISE,3,0,3600); --reraise 3, 1 hr duration
end;