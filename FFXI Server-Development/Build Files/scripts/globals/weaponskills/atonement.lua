-----------------------------------	
-- Atonement
-- Sword weapon skill	
-- Skill Level: NA	
-- Delivers a twofold attack. Damage varies with TP. Burtgang: Aftermath effect varies with TP.		
-- In order to obtain Atonement, the quest Unlocking a Myth must be completed.	
-- Will stack with Sneak Attack.	
-- Aligned with the Aqua Gorget, Flane Gorget & Light Gorget	
-- Aligned with the Aqua Belt, Flame Belt & Light Belt.	
-- Element: None	
-- Modifiers: Related to accumulated Eminity	
-- 100%TP    200%TP    300%TP	
-- 1.00      1.75      2.50	
-----------------------------------	
	
require("scripts/globals/status");	
require("scripts/globals/settings");	
require("scripts/globals/weaponskills");	
-----------------------------------	
	
function OnUseWeaponSkill(player, target, wsID)	
	
	local params = {};
	params.numHits = 2;
	params.ftp100 = 1; params.ftp200 = 1.75; params.ftp300 = 2.5;
	params.str_wsc = 0.3; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.0; params.int_wsc = 0.0; params.mnd_wsc = 0.5; params.chr_wsc = 0.0;
	params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
	params.canCrit = false;
	params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
	params.atkmulti = 1;
	local damage, tpHits, extraHits = doPhysicalWeaponskill(player, target, params);
	
	return tpHits, extraHits, damage;
	
end	
