-----------------------------------
--
-- 	EFFECT_POISON
--
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
    --nRes=1;
	--cRes = target:getMod(MOD_POISONRES);
    --if(cRes > 0) then
	--    nRes = cRes + nRes
	--end
    --target:setMod(MOD_POISONRES,nRes,30);
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
end;


-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
end;