-----------------------------------
--  Area: Aht Urhgan Whitegate
--   NPC: Rytaal
--  Type: Standard NPC
-- @zone: 50
--  @pos: 112.002 -1.338 -45.038
-- 
-- Auto-Script: Requires Verification (Verified by Brawndo)
-----------------------------------
package.loaded["scripts/zones/Aht_Urhgan_Whitegate/TextIDs"] = nil;
require("scripts/globals/keyitems");
require("scripts/zones/Aht_Urhgan_Whitegate/TextIDs");
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
 local currentday = tonumber(os.date("%j"));  
 local lastarmyIDtag = player:getVar("TIME_IMPERIAL_ARMY_ID_TAG");
 local currenttagnummber = player:getVar("REMAINING_IMPERIAL_ARMY_ID_TAG");
 local diffday = currentday - lastarmyIDtag ;
 local currentassault = player:getCurrentMission(ASSAULT);
 local haveimperialIDtag;

 ---------------------------------------------------------------------
	if(player:getCurrentMission(TOAU) == PRESIDENT_SALAHEEM and player:getVar("TOAUM3") == 0)then
		player:startEvent(0x010D,0,0,0,0,0,0,0,0,0);
	elseif(player:getCurrentMission(TOAU) <= IMMORTAL_SENTRIES)
		then player:startEvent(0x010E);
	elseif(player:getMainLvl() <= 50)
		then player:startEvent(0x010E);

	elseif((player:getCurrentMission(TOAU) > PRESIDENT_SALAHEEM) or (player:getCurrentMission(TOAU) == PRESIDENT_SALAHEEM and player:getVar("TOAUM3") ==1))then

		if (lastarmyIDtag == 0 )then -- first time you get the tag
		player:setVar("REMAINING_IMPERIAL_ARMY_ID_TAG",3); currenttagnummber =3;
		player:setVar("TIME_IMPERIAL_ARMY_ID_TAG",currentday);
		elseif ( diffday > 0 )then  
		currenttagnummber = currenttagnummber + diffday ;
		if (currenttagnummber > 3)then -- store 3 TAG max
	     currenttagnummber = 3;
		end
    player:setVar("REMAINING_IMPERIAL_ARMY_ID_TAG",currenttagnummber);
	player:setVar("TIME_IMPERIAL_ARMY_ID_TAG",currentday);
		end
---------------------------------------------------------------------------

    if (player:getMainLvl() >= 50)then
    if(player:hasKeyItem(IMPERIAL_ARMY_ID_TAG))then
     haveimperialIDtag = 1;
     else
     haveimperialIDtag = 0;
	 end
   player:startEvent(0x010C,IMPERIAL_ARMY_ID_TAG,currenttagnummber,currentassault,haveimperialIDtag);
  else
  player:startEvent(0x010e);
  end
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
local currenttagnummber =  player:getVar("REMAINING_IMPERIAL_ARMY_ID_TAG");
local CurrentAssault = player:getCurrentMission(ASSAULT);

 

	-- printf("CSID: %u",csid);
	 printf("RESULT: %u",option);
	 if(csid == 0x010D)then
	player:setVar("TOAUM3",1);
		player:addKeyItem(IMPERIAL_ARMY_ID_TAG);
		player:messageSpecial(KEYITEM_OBTAINED,IMPERIAL_ARMY_ID_TAG);
	elseif(csid == 0x010C and option == 1 	and player:hasKeyItem(IMPERIAL_ARMY_ID_TAG)==false and currenttagnummber > 0)then
	player:addKeyItem(IMPERIAL_ARMY_ID_TAG);
	player:messageSpecial(KEYITEM_OBTAINED,IMPERIAL_ARMY_ID_TAG);
	player:setVar("REMAINING_IMPERIAL_ARMY_ID_TAG",currenttagnummber - 1);
	elseif(csid == 0x010C and option == 2 and player:hasKeyItem(IMPERIAL_ARMY_ID_TAG)==false )then
	   if(player:hasKeyItem(LEUJAOAM_ASSUALT_ORDERS))then
	       player:delKeyItem(LEUJAOAM_ASSUALT_ORDERS);
	   elseif(player:hasKeyItem(MAMMOOL_JA_ASSAULT_ORDERS))then
	       player:delKeyItem(MAMMOOL_JA_ASSAULT_ORDERS);
       elseif(player:hasKeyItem(LEBROS_ASSUALT_ORDERS))then
	       player:delKeyItem(LEBROS_ASSUALT_ORDERS);
	   elseif(player:hasKeyItem(PERIQIA_ASSUALT_ORDERS))then
	       player:delKeyItem(PERIQIA_ASSUALT_ORDERS);
	   elseif(player:hasKeyItem(ILRUSI_ASSUALT_ORDERS ))then
	       player:delKeyItem(ILRUSI_ASSUALT_ORDERS);
	   elseif(player:hasKeyItem(NYZUL_ISLE_ASSAULT_ORDERS))then
	       player:delKeyItem(NYZUL_ISLE_ASSAULT_ORDERS);
		
	   end
          player:addKeyItem(IMPERIAL_ARMY_ID_TAG);
		  player:messageSpecial(KEYITEM_OBTAINED,IMPERIAL_ARMY_ID_TAG);
		  player:delMission(ASSAULT,CurrentAssault);
	end
	
end;

