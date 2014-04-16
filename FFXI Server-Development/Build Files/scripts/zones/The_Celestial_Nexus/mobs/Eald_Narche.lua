-----------------------------------
-- Area: 
-- NPC:  
-----------------------------------

require("scripts/globals/quests");
require("scripts/globals/missions");
require("scripts/globals/titles");
require("scripts/globals/conquest");
require("scripts/globals/status");
require("scripts/globals/settings");


-----------------------------------
-- onMobSpawn
-----------------------------------

function onMobSpawn(mob)
end;
-----------------------------------
-- onMobEngaged
-----------------------------------
function onMobEngaged(mob,target)
	GetMobByID(17518594):updateEnmity(target);
	SpawnMob(17518596):updateEnmity(target);
	SpawnMob(17518597):updateEnmity(target);
	
end;


-----------------------------------
-- onMobFight
-----------------------------------
function onMobFight(mob,target)

end;


-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)

if(mob:getID() < 17518594) then
DespawnMob(17518596);
DespawnMob(17518597);
killer:startEvent(0x7d04);

else
DespawnMob(17518596);
DespawnMob(17518597);
killer:addTitle(BURIER_OF_THE_ILLUSION);
end
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
printf("finishCSID: %u",csid);
printf("RESULT: %u",option);
	
	if(csid == 0x7d04) then
	SpawnMob(17518595);
	end
	end;


