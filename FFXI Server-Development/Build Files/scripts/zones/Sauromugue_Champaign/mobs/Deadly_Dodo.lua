-----------------------------------
--  Area: Sauromugue Champaign (120)
--   Mob: Deadly_Dodo
-----------------------------------

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)	
  
    -- Set Deadly_Dodo's Window Open Time
    SetServerVariable("[POP]Deadly_Dodo", os.time(t) + 3600); -- 1 hour
    DeterMob(mob:getID(), true);

    -- Set PH back to normal, then set to respawn
    PH = GetServerVariable("[PH]Deadly_Dodo");
    SetServerVariable("[PH]Deadly_Dodo", 0);
    DeterMob(PH, false);
    SpawnMob(PH, '', GetMobRespawnTime(PH));
  
end;

