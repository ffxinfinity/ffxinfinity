-----------------------------------
-- Area: Cloister of Flames
-- NPC:  Fire Protocrystal
-- Involved in Quests: Trial by Fire, Trial Size Trial by Fire
-- @pos -721 0 -598 207
-----------------------------------
package.loaded["scripts/zones/Cloister_of_Flames/TextIDs"] = nil;
package.loaded["scripts/globals/bcnm"] = nil;
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/bcnm");
require("scripts/zones/Cloister_of_Flames/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	if(TradeBCNM(player,player:getZone(),trade,npc))then
		return;
	end
	
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(EventTriggerBCNM(player,npc))then
		return;
	end
	
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("onUpdate CSID: %u",csid);
--printf("onUpdate RESULT: %u",option);
	
	if(EventUpdateBCNM(player,csid,option))then
		return;
	end
	
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("onFinish CSID: %u",csid);
--printf("onFinish RESULT: %u",option);
	
	if(EventFinishBCNM(player,csid,option))then
		return;
	end
	
end;