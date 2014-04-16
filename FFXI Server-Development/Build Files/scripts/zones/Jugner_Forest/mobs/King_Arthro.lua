-----------------------------------
-- Area: Jugner Forest
-- NPC:  King Arthro
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- onMobFight Action
-----------------------------------

function onMobFight(mob,target)
	
	if(mob:getBattleTime() == 1200) then
		mob:rageMode();
	end
	
end;

-----------------------------------
-- onMonsterMagicPrepare
-----------------------------------

function onMonsterMagicPrepare(mob, target)
    
	-- Instant cast on spells - Waterga IV, Poisonga II, Drown, and Enwater
	rnd = math.random();
	
	if (rnd < 0.2) then
		return 202; -- Waterga IV
	elseif (rnd < 0.6) then
		return 226; -- Poisonga II
	elseif (rnd < 0.8) then
		return 240; -- Drown
	else
		return 105; -- Enwater
	end
    
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
end;