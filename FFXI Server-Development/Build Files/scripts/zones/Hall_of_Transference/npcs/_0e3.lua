-----------------------------------
-- Large Apparatus - Holla
-- PH PM PD 1=available 2=first selected 3=second selected
-- @pos -239 -1 290 14
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/zones/Hall_of_Transference/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

	if(player:getVar("PM") >= 2 or player:getVar("PD") >= 2)then
		player:messageSpecial(NODATA);
	elseif(player:getVar("COPM2") == 2)then 
		player:startEvent(0x00A0);
	elseif(player:getVar("PH") >= 2)then
		player:startEvent(0x007A);
	elseif(player:getVar("COPM2") == 3)then
		if((player:hasKeyItem(LIGHT_OF_MEA) and player:getVar("PD") <=1)or (player:hasKeyItem(LIGHT_OF_DEM) and player:getVar("PM") <=1))then
			player:startEvent(0x007E);
		end
	end
	return 1;
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

	if(csid == 0x00A0) then
		player:setPos(82 ,0 ,89 ,119 ,16 );
		player:setVar("COPM2",3); 
		player:setVar("PH",2);
	elseif(csid == 0x007E and option == 0)then
		player:setVar("PH",3);	
		player:setPos(82 ,0 ,89 ,119 ,16 );
	elseif(csid == 0x007A and option == 0)then 
		player:setVar("PH",1);	
		player:setpos(337,19,-60,127,102);
	end
end;