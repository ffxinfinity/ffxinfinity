-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Naja Salaheem
--  Type: Standard NPC
-- @zone: 50
--  @pos: 22.700 -8.804 -45.591
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Aht_Urhgan_Whitegate/TextIDs"] = nil;
require("scripts/globals/missions");
require("scripts/zones/Aht_Urhgan_Whitegate/TextIDs");
require("scripts/globals/titles");
require("scripts/globals/keyitems");

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
	if(player:getCurrentMission(TOAU) == IMMORTAL_SENTRIES and player:getVar("TOAUM2") == 1) then
		if(player:getVar("TOAUM2") == 1) then
			player:startEvent(0x0BBA,0,0,0,0,0,0,0,0,0);
		end
	elseif(player:getCurrentMission(TOAU) == PRESIDENT_SALAHEEM and player:getVar("TOAUM3") == 1)then
		player:startEvent(0x0049,0,0,0,0,0,0,0,0,0);
		player:setVar("TOAUM3",2);
	elseif(player:getCurrentMission(TOAU) == PRESIDENT_SALAHEEM and player:getVar("TOAUM3") == 2)then
		player:startEvent(0x0bcc,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == KNIGHT_OF_GOLD and player:getVar("TOAUM4") == 0)then
		player:startEvent(0x0Bcd,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == WESTERLY_WINDS and player:getVar("TOAUM7") == 1)then
		player:startEvent(0x0Bd4,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == UNDERSEA_SCOUTING)then
		player:startEvent(0x0beb,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == ASTRAL_WAVES)then
		player:startEvent(0x0bec,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == IMPERIAL_SCHEMES)then
		player:startEvent(0x0bfe,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == ROYAL_PUPPETEER)then
		player:startEvent(0x0bff,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == THE_DOLPHIN_CREST)then
		player:startEvent(0x0c00,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) == THE_BLACK_COFFIN)then
		player:startEvent(0x0c01,0,0,0,0,0,0,0,0,0);
	else
		player:startEvent(0x0bbb,1,0,0,0,0,0,0,1,0);
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
printf("CSID: %u",csid);
printf("RESULT: %u",option);

	if(csid == 0x0BBA)then
		player:setVar("TOAUM2",0);
		player:completeMission(TOAU,IMMORTAL_SENTRIES);
		player:addMission(TOAU,PRESIDENT_SALAHEEM);
	elseif(csid == 0x0Bcc)then
		player:completeMission(TOAU,PRESIDENT_SALAHEEM);
		player:addMission(TOAU,KNIGHT_OF_GOLD);
		player:setVar("TOAUM3",0);
	elseif(csid == 0x0bd4)then
		player:setVar("TOAUM7",0);
		player:completeMission(TOAU,WESTERLY_WINDS);
		player:addItem(2185,1);
		player:messageSpecial(ITEM_OBTAINED,2185);
		player:addMission(TOAU,A_MERCENARY_LIFE);
	elseif(csid == 0x0bec)then
		player:completeMission(TOAU,ASTRAL_WAVES);
		player:addMission(TOAU,IMPERIAL_SCHEMES);
	elseif(csid == 0x0bfe)then
		player:completeMission(TOAU,IMPERIAL_SCHEMES);
		player:addMission(TOAU,ROYAL_PUPPETEER);
	elseif(csid == 0x0c00)then
		player:completeMission(TOAU,THE_DOLPHIN_CREST);
		player:addMission(TOAU,THE_BLACK_COFFIN);
	end
end;

