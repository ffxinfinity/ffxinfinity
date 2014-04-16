----------------------------------	
-- Area: Gustav Tunnel	
--  MOB: Nanoplasm
-----------------------------------	
package.loaded["scripts/zones/Gustav_Tunnel/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/globals/status");
require("scripts/zones/Gustav_Tunnel/TextIDs");





-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)
killer:setVar("BASTOK91",killer:getVar("BASTOK91")+1);
   end;	
