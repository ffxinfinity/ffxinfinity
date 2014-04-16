-----------------------------------	
-- Expiacion
-- Sword weapon skill
-- Skill level: NA
-- Tizona: Aftermath effect varies with TP. 
-- In order to obtain Expiacion, the quest Unlocking a Myth must be completed. 
-- Description: Delivers a twofold attack.
-- Aligned with the Aqua Gorget, Snow Gorget & Soil Gorget. 
-- Aligned with the Aqua Belt, Snow Belt & Soil Belt. 
-- Element: None	
-- Modifiers: STR:30% INT:30%
-- 100%TP    200%TP    300%TP	
-- 1.5        2.0       2.5
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 2;
	params.ftp100 = 1.5; params.ftp200 = 2.0; params.ftp300 = 2.5;
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.3; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);

	return tpHits, extraHits, damage;
end	
