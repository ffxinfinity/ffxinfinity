-----------------------------------
-- Area: Mount Zhayolm
-- NPC:  Bapokk
-- Handles access to Alzadaal Ruins
-- @pos -20 -6 276 61
-----------------------------------
package.loaded["scripts/zones/Mount_Zhayolm/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Mount_Zhayolm/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	if(trade:getItemCount() == 1 and trade:hasItemQty(2185,1)) then -- Silver
		player:tradeComplete();
	  	player:setPos(-20,-6,0.001); -- using the pos method until the problem below is fixed
	  	-- player:startEvent(0x00A3,0,0,0,0,0,0,0,0); -- << this CS goes black at the end, never fades in
		return 1;
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	-- Ruins -> Zhayolm
	if(player:getZPos() >= 280) then
		player:startEvent(0x00A4);
	-- Zhayolm -> Ruins
   	else
		player:startEvent(0x00A3,2,2,2,2,2,2,2,2);
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
	if(csid == 0x00a3)then
		player:startEvent(0x00a6);
	end
end;