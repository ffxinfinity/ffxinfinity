-----------------------------------
--  Area: North Gustaberg
--   NPC: Hunting Bear
--  Type: NPC Quest 
--  Involved in Quest: The Gustaberg Tour
-- @zone: 106
--  @pos: -232.415 40.465 426.495
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/North_Gustaberg/TextIDs"] = nil;
require("scripts/zones/North_Gustaberg/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/titles");
-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	local TheGustabergTour = player:getQuestStatus(BASTOK, THE_GUSTABERG_TOUR);
	if (TheGustabergTour == QUEST_COMPLETED) then
		player:startEvent(0x0017); -- final dialog if quest complete
	elseif (TheGustabergTour == QUEST_ACCEPTED) then
		if (player:getPartySize() == 6) then 
			--nil if player is not in party; this works fine
			--check that all player's levels are <= 5 (or actually just < 6)
			--also check that they are in zone
			local questreq = true;
			local pmemb;
			for pmemb = 0, 5, 1 do
				local memb = player:getPartyMember(pmemb, 0);
				questreq = questreq and (memb:getMainLvl() < 6 and memb:getZone() == 106); -- North Gustaberg is 106 pre-Adoulin, at least
			end
			
			if (questreq) then
				player:startEvent(0x0016);
			else
				player:startEvent(0x0015);
			end
		else
			player:startEvent(0x0015);
		end
	else
		player:startEvent(0x0014);
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
	if (csid == 0x0016) then
		player:addGil(GIL_RATE*500);
		player:messageSpecial(GIL_OBTAINED,GIL_RATE*500);
		player:addFame(BASTOK,BAS_FAME*30);
		player:completeQuest(BASTOK,THE_GUSTABERG_TOUR);
		player:addTitle(GUSTABERG_TOURIST);
	end
end;

