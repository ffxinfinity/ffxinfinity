-----------------------------------	
-- Area: Kuftal Tunnel	
-- MOB:  Deinonychus	
-- Note: Place Holder for Yowie
-----------------------------------	

require("scripts/zones/Kuftal_Tunnel/MobIDs");
	
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	

  mob = mob:getID();
  if (Yowie_PH[mob] ~= nil) then
  
    ToD = GetServerVariable("[POP]Yowie");
    if (ToD <= os.time(t) and GetMobAction(Yowie) == 0) then
      if (math.random((1),(20)) == 5) then
        UpdateNMSpawnPoint(Yowie);
        SpawnMob(Yowie, "", GetMobRespawnTime(mob));
        SetServerVariable("[PH]Yowie", mob);
        DeterMob(mob, true);
      end
    end
  end
end;	
