-----------------------------------
--
-- Zone: Lufaise_Meadows (24)
--
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/missions");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)

	local Colorful_Leshy = 16875762;
	GetMobByID(Colorful_Leshy):setExtraVar(os.time() + math.random((43200), (86400)));

end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
cs = -1;	
	if(player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then	
		player:setPos(438 ,0.001 ,-18 ,11 ,24);
	end
	if(player:getCurrentMission(COP) == AN_INVITATION_WEST and player:getVar("COPM21") == 0) then
		cs = 0x006E;
	elseif(player:getCurrentMission(COP) == CHAINS_AND_BONDS and player:getVar("PromathiaStatus") == 0) then
        cs = 0x006F;	
	end
	if(player:getCurrentMission(COP) == CHAINS_AND_BONDS and player:getVar("PromathiaStatus") == 0) then
		cs = 0x006F,0,14657;	
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
	if (csid == 0x006E) then
		player:setVar("COPM21",1);
	elseif(csid == 0x006F)then
	player:setVar("PromathiaStatus",1);
	player:addItem(14657);
	player:messageSpecial(ITEM_OBTAINED,14657);
    elseif(csid == 0x006F)then
		player:addItem(14657);
		player:setVar("PromathiaStatus",1);
	end
end;