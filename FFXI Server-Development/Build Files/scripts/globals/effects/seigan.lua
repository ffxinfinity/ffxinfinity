-----------------------------------
--
--
--
-----------------------------------

require("scripts/globals/status");

-----------------------------------
-- onEffectGain Action
-----------------------------------

function onEffectGain(target,effect)
	target:addMod(MOD_COUNTER,(target:getMod(MOD_ZANSHIN)/4));
	target:addMod(MOD_FASTCAST,-50);
end;

-----------------------------------
-- onEffectTick Action
-----------------------------------

function onEffectTick(target,effect)
end;

-----------------------------------
-- onEffectLose Action
-----------------------------------

function onEffectLose(target,effect)
	target:delMod(MOD_COUNTER,(target:getMod(MOD_ZANSHIN)/4));
	target:delMod(MOD_FASTCAST,-50);
end;
