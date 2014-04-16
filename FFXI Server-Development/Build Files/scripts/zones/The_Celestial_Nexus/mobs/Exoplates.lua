-----------------------------------
-- Area: 
-- NPC:  
-----------------------------------

require("scripts/globals/quests");
require("scripts/globals/missions");
require("scripts/globals/conquest");
require("scripts/globals/status");
require("scripts/globals/settings");


-----------------------------------
-- onMobSpawn
-----------------------------------

function onMobSpawn(mob)
if(mob:AnimationSub() == 0) then mob:AnimationSub(1);
end
end;
-----------------------------------
-- onMobEngaged
-----------------------------------
function onMobEngaged(mob,target)
GetMobByID(17518593):updateEnmity(target);

end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
GetMobByID(17518593):delMod(MOD_UDMGPHYS, -200);
GetMobByID(17518593):delMod(MOD_UDMGMAGIC, -200);
end;


