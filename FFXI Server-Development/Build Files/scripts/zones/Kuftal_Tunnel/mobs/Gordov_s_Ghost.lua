-----------------------------------
-- Area: Kuftal Tunnel
-----------------------------------

-----------------------------------
-- OnMobSpawn Action
-----------------------------------

function onMobSpawn(mob)
end; 

-----------------------------------
-- OnMobDeath Action
-----------------------------------
function onMobDeath(mob,killer)
killer:setVar("bastok82",(killer:getVar("bastok82")+1));
end;
