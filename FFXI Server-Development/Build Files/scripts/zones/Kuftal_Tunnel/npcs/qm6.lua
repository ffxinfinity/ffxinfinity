-----------------------------------
-- Area: Kuftal Tunnel
-----------------------------------
package.loaded["scripts/zones/Kuftal_Tunnel/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/keyitems");
require("scripts/globals/treasure");
require("scripts/globals/quests");
require("scripts/zones/Kuftal_Tunnel/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;
-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
if(player:getVar("bastok82") == 2)then
player:messageSpecial(7281);
if(GetMobAction(17489926) == 0) then
SpawnMob(17489926,180):updateEnmity(player);
end
if(GetMobAction(17489927) == 0) then
SpawnMob(17489927,180):updateEnmity(player);
end
if(GetMobAction(17489928) == 0) then
SpawnMob(17489928,180):updateEnmity(player);
end
elseif(player:getVar("bastok82") == 5)then
player:startEvent(0x000d);
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
printf("CSID: %u",csid);
printf("RESULT: %u",option);
if(csid == 0x000c and option ==0)then
player:messageSpecial(7280);
player:setVar("bastok82",2);
elseif(csid == 0x000d)then
player:setVar("bastok82",6);
end
end;