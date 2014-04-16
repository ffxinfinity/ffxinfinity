-----------------------------------	
-- Stringing Pummel
-- Hand-to-Hand weapon skill	
-- Skill Level: NA
-- Delivers an sixfold attack. Chance of critical varies with TP. 
-- Kenkonken:Aftermath effect varies with TP.
-- In order to obtain Stringing Pummel, the quest Unlocking a Myth must be completed.	
-- Aligned with the Shadow Gorget, Soil Gorget & Flame Gorget.	
-- Aligned with the Shadow Belt, Soil Belt & Flame Belt.	
-- Element: None	
-- Modifiers: STR:32% ; VIT:32%	
-- 100%TP    200%TP    300%TP	
-- 0.75      0.75      0.75	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 6;
	params.ftp100 = 0.75; params.ftp200 = 0.75; params.ftp300 = 0.75;
	params.str_wsc = 0.32; params.dex_wsc = 0.0; params.vit_wsc = 0.32; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
	params.crit100 = 0.2; params.crit200 = 0.3; params.crit300 = 0.45;
	params.canCrit = false;
	params.acc100 = 0.8; params.acc200= 0.9; params.acc300= 1;
	params.atkmulti = 1;
	local damage, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	return tpHits, extraHits, damage;
	
end	
