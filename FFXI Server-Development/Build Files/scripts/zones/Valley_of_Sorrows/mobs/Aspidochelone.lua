-----------------------------------
-- Area: Valley of Sorrows
-- NPC:  Aspidochelone
-----------------------------------

require("scripts/globals/titles");
require("scripts/globals/status");

-----------------------------------
-- onMobInitialize Action
-----------------------------------

function onMobInitialize(mob)
	mob:addStatusEffect(EFFECT_REGEN,50,3,0);
	mob:addStatusEffect(EFFECT_REGAIN,15,3,0);
end;

-----------------------------------
-- onMobEngaged Action
-----------------------------------

function onMobEngaged(mob,target)
	Aspid_Engaged = os.time(t);
end;

-----------------------------------
-- onMobFight Action
-----------------------------------

function onMobFight(mob,target)

	if (mob:getBattleTime() % 60 == 0) then -- Check every minute to reduce load
		if(os.time(t) >= (Aspid_Engaged + 3600)) then
			mob:rageMode(); -- Stats = Stats * 10
		end
	end

end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)

    killer:addTitle(ASPIDOCHELONE_SINKER);

    -- Set Aspidochelone's Window Open Time
    wait = 72 * 3600
    SetServerVariable("[POP]Aspidochelone", os.time(t) + wait); -- 3 days
    DeterMob(mob:getID(), true);

    -- Set Adamantoise's spawnpoint and respawn time (21-24 hours)
    Adamantoise = 17301537;
    SetServerVariable("[PH]Aspidochelone", 0);
    DeterMob(Adamantoise, false);
    UpdateNMSpawnPoint(Adamantoise);
    SpawnMob(Adamantoise, '', math.random((75600),(86400)));
    
end;