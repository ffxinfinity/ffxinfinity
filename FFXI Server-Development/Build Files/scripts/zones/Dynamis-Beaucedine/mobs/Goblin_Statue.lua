-----------------------------------
-- Area: Dynamis Beaucedine
-- NPC:  Goblin Statue
-- Map Position: http://images1.wikia.nocookie.net/__cb20090312005233/ffxi/images/thumb/b/b6/Bea.jpg/375px-Bea.jpg
-----------------------------------
package.loaded["scripts/zones/Dynamis-Beaucedine/TextIDs"] = nil;
-----------------------------------

require("scripts/globals/dynamis");
require("scripts/zones/Dynamis-Beaucedine/TextIDs");

-----------------------------------
-- onMobSpawn Action
-----------------------------------

function onMobSpawn(mob)
end;

-----------------------------------
-- onMobEngaged
-----------------------------------

function onMobEngaged(mob,target)
	
	local X = mob:getXPos();
	local Y = mob:getYPos();
	local Z = mob:getZPos();
	local spawnList = beaucedineGoblinList;
	
	for nb = 1, table.getn(spawnList), 2 do
		if(mob:getID() == spawnList[nb]) then
			for nbi = 1, table.getn(spawnList[nb + 1]), 1 do
				if((nbi % 2) == 0) then X=X+2; Z=Z+2; else X=X-2; Z=Z-2; end
				local mobNBR = spawnList[nb + 1][nbi];
				
				if(mobNBR <= 20) then
					if(mobNBR == 0) then mobNBR = math.random(1,15);  end -- Spawn random Vanguard (TEMPORARY)
					local DynaMob = getDynaMob(target,mobNBR,2);
					
					if(DynaMob ~= nil) then
						-- Spawn Mob
						SpawnMob(DynaMob):updateEnmity(target);
						GetMobByID(DynaMob):setPos(X,Y,Z);
						GetMobByID(DynaMob):setSpawn(X,Y,Z);
						-- Spawn Pet for BST, DRG, and SMN
						if(mobNBR == 9 or mobNBR == 15) then
							SpawnMob(DynaMob + 1):updateEnmity(target);
							GetMobByID(DynaMob + 1):setPos(X,Y,Z);
							GetMobByID(DynaMob + 1):setSpawn(X,Y,Z);
						end
					end
				elseif(mobNBR > 20) then
					SpawnMob(mobNBR):updateEnmity(target);
					
					local MJob = GetMobByID(mobNBR):getMainJob();
					if(MJob == 9 or MJob == 15) then
						-- Spawn Pet for BST, DRG, and SMN
						SpawnMob(mobNBR + 1):updateEnmity(target);
						GetMobByID(mobNBR + 1):setPos(X,Y,Z);
						GetMobByID(mobNBR + 1):setSpawn(X,Y,Z);
					end
				end
			end
		end
	end
	
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob,killer)
	
	local mobID = mob:getID();
	-- Time Bonus: 031 046
	if(mobID == 17326860 and alreadyReceived(killer,3) == false) then
		killer:addTimeToDynamis(15);
		addDynamisList(killer,4);
	elseif(mobID == 17326875 and alreadyReceived(killer,4) == false) then
		killer:addTimeToDynamis(15);
		addDynamisList(killer,8);
	-- HP Bonus: 037 041 044 051 053 
	elseif(mobID == 17326866 or mobID == 17326870 or mobID == 17326873 or mobID == 17326880 or mobID == 17326882) then 
		killer:restoreHP(2000);
		killer:messageBasic(024,(killer:getMaxHP()-killer:getHP()));
	-- MP Bonus: 038 040 045 049 052 104
	elseif(mobID == 17326867 or mobID == 17326869 or mobID == 17326874 or mobID == 17326878 or mobID == 17326881 or mobID == 17326933) then 
		killer:restoreMP(2000);
		killer:messageBasic(025,(killer:getMaxMP()-killer:getMP()));
	end
	
end;