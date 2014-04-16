-----------------------------------
-- Area: 181
-- Name: celestial nexus
-----------------------------------
package.loaded["scripts/zones/The_Celestial_Nexus/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/bcnm");
require("scripts/globals/titles");
require("scripts/globals/quests");
require("scripts/globals/status");
require("scripts/globals/settings");
require("scripts/globals/missions");
require("scripts/zones/The_Celestial_Nexus/TextIDs");

-----------------------------------
-- EXAMPLE SCRIPT
-- 
-- What should go here:
-- giving key items, playing ENDING cutscenes
--
-- What should NOT go here:
-- Handling of "battlefield" status, spawning of monsters,
-- putting loot into treasure pool, 
-- enforcing ANY rules (SJ/number of people/etc), moving
-- chars around, playing entrance CSes (entrance CSes go in bcnm.lua)

-- After registering the BCNM via bcnmRegister(bcnmid)
function OnBcnmRegister(player,instance)
end;

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function OnBcnmEnter(player,instance)
print("instance code ");
end;

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

function OnBcnmLeave(player,instance,leavecode)
printf("leavecode: %u",leavecode);

	
if(leavecode == 2) then 
player:startEvent(0x7D01,0,0,0,instance:getTimeInside(),0,0,1,1); 

elseif(leavecode == 4) then
player:startEvent(0x7d02);
end
	
end;

function onEventUpdate(player,csid,option)
print("bc update csid "..csid.." and option "..option);
if(player:getVar("ZM16") == 2)then
player:startEvent(0x7D04)
end
end;

function onEventFinish(player,csid,option)
print("bc finish csid "..csid.." and option "..option);	
if(csid == 0x7D01)then
player:setPos(0.001,-12,40,071,251);
player:completeMission(ZILART,THE_CELESTIAL_NEXUS);
player:addMission(ZILART_AWAKENING);
player:setVar("ZM16",0);
end
end;


