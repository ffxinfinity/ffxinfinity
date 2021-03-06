-----------------------------------
--  Area: Giddeus (145)
--   Mob: Juu_Duzu_the_Whirlwind
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	

    -- Set Juu_Duzu_the_Whirlwind's Window Open Time
    SetServerVariable("[POP]Juu_Duzu_the_Whirlwind", os.time(t) + math.random((3600),(7200))); -- 1-2 hours
    DeterMob(mob:getID(), true);
    
    -- Set PH back to normal, then set to respawn spawn
    PH = GetServerVariable("[PH]Juu_Duzu_the_Whirlwind");
    SetServerVariable("[PH]Juu_Duzu_the_Whirlwind", 0);
    DeterMob(PH, false);
    SpawnMob(PH, '', GetMobRespawnTime(PH));
  
end;

