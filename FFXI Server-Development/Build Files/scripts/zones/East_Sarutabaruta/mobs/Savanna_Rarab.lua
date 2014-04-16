-----------------------------------	
-- Area: East Sarutabaruta	
-- MOB:  Savanna Rarab	
-----------------------------------	
	
require("/scripts/globals/fieldsofvalor");	
require("/scripts/zones/East_Sarutabaruta/MobIDs");

-----------------------------------	
-- onMobDeath	
-----------------------------------	
	
function onMobDeath(mob,killer)	
	checkRegime(killer,mob,91,1);
    
    mob = mob:getID();
    if (Sharp_Eared_Ropipi_PH[mob] ~= nil) then

        ToD = GetServerVariable("[POP]Sharp_Eared_Ropipi");
        if (ToD <= os.time(t) and GetMobAction(Sharp_Eared_Ropipi) == 0) then
            if (math.random((1),(5)) == 3) then
                UpdateNMSpawnPoint(Sharp_Eared_Ropipi);
                SpawnMob(Sharp_Eared_Ropipi, "", GetMobRespawnTime(mob));
                SetServerVariable("[PH]Sharp_Eared_Ropipi", mob);
                DeterMob(mob, true);
            end
        end
    end
    
end;	
