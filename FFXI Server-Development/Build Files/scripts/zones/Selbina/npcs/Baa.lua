-----------------------------------
-- Area: Selbina
-- NPC: Baa
-- Standard Info NPC
-----------------------------------

-----------------------------------
-- onTrade Action
-----------------------------------

function onTrade(player,npc,trade)
end; 

-----------------------------------
-- onTrigger Action
-----------------------------------

function onTrigger(player,npc)
--printf("CSID: %u",csid);
	stock = {5621,20000, 30}	  --candy
	showNationShop(player,SELBINA,stock);
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
	stock = {5621,20000, 30}	  --candy
	showNationShop(player,SELBINA,stock);
end;
