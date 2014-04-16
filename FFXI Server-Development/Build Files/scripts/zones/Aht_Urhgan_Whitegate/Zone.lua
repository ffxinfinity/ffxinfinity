-----------------------------------
--
-- Zone: Aht_Urhgan_Whitegate (50)
--
-----------------------------------

package.loaded["scripts/zones/Aht_Urhgan_Whitegate/TextIDs"] = nil;
require("scripts/globals/settings");
require("scripts/zones/Aht_Urhgan_Whitegate/TextIDs");
require("scripts/globals/titles");
require("scripts/globals/keyitems");
require("scripts/globals/missions");

-----------------------------------
-- onInitialize
-----------------------------------

function onInitialize(zone)
	zone:registerRegion(1,57,-1,-70,62,1,-65); -- Sets Mark for "Got It All" Quest cutscene.
	zone:registerRegion(2,-96,-7,121,-64,-5,137); -- Sets Mark for "Vanishing Act" Quest cutscene.
	zone:registerRegion(3,14,-7,-65,37,-2,-41);
	zone:registerRegion(4,75,-3,25,90,1,59);
	zone:registerRegion(5,73,-7,-137,95,-3,-115);
end;

-----------------------------------		
-- onZoneIn		
-----------------------------------		

function onZoneIn(player,prevZone)		
	cs = -1;	
	-- MOG HOUSE EXIT	
	
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then
		if(prevZone == 46) then		
			cs = 0x00c9;
		elseif(prevZone == 59) then
			cs = 0x00cc;
		elseif(prevZone == 58) then
			cs = 0x00cc;
		else 
			local position = math.random(1,5) - 83;
			player:setPos(-100,0,position,0);
		end
	end		
	if(player:getCurrentMission(COP) == FOR_WHOM_THE_VERSE_IS_SUNG and player:getVar("PromathiaStatus") == 2) then
		cs = 0x273F;
	end

	return cs;		

end;		

-----------------------------------	
-- onRegionEnter	
-----------------------------------	

function onRegionEnter(player,region)	
	switch (region:GetRegionID()): caseof
	{
	[1] = function (x)  -- Cutscene for Got It All quest.
		if(player:getVar("gotitallCS") == 5)then
			player:startEvent(0x020e);
		end
	end,
	[2] = function (x) -- CS for Vanishing Act Quest
		if(player:getVar("vanishingactCS") == 3) then
			player:startEvent(0x002c);
		end
	end,
	[3] = function (x) -- AH mission 
		if(player:getCurrentMission(TOAU)== LAND_OF_SACRED_SERPENTS) then	
			player:startEvent(0x0BB8,0,0,0,0,0,0,0,0,0);
		elseif(player:getCurrentMission(TOAU) == A_MERCENARY_LIFE)	then
			if(prevZone ~= 50)then
				player:startEvent(0x0Bea,3,3,3,3,3,3,3,3,0);
			end
		end
	end,
	[4] = function (x) -- AH mission 
		if(player:getCurrentMission(TOAU)== KNIGHT_OF_GOLD and player:getVar("TOAUM4") == 2) then
			player:startEvent(0x0Bd0,0,0,0,0,0,0,0,0,0);
		end
	end,
	[5] = function (x) -- AH mission 
		if(player:getCurrentMission(TOAU)== KNIGHT_OF_GOLD and player:getVar("TOAUM4") == 3) then
			player:startEvent(0x0Bd2,0,0,0,0,0,0,0,0,0);
		elseif(player:getCurrentMission(TOAU) == WESTERLY_WINDS and player:getVar("TOAUM7") == 0) then
			player:startEvent(0x0BD3,0,0,0,0,0,0,0,0,0);
		end
	end,
	}
end;	

-----------------------------------	
-- onRegionLeave	
-----------------------------------	

function onRegionLeave(player,region)	
end;	

-----------------------------------		
-- onTransportEvent		
-----------------------------------		

function onTransportEvent(player,transport)
	if ((transport == 46) or (transport == 47)) then 
		player:startEvent(0x00c8);
	elseif (transport == 58) or (transport == 59) then 
		player:startEvent(0x00cb);
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
	if(csid == 0x00c9)then
		player:setPos(-11,2,-142,192);
	elseif(csid == 0x00cc)then
		player:setPos(11,2,142,64);
	elseif(csid == 0x00c8) then
		player:setPos(0,-2,0,0,47);
	elseif(csid == 0x00cb) then
		player:setPos(0,-2,0,0,58);
	elseif(csid == 0x002c)then
		player:setVar("vanishingactCS",4);
		player:setPos(-80,-6,122,5);
	elseif(csid == 0x020e)then
		player:setVar("gotitallCS",6);
		player:setPos(60,0,-71,38);
	elseif(csid == 0x0bd0)then
		player:setVar("TOAUM4",3);
	elseif(csid == 0x0bd2)then
		player:setVar("TOAUM4",4);
		player:addKeyItem(RAILLEFALS_LETTER);
		player:messageSpecial(KEYITEM_OBTAINED,RAILLEFALS_LETTER);
		player:completeMission(TOAU,KNIGHT_OF_GOLD);
		player:addMission(TOAU,CONFESSIONS_OF_ROYALTY);
	elseif(csid == 0x0BB8) then
		player:completeMission(TOAU,LAND_OF_SACRED_SERPENTS);
		player:addMission(TOAU,IMMORTAL_SENTRIES);
		player:addKeyItem(SUPPLIES_PACKAGE);
		player:messageSpecial(KEYITEM_OBTAINED,SUPPLIES_PACKAGE);
	elseif(csid ==0x0BD3)then
		player:setVar("TOAUM7",1)
		player:addKeyItem(RAILLEFALS_NOTE);
		player:messageSpecial(KEYITEM_OBTAINED,RAILLEFALS_NOTE);
		player:addItem(2185,1);
		player:messageSpecial(ITEM_OBTAINED,2185);
	elseif(csid == 0x0bea)then
		player:completeMission(TOAU,A_MERCENARY_LIFE);
		player:addMission(TOAU,UNDERSEA_SCOUTING);
	end
 end;
