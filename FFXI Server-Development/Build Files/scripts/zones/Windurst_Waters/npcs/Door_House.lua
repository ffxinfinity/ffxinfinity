-----------------------------------
-- Area: Windurst Waters
-- NPC: Door CS
-- Standard Info NPC	-- Mini Quest Af Corsair
-----------------------------------

require("scripts/globals/settings");
require("scripts/zones/Windurst_Waters/TextIDs");
require("scripts/globals/quests");
require("scripts/globals/keyitems");
require("scripts/globals/common");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	-- "Corsair SideQuest" Trades
	
	if(player:getVar("LeleroonsLetterGreen") ==2) then
		if(trade:getItemCount() == 4 and trade:hasItemQty(823,1) and trade:hasItemQty(879,1) and trade:hasItemQty(1829,1) and trade:hasItemQty(2289,1)) then -- Trade gold thread, karakul leather, red grass cloth, wamoura silk
			player:tradeComplete(); --Trade Completed
			player:startEvent(0x3AF); 
			player:setVar("LeleroonsLetterGreen",3);
		end
	
	
	elseif(player:getVar("LeleroonsLetterGreen") == 3) then
		if(trade:hasItemQty(2186,4) and trade:getItemCount() == 4) then -- Trade 4 Imperial Mythril
			player:tradeComplete(); --Trade Completed
			player:startEvent(0x03B2);
			player:setVar("LeleroonsLetterGreen",4);
			player:setVar("Corsair_Gloves_JPMidnight_Timer",getMidnight()); -- SET TIMER FOR 1 DAY REAL LIFE TIME
			player:needToZone(true);
		end
	
	end	
end;  

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
	local GreenLetter = player:getVar("LeleroonsLetterGreen");
	
	if(GreenLetter == 1 and player:hasKeyItem(LELEROONS_LETTER_GREEN) == true) then
		player:startEvent(0x3AD);
		player:delKeyItem(LELEROONS_LETTER_GREEN); -- Removes Key Item Green Letter
		player:setVar("LeleroonsLetterGreen",2);
		player:setVar("AgainstAllOddsSideQuests",0);
	elseif(GreenLetter == 2) then
		player:startEvent(0x3AE);
	elseif(GreenLetter == 3) then
		player:startEvent(0x3BA);	
	elseif(player:getVar("Corsair_Gloves_JPMidnight_Timer") < os.time() and GreenLetter == 4) then
		player:startEvent(0x3B0); -- CS For Final Part Of Side Quest Green Letter Complete 
	elseif(GreenLetter == 4) then
		player:startEvent(0x3B1);	
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
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);

	if(csid == 0x3B0) then
		player:addItem(14929); -- Corsair's Gants
		player:messageSpecial(ITEM_OBTAINED,14929); -- Item Obtained: Corsair's Gants
		player:setVar("LeleroonsLetterGreen",0);
		player:setVar("AgainstAllOddsSideQuests",1); -- Set for SideQuest NPC
		player:setVar("Corsair_Gloves",0);
	end
end;



