-----------------------------------
--
-- Zone: Norg (252)
--
-----------------------------------
package.loaded["scripts/zones/Norg/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Norg/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
	
	cs = -1;
	if((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
		player:setPos(-19.238,-2.163,-63.964,187);
	end
	
	if(player:getCurrentMission(ZILART) == AWAKENING and (player:getVar("ZMPM") == 0 or player:getVar("ZMPM") ==1))then
		cs = 0x00b0
	elseif(player:getCurrentMission(ZILART) == THE_NEW_FRONTIER) then
		cs = 0x0001;
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
	
	if(csid == 0x0001) then
		player:addKeyItem(MAP_OF_NORG);
		player:messageSpecial(KEYITEM_OBTAINED,MAP_OF_NORG);
		player:completeMission(ZILART,THE_NEW_FRONTIER);
		player:addMission(ZILART,WELCOME_TNORG);
	elseif(csid == 0x00b0)then
		 if(player:getVar("ZMPM") ==1)then
	   		player:setVar("ZMPM",3);
       	 else
	  		player:setVar("ZMPM",2);
		 end
	end
end;	