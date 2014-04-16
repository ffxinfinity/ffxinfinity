-----------------------------------
-- Area: Qu'Bia Arena
-- Name: Shattering stars - Maat Fight
-- @pos -221 -24 19 206
-----------------------------------

-- After registering the BCNM via bcnmRegister(bcnmid)
function OnBcnmRegister(player,instance)
end;

-- Physically entering the BCNM via bcnmEnter(bcnmid)
function OnBcnmEnter(player,instance)
	-- player:messageSpecial(107);
end;

-- Leaving the BCNM by every mean possible, given by the LeaveCode
-- 1=Select Exit on circle
-- 2=Winning the BC
-- 3=Disconnected or warped out
-- 4=Losing the BC
-- via bcnmLeave(1) or bcnmLeave(2). LeaveCodes 3 and 4 are called
-- from the core when a player disconnects or the time limit is up, etc

function OnBcnmLeave(player,instance,leavecode)
-- print("leave code "..leavecode);

	if(leavecode == 2) then -- play end CS. Need time and battle id for record keeping + storage
		player:startEvent(0x7d01,1,1,1,instance:getTimeInside(),1,1,0);
	elseif(leavecode == 4) then
		player:startEvent(0x7d02);
	end

end;

function onEventUpdate(player,csid,option)
-- print("bc update csid "..csid.." and option "..option);
end;

function onEventFinish(player,csid,option)
-- print("bc finish csid "..csid.." and option "..option);

	if(csid == 0x7d01) then
		if(player:getQuestStatus(JEUNO,SHATTERING_STARS) == QUEST_ACCEPTED and player:getFreeSlotsCount() > 0) then
			player:addItem(4181);
			player:messageSpecial(ITEM_OBTAINED,4181);
			player:setVar("maatDefeated",player:getMainJob()); 
			--i moved it here so you can keep fighting maat after turning in quest
		end
	
		
		if (player:getVar("maatCap")>0 and player:getVar("UpdatedMaatCapValue") == 0) then
			MaatFirstWonJob = "MaatJob";
			MaatFirstWonJob = MaatFirstWonJob .. player:getVar("maatCap");
			player:setVar(MaatFirstWonJob, player:getVar("maatCap"));
			player:setVar("UpdatedMaatCapValue", 1);
		end
		--this is mainly for people that have killed Maat before on a previous job before cap was added
		
		MaatCapTotal = 0;
		MaatWonJob = "MaatJob";
		MaatWonJob = MaatWonJob .. player:getMainJob();
		player:setVar(MaatWonJob, player:getMainJob());	
		--gets value of job, adds it to a dynamic variable, for example, BRD is job 10, so it updates MaatJob10 with 10, etc
		--this prevents duplicate victories from accidentally being added
		for i=1,15 do --checks Maat victories
		
		MaatCheck = "MaatJob";
		MaatCheck = MaatCheck .. i;
		MaatCapTotal = MaatCapTotal + player:getVar(MaatCheck);
		end
		
		
		
		player:setVar("maatCap", MaatCapTotal); --update maat's cap progress
		player:addTitle(MAAT_MASHER);
		
		if(player:getVar("maatCap") == 120) then --120 is WAR to SMN values added together, so beating him with the 15 jobs
		player:addQuest(JEUNO,BEYOND_THE_SUN); 
		--this isn't really necessary, but it's a helpful way to indicate to the player they can get Maat's Cap
		end
	
	end

end;