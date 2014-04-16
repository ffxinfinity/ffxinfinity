-----------------------------------
-- Area: King Ranperres Tomb
-- NPC:  Corrupted Soffeil
-----------------------------------
-----------------------------------

require("/scripts/globals/missions");	

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	local currentMission = killer:getCurrentMission(SANDORIA);
	      MissionStatus = killer:getVar("MissionStatus");
	
	if(currentMission == RANPERRE_S_FINAL_REST and MissionStatus == 1) then
		killer:setVar("Mission6-2MobKilled",1);
	end
end;
