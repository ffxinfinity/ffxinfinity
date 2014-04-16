-----------------------------------
--  Area: Wajaom Woodlands
--  NPC:  Watisa
--  Type: Chocobo Renter
--  @pos -201 -11 93 51
-----------------------------------

require("scripts/globals/status");
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
	
	price = 100;
	gil = player:getGil();

	if(player:hasKeyItem(CHOCOBO_LICENSE) and player:getMainLvl() >= 20) then
		player:startEvent(0x0009,price,gil);
	else
		player:startEvent(0x000a,price,gil);
	end
	
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

    local price = 100;

	if(csid == 0x0009 and option == 0) then
        if (player:delGil(price)) then
            if (player:getMainLvl() >= 20) then
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,1800,true);
            else
                player:addStatusEffectEx(EFFECT_CHOCOBO,EFFECT_CHOCOBO,1,0,900,true);
            end
        end
	end
	
end;
