----------------------------------	
-- Area: Labyrinth of Onzozo
--   NM: Hellion
-----------------------------------	
  
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
    -- Set Hellion's Window Open Time
    wait = math.random((2),(4)) * 3600
    SetServerVariable("[POP]Hellion", os.time(t) + wait); -- 2-4 hours
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Hellion");
    SetServerVariable("[PH]Hellion", 0);
    DeterMob(PH, false);
    SpawnMob(PH, '', GetMobRespawnTime(PH));

end;