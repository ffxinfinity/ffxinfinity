-----------------------------------
-- Area: King Ranperre's Tomb
-- NPC:  Vrtra
-----------------------------------

require("scripts/globals/titles");

-----------------------------------
-- OnMobInitialize Action
-----------------------------------

function onMobInitialize(mob)
	mob:addStatusEffect(EFFECT_REGEN,25,3,0);
	mob:addStatusEffect(EFFECT_MAGIC_DEF_BOOST,50,0,0);
end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
	killer:addTitle(VRTRA_VANQUISHER);
end;