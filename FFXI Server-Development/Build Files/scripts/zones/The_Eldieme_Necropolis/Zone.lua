-----------------------------------
--
-- Zone: The_Eldieme_Necropolis (195)
--
-----------------------------------

package.loaded["scripts/zones/The_Eldieme_Necropolis/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/zones/The_Eldieme_Necropolis/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
	
	-- rng af2
	local FireAndBrimstoneCS = player:getVar("fireAndBrimstone");	
	if (FireAndBrimstoneCS == 2) then
		return 4;
	end
	
	cs = -1;	
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
		player:setPos(-438.878,-26.091,540.004,126);
	end	
	return cs;	
end;		

-----------------------------------		
-- onRegionEnter		
-----------------------------------		

function onRegionEnter(player,region)	
end;	

-----------------------------------	
-- onEventUpdate	
-----------------------------------	

function onEventUpdate(player,csid,option)	
	--printf("CSID: %u",csid);
	--printf("RESULT: %u",option);
end;	

-----------------------------------	
-- onEventFinish	
-----------------------------------	

function onEventFinish(player,csid,option)	
	--printf("CSID: %u",csid);
	--printf("RESULT: %u",option);
	
	if (csid == 4) then
		player:setVar("fireAndBrimstone",3);		
	end
	
end;	
