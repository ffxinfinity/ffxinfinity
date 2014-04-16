-----------------------------------
-- Area: Konschtat Highlands
-- NPC:  Shattered telepoint
-- @pos 135 19 220 108
-----------------------------------
package.loaded["scripts/zones/Konschtat_Highlands/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/zones/Konschtat_Highlands/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	if(player:getCurrentMission(COP) == BELOW_THE_ARKS and player:getVar("COPM2") == 1) then
		player:startEvent(0x0390);  
	elseif(player:getCurrentMission(COP) == BELOW_THE_ARKS and player:getVar("COPM2") >= 2) then
		player:startEvent(0x0391);  

	elseif(player:getCurrentMission(COP) > BELOW_THE_ARKS)then
		player:startEvent(0x0391);
	else
		player:messageSpecial(TELEPOINT_HAS_BEEN_SHATTERED);
	end

end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);
	
	if(csid == 0x0390) then
		player:setVar("COPM2",2);
		player:setPos(-267.194, -40.634, -280.019, 0, 14);
	elseif(csid == 0x0391 and option == 0) then 
		player:setPos(-267.194, -40.634, -280.019, 0, 14); 
	end
	
end;