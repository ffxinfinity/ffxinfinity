-----------------------------------	
-- Area: Cape Teriggan	
-- MOB:  Greater Manticore	
-- Note: Place Holder for Frostmane
-----------------------------------	

require("scripts/zones/Cape_Teriggan/MobIDs");
require("scripts/globals/fieldsofvalor");	
	
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
	checkRegime(killer,mob,108,2);
  mob = mob:getID();
  if (Frostmane_PH[mob] ~= nil) then
  
    ToD = GetServerVariable("[POP]Frostmane");
    if (ToD <= os.time(t) and GetMobAction(Frostmane) == 0) then
      if (math.random((1),(20)) == 5) then
        UpdateNMSpawnPoint(Frostmane);
        SpawnMob(Frostmane, "", GetMobRespawnTime(mob));
        SetServerVariable("[PH]Frostmane", mob);
        DeterMob(mob, true);
      end
    end
  end
end;	
