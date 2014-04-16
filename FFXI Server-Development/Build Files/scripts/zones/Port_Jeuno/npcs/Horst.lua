-----------------------------------
-- Area: Port Jeuno
-- NPC: Horst
-----------------------------------

package.loaded["scripts/zones/Port_Jeuno/TextIDs"] = nil;
require("scripts/zones/Port_Jeuno/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
player:startEvent(0x0153,2,15,7,7,7);
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
if(csid == 0x0153)then
if(option == 260)then
player:setPos(-562,0.001,640,26,102); -- latheine
elseif(option == 264)then
player:setPos(91,-68,-582,237,108); -- konsh
elseif(option == 268)then
player:setPos(-28,46,-680,76,117); -- tahr
elseif(option == 272)then
player:setPos(241,0.001,11,42,104); -- jugner
elseif(option == 276)then
player:setPos(362,0.001,-119,4,103); -- valkrum
elseif(option == 280)then
player:setPos(-338,-23,47,167,118); -- bubu
elseif(option == 288)then
player:setPos(269,-7,-75,192,112); -- xarca
elseif(option == 284)then
player:setPos(337,0.001,-675,52,107);  -- gusta S
elseif(option == 292)then
player:setPos(-71,0.001,601,126,106); -- gusta N
end
end
end;




