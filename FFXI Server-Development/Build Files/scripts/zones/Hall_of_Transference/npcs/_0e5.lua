-----------------------------------
-- Large Apparatus - Dem
-- 
-- @pos -239 -41 -270 14
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
	if(player:getVar("PH") >= 2 or player:getVar("PM") >= 2)then
		player:messageSpecial(NODATA);
	elseif(player:getVar("COPM2") == 2)then 
		player:startEvent(0x00A0);
	elseif(player:getVar("PD") >= 2)then
		player:startEvent(0x007D);
	elseif(player:getVar("COPM2") == 3)then
		if((player:hasKeyItem(LIGHT_OF_HOLLA) and player:getVar("PM") <= 1)or (player:hasKeyItem(LIGHT_OF_MEA) and player:getVar("PH") <=1 )) then 
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

	if(csid == 0x00A0)then
		player:setPos(152,0 ,-70 ,81 ,18 );
		player:setVar("COPM2",3); 
		player:setVar("PD",2);
	elseif(csid == 0x007E and option == 0)then
		player:setVar("PD",3);
		player:setPos(152,0 ,-70 ,81 ,18 );
	elseif(csid == 0x007D and option == 0)then
		player:setVar("PD",1);
		player:setPos(136,19,220,130,108);
	end
end;