-----------------------------------   
-- Wildfire
-- Marksmanship weapon skill   
-- Skill level: 357   
-- Empyrean Weapon Skill
-- COR Main Job Required
-- Aligned with the Light Gorget & Flame Gorget.   
-- Aligned with the Light Belt & Flame Belt.   
-- Element:
-- Modifiers: AGI:60%
-- 100%TP    200%TP    300%TP   
--  5.5      5.5      5.5
-----------------------------------   
require("scripts/globals/status");     
require("scripts/globals/settings");   
require("scripts/globals/weaponskills");       
-----------------------------------   
       
function OnUseWeaponSkill(player, target, wsID)
       
        local params = {};
        params.numHits = 1;
        params.ftp100 = 5.5; params.ftp200 = 5.5; params.ftp300 = 5.5;
        params.str_wsc = 0.16; params.dex_wsc = 0.0; params.vit_wsc = 0.0; params.agi_wsc = 0.6; params.int_wsc = 0.0; params.mnd_wsc = 0.0; params.chr_wsc = 0.0;
        params.crit100 = 0.0; params.crit200 = 0.0; params.crit300 = 0.0;
        params.canCrit = false;
        params.acc100 = 0.0; params.acc200= 0.0; params.acc300= 0.0;
        params.atkmulti = 1;
        damage, tpHits, extraHits = doRangedWeaponskill(player, target, params);
       
        return tpHits, extraHits, damage;
       
end