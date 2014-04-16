-----------------------------------
--
-- Zone: Bastok_Mines (234)
--
-----------------------------------

package.loaded["scripts/zones/Bastok_Mines/TextIDs"] = nil;
require("scripts/globals/server");
require("scripts/globals/settings");
require("scripts/zones/Bastok_Mines/TextIDs");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
end;			

-----------------------------------			
-- onZoneIn			
-----------------------------------			

function onZoneIn(player,prevZone)			
	cs = -1;		
	if(player:getVar("bastok82") == 7)then
		cs = 0x00B0;
	end
	-- FIRST LOGIN (START CS)		
	if (prevZone == 0) then		
		if (OPENING_CUTSCENE_ENABLE == 1) then	
			cs = 0x01;
		end	
		player:setPos(-45,-0,26,213);	
		player:setHomePoint();	
	end		
	-- MOG HOUSE EXIT		
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then		
		position = math.random(1,5) - 75;	
		player:setPos(116,0.99,position,127);	
		if (player:getMainJob() ~= player:getVar("PlayerMainJob")) then	
			cs = 0x7534;
		end	
		player:setVar("PlayerMainJob",0);	
	end		
	return cs;		
end;			

-----------------------------------			
-- onRegionEnter			
-----------------------------------			

function onRegionEnter(player,region)	
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
	if(csid == 0x01) then	
		player:messageSpecial(ITEM_OBTAINED,0x218);
	elseif (csid == 0x7534 and option == 0) then	
		player:setHomePoint();
		player:messageSpecial(HOMEPOINT_SET);
	elseif (csid == 0x00b0)then
		player:setVar("bastok82",0);
		player:completeMission(BASTOK,ENTER_THE_TALEKEEPER);
		player:setRank(9);
		player:setRankPoints(0);
		player:addGil(GIL_RATE*80000)
		player:messageSpecial(GIL_OBTAINED,GIL_RATE*80000);
	end	
end;		
