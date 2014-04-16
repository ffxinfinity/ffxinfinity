-----------------------------------
-- 
-- Zone: Hall_of_Transference
-- 
-----------------------------------
package.loaded["scripts/zones/Hall_of_Transference/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/missions");
require("scripts/globals/settings");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/zones/Hall_of_Transference/TextIDs");

-----------------------------------
--  onInitialize
-----------------------------------

function onInitialize(zone)
	zone:registerRegion(1,-281,-5,277,-276,0,284); -- Holla
	zone:registerRegion(2,276,-84,-82,283,-80,-75); -- Mea
	zone:registerRegion(3,-283,-45,-283,-276,-40,-276); -- Dem
	zone:registerRegion(4,0,0,0,0,0,0);
end;

-----------------------------------
-- onZoneIn
-----------------------------------

function onZoneIn(player,prevZone)
cs = -1;
if(prevZone == 108 or prevZone == 102 or prevZone == 117)then

    if(player:getVar("COPM2") == 3)then
	
	if(player:hasKeyItem(LIGHT_OF_DEM) and player:hasKeyItem(LIGHT_OF_MEA) and not(player:hasKeyItem(LIGHT_OF_HOLLA)))then
	cs = 0x009B;
	player:setVar("COPM2",4);

	elseif(player:hasKeyItem(LIGHT_OF_HOLLA) and player:hasKeyItem(LIGHT_OF_MEA) and not(player:hasKeyItem(LIGHT_OF_DEM)))then
	cs = 0x009B;
	player:setVar("COPM2",5);

		
	elseif(player:hasKeyItem(LIGHT_OF_HOLLA) and player:hasKeyItem(LIGHT_OF_DEM) and not(player:hasKeyItem(LIGHT_OF_MEA)))then
	cs = 0x009B;
	player:setVar("COPM2",6);

	end
  end

end

if((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then	
player:setPos(274,-82,-62 ,180);

end
return cs;
end;

-----------------------------------
-- onRegionEnter          
-----------------------------------

function onRegionEnter(player,region)

	switch (region:GetRegionID()): caseof
	{
		[1] = function (x) -- Holla
			player:startEvent(0x0067);
		end,
		[2] = function (x) -- Mea
			player:startEvent(0x0068);
		end,
		[3] = function (x) -- Dem
			player:startEvent(0x0069);
		end,
		[4] = function (x)
			player:startEvent(0x0067);
		end,
	}
	

end;
-----------------------------------	
-- onRegionLeave	
-----------------------------------	

function onRegionLeave(player,region)
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

	if(player:getVar("COPM2") == 4)then
		player:setPos(82 ,0 ,89 ,119 ,16 );
	elseif(player:getVar("COPM2") == 5)then
		player:setPos(152,0 ,-70 ,81 ,18 );
	elseif(player:getVar("COPM2") == 6)then
		player:setPos(-107 ,0 ,223 ,164 ,20);
	elseif(csid == 0x009b)then
		if(player:getVar("COPM2") == 4)then
			player:setPos(82 ,0 ,89 ,119 ,16 );
		elseif(player:getVar("COPM2") == 5)then
			player:setPos(152,0 ,-70 ,81 ,18 );
		elseif(player:getVar("COPM2") == 6)then
			player:setPos(-107 ,0 ,223 ,164 ,20);
		end
	elseif(csid==103 and option ==1)then
		player:setPos(337 ,19 ,-60 ,125 ,102); 
	elseif(csid==104 and option ==1)then
		player:setPos(179 ,35 ,256 ,63 ,117 ); 
	elseif(csid==105 and option ==1)then
		player:setPos(136 ,19 ,220 ,130 ,108 ); 
	end
end;