-----------------------------------
-- Area: Bhaflau Thickets
-- NPC: Kamih Mapokhalam
-- 
-----------------------------------
package.loaded["scripts/zones/Bhaflau_Thickets/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/zones/Bhaflau_Thickets/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

	count = trade:getItemCount();

	if(count == 1 and trade:hasItemQty(2185,1)) then -- Silver
		player:tradeComplete();
		player:startEvent(0x0079);
	elseif(count == 3 and trade:hasItemQty(2186,3)) then -- Mythril
		if(player:hasKeyItem(MAP_OF_ALZADAAL_RUINS)) then
			player:startEvent(0x0093); 
		else
			player:startEvent(0x0092);
		end
	
	end
	
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getZPos() < 597) then
		player:startEvent(0x0078);
	else
		player:startEvent(0x007A);
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
	
	if(csid == 0x0079) then
	if(player:getCurrentMission(TOAU,UNDERSEA_SCOUTING))then
		player:setVar("TOAUM9",1);
		player:setPos(325,-4,-620,0,72);
	else
		player:setPos(325,-4,-620,0,72);
	end
	elseif(csid == 0x0092) then
		player:tradeComplete();
		player:addKeyItem(MAP_OF_ALZADAAL_RUINS);
player:messageSpecial(KEYITEM_OBTAINED,MAP_OF_ALZADAAL_RUINS);
	end
	
end;