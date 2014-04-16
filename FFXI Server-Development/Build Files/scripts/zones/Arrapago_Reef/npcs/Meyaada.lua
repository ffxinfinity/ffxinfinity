-----------------------------------
-- Area: Arrapago Reef
-- NPC:  meyaada
-----------------------------------
package.loaded["scripts/zones/Arrapago_Reef/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/keyitems");
require("scripts/globals/besieged");
require("scripts/globals/missions");
require("scripts/zones/Arrapago_Reef/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	local IPpoint=player:getPoint(AHTURHGAN );
	local assault=player:getCurrentMission(ASSAULT);
	--print(IPpoint);
	--print(assault);


	if(player:hasKeyItem(SUPPLIES_PACKAGE))then
		player:startEvent(0x0005);
	elseif(player:getVar("TOAUM2") ==1)then
		player:startEvent(0x0006);
	elseif(player:getCurrentMission(TOAU) > IMMORTAL_SENTRIES)then
		player:startEvent(0x0007);
	elseif(assault>40 and assault<51 and player:hasKeyItem(ASSAULT_ARMBAND)==false)then
   		player:startEvent(0x00DF,50,IPpoint);
  	else
  		player:startEvent(0x0004);
		-- player:delKeyItem(ASSAULT_ARMBAND);
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
	
	if(csid == 0x00DF and option == 1) then
       		player:delPoint(AHTURHGAN,50);
	   	player:addKeyItem(ASSAULT_ARMBAND);
	   	player:messageSpecial(KEYITEM_OBTAINED,ASSAULT_ARMBAND);
	elseif(csid == 0x0005 and option == 1)then
		player:delKeyItem(SUPPLIES_PACKAGE);
		player:setVar("TOAUM2",1);
		elseif(csid == 0x0006)then
		player:setVar("TOAUM2",1);
	end
	
end;