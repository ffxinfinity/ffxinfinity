-----------------------------------
--
-- 	EFFECT_HELIX
-- 	
-----------------------------------

require("scripts/globals/status");
require("scripts/globals/magic");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)

end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
	if(target:hasStatusEffect(EFFECT_STONESKIN)) then
		local skin = target:getMod(MOD_STONESKIN);
		local dmg = effect:getPower();
		if(skin >= dmg) then --absorb all damage
			target:delMod(MOD_STONESKIN,effect:getPower());
		else
			target:delStatusEffect(EFFECT_STONESKIN);
			target:delHP(dmg - skin);
			target:wakeUp();
		end
	else
		target:delHP(effect:getPower());
		target:wakeUp();
	end
	if (effect:getTick() == 3000) then
		effect:setTick(9000);
	end
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)

end;