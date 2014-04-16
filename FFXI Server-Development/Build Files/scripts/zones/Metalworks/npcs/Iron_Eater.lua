-----------------------------------
-- Area: Metalworks
-- NPC: Iron Eater
-- Involved in Missions
-- @zone
-- @pos 
-----------------------------------
package.loaded["scripts/zones/Metalworks/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/zones/Metalworks/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	local currentMission = player:getCurrentMission(BASTOK);
	local missionStatus = player:getVar("MissionStatus");

	if(currentMission == THE_FOUR_MUSKETEERS and missionStatus == 0) then -- Four Musketeers
		player:startEvent(0x02cb);
	elseif(currentMission == THE_FOUR_MUSKETEERS and missionStatus == 1) then
		player:startEvent(0x02cc);
	elseif(currentMission == THE_CHAINS_THAT_BIND_US and missionStatus == 0) then
	    player:startEvent(0x02ff); -- First cutscene of mission
	elseif (currentMission == THE_CHAINS_THAT_BIND_US) and (missionStatus == 2) then
		player:showText(npc, 8596); -- Dialogue after first cutscene
	elseif (currentMission == THE_CHAINS_THAT_BIND_US) and (missionStatus == 3) then
		player:startEvent(0x0300); -- Cutscene on return from Quicksand Caves
	else
		player:startEvent(0x025c);
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
	if(csid == 0x02cb and option == 0) then
		player:setVar("MissionStatus",1);
	elseif(csid == 0x02ff and option == 0) then
	    player:setVar("MissionStatus", 1);
	elseif(csid == 0x0300) then
		finishMissionTimeline(player, 1, csid, option);
	end
end;