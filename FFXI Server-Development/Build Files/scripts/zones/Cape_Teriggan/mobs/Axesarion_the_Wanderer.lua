-----------------------------------
-- Area: Cape Teriggan
-- NPC:  Axesarion the Wanderer
-----------------------------------

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function OnMobSpawn(mob)
end;

-----------------------------------
-- onMobDeath Action
-----------------------------------

function onMobDeath(mob,killer)
	
	if(GetServerVariable("[ZM4]Wind_Headstone_Active") == 0) then	
		SetServerVariable("[ZM4]Wind_Headstone_Active",os.time()+ 900);
	end
	
end;