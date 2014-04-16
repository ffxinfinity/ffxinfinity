-----------------------------------
-- Area: La_Theine_Plateau
-- NPC:  Shattered telepoint
-- @pos 334 19 -60 102
-----------------------------------
package.loaded["scripts/zones/La_Theine_Plateau/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/teleports");
require("scripts/zones/La_Theine_Plateau/TextIDs");

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
		player:startEvent(0x00C9);  
	elseif(player:getCurrentMission(COP) == BELOW_THE_ARKS and player:getVar("COPM2") >= 2) then
		player:startEvent(0x00CA);
	elseif(player:hasKeyItem(LIGHT_OF_HOLLA))then
		player:startEvent(0x00CA);
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
	
	if(csid == 0x00C9) then
		player:setVar("COPM2",2);
		player:setPos(-266.76, -0.6337, 280.058, 0, 14); -- teleport to zone 14
	elseif(csid == 0x00CA and option == 0) then 
		player:setPos(-266.76, -0.6337, 280.058, 0, 14); -- teleport to zone 14 
	end
	   
end;

