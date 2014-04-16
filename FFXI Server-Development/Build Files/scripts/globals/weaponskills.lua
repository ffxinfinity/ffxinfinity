--Contains all common weaponskill calculations including but not limited to:
-- fSTR
-- Alpha
-- Ratio -> cRatio
-- min/max cRatio
-- applications of fTP
-- applications of critical hits ('Critical hit rate varies with TP.')
-- applications of accuracy mods ('Accuracy varies with TP.')
-- applications of damage mods ('Damage varies with TP.')
-- performance of the actual WS (rand numbers, etc)
require("scripts/globals/status");
require("scripts/globals/utils");

--params contains: ftp100, ftp200, ftp300, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, canCrit, crit100, crit200, crit300, acc100, acc200, acc300, ignoresDef, ignore100, ignore200, ignore300, atkmulti
function doPhysicalWeaponskill(attacker, target, params)
	
	local criticalHit = false;
	
	--get fstr
	local fstr = fSTR(attacker:getStat(MOD_STR),target:getStat(MOD_VIT),attacker:getWeaponDmgRank());

	--apply WSC
	local weaponDamage = attacker:getWeaponDmg();

	if (attacker:getWeaponSkillType(0) == 1) then
		local h2hSkill = ((attacker:getSkillLevel(1) * 0.11) + 3);
		weaponDamage = attacker:getWeaponDmg()-3;

		if(params.kick == true and attacker:hasStatusEffect(EFFECT_FOOTWORK)) then
			weaponDamage = attacker:getMod(MOD_KICK_DMG);
		end

		weaponDamage = weaponDamage + h2hSkill;
	end

	local base = weaponDamage + fstr +
		(attacker:getStat(MOD_STR) * params.str_wsc + attacker:getStat(MOD_DEX) * params.dex_wsc +
		 attacker:getStat(MOD_VIT) * params.vit_wsc + attacker:getStat(MOD_AGI) * params.agi_wsc +
		 attacker:getStat(MOD_INT) * params.int_wsc + attacker:getStat(MOD_MND) * params.mnd_wsc +
		 attacker:getStat(MOD_CHR) * params.chr_wsc) * getAlpha(attacker:getMainLvl());

	--Applying fTP multiplier
	local tp = attacker:getTP();
	if attacker:hasStatusEffect(EFFECT_SEKKANOKI) then
		tp = 100;
	end
	local ftp = fTP(tp,params.ftp100,params.ftp200,params.ftp300);

	local ignoredDef = 0;
	if (params.ignoresDef == not nil and params.ignoresDef == true) then
		ignoredDef = calculatedIgnoredDef(attacker:getTP(), target:getStat(MOD_DEF), params.ignored100, params.ignored200, params.ignored300);
	end

	--get cratio min and max
	local cratio, ccritratio = cMeleeRatio(attacker, target, params, ignoredDef);
	local ccmin = 0;
	local ccmax = 0;
	local hasMightyStrikes = attacker:hasStatusEffect(EFFECT_MIGHTY_STRIKES);
	local isSneakValid = attacker:hasStatusEffect(EFFECT_SNEAK_ATTACK);
	if(isSneakValid and not attacker:isBehind(target))then
		isSneakValid = false;
	end
	attacker:delStatusEffect(EFFECT_SNEAK_ATTACK);
	local isTrickValid = attacker:hasStatusEffect(EFFECT_TRICK_ATTACK);
	if(isTrickValid and not attacker:isTrickAttackAvailable(target)) then
		isTrickValid = false;
	end

	local isAssassinValid = isTrickValid;
	if(isAssassinValid and not attacker:hasTrait(68)) then
		isAssassinValid = false;
	end

	local critrate = 0;

	if(params.canCrit) then --work out critical hit ratios, by +1ing
		critrate = fTP(attacker:getTP(),params.crit100,params.crit200,params.crit300);
		--add on native crit hit rate (guesstimated, it actually follows an exponential curve)
		local nativecrit = (attacker:getStat(MOD_DEX) - target:getStat(MOD_AGI))*0.005; --assumes +0.5% crit rate per 1 dDEX
		nativecrit = nativecrit + (attacker:getMod(MOD_CRITHITRATE)/100);

		if(nativecrit > 0.2) then --caps!
			nativecrit = 0.2;
		elseif(nativecrit < 0.05) then
			nativecrit = 0.05;
		end
		critrate = critrate + nativecrit;
	end


	local dmg = base * ftp;

	--Applying pDIF
	local double pdif = generatePdif(cratio[1], cratio[2], true);

	local double firsthit = math.random();
	local finaldmg = 0;
	local hitrate = getHitRate(attacker,target,true);
	if(params.acc100~=0) then
		--ACCURACY VARIES WITH TP, APPLIED TO ALL HITS.
		--print("Accuracy varies with TP.");
		hr = accVariesWithTP(getHitRate(attacker,target,false),attacker:getACC(),attacker:getTP(),params.acc100,params.acc200,params.acc300);
		hitrate = hr;
	end

	local tpHitsLanded = 0;
	local tpHits = 0;
	if (firsthit <= hitrate or isSneakValid or isAssassinValid or math.random() < attacker:getMod(MOD_ZANSHIN)/100) then
		if(params.canCrit or isSneakValid or isAssassinValid) then
			local double critchance = math.random();
			if(critchance <= critrate or hasMightyStrikes or isSneakValid or isAssassinValid) then --crit hit!
				local double cpdif = generatePdif(ccritratio[1], ccritratio[2], true);
				finaldmg = dmg * cpdif;
				if(isSneakValid and attacker:getMainJob()==6) then --have to add on DEX bonus if on THF main
					finaldmg = finaldmg + (attacker:getStat(MOD_DEX) * ftp * cpdif);
				end
				if(isTrickValid and attacker:getMainJob()==6) then
					finaldmg = finaldmg + (attacker:getStat(MOD_AGI) * ftp * cpdif);
				end
			else
				finaldmg = dmg * pdif;
				if(isTrickValid and attacker:getMainJob()==6) then
					finaldmg = finaldmg + (attacker:getStat(MOD_AGI) * ftp * pdif);
				end
			end
		else
			finaldmg = dmg * pdif;
			if(isTrickValid and attacker:getMainJob()==6) then
				finaldmg = finaldmg + (attacker:getStat(MOD_AGI) * ftp * pdif);
			end
		end
		tpHitsLanded = 1;
	end

	tpHits = 1;
	if((attacker:getOffhandDmg() ~= 0) and (attacker:getOffhandDmg() > 0 or attacker:getWeaponSkillType(0)==1)) then

		local chance = math.random();
		if (chance<=hitrate or math.random() < attacker:getMod(MOD_ZANSHIN)/100 or isSneakValid) then --it hit
			pdif = generatePdif(cratio[1], cratio[2], true);
			if(params.canCrit) then
				critchance = math.random();
				if(critchance <= critrate or hasMightyStrikes) then --crit hit!
					criticalHit = true;
					cpdif = generatePdif(ccritratio[1], ccritratio[2], true);
					finaldmg = finaldmg + base * cpdif;
				else
					finaldmg = finaldmg + base * pdif;
				end
			else
				finaldmg = finaldmg + base * pdif; --NOTE: not using 'dmg' since fTP is 1.0 for subsequent hits!!
			end
			tpHitsLanded = tpHitsLanded + 1;
		end
		tpHits = tpHits + 1;
	end

	local numHits = getMultiAttacks(attacker, params.numHits);

	local extraHitsLanded = 0;

	if(numHits>1) then

		local hitsdone = 1;
		while (hitsdone < numHits) do
			local chance = math.random();
			if (chance<=hitrate or math.random() < attacker:getMod(MOD_ZANSHIN)/100) then --it hit
				pdif = generatePdif(cratio[1], cratio[2], true);
				if(params.canCrit) then
					critchance = math.random();
					if(critchance <= critrate or hasMightyStrikes) then --crit hit!
						criticalHit = true;
						cpdif = generatePdif(ccritratio[1], ccritratio[2], true);
						finaldmg = finaldmg + base * cpdif;
					else
						finaldmg = finaldmg + base * pdif;
					end
				else
					finaldmg = finaldmg + base * pdif; --NOTE: not using 'dmg' since fTP is 1.0 for subsequent hits!!
				end
				extraHitsLanded = extraHitsLanded + 1;
			end
			hitsdone = hitsdone + 1;
		end
	end
	finaldmg = finaldmg + souleaterBonus(attacker, (tpHitsLanded+extraHitsLanded));
	-- print("Landed " .. hitslanded .. "/" .. numHits .. " hits with hitrate " .. hitrate .. "!");

	if(target:hasStatusEffect(EFFECT_FORMLESS_STRIKES) == false) then
		utils.dmgTaken(target, finaldmg);
		utils.physicalDmgTaken(target, finaldmg);
	end

	return finaldmg, criticalHit, tpHitsLanded, extraHitsLanded;
end;

function souleaterBonus(attacker, numhits)
	if attacker:hasStatusEffect(EFFECT_SOULEATER) then
		local damage = 0;
		local percent = 0.1;
		if attacker:getMainJob() ~= 8 then
			percent = percent / 2;
		end
		if attacker:getEquipID(SLOT_HEAD) == 12516 or attacker:getEquipID(SLOT_HEAD) == 15232 or attacker:getEquipID(SLOT_BODY) == 14409 or attacker:getEquipID(SLOT_LEGS) == 15370 then
			percent = percent + 0.02;
		end
		local hitscounted = 0;
		while (hitscounted < numhits) do
			local health = attacker:getHP();
			if health > 10 then
				damage = damage + health*percent;
			end
			hitscounted = hitscounted + 1;
		end
		attacker:delHP(numhits*0.10*attacker:getHP());
		return damage;
	else
		return 0;
	end
end;

function accVariesWithTP(hitrate,acc,tp,a1,a2,a3)
	--sadly acc varies with tp ALL apply an acc PENALTY, the acc at various %s are given as a1 a2 a3
	accpct = fTP(tp,a1,a2,a3);
	acclost = acc - (acc*accpct);
	hrate = hitrate - (0.005*acclost);
	--cap it
	if (hrate>0.95) then
		hrate = 0.95;
	end
	if (hrate<0.2) then
		hrate = 0.2;
	end
	return hrate;
end;

function getHitRate(attacker,target,capHitRate)
	local int acc = attacker:getACC();
	local int eva = target:getEVA();

	if(attacker:getMainLvl() > target:getMainLvl()) then --acc bonus!
		acc = acc + ((attacker:getMainLvl()-target:getMainLvl())*4);
	elseif(attacker:getMainLvl() < target:getMainLvl()) then --acc penalty :(
		acc = acc - ((target:getMainLvl()-attacker:getMainLvl())*4);
	end

	local double hitdiff = 0;
	local double hitrate = 75;
	if (acc>eva) then
	hitdiff = (acc-eva)/2;
	end
	if (eva>acc) then
	hitdiff = ((-1)*(eva-acc))/2;
	end

	hitrate = hitrate+hitdiff;
	hitrate = hitrate/100;


	--Applying hitrate caps
	if(capHitRate) then --this isn't capped for when acc varies with tp, as more penalties are due
		if (hitrate>0.95) then
			hitrate = 0.95;
		end
		if (hitrate<0.2) then
			hitrate = 0.2;
		end
	end
	return hitrate;
end;

function getRangedHitRate(attacker,target,capHitRate)
	local int acc = attacker:getRACC();
	local int eva = target:getEVA();

	if(attacker:getMainLvl() > target:getMainLvl()) then --acc bonus!
		acc = acc + ((attacker:getMainLvl()-target:getMainLvl())*4);
	elseif(attacker:getMainLvl() < target:getMainLvl()) then --acc penalty :(
		acc = acc - ((target:getMainLvl()-attacker:getMainLvl())*4);
	end

	local double hitdiff = 0;
	local double hitrate = 75;
	if (acc>eva) then
	hitdiff = (acc-eva)/2;
	end
	if (eva>acc) then
	hitdiff = ((-1)*(eva-acc))/2;
	end

	hitrate = hitrate+hitdiff;
	hitrate = hitrate/100;


	--Applying hitrate caps
	if(capHitRate) then --this isn't capped for when acc varies with tp, as more penalties are due
		if (hitrate>0.95) then
			hitrate = 0.95;
		end
		if (hitrate<0.2) then
			hitrate = 0.2;
		end
	end
	return hitrate;
end;

function fTP(tp,ftp1,ftp2,ftp3)
	if(tp>=100 and tp<200) then
		return ftp1 + ( ((ftp2-ftp1)/100) * (tp-100));
	elseif(tp>=200 and tp<=300) then
		--generate a straight line between ftp2 and ftp3 and find point @ tp
		return ftp2 + ( ((ftp3-ftp2)/100) * (tp-200));
	else
		print("fTP error: TP value is not between 100-300!");
	end
	return 1; --no ftp mod
end;

function calculatedIgnoredDef(tp, def, ignore1, ignore2, ignore3)
	if(tp>=100 and tp <200) then
		return (ignore1 + ( ((ignore2-ignore1)/100) * (tp-100)))*def;
	elseif(tp>=200 and tp<=300) then
		return (ignore2 + ( ((ignore3-ignore2)/100) * (tp-200)))*def;
	end
	return 1; --no def ignore mod
end
--Given the raw ratio value (atk/def) and levels, returns the cRatio (min then max)
function cMeleeRatio(attacker, defender, params, ignoredDef)

	local cratio = (attacker:getStat(MOD_ATT)) / (defender:getStat(MOD_DEF) - ignoredDef);

	local levelcor = 0;
	if (attacker:getMainLvl() < defender:getMainLvl()) then
		levelcor = 0.05 * (defender:getMainLvl() - attacker:getMainLvl());
	end

	cratio = cratio - levelcor;
	cratio = cratio * params.atkmulti;

	if(attacker:isWeaponTwoHanded()) then
		if (cratio > 2.25 - levelcor) then
			cratio = 2.25 - levelcor;
		end
	else
		if (cratio > 2 - levelcor) then
			cratio = 2 - levelcor;
		end
	end

	if(cratio < 0) then
		cratio = 0;
	end
	local pdifmin = 0;
	local pdifmax = 0;
	if(attacker:isWeaponTwoHanded()) then

		--max

		if (cratio < 0.5) then
			pdifmax = (cratio * 1.2) + 0.4;
		elseif (cratio < (5/6)) then
			pdifmax = 1;
		elseif (cratio < (10/6)) then
			pdifmax = cratio * 1.25;
		else
			pdifmax = cratio * 1.2;
		end

		--min

		if (cratio < (5/12)) then
			pdifmin = 0;
		elseif (cratio < 1.25) then
			pdifmin = (cratio * 1.2) - 0.5;
		elseif (cratio < 1.5) then
			pdifmin = 1;
		else
			pdifmin = (1.2 * cratio) - 0.8;
		end

	else

		--max

		if (cratio < 0.5) then
			pdifmax = 1 + ((10/9)*(cratio-0.5));
		elseif (cratio < 0.75) then
			pdifmax = 1;
		else
			pdifmax = 1 + ((10/9)*(cratio-0.75));
		end

		--min

		if (cratio < 0.5) then
			pdifmin = (1/6);
		elseif (cratio < 1.25) then
			pdifmin = 1 + ((10/9)*(cratio - 1.25));
		elseif (cratio < 1.5) then
			pdifmin = 1;
		else
			pdifmin = 1 + ((10/9)*(cratio - 1.5));
		end
	end
	pdif = {};
	pdif[1] = pdifmin;
	pdif[2] = pdifmax;

	pdifcrit = {};

	--printf("ratio: %f min: %f max %f\n", cratio, pdifmin, pdifmax);

	pdifmin = pdifmin + 1;
	pdifmax = pdifmax + 1;
	if (pdifmin > 3) then
		pdifmin = 3;
	end
	if (pdifmax > 3) then
		pdifmax = 3;
	end

	pdifcrit[1] = pdifmin;
	pdifcrit[2] = pdifmax;

	return pdif, pdifcrit;
end;

function cRangedRatio(attacker, defender, params, ignoredDef)

	local cratio = attacker:getRATT() / (defender:getStat(MOD_DEF) - ignoredDef);

	local levelcor = 0;
	if (attacker:getMainLvl() < defender:getMainLvl()) then
		levelcor = 0.025 * (defender:getMainLvl() - attacker:getMainLvl());
	end

	cratio = cratio - levelcor;

	cratio = cratio * params.atkmulti;

	if(cratio > 3 - levelcor) then
		cratio = 3 - levelcor;
	end

	if(cratio < 0) then
		cratio = 0;
	end

	--max
	local pdifmax = 0;
	if (cratio < 0.9) then
		pdifmax = cratio * (10/9);
	elseif (cratio < 1.1) then
		pdifmax = 1;
	else
		pdifmax = cratio;
	end

	--min
	local pdifmin = 0;
	if (cratio < 0.9) then
		pdifmin = cratio;
	elseif (cratio < 1.1) then
		pdifmin = 1;
	else
		pdifmin = (cratio * (20/19))-(3/19);
	end

	pdif = {};
	pdif[1] = pdifmin;
	pdif[2] = pdifmax;
	--printf("ratio: %f min: %f max %f\n", cratio, pdifmin, pdifmax);
	pdifcrit = {};

	pdifmin = pdifmin * 1.25;
	pdifmax = pdifmax * 1.25;

	pdifcrit[1] = pdifmin;
	pdifcrit[2] = pdifmax;

	return pdif, pdifcrit;

end

--Given the attacker's str and the mob's vit, fSTR is calculated
function fSTR(atk_str,def_vit,base_dmg)
	local dSTR = atk_str - def_vit;
	if (dSTR >= 12) then
		fSTR2 = ((dSTR+4)/2);
	elseif (dSTR >= 6) then
		fSTR2 = ((dSTR+6)/2);
	elseif (dSTR >= 1) then
		fSTR2 = ((dSTR+7)/2);
	elseif (dSTR >= -2) then
		fSTR2 = ((dSTR+8)/2);
	elseif (dSTR >= -7) then
		fSTR2 = ((dSTR+9)/2);
	elseif (dSTR >= -15) then
		fSTR2 = ((dSTR+10)/2);
	elseif (dSTR >= -21) then
		fSTR2 = ((dSTR+12)/2);
	else
		fSTR2 = ((dSTR+13)/2);
	end
	--Apply fSTR caps.
	if (fSTR2<((base_dmg/9)*(-1))) then
		fSTR2 = (base_dmg/9)*(-1);
	elseif (fSTR2>((base_dmg/9)+8)) then
		fSTR2 = (base_dmg/9)+8;
	end
	return fSTR2;
end;

--obtains alpha, used for working out WSC
function getAlpha(level)
alpha = 1.00;
if (level <= 5) then
	alpha = 1.00;
elseif (level <= 11) then
	alpha = 0.99;
elseif (level <= 17) then
	alpha = 0.98;
elseif (level <= 23) then
	alpha = 0.97;
elseif (level <= 29) then
	alpha = 0.96;
elseif (level <= 35) then
	alpha = 0.95;
elseif (level <= 41) then
	alpha = 0.94;
elseif (level <= 47) then
	alpha = 0.93;
elseif (level <= 53) then
	alpha = 0.92;
elseif (level <= 59) then
	alpha = 0.91;
elseif (level <= 61) then
	alpha = 0.90;
elseif (level <= 63) then
	alpha = 0.89;
elseif (level <= 65) then
	alpha = 0.88;
elseif (level <= 67) then
	alpha = 0.87;
elseif (level <= 69) then
	alpha = 0.86;
elseif (level <= 71) then
	alpha = 0.85;
elseif (level <= 73) then
	alpha = 0.84;
elseif (level <= 75) then
	alpha = 0.83;
elseif (level <= 99) then
	alpha = 0.85;
end
return alpha;
 end;

 --params contains: ftp100, ftp200, ftp300, str_wsc, dex_wsc, vit_wsc, int_wsc, mnd_wsc, canCrit, crit100, crit200, crit300, acc100, acc200, acc300, ignoresDef, ignore100, ignore200, ignore300, atkmulti
 function doRangedWeaponskill(attacker, target, params)
	--get fstr
	local fstr = fSTR(attacker:getStat(MOD_STR),target:getStat(MOD_VIT),attacker:getRangedDmgForRank());

	--apply WSC
	local base = attacker:getRangedDmg() + fstr +
		(attacker:getStat(MOD_STR) * params.str_wsc + attacker:getStat(MOD_DEX) * params.dex_wsc +
		 attacker:getStat(MOD_VIT) * params.vit_wsc + attacker:getStat(MOD_AGI) * params.agi_wsc +
		 attacker:getStat(MOD_INT) * params.int_wsc + attacker:getStat(MOD_MND) * params.mnd_wsc +
		 attacker:getStat(MOD_CHR) * params.chr_wsc) * getAlpha(attacker:getMainLvl());

	--Applying fTP multiplier
	local ftp = fTP(attacker:getTP(),params.ftp100,params.ftp200,params.ftp300);

	local ignoredDef = 0;
	if (params.ignoresDef == not nil and params.ignoresDef == true) then
		ignoredDef = calculatedIgnoredDef(attacker:getTP(), target:getStat(MOD_DEF), params.ignored100, params.ignored200, params.ignored300);
	end

	--get cratio min and max
	local cratio, ccritratio = cRangedRatio( attacker, target, params, ignoredDef);
	local ccmin = 0;
	local ccmax = 0;
	local hasMightyStrikes = attacker:hasStatusEffect(EFFECT_MIGHTY_STRIKES);
	local critrate = 0;
	if(params.canCrit) then --work out critical hit ratios, by +1ing
		critrate = fTP(attacker:getTP(),params.crit100,params.crit200,params.crit300);
		--add on native crit hit rate (guesstimated, it actually follows an exponential curve)
		local nativecrit = (attacker:getStat(MOD_DEX) - target:getStat(MOD_AGI))*0.005; --assumes +0.5% crit rate per 1 dDEX
		if(nativecrit > 0.2) then --caps!
			nativecrit = 0.2;
		elseif(nativecrit < 0.05) then
			nativecrit = 0.05;
		end
		critrate = critrate + nativecrit;
	end


	local dmg = base * ftp;

	--Applying pDIF
	local double pdif = generatePdif(cratio[1],cratio[2], false);

	--First hit has 95% acc always. Second hit + affected by hit rate.
	local double firsthit = math.random();
	local finaldmg = 0;
	local hitrate = getHitRate(attacker,target,true);
	if(params.acc100~=0) then
		--ACCURACY VARIES WITH TP, APPLIED TO ALL HITS.
		--print("Accuracy varies with TP.");
		hr = accVariesWithTP(getRangedHitRate(attacker,target,false),attacker:getRACC(),attacker:getTP(),params.acc100,params.acc200,params.acc300);
		hitrate = hr;
	end

	local tpHitsLanded = 0;
	if (firsthit <= hitrate) then
		if(params.canCrit) then
			local double critchance = math.random();
			if(critchance <= critrate or hasMightyStrikes) then --crit hit!
				local double cpdif = generatePdif(ccritratio[1], ccritratio[2], false);
				finaldmg = dmg * cpdif;
			else
				finaldmg = dmg * pdif;
			end
		else
			finaldmg = dmg * pdif;
		end
		tpHitsLanded = 1;
	end

	local numHits = params.numHits;

	local extraHitsLanded = 0;
	if(numHits>1) then
		if(params.acc100==0) then
			--work out acc since we actually need it now
			hitrate = getRangedHitRate(attacker,target,true);
		end

		hitsdone = 1;
		while (hitsdone < numHits) do
			chance = math.random();
			if (chance<=hitrate) then --it hit
				pdif = generatePdif(cratio[1],cratio[2], false);
				if(canCrit) then
					critchance = math.random();
					if(critchance <= critrate or hasMightyStrikes) then --crit hit!
						cpdif = generatePdif(ccritratio[1], ccritratio[2], false);
						finaldmg = finaldmg + base * cpdif;
					else
						finaldmg = finaldmg + base * pdif;
					end
				else
					finaldmg = finaldmg + base * pdif; --NOTE: not using 'dmg' since fTP is 1.0 for subsequent hits!!
				end
				extraHitsLanded = extraHitsLanded + 1;
			end
			hitsdone = hitsdone + 1;
		end
	end
	--print("Landed " .. hitslanded .. "/" .. numHits .. " hits with hitrate " .. hitrate .. "!");

	utils.dmgTaken(target, finaldmg);
	utils.rangedDmgTaken(target, finaldmg);

	return finaldmg, tpHitsLanded, extraHitsLanded;
end;

function getMultiAttacks(attacker, numHits)
	local bonusHits = 0;
	local tripleChances = 1;
	local doubleRate = attacker:getMod(MOD_DOUBLE_ATTACK)/100;
	local tripleRate = attacker:getMod(MOD_TRIPLE_ATTACK)/100;

	--triple only procs on first hit, or first two hits if dual wielding
	if(attacker:getOffhandDmg() > 0) then
		tripleChances = 2;
	end

	for i = 1, numHits, 1 do
		chance = math.random();
		if (chance < tripleRate and i <= tripleChances) then
			bonusHits = bonusHits + 2;
		else
			--have to check if triples are possible, or else double attack chance
			-- gets accidentally increased by triple chance (since it can only proc on 1 or 2)
			if (i <= tripleChances) then
				if (chance < tripleRate + doubleRate) then
					bonusHits = bonusHits + 1;
				end
			else
				if (chance < doubleRate) then
					bonusHits = bonusHits + 1;
				end
			end
		end
		if (i == 1) then
			attacker:delStatusEffect(EFFECT_ASSASSIN_S_CHARGE);
			attacker:delStatusEffect(EFFECT_WARRIOR_S_CHARGE);

			-- recalculate mods
			doubleRate = attacker:getMod(MOD_DOUBLE_ATTACK)/100;
			tripleRate = attacker:getMod(MOD_TRIPLE_ATTACK)/100;
		end
	end
	if ((numHits + bonusHits ) > 8) then
		return 8;
	end
	return numHits + bonusHits;
end;

function generatePdif(cratiomin, cratiomax, melee)
	local pdif = math.random(cratiomin*1000, cratiomax*1000) / 1000;
	if (melee) then
		pdif = pdif * (math.random(100,105)/100);
	end
	return pdif;
end