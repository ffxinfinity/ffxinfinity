-----------------------------------	
-- Bora Axe	
-- Axe weapon skill
-- Skill level: 290
-- Delivers a single-hit ranged attack at a maximum distance of 15.7'. Chance of binding varies with TP
-- Bind doesn't always break from hitting mob. 
-- This Weapon Skill's first hit params.ftp is duplicated for all additional hits
-- Not natively available to RNG 
-- Aligned with the ?? Gorget. 
-- Element: Ice	
-- Modifiers: DEX 60%  --http://wiki.bluegartr.com/bg/Bora_Axe
-- 100%TP    200%TP    300%TP	
-- 1.0        1.0      1.0

-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 1.0; params.ftp200 = 1.0; params.ftp300 = 1.0;
	params.str_wsc = 0.0; params.dex_wsc = 0.6; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 3.5;
	local damage, criticalHit, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	if damage > 0 and (target:hasStatusEffect(EFFECT_BIND) == false) then
		target:addStatusEffect(EFFECT_BIND, 1, 0, 20);
	end

	return tpHits, extraHits, criticalHit, damage;
	
end	
