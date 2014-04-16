-----------------------------------
--  Area: Bhaflau Thickets
--   NPC: Daswil
--  Type: Assault
-- @zone: 52
--  @pos: -208.720 -12.889 -779.713
-- 
package.loaded["scripts/zones/Bhaflau_Thickets/TextIDs"] = nil;
require("scripts/globals/missions");
require("scripts/zones/Bhaflau_Thickets/TextIDs");
require("scripts/globals/titles");
require("scripts/globals/keyitems");

-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)

if(player:hasKeyItem(SUPPLIES_PACKAGE))then
player:startEvent(0x0005);
elseif(player:getVar("TOAUM2") ==1)then
player:startEvent(0x0006);
elseif(player:getCurrentMission(TOAU) > IMMORTAL_SENTRIES)then
player:startEvent(0x0007);
else
player:startEvent(0x0004);
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
if(csid == 0x0005 and option == 1)then
player:delKeyItem(SUPPLIES_PACKAGE);
player:setVar("TOAUM2",1);
elseif(csid == 0x0006)then
player:setVar("TOAUM2",1);
end
end;

