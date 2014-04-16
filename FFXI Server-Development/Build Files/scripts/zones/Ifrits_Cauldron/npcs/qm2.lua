-----------------------------------
-- Area: Ifrit's Cauldron
-- NPC:  ??? (Bomb Queen's Spawn)
-- Allows players to spawn Bomb Queen NM with 3 pinches of Bomb Queen Ash and a Bomb Queen Core.
-- @pos 19.395, 23, -99.967
-----------------------------------
package.loaded["scripts/zones/Ifrits_Cauldron/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Ifrits_Cauldron/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
	-- Trade 3 pinches of Bomb Queen Ash and a Bomb Queen Core and a verification if the nm is already spawned
	if(GetMobAction(17617158) == 0 and trade:hasItemQty(1187,3) and trade:hasItemQty(1186,1) and trade:getItemCount() == 4) then
		player:tradeComplete();
		SpawnMob(17617158,80):updateEnmity(player); -- Spawn Bomb Queen
	end
	
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
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
end;