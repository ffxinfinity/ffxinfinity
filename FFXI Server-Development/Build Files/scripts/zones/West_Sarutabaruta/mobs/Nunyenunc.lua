-----------------------------------
--  Area: West Sarutabaruta (115)
--    NM: Nunyenunc
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Nunyenunc's Window Open Time
    wait = math.random((7200),(10800))
    SetServerVariable("[POP]Nunyenunc", os.time(t) + wait); -- 2-3 hours
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Nunyenunc");
    SetServerVariable("[PH]Nunyenunc", 0);
    DeterMob(PH, false);
    SpawnMob(PH, '', GetMobRespawnTime(PH));
    
end;

