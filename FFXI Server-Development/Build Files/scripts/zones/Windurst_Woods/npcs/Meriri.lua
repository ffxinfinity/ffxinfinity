-----------------------------------
-- Area: Windurst Woods
-- NPC: Meriri
-- Guild Merchant NPC: Clothcrafting Guild 
-- @zone: 241
-- @pos: -76.471 -3.55 -128.341
-----------------------------------
package.loaded["scripts/zones/Windurst_Woods/TextIDs"] = nil;
-----------------------------------
require("scripts/globals/settings");
require("scripts/zones/Windurst_Woods/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end;

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	if(player:sendGuild(515,6,21,0)) then
		player:showText(npc,MERIRI_DIALOG);
	end
end;

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
	-- printf("CSID: %u",csid);
	-- printf("RESULT: %u",option);
end;

