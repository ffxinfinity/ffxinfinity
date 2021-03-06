-----------------------------------	
-- Leaden Salute
-- Marksmanship weapon skill	
-- Skill Level: NA
-- Deals darkness elemental damage. Damage varies with TP.
-- Death Penalty: Aftermath effect varies with TP.
-- Aligned with the Shadow, Soil, & Light Gorgets.	
-- Aligned with the Shadow, Soil, & Light Belts.	
-- Element: Darkness	
-- Modifiers: AGI:30%	
-- 100%TP    200%TP    300%TP	
-- 4.00      4.25      4.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 1;
	params.ftp100 = 4; params.ftp200 = 4.25; params.ftp300 = 4.75;
	params.str_wsc = 0.0; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.3; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.8; params.acc200= 0.9; params.acc300= 1;
	params.atkmulti = 1;
	local damage, tpHits, extraHits = doRangedWeaponskill(player, target, params);
	
	return tpHits, extraHits, damage;
	
end	
