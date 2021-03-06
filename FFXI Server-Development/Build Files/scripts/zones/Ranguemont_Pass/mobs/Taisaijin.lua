-----------------------------------
-- Area: Ranguemont Pass
-- MOB:  Taisaijin
-----------------------------------
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)	
	
	local Taisaijin = 17457216;
	local Taisaijin_PH = GetServerVariable("Taisaijin_PH");
		
	GetMobByID(Taisaijin):setExtraVar(os.time() + math.random((86400), (259200)));
	SetServerVariable("Taisaijin_PH", 0);
	DeterMob(Taisaijin, true);
	DeterMob(Taisaijin_PH, false);
	SpawnMob(Taisaijin_PH, "", GetMobRespawnTime(Taisaijin_PH));
	
	killer:addTitle(BYEBYE_TAISAI);
	
end;