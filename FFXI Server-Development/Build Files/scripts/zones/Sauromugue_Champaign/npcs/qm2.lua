-----------------------------------
--  Area: Sauromugue Champaign
--   NPC: qm2 (Tower 2) 
--  Type: Standard NPC
--
-- THF Quest "As Thick As Thieves"
-- @zone: 120
-- @where x193, y32, z211
-----------------------------------
package.loaded["scripts/zones/Sauromugue_Champaign/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/globals/keyitems");
require("scripts/zones/Sauromugue_Champaign/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)

	thickAsThievesGrapplingCS = player:getVar("thickAsThievesGrapplingCS");

	if(thickAsThievesGrapplingCS >= 2 and thickAsThievesGrapplingCS <= 7) then
		if(trade:hasItemQty(17474,1) and trade:getItemCount() == 1) then -- Trade grapel
			player:startEvent(0x0002); -- complete grappling part of the quest			
		end
	end
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	thickAsThieves = player:getQuestStatus(WINDURST,AS_THICK_AS_THIEVES);
	thickAsThievesGrapplingCS = player:getVar("thickAsThievesGrapplingCS");
	
	if(thickAsThievesGrapplingCS == 2) then
		SpawnMob(17269107,120):updateEnmity(player); -- Climbpix Highrise
		setMobPos(17269107,193,32,211,0);		
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
	
	if(csid == 0x0002) then
		player:setVar("thickAsThievesGrapplingCS",8);
		player:delKeyItem(FIRST_FORGED_ENVELOPE);
		player:addKeyItem(FIRST_SIGNED_FORGED_ENVELOPE);
		player:messageSpecial(KEYITEM_OBTAINED,FIRST_SIGNED_FORGED_ENVELOPE);
		player:tradeComplete();
	end
	
end;