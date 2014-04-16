-----------------------------------
-- Cermet Gate
-- GATE TO PROMY MEA
-- @pos 280 -86 -19
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/globals/settings");
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

	if(player:hasKeyItem(LIGHT_OF_MEA))then
		player:startEvent(0x0098);
	elseif(player:getVar("PH") >=2 or player:getVar("PD") >= 2)then
		player:messageSpecial(DOOR_IS_CLOSED);
	elseif(player:getVar("PM") >= 2)then
		player:startEvent(0x0098);
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

	if(csid == 0x0098 and option == 1) then
		player:setPos(-107 ,0 ,223 ,164 ,20);
	end
end;