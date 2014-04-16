-----------------------------------
-- Large Apparatus - Mea
-- 
-- @pos 269 -81 -39 14
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
	if(player:getVar("PH") >= 2 or player:getVar("PD") >= 2)then
		player:messageSpecial(NODATA);
	elseif(player:getVar("COPM2") == 2)then 
		player:startEvent(0x00A0);
	elseif(player:getVar("PM") >= 2)then
		player:startEvent(0x0080);
	elseif(player:getVar("COPM2") == 3)then
		if((player:hasKeyItem(LIGHT_OF_HOLLA) and player:getVar("PD") == 1)or (player:hasKeyItem(LIGHT_OF_DEM) and player:getVar("PH") ==1 ))then
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
		player:setPos(-107 ,0 ,223 ,164 ,20 );
		player:setVar("COPM2",3);
		player:setVar("PM",2);
		elseif(csid == 0x007E and option == 0)then
		player:setVar("PM",3);	
		player:setPos(-107 ,0 ,223 ,164 ,20 );
	elseif(csid == 0x0080 and option == 0)then
		player:setVar("PM",1);
		player:setPos(179 ,35 ,256 ,63 ,117 ); 
	end
end;