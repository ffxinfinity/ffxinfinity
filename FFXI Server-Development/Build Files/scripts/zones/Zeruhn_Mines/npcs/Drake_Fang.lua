-----------------------------------
-- Area: Zeruhn Mines
-- NPC:  Drake Fang
-- Involved in Mission: Bastok 6-1
-- @pos -74 0 58 172
-----------------------------------
package.loaded["scripts/zones/Zeruhn_Mines/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/zones/Zeruhn_Mines/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	if(player:getCurrentMission(BASTOK) == RETURN_OF_THE_TALEKEEPER and player:getVar("MissionStatus") >= 1) then
		if(player:getVar("MissionStatus") == 1) then
			player:startEvent(0x00c8);
		else
			player:startEvent(0x00c9);
		end
elseif(player:getCurrentMission(BASTOK) == ENTER_THE_TALEKEEPER and player:getVar("bastok82")==0)then player:startEvent(0x00ca);
player:setVar("bastok82",1);
elseif(player:getCurrentMission(BASTOK) == ENTER_THE_TALEKEEPER and player:getVar("bastok82")==1)then player:startEvent(0x00cb);
elseif(player:getCurrentMission(BASTOK) == ENTER_THE_TALEKEEPER and player:getVar("bastok82")==6)then player:startEvent(0x00cc,1);
else
	player:startEvent(0x006c);
end
	
end;

-- 0x006c  0x00c8  0x00c9  0x00ca  0x00cb  0x00cc

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
printf("CSID: %u",csid);
printf("RESULT: %u",option);
	
	if(csid == 0x00c8) then
		player:setVar("MissionStatus",2);
	elseif(csid == 0x00cc) then
		player:setVar("bastok82",7);
		player:setPos(-185,-8,-21,1,234);
	end
	
end;