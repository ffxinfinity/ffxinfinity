-----------------------------------
-- Area: Ship bound for Selbina
-- NPC: Rajmonda
-- Guild Merchant NPC: Fishing Guild 
-----------------------------------

package.loaded["scripts/zones/Ship_bound_for_Selbina/TextIDs"] = nil;

require("scripts/zones/Ship_bound_for_Selbina/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:sendGuild(519,1,23,5)) then
		player:showText(npc,RAJMONDA_SHOP_DIALOG);
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
end;



