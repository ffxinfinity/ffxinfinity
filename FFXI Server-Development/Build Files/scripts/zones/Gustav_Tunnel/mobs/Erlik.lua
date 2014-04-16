----------------------------------	
-- Area: Gustav Tunnel	
--  MOB: Erlik
-- Note: Place holder Baobhan Sith
-----------------------------------	

require("/scripts/zones/Gustav_Tunnel/MobIDs");
	
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
  
  mob = mob:getID();
  if (Baobhan_Sith_PH[mob] ~= nil) then
  
    ToD = GetServerVariable("[POP]Baobhan_Sith");
    if (ToD <= os.time(t) and GetMobAction(Baobhan_Sith) == 0) then
      if (math.random((1),(20)) == 5) then
        UpdateNMSpawnPoint(Baobhan_Sith);
        SpawnMob(Baobhan_Sith, "", GetMobRespawnTime(mob));
        SetServerVariable("[PH]Baobhan_Sith", mob);
        DeterMob(mob, true);
      end
    end
  end
  
end;	
