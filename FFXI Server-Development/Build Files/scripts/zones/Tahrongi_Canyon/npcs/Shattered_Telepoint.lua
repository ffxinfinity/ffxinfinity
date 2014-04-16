-----------------------------------
-- Area: Tahrongi_Canyon
-- NPC:  Shattered telepoint
-- @pos 179 35 255 117
-----------------------------------
package.loaded["scripts/zones/Tahrongi_Canyon/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/zones/Tahrongi_Canyon/TextIDs");

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
		player:startEvent(0x0390);  	elseif(player:getCurrentMission(COP) == BELOW_THE_ARKS and player:getVar("COPM2") >= 2) then
		player:startEvent(0x00391);  

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
		player:setPos(280.066, -80.63337, -67.096, 192, 14);
	elseif(csid == 0x0391 and option == 0) then 
		player:setPos(280.066, -80.63337, -67.096, 192, 14);
	end
	
end;