-----------------------------------
-- Area: Arrapago Reef
-- NPC:  Medusa
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobEngaged Action
-----------------------------------

function OnMobEngaged(mob,target)
	
	SpawnMob(16998863,180):updateEnmity(target);
	SpawnMob(16998864,180):updateEnmity(target);
	SpawnMob(16998865,180):updateEnmity(target);
	SpawnMob(16998866,180):updateEnmity(target);
	
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	killer:addTitle(GORGONSTONE_SUNDERER);
end;