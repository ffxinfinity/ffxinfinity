-----------------------------------	
-- Area: Kuftal Tunnel	
-- MOB:  Recluse Spider	
-- Note: Place Holder for Arachne
-----------------------------------	

require("scripts/zones/Kuftal_Tunnel/MobIDs");
	
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	

  mob = mob:getID();
  if (Arachne_PH[mob] ~= nil) then
  
    ToD = GetServerVariable("[POP]Arachne");
    if (ToD <= os.time(t) and GetMobAction(Arachne) == 0) then
      if (math.random((1),(20)) == 5) then
        UpdateNMSpawnPoint(Arachne);
        SpawnMob(Arachne, "", GetMobRespawnTime(mob));
        SetServerVariable("[PH]Arachne", mob);
        DeterMob(mob, true);
      end
    end
  end
end;	
