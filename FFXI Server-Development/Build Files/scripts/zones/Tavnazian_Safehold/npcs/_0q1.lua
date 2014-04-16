-----------------------------------
-- Area: Tavnazian Safehold
-- NPC:  Sewer entrance
-- @pos 28 -12 44 26
-----------------------------------
package.loaded["scripts/zones/Tavnazian_Safehold/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/zones/Tavnazian_Safehold/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(player:getCurrentMission(COP) == THE_LOST_CITY and player:getVar("PromathiaStatus") == 1)then
		player:startEvent(0x0067);	
    elseif(player:getCurrentMission(COP) == CHAINS_AND_BONDS and player:getVar("PromathiaStatus")==3)then
	    player:startEvent(0x0073);
	elseif(player:getCurrentMission(COP) >= DISTANT_BELIEFS)then
		player:startEvent(0x01f6);
	else
		--player:messageSpecial();
	end
	
	return 1;
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
	
	if(csid == 0x0067)then
		player:setVar("PromathiaStatus",0);
		player:completeMission(COP,THE_LOST_CITY);
		player:addMission(COP,DISTANT_BELIEFS);
	elseif(csid == 0x0073)then
	    player:setVar("PromathiaStatus",4);
	elseif(csid == 0x01f6 and option == 1)then
		player:setPos(260 ,0 ,-289 ,190 ,27);
	end
  
end;
