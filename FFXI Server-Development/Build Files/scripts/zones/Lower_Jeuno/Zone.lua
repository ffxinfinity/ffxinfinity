-----------------------------------
--
-- Zone: Lower_Jeuno (245)
--
-----------------------------------

package.loaded["scripts/zones/Lower_Jeuno/TextIDs"] = nil;
require("scripts/zones/Lower_Jeuno/TextIDs");

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
	-- MOG HOUSE EXIT		
	if ((player:getXPos() == 0) and (player:getYPos() == 0) and (player:getZPos() == 0)) then		
		player:setPos(41.2,-5, 84,85);

	    if (player:getMainJob() ~= player:getVar("PlayerMainJob")) then	
			cs = 0x7534;
	    end	
	player:setVar("PlayerMainJob",0);
	elseif(player:getCurrentMission(COP) == TENDING_AGED_WOUNDS and player:getVar("PromathiaStatus")==0)then
		       player:setVar("PromathiaStatus",1);
		     cs = 0x0046;  
	    
	    
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
	if (csid == 0x7534 and option == 0) then	
		player:setHomePoint();
		player:messageSpecial(HOMEPOINT_SET);
        end
end;		
