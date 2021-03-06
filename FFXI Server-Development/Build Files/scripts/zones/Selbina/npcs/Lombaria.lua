-----------------------------------
-- Area: Selbina
-- NPC: Lombaria
-- Map Seller NPC
-----------------------------------

require("scripts/globals/settings");
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
    local mapVar = 0;
	if player:hasKeyItem(MAP_OF_THE_SANDORIA_AREA) then
		mapVar = mapVar + 4;
	end
	if player:hasKeyItem(MAP_OF_THE_BASTOK_AREA) then
		mapVar = mapVar + 8;
	end
	if player:hasKeyItem(MAP_OF_THE_WINDURST_AREA) then
		mapVar = mapVar + 16;
	end
	if player:hasKeyItem(MAP_OF_THE_JEUNO_AREA) then
		mapVar = mapVar + 32;
	end
    player:startEvent(0x01f4, mapVar);
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
    if (csid == 0x01f4 and option ~= 1073741824) then
        local gil = 0;
        if option == MAP_OF_THE_SANDORIA_AREA then
            gil = 200;
        elseif option == MAP_OF_THE_BASTOK_AREA then
            gil = 200;
        elseif option == MAP_OF_THE_WINDURST_AREA then
            gil = 200;
        elseif option == MAP_OF_THE_JEUNO_AREA then
            gil = 600;
        end
        if (gil > 0 and player:delGil(gil)) then
            player:addKeyItem(option);
            player:messageSpecial(TextID_Selbina.KEYITEM_OBTAINED,option); 
        else
            player:messageSpecial(TextID_Selbina.NOT_HAVE_ENOUGH_GIL);
        end
    end
end;




