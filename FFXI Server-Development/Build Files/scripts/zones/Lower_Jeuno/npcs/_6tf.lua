-----------------------------------
--	Area: Lower Jeuno
-- 	Door: 
-----------------------------------
package.loaded["scripts/zones/Lower_Jeuno/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/zones/Lower_Jeuno/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:getCurrentMission(ZILART) == AWAKENING and player:getVar("ZMPM") ==0 or player:getVar("ZMPM") ==2)then
player:startEvent(0x0014)
else
return;
end
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

	if(csid == 0x0014)then
	  if(player:getVar("ZMPM") ==2)then
			player:setVar("ZMPM",3);
	  else 
		player:setVar("ZMPM",1);
	end
	end
end;