-----------------------------------
--  Area: Caedarva Mire
--   NPC: Nahshib
--  Type: Assault
-- @zone: 79
--  @pos: -274.334 -9.287 -64.255
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Caedarva_Mire/TextIDs"] = nil;
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

