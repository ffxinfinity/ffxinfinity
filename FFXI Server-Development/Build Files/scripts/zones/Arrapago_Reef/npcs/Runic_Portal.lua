-----------------------------------
-- Area: Arrapago Reef
-- NPC:  Runic Portal
-- Arrapago Reef Teleporter Back to Aht Urgan Whitegate
-- @pos 15 -7 627 54
-----------------------------------
package.loaded["scripts/zones/Arrapago_Reef/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/besieged");
require("scripts/globals/teleports");
require("scripts/globals/missions");
require("scripts/zones/Arrapago_Reef/TextIDs");
require("scripts/globals/titles");
require("scripts/globals/keyitems");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
		if(player:getCurrentMission(TOAU)== IMMORTAL_SENTRIES and player:getVar("TOAUM2") ==1)then
	player:startEvent(0x006F);
	elseif(player:getCurrentMission(TOAU) > IMMORTAL_SENTRIES)then

	if(hasRunicPortal(player,5) == 1) then
		player:startEvent(0x006d);
	else
		player:startEvent(0x006f);
	end
else	
player:messageSpecial(RESPONSE);
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
	
	if(option == 1) then
		if(csid == 0x006f) then
			player:addNationTeleport(AHTURHGAN,32);
		end
		toChamberOfPassage(player);
	end
	
end;