-----------------------------------
--	Area: Port Windurst
--	NPC: Ryan 
--	Standard Merchant NPC
--	Working 100%
-----------------------------------

require("scripts/globals/shop");
package.loaded["scripts/zones/Port_Windurst/TextIDs"] = nil;
require("scripts/zones/Port_Windurst/TextIDs");

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
	
player:showText(npc,RYAN_SHOP_DIALOG);

stock = {0x4100,290,  --Bronze Axe
		 0x4097,246,  --Bronze Sword
		 0x43b8,5,    --Crossbow Bolt
		 0x3120,235,  --Bronze Harness
		 0x3121,2286, --Brass Harness
		 0x31a0,128,  --Bronze Mittens
		 0x31a1,1255, --Brass Mittens
		 0x3220,191,  --Bronze Subligar
		 0x3221,1840, --Brass Subligar
		 0x32a0,117,  --Bronze Leggings
		 0x32a1,1140, --Brass Leggings
		 0x3128,1145, --Kenpogi
		 0x31a8,630,  --Tekko
		 0x3228,915,  --Sitabaki
		 0x32a8,584}  --Kyahan
 
showShop(player, WINDURST, stock);
end; 

-----------------------------------
-- onEventUpdate
-----------------------------------

function onEventUpdate(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
end;

-----------------------------------
-- onEventFinish
-----------------------------------

function onEventFinish(player,csid,option)
--printf("CSID: %u",csid);
--printf("RESULT: %u",option);
end;



