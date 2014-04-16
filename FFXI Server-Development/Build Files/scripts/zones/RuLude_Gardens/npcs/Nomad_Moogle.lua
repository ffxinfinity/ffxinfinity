-----------------------------------
--  Area: Ru'Lude Gardens
--  NPC:  Nomad Moogle
--  Type: Adventurer's Assistant
--  @pos 10.012 1.453 121.883 243
-----------------------------------
package.loaded["scripts/zones/RuLude_Gardens/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/zones/RuLude_Gardens/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	local newworldsawait = player:getQuestStatus(JEUNO,NEW_WORLDS_AWAIT);
	local expandinghorizons = player:getQuestStatus(JEUNO,EXPANDING_HORIZONS);
	local beyondthestars = player:getQuestStatus(JEUNO,BEYOND_THE_STARS);
	local dormantpowersdormant = player:getQuestStatus(JEUNO,DORMANT_POWERS_DISLODGED);
	local beyondinfinity = player:getQuestStatus(JEUNO,BEYOND_INFINITY);
	if(player:hasKeyItem(LIMIT_BREAKER) == false && newworldsawait == QUEST_AVAILABLE and LvL == 75 and player:levelCap() == 75 and MAX_LEVEL >= 75) then
		player:startEvent(0x004f); -- Start Quest "In Defiant Challenge"
	elseif(player:hasKeyItem(LIMIT_BREAKER) == false && expandinghorizons == QUEST_AVAILABLE and LvL >= 76 and player:levelCap() == 80 and MAX_LEVEL >= 80) then
		player:startEvent(0x004f); -- Start Quest "In Defiant Challenge"
	elseif(player:hasKeyItem(LIMIT_BREAKER) == false && beyondthestars == QUEST_AVAILABLE and LvL >= 81 and player:levelCap() == 85 and MAX_LEVEL >= 85) then
		player:startEvent(0x004f); -- Start Quest "In Defiant Challenge"
	elseif(player:hasKeyItem(LIMIT_BREAKER) == false && dormantpowersdormant == QUEST_AVAILABLE and LvL >= 86 and player:levelCap() == 90 and MAX_LEVEL >= 90) then
		player:startEvent(0x004f); -- Start Quest "In Defiant Challenge"
	elseif(player:hasKeyItem(LIMIT_BREAKER) == false && beyondinfinity == QUEST_AVAILABLE and LvL >= 91 and player:levelCap() == 95 and MAX_LEVEL >= 95) then
		player:startEvent(0x004f); -- Start Quest "In Defiant Challenge"
	elseif(player:hasKeyItem(LIMIT_BREAKER) == false and player:getMainLvl() >= 75) then
		player:startEvent(0x2797);
	else
		player:startEvent(0x005E);
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
	
	if(csid == 0x2797) then
		player:addKeyItem(LIMIT_BREAKER);
		player:messageSpecial(KEYITEM_OBTAINED,LIMIT_BREAKER);
	end
	
end;