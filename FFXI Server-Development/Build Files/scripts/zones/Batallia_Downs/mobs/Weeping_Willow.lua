-----------------------------------
-- Area: Batallia Downs
-- NPC:  Weeping Willow
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobFight Action
-----------------------------------

function onMobFight(mob,target)
	if(mob:getHP() <= mob:getMaxHP()/2 and GetServerVariable("NM-SpecialWeepWillowSapSpawn") < 1) then
		SpawnMob(17207303,600):updateEnmity(target);
		SpawnMob(17207304,600):updateEnmity(target);
		SpawnMob(17207305,600):updateEnmity(target);
		SpawnMob(17207306,600):updateEnmity(target);
		SpawnMob(17207307,600):updateEnmity(target);
		SetServerVariable("NM-SpecialWeepWillowSapSpawn",1);
	end
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	SpawnMob(17207308,600):updateEnmity(killer);
	SetServerVariable("NM-SpecialWeepWillowSapSpawn",0);
end;


-----------------------------------
-- onMobDespawn
-----------------------------------

function OnMobDespawn(mob)
	SetServerVariable("[NM-Special]WeepWillowSapSpawn",0);
end;