-----------------------------------
-- Area: Xarcabard
-- NPC:  Boreal Tiger
-- Involved in Quests: Atop the Highest Mountains
-- @zone 112
-- @pos 341 -29 370
-----------------------------------

require("scripts/globals/keyitems");
require("scripts/globals/quests");

-----------------------------------
-- onMobSpawn
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)

	if(killer:getQuestStatus(JEUNO,ATOP_THE_HIGHEST_MOUNTAINS) == QUEST_ACCEPTED and killer:hasKeyItem(ROUND_FRIGICITE) == false) then
		killer:setVar("BorealTigerKilled",os.time());
	end

end;