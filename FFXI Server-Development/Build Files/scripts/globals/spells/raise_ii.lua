-----------------------------------------
-- Spell: Raise
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	return 0;
end;

function onSpellCast(caster,target,spell)
	target:sendRaise(2);
    spell:setMsg(309);

    return 2;
end;