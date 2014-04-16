-----------------------------------
--	Area: Mhaura
--	NPC:  Numi Adaligo
--	Working 100%
--  Involved In Quest: RYCHARDE_THE_CHEF
-----------------------------------

require("scripts/globals/settings");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:startEvent(0x32);
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
-- printf("CSID: %u",csid);
-- printf("RESULT: %u",option);

RychardetheChef = player:getQuestStatus(OTHER_AREAS,RYCHARDE_THE_CHEF);
QuestStatus=player:getVar("QuestRychardetheChef_var"); 

if((option == 2) and (RychardetheChef == QUEST_AVAILABLE) and (tonumber(QuestStatus) == 0)) then
	player:setVar("QuestRychardetheChef_var",1);  -- first stage of rycharde the chef quest
end;
	
end;



