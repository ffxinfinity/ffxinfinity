-----------------------------------------------
-----   Special In Game Events/Festivals ------
-----------------------------------------------

package.loaded["scripts/globals/festivals"] = nil;
require("scripts/globals/status");
require("scripts/globals/settings");

---------------------------------------------------------
---------------------------------------------------------
------------    Harvest Festivals    --------------------
------------   Author: Metalfiiish   --------------------
---------------------------------------------------------
---------------------------------------------------------

function isHalloweenEnabled()
	local option = 0;
	if(HALLOWEEN_2005 == 1) then
		option = 1;
	elseif(HALLOWEEN_2008 == 1) then
		option = 2;
	elseif(HALLOWEEN_2009 == 1) then
		option = 3;
	elseif(HALLOWEEN_2010 == 1) then
		option = 4;		
	end
	return option;
end;

-- Add two custom dragon skins: @420/421
-- @422 dancing weapon
-- @ 433/432 golem
-- 265 dark eye, 266 Giant version
-- 290 dark bombs
-- 301 dark flour dude
-- 313 black spiders
-- 488 gob
-- 531 - 548 shade
-- 564/579 skele

function npcCostumeCheck(player,npc)
	
	-- Possible costume values:
	Yagudo = 580;
	Quadav = 0;
	Shade = 548;
	Orc = 0;
	Ghost = 368;
	Hound = 365;
	Skeleton = 564;
	Dark_Stalker = 547;
	
	halloween_costum_list = {Yagudo,Shade,Ghost,Hound}; 

	player:addStatusEffect(EFFECT_COSTUME,halloween_costum_list[math.random(1,table.getn(halloween_costum_list)) ],0,3600);

end;


function halloweenItemsCheck(player)
	local headSlot = player:getEquipID(SLOT_HEAD);
	local mainHand = player:getEquipID(SLOT_MAIN);
	local reward = 0;
	
	-- Normal Quality Rewards
	local pumpkinHead = 13916
	local pumpkinHead2 = 15176;
	local trickStaff = 17565;
	local trickStaff2 = 17587;
	
	reward_list = {pumpkinHead,pumpkinHead2,trickStaff,trickStaff2};

	-- Checks for HQ Upgrade
	for ri = 1, table.getn(reward_list) do
		printf("Checking for HQ");
		if(headSlot == reward_list[ri] or mainHand == reward_list[ri]) then
			if(headSlot == pumpkinHead and player:hasItem(13917) == false) then
				reward = 13917; -- Horror Head
			elseif(headSlot == pumpkinHead2 and player:hasItem(15177) == false) then
				reward = 15177; -- Horror Head II
			elseif(mainHand == trickStaff and player:hasItem(17566) == false) then
				reward =  17566; -- Treat Staff
			elseif(mainHand == trickStaff2 and player:hasItem(17588) == false) then
				reward = 17588; -- Treat Staff II
			end
			printf("HQ was %u",reward);
			return reward;
		end
	end
	
	-- Checks the possible item rewards to ensure player doesnt already have the item we are about to give them
	local cnt = table.getn(reward_list);
	printf("Cnt starts at: %u",cnt);
	printf("Reward List: %u",reward_list[1]);
	printf("Reward List: %u",reward_list[2]);
	printf("Reward List: %u",reward_list[3]);
	printf("Reward List: %u",reward_list[4]);
	while cnt ~= 0 do
		printf("...in loop..cnt = %u",cnt);

		local picked = reward_list[math.random(1,table.getn(reward_list))];
		printf("Picked reward: %u",picked);
		if(player:hasItem(picked) == false) then
			printf("Hit if");
			reward = picked;
			cnt = 0;
		else
			printf("Hit else");
			table.remove(reward_list,picked);
			cnt = cnt - 1;
		end
	printf("Item reward: %u",reward);
	return reward;
	end;
end;

function onHalloweenTrade(player,trade,npc)
	local contentEnabled = isHalloweenEnabled();
	local item = trade:getItem();
	printf("Started with item %u",item);
	-------------------
	-- 2005 edition ---
	-------------------
	if(contentEnabled == 1) then
		printf("Content is eabled!");
		-----------------------------------
		-- Treats allowed
		-----------------------------------
		treats_table = {4510, -- Acorn Cookie
					  5646, -- Bloody Chocolate
					  4496, -- Bubble Chocolate
					  4397, -- Cinna-cookie
					  4394, -- Ginger Cookie
					  4495, -- Goblin Chocolate
					  4413, -- Apple Pie
					  4488, -- Jack-o'-Pie
					  4421, -- Melon Pie
					  4563, -- Pamama Tart
					  4446, -- Pumpkin Pie
					  4414, -- Rolanberry Pie
					  4406, -- Baked Apple
					  5729, -- Bavarois
					  5745, -- Cherry Bavarois
					  5653, -- Cherry Muffin
					  5655, -- Coffee Muffin
					  5718, -- Cream Puff
					  5144, -- Crimson Jelly
					  5681, -- Cupid Chocolate
					  5672, -- Dried Berry
					  5567, -- Dried Date
					  4556, -- Icecap Rolanberry
					  5614, -- Konigskuchen
					  5230, -- Love Chocolate
					  4502, -- Marron Glace
					  4393, -- Orange Kuchen
					  5147, -- Snoll Gelato
					  4270, -- Sweet Rice Cake
					  5645, -- Witch Nougat
					  5552, -- Black Pudding
					  5550, -- Buche au Chocolat
					  5616, -- Lebkuchen House
					  5633, -- Chocolate Cake
					  5542, -- Gateau aux Fraises
					  5572, -- Irmik Helvasi
					  5625, -- Maple Cake
					  5559, -- Mille Feuille
					  5557, -- Mont Blanc
					  5629, -- Orange Cake
					  5631, -- Pumpkin Cake
					  5577, -- Sutlac
					  5627}; -- Yogurt Cake
		
		for itemInList = 1, table.getn(treats_table)  do
			printf("...running item check...");
			if(item == treats_table[itemInList]) then
			
				local itemReward = halloweenItemsCheck(player);
				
				if(itemReward ~= 0 and player:getFreeSlotsCount() >= 1) then -- Math.random added so you have 33% chance on getting item /and math.random(1,3) < 2
					local TextIDs = "scripts/zones/" .. player:getZoneName() .. "/TextIDs";
					package.loaded[TextIDs] = nil;
					require(TextIDs);
					player:addItem(itemReward);
					player:messageSpecial(ITEM_OBTAINED,itemReward);
				elseif(player:canUseCostume()) then
					npcCostumeCheck(player,npc);
				end
				player:tradeComplete();
				break;
			end
		end
	end
end;



