-----------------------------------
-- Area: Gusgen Mines
-- NPC:  qm4 (???)
-- Involved In Quest: Ghosts of the Past
-- @zone 196
-- @pos -174 0 369
-----------------------------------
package.loaded["scripts/zones/Gusgen_Mines/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/quests");
require("scripts/zones/Gusgen_Mines/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
	
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:getCurrentMission(BASTOK) == THE_SALT_OF_THE_EARTH and player:getVar("BASTOK91") ==2) then

if(GetMobAction(17645794) == 0 and GetMobAction(17645795)== 0 and GetMobAction(17645796)== 0 and GetMobAction(17645797)== 0 and GetMobAction(17645798)== 0 and GetMobAction(17645799)== 0 and GetMobAction(17645800)== 0 and GetMobAction(17645801)== 0 and GetMobAction(17645802)== 0 and GetMobAction(17645803)== 0 and GetMobAction(17645804)== 0 and GetMobAction(17645805)== 0 and GetMobAction(17645806)== 0 and GetMobAction(17645807)== 0 and GetMobAction(17645808)== 0)then
SpawnMob(17645794);
end

elseif(player:getVar("BASTOK91") >2 and player:getVar("BASTOK91") < 10)then 	if(GetMobAction(17645794) == 0 and GetMobAction(17645795)== 0 and GetMobAction(17645796)== 0 and GetMobAction(17645797)== 0 and GetMobAction(17645798)== 0 and GetMobAction(17645799)== 0 and GetMobAction(17645800)== 0 and GetMobAction(17645801)== 0 and GetMobAction(17645802)== 0 and GetMobAction(17645803)== 0 and GetMobAction(17645804)== 0 and GetMobAction(17645805)== 0 and GetMobAction(17645806)== 0 and GetMobAction(17645807)== 0 and GetMobAction(17645808)== 0)then
SpawnMob(17645794);
player:setVar("BASTOK91",2);
end
elseif(GetMobAction(17645794) == 0 and GetMobAction(17645795)== 0 and GetMobAction(17645796)== 0 and GetMobAction(17645797)== 0 and GetMobAction(17645798)== 0 and GetMobAction(17645799)== 0 and GetMobAction(17645800)== 0 and GetMobAction(17645801)== 0 and GetMobAction(17645802)== 0 and GetMobAction(17645803)== 0 and GetMobAction(17645804)== 0 and GetMobAction(17645805)== 0 and GetMobAction(17645806)== 0 and GetMobAction(17645807)== 0 and GetMobAction(17645808)== 0)then
	if(player:getVar("BASTOK91") == 10)then
	player:addKeyItem(MIRACLESALT);
	player:messageSpecial(KEYITEM_OBTAINED,MIRACLESALT);
	end
	else
	player:messageSpecial(NOTHING_OUT_OF_ORDINARY);
	end	
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("CSID2: %u",csid);
--printf("RESULT2: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
end;