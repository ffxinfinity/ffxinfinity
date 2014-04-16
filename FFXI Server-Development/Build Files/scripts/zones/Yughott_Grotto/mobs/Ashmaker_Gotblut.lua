-----------------------------------
--  Area: Yughott Grotto (142)
--    NM: Ashmaker_Gotblut
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Ashmaker_Gotblut's Window Open Time
    wait = math.random((7200),(10800))
    SetServerVariable("[POP]Ashmaker_Gotblut", os.time(t) + wait); -- 2-3 hours
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Ashmaker_Gotblut");
    SetServerVariable("[PH]Ashmaker_Gotblut", 0);
    DeterMob(PH, false);
    SpawnMob(PH, '', GetMobRespawnTime(PH));

end;

