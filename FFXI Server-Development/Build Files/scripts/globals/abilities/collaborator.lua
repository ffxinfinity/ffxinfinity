-----------------------------------
-- Ability: Collaborator
-----------------------------------

require("scripts/globals/settings");
require("scripts/globals/status");

-----------------------------------
-- OnUseAbility
-----------------------------------

function OnAbilityCheck(player,target,ability)
	if (target == nil or target:getID() == player:getID() or not target:isPC()) then
		return MSGBASIC_CANNOT_ON_THAT_TARG,0;
	elseif (not target:hasTarget()) then
		return MSGBASIC_UNABLE_TO_USE_JA2,0;
	else
		return 0,0;
	end
end;

function OnUseAbility(player, target, ability)
end;
