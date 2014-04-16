-----------------------------------
-- Area: Ordelles Caves (193)
-- NPC:  Morbolger
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)

	killer:addTitle(MORBOLBANE);
    
    -- Set Morbolger's spawnpoint and respawn time (21-24 hours)
    Morbolger = mob:getID();
    UpdateNMSpawnPoint(17568127);
    SpawnMob(17568127, '', math.random((75600),(86400)));
    
end;