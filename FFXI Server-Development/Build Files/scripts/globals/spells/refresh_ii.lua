-----------------------------------------
-- Spell: Refresh II
-- Gradually restores target party member's MP
-----------------------------------------

require("scripts/globals/status");

-----------------------------------------
-- OnMagicCastingCheck
-----------------------------------------

function OnMagicCastingCheck(caster,target,spell)
	
	return 0;

end;

-----------------------------------------
-- OnSpellCast
-----------------------------------------

function onSpellCast(caster,target,spell) 
    
	   
    mp = 6; 
	duration = 180;
	
			
	if (target:getMainLvl() < 41) then
		duration = duration * target:getMainLvl() / 41;
	end
	
	target:delStatusEffect(EFFECT_REFRESH);
	target:addStatusEffect(EFFECT_REFRESH,mp,3,duration);
    return 0;
	
end;