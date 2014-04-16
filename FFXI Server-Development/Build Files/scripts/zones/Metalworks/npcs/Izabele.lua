-----------------------------------
-- Area: Metalworks
-- NPC: Izabele
-- Type: Quest Giver
-- Involved in Quest: The Gustaberg Tour
-----------------------------------

package.loaded["scripts/zones/Metalworks/TextIDs"] = nil;
require("scripts/zones/Metalworks/TextIDs");
require("scripts/globals/quests");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	local TheGustabergTour = player:getQuestStatus(BASTOK,THE_GUSTABERG_TOUR);
	if (TheGustabergTour == QUEST_AVAILABLE) then
		player:startEvent(0x02E9);
	elseif (TheGustabergTour == QUEST_ACCEPTED) then
		player:startEvent(0x02ea);
	else
		player:startEvent(0x02eb); -- final dialog; after quest is complete
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
	if (csid == 0x02E9) then
		player:addQuest(BASTOK, THE_GUSTABERG_TOUR);
	end
end;



