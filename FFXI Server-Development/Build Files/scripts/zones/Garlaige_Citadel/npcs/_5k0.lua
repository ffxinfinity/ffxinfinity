-----------------------------------
-- Area: Garlaige Citadel
-- NPC:  Banishing Gate #1
-- @zone 200
-- @pos -201.000 -2.994 220
-----------------------------------
package.loaded["scripts/zones/Garlaige_Citadel/TextIDs"] = nil;
-----------------------------------

require("scripts/zones/Garlaige_Citadel/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:hasKeyItem(POUCH_OF_WEIGHTED_STONES) == false or player:getXPos() > -201) then
		player:messageSpecial(A_GATE_OF_STURDY_STEEL);
		return 1;
	else
		for thisgate=npc:getID(),npc:getID()+4,1 do
			GetNPCByID(thisgate):openDoor(30);
		end
		player:messageSpecial(BANISHING_GATES); -- Banishing gate opening
		return 1;
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
end;