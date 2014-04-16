-----------------------------------
-- Area: Valley of Sorrows
-- NPC:  Adamantoise
-----------------------------------

require("scripts/globals/titles");
require("scripts/globals/status");

-----------------------------------
-- onMobInitialize Action
-----------------------------------

function onMobInitialize(mob)
	mob:addStatusEffect(EFFECT_REGAIN,15,3,0);
end;

-----------------------------------
-- onMobEngaged Action
-----------------------------------

function onMobEngaged(mob,target)
	Adamantoise_Engaged = os.time(t);
end;

-----------------------------------
-- onMobFight Action
-----------------------------------

function onMobFight(mob,target)

	if (mob:getBattleTime() % 60 == 0) then -- Check every minute to reduce load
		if(os.time(t) >= (Adamantoise_Engaged + 1800)) then
			mob:rageMode(); -- Stats = Stats * 10
		end
	end

end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
    killer:addTitle(TORTOISE_TORTURER);

    Adamantoise  = mob:getID();
    Aspidochelone = 17301538; 
    ToD     = GetServerVariable("[POP]Aspidochelone");
    kills   = GetServerVariable("[PH]Aspidochelone");
    DeterMob(Adamantoise, true);
    if (ToD <= os.time(t) and GetMobAction(Aspidochelone) == 0) then
        if (math.random((1),(5)) == 3 or kills > 6) then
            UpdateNMSpawnPoint(Aspidochelone);
            SpawnMob(Aspidochelone, "", math.random((75600),(86400)));
        end
    else
        UpdateNMSpawnPoint(Adamantoise);
        SpawnMob(Adamantoise, '', math.random((75600),(86400)));
        SetServerVariable("[PH]Aspidochelone", kills + 1);
    end
end;