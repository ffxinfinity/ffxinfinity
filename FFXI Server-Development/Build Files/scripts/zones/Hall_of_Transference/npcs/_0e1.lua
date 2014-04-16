-----------------------------------
-- Cermet Gate
-- GATE TO PRMY DEM
-- @pos -220 -46 -279 14
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/zones/Hall_of_Transference/TextIDs");
-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	if(player:hasKeyItem(LIGHT_OF_DEM))then
		player:startEvent(0x0097);
	elseif(player:getVar("PH") >=2 or player:getVar("PM") >= 2)then
		player:messageSpecial(DOOR_IS_CLOSED);
	elseif(player:getVar("PD") >= 2) then
		player:startEvent(0x0097);
	else
		player:messageSpecial(DOOR_IS_CLOSED);
	end
	return 1;
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

	if(csid == 0x0097 and option == 1) then
		player:setPos(152,0 ,-70 ,81 ,18); 
	end
end;