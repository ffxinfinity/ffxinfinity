---------------------------------------------
--  Magic Fruit
--
--  Description: Restores HP for the target party member.
--  Type: Magical (Light)
--
--
---------------------------------------------
require("/scripts/globals/settings");
require("/scripts/globals/status");
require("/scripts/globals/monstertpmoves");
---------------------------------------------
function OnMobSkillCheck(target,mob,skill)
	return 0;
end;

function OnMobWeaponSkill(target, mob, skill)
	local m = math.random(1,3)+10; -- 9% - 12%
	local base = (mob:getMaxHP()/100)* m;
	local mobHP = mob:getHP();
	local mobMaxHP = mob:getMaxHP();
	if(mobHP+base > mobMaxHP) then
		base = mobMaxHP - mobHP; --cap it
	end
	skill:setMsg(MSG_SELF_HEAL);
	mob:addHP(base);
	return base;
end;
