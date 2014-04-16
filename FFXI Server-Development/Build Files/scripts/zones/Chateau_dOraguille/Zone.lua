-----------------------------------
--
-- Zone: Chateau_dOraguille (233)
--
-----------------------------------
package.loaded["scripts/zones/Chateau_dOraguille/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/missions");
require("scripts/zones/Chateau_dOraguille/TextIDs");

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
	
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
		player:setPos(14.872,8.918,24.002,255);
	end
	
	if(prevZone == 231 and player:getCurrentMission(SANDORIA) == THE_CRYSTAL_SPRING and player:getVar("MissionStatus") == 2) then	
		cs = 0x022b;
	elseif(prevZone == 231 and player:hasKeyItem(MESSAGE_TO_JEUNO_SANDORIA)) then
		cs = 0x01FD;
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
	
	if(csid == 0x022b) then	
		player:setVar("MissionStatus",3);
	elseif(csid == 0x01FD) then
		player:setVar("MissionStatus",9);
		player:delKeyItem(MESSAGE_TO_JEUNO_SANDORIA);
	end
	
end;		
