-----------------------------------	
-- Area: Valkurm Dunes	
--  MOB: Damselfly
-- Note: Place holder Valkurm Emperor 
-----------------------------------	

require("/scripts/zones/Valkurm_Dunes/MobIDs");
require("/scripts/globals/fieldsofvalor");	
	
-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
	checkRegime(killer,mob,9,1);
	checkRegime(killer,mob,10,2);
  
    mob = mob:getID();
    if (Valkurm_Emperor_PH[mob] ~= nil) then

        VE_ToD = GetServerVariable("[POP]Valkurm_Emperor");
        if (VE_ToD <= os.time(t) and GetMobAction(Valkurm_Emperor) == 0) then
            if (math.random((1),(33)) == 5) then
                UpdateNMSpawnPoint(Valkurm_Emperor);
                SpawnMob(Valkurm_Emperor, "", GetMobRespawnTime(mob));
                SetServerVariable("[PH]Valkurm_Emperor", mob);
                DeterMob(mob, true);
            end
        end
    end
end;	
