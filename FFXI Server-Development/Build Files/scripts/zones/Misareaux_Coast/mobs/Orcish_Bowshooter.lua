
-----------------------------------
-- mob :Orcish_Bowshooter
-- zone : Misareaux_Coast
-----------------------------------




-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)

	local kills = killer:getVar("FOMOR_HATE");
	if(kills > 0) then
		killer:setVar("FOMOR_HATE",kills -1);
	end
end;