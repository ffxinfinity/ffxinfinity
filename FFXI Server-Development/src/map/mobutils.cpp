﻿/*
===========================================================================

  Copyright (c) 2010-2012 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

  This file is part of DarkStar-server source code.

===========================================================================
*/

#include "../common/utils.h"

#include <math.h>

#include "battleutils.h"
#include "grades.h"
#include "trait.h"
#include "mobutils.h"
#include "modifier.h"
#include "spell.h"

namespace mobutils
{

/************************************************************************
*																		*
*  Расчет базовой величины оружия монстров								*
*																		*
************************************************************************/

uint16 GetWeaponDamage(CMobEntity* PMob)
{
	float MainLevel = PMob->GetMLevel();
	return (uint16)(MainLevel * (MainLevel < 40 ? 1.4 - MainLevel/100 : 1));
}

/************************************************************************
*																		*
*  Базовое значение для расчера характеристик							*
*  (на название не хватило фантазии)									*
*																		*
************************************************************************/

uint16 GetBaseToRank(uint8 rank, uint16 lvl)
{
	switch (rank)
	{
		case 1: return (5+((lvl-1)*50)/100);
		case 2: return (4+((lvl-1)*45)/100);
		case 3: return (4+((lvl-1)*40)/100);
		case 4: return (3+((lvl-1)*35)/100);
		case 5: return (3+((lvl-1)*30)/100);
		case 6: return (2+((lvl-1)*25)/100);
		case 7: return (2+((lvl-1)*20)/100);
	}
	return 0;
}

/************************************************************************
*																		*
*  Базовое значение для расчерта защиты и уклонения						*
*  (на название не хватило фантазии)									*
*																		*
************************************************************************/

uint16 GetBase(CMobEntity * PMob, uint8 rank)
 {
 	uint8 lvl = PMob->GetMLevel();
 	if(lvl > 50){
 		switch(rank){
 			case 1:
 				return (float)153+(lvl-50)*5.0;
 			case 2:
 				return (float)147+(lvl-50)*4.9;
 			case 3:
 				return (float)136+(lvl-50)*4.8;
 			case 4:
 				return (float)126+(lvl-50)*4.7;
 			case 5:
 				return (float)116+(lvl-50)*4.5;
 			case 6:
 				return (float)106+(lvl-50)*4.4;
 			case 7:
 				return (float)96+(lvl-50)*4.3;
 		}
 	} else {
 		switch(rank){
 			case 1:
 				return (float)6+(lvl-1)*3.0;
 			case 2:
 				return (float)5+(lvl-1)*2.9;
 			case 3:
 				return (float)5+(lvl-1)*2.8;
 			case 4:
 				return (float)4+(lvl-1)*2.7;
 			case 5:
 				return (float)4+(lvl-1)*2.5;
 			case 6:
 				return (float)3+(lvl-1)*2.4;
 			case 7:
 				return (float)3+(lvl-1)*2.3;
 		}
 	}
	return 0;
}

/************************************************************************
*																		*
*  Расчет атрибутов (характеристик) монстра								*
*																		*
************************************************************************/

void CalculateStats(CMobEntity * PMob)
{
	bool isNM = PMob->m_Type & MOBTYPE_NOTORIOUS;
	JOBTYPE mJob = PMob->GetMJob();
	JOBTYPE sJob = PMob->GetSJob();

	if(isNM)
	{
		// enmity range is larger
		PMob->m_enmityRange = 28;
		PMob->m_tpUseChance = 40;
	}

	if(PMob->HPmodifier == 0){

		float growth = 1.06;
		float base = 18.0;
		uint8 lvl = PMob->GetMLevel();

		//give hp boost every 10 levels after 25
		//special boosts at 25 and 50
		if(lvl > 75){
			growth = 1.28;
		}else if(lvl > 65){
			growth = 1.27;
		} else if(lvl > 55){
			growth = 1.25;
		} else if(lvl > 50){
			growth = 1.21;
		} else if(lvl > 45){
			growth = 1.17;
		} else if(lvl > 35){
			growth = 1.14;
		} else if(lvl > 25){
			growth = 1.1;
		}

		// pets have lower health
		if(PMob->PMaster != NULL)
		{
			growth = 0.95;
		}


		PMob->health.maxhp = (int16)(base * pow(lvl, growth) * PMob->HPscale);

		if(isNM)
		{
			PMob->health.maxhp *= 2.0;
			if(PMob->GetMLevel() > 75){
				PMob->health.maxhp *= 2.5;
			}
		}

	} else {
		PMob->health.maxhp = PMob->HPmodifier;
		//printf("HP: %u \n",PMob->health.maxhp);
	}

	switch(mJob){
	case JOB_PLD:
	case JOB_WHM:
	case JOB_BLM:
	case JOB_RDM:
	case JOB_DRK:
	case JOB_BLU:
	case JOB_SCH:
	case JOB_SMN:
		if(PMob->MPmodifier == 0){
			PMob->health.maxmp = (int16)(18.2 * pow(PMob->GetMLevel(),1.1075) * PMob->MPscale);
			if(isNM){
			PMob->health.maxmp *= 2.5;
				if(PMob->GetMLevel()>75){
					PMob->health.maxmp *= 2.5;
				}
			}
		} else {
			PMob->health.maxmp = PMob->MPmodifier;
		}
		break;
	}

	if(PMob->m_Family == 193 || PMob->m_Family == 34)
	{
		// pet wyverns / avatar have mp
		PMob->health.maxmp = (int16)(18.2 * pow(PMob->GetMLevel(),1.1075) * PMob->MPscale);
	}

    PMob->UpdateHealth();

	PMob->health.tp = 0;
    PMob->health.hp = PMob->GetMaxHP();
    PMob->health.mp = PMob->GetMaxMP();

	uint16 evaRank = battleutils::GetSkillRank(SKILL_EVA, PMob->GetMJob());

	PMob->setModifier(MOD_DEF, GetBase(PMob,PMob->defRank));
	PMob->setModifier(MOD_EVA, GetBase(PMob,evaRank));
	PMob->setModifier(MOD_ATT, GetBase(PMob,PMob->attRank));
	PMob->setModifier(MOD_ACC, GetBase(PMob,PMob->accRank));

	PMob->m_Weapons[SLOT_MAIN]->setDamage(GetWeaponDamage(PMob));

    //reduce weapon delay of MNK
    if(PMob->GetMJob()==JOB_MNK){
		PMob->m_Weapons[SLOT_MAIN]->resetDelay();
    }

	uint16 fSTR = GetBaseToRank(PMob->strRank, PMob->GetMLevel());
	uint16 fDEX = GetBaseToRank(PMob->dexRank, PMob->GetMLevel());
	uint16 fVIT = GetBaseToRank(PMob->vitRank, PMob->GetMLevel());
	uint16 fAGI = GetBaseToRank(PMob->agiRank, PMob->GetMLevel());
	uint16 fINT = GetBaseToRank(PMob->intRank, PMob->GetMLevel());
	uint16 fMND = GetBaseToRank(PMob->mndRank, PMob->GetMLevel());
	uint16 fCHR = GetBaseToRank(PMob->chrRank, PMob->GetMLevel());

	uint16 mSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(),2), PMob->GetMLevel());
	uint16 mDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(),3), PMob->GetMLevel());
	uint16 mVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(),4), PMob->GetMLevel());
	uint16 mAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(),5), PMob->GetMLevel());
	uint16 mINT = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(),6), PMob->GetMLevel());
	uint16 mMND = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(),7), PMob->GetMLevel());
	uint16 mCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetMJob(),8), PMob->GetMLevel());

	uint16 sSTR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(),2), PMob->GetSLevel());
	uint16 sDEX = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(),3), PMob->GetSLevel());
	uint16 sVIT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(),4), PMob->GetSLevel());
	uint16 sAGI = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(),5), PMob->GetSLevel());
	uint16 sINT = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(),6), PMob->GetSLevel());
	uint16 sMND = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(),7), PMob->GetSLevel());
	uint16 sCHR = GetBaseToRank(grade::GetJobGrade(PMob->GetSJob(),8), PMob->GetSLevel());

	if(PMob->GetSLevel() > 15)
	{
		sSTR /= 2;
		sDEX /= 2;
		sAGI /= 2;
		sINT /= 2;
		sMND /= 2;
		sCHR /= 2;
		sVIT /= 2;
	} else {
		sSTR = 0;
		sDEX = 0;
		sAGI = 0;
		sINT = 0;
		sMND = 0;
		sCHR = 0;
		sVIT = 0;
	}

	PMob->stats.STR = fSTR + mSTR + sSTR;
	PMob->stats.DEX = fDEX + mDEX + sDEX;
	PMob->stats.VIT = fVIT + mVIT + sVIT;
	PMob->stats.AGI = fAGI + mAGI + sAGI;
	PMob->stats.INT = fINT + mINT + sINT;
	PMob->stats.MND = fMND + mMND + sMND;
	PMob->stats.CHR = fCHR + mCHR + sCHR;

	if(isNM){
		PMob->stats.STR *= 1.5;
		PMob->stats.DEX *= 1.5;
		PMob->stats.VIT *= 1.5;
		PMob->stats.AGI *= 1.5;
		PMob->stats.INT *= 1.5;
		PMob->stats.MND *= 1.5;
		PMob->stats.CHR *= 1.5;
	}

	PMob->m_SpecialSkill = 0;

	PMob->m_RoamCoolDown = 45000;

	if(PMob->m_Family == 258)
	{
		// worms don't act as often
		PMob->m_RoamCoolDown = 60000;
	}

	// aggro mobs move around a bit more often
	if(PMob->m_Behaviour != BEHAVIOUR_NONE)
	{
		PMob->m_RoamCoolDown = 30000;
	}

	// setup special ability
	if(mJob == JOB_RNG)
	{

		// giga
		if(PMob->m_Family == 126 && PMob->m_Family <= 130)
		{
			PMob->m_SpecialCoolDown = 35000;
			// catapult
			PMob->m_SpecialSkill = 402;
		}
		else
		{
			// all other rangers
			PMob->m_SpecialCoolDown = 20000;
			PMob->m_SpecialSkill = 16;
		}

	}
	else if(mJob == JOB_NIN)
	{
		PMob->m_SpecialCoolDown = 35000;
		PMob->m_SpecialSkill = 16;
	}
	else if(mJob == JOB_DRG && PMob->m_Family != 193)
	{
		PMob->m_SpecialCoolDown = 60000;

		// sahigans
		if(PMob->m_Family == 213)
		{
			PMob->m_SpecialSkill = 514;
		}
		else
		{
			// all other dragoons
			PMob->m_SpecialSkill = 808;
		}
	}

	// maat shouldn't have a special skill
	if(PMob->m_Family == 335)
	{
		PMob->m_SpecialSkill = 0;
	}

	// all pets must be defined in the mob_pets file
	// set recast times for summoning pets
	if(!PMob->isInDynamis())
	{
		if(mJob == JOB_BST)
		{
			PMob->m_SpecialCoolDown = 120000;
			PMob->m_SpecialSkill = 761;
		}
		else if(mJob == JOB_DRG && !isNM)
		{
			// only drgs in 3rd expansion calls wyvern as non-NM
			// include fomors
			if(PMob->loc.zone->GetContinentID() == THE_ARADJIAH_CONTINENT || PMob->m_Family == 115)
			{
				// 20 min recast
				PMob->m_SpecialSkill = 476;
				PMob->m_SpecialCoolDown = 720000;
			}
		}
		else if(mJob == JOB_PUP)
		{
			PMob->m_SpecialSkill = 1645;
			PMob->m_SpecialCoolDown = 720000;
		}
	}

	// ambush antlions
	if(PMob->m_Family == 357)
	{
		PMob->m_SpecialSkill = 22;
		PMob->m_SpecialCoolDown = 1000;
		PMob->m_specialFlags |= SPECIALFLAG_HIDDEN;
		PMob->m_roamFlags |= ROAMFLAG_AMBUSH;
	}


	// handle standback
	// mobs that stand back: blm, whm, rng, cor, nin
	if(mJob == JOB_RNG)
	{

		// giga
		if(PMob->m_Family == 126 && PMob->m_Family <= 130)
		{
			PMob->m_StandbackTime = 20000;
		}
		else if(PMob->m_Family == 199)
		{
			// they stay back forever
			PMob->m_StandbackTime = 90000;
		}
		else 
		{
			PMob->m_StandbackTime = 60000;
		}

	}
	else if(mJob == JOB_COR)
	{
		PMob->m_StandbackTime = 60000;
	}
	else if(mJob == JOB_BLM)
	{
		PMob->m_StandbackTime = 42000;
	}
	else if(mJob == JOB_WHM)
	{
		PMob->m_StandbackTime = 32000;
	}
	else if(mJob == JOB_NIN)
	{
		PMob->m_StandbackTime = 25000;
	}
	else
	{
		PMob->m_StandbackTime = 0;
	}

	// modify sneak / sight ranges
	if(PMob->m_Family == 87)
	{
		PMob->m_sightRange = 18;
		PMob->m_hearingRange = 10;
	}

	// clear current traits first
    for (uint8 i = 0; i < PMob->TraitList.size(); ++i)
    {
        CTrait* PTrait = PMob->TraitList.at(i);
        PMob->delModifier(PTrait->getMod(), PTrait->getValue());
    }

	// add special traits to families
	// right now this is hard coded but will eventually be put into a column?

	if(PMob->m_Family == 175)
	{
		// magic pot has high defense bonus
		PMob->setModifier(MOD_MDEF, 50);
	}
	else if(PMob->m_Family == 4 || PMob->m_Family == 74 || PMob->m_Family == 61 || PMob->m_Family == 169)
	{
		// ahriman has magic defense bonus
		// cardians, corse, demons
		PMob->setModifier(MOD_MDEF, 25);
	}
	else if(PMob->m_Family == 110 || PMob->m_Family == 111 || PMob->m_Family == 171)
	{
		// evil weapons
		PMob->setModifier(MOD_MDEF, 13);
	}
	else if(PMob->m_Family == 139)
	{
		// hecteyes
		PMob->setModifier(MOD_EVA, 10);
	}
	else if(PMob->m_Family == 176)
	{
		PMob->setModifier(MOD_EVA, 10);
	}
	else if(PMob->m_Family == 217)
	{
		// scorpion
		PMob->m_Immunity = (IMMUNITY)(uint16)(PMob->m_Immunity | IMMUNITY_POISON);
	}
	else if(PMob->m_Family == 258)
	{
		// worm
		PMob->m_MagicRecastTime = 12000;
	}

	// TODO: this should be put into its own column
	// has not been decided where yet
	if(PMob->m_Family == 258 || PMob->m_Family == 276)
	{
		// makes worms roam by going into ground / back up
		PMob->m_roamFlags |= ROAMFLAG_WORM;
	}

	if(PMob->m_Behaviour != BEHAVIOUR_NONE)
	{
		PMob->m_roamFlags |= ROAMFLAG_MEDIUM;
	}
	else
	{
		PMob->m_roamFlags |= ROAMFLAG_SMALL;
	}

	if(PMob->m_roamFlags & ROAMFLAG_AMBUSH)
	{
		// always stay close to spawn
		PMob->m_maxRoamDistance = 3;
	}

    PMob->TraitList.clear();

    // add double attack bonus 50+
    if(PMob->GetMLevel() >= 50 && PMob->GetMJob() == JOB_WAR){
    	PMob->delModifier(MOD_DOUBLE_ATTACK, 10);
    	PMob->addModifier(MOD_DOUBLE_ATTACK, 10);
    }

	// add traits for sub and main
	AddTraits(PMob, PMob->GetMJob(), PMob->GetMLevel());
	AddTraits(PMob, PMob->GetSJob(), PMob->GetSLevel());

	PMob->delModifier(MOD_MEVA, PMob->m_magicEvasion);
	//natural magic evasion
	if(PMob->GetMLevel()<=83){
	    PMob->m_magicEvasion = battleutils::GetMaxSkill(SKILL_ELE, JOB_RDM, PMob->GetMLevel());
		PMob->setModifier(MOD_MEVA, PMob->m_magicEvasion);
	} else {
	    PMob->m_magicEvasion = battleutils::GetMaxSkill(SKILL_SWD, JOB_RDM, PMob->GetMLevel());
		PMob->setModifier(MOD_MEVA, PMob->m_magicEvasion);
	}

	// cap all magic skills so they play nice with spell scripts
	for (int i=SKILL_DIV; i <=SKILL_BLU; i++) {
		uint16 maxSkill = battleutils::GetMaxSkill((SKILLTYPE)i,PMob->GetMJob(),PMob->GetMLevel());
		if (maxSkill != 0) {
			PMob->WorkingSkills.skill[i] = maxSkill;
		}
		else //if the mob is WAR/BLM and can cast spell
		{
			// set skill as high as main level, so their spells won't get resisted
			uint16 maxSubSkill = battleutils::GetMaxSkill((SKILLTYPE)i,PMob->GetSJob(),PMob->GetMLevel());

			if (maxSubSkill != 0)
			{
				PMob->WorkingSkills.skill[i] = maxSubSkill;
			}
		}
	}

}

void AddTraits(CMobEntity* PMob, JOBTYPE jobID, uint8 lvl)
{
	TraitList_t* PTraitsList = traits::GetTraits(jobID);
    for (uint8 i = 0; i <  PTraitsList->size(); ++i)
	{
		CTrait* PTrait = PTraitsList->at(i);
		if (lvl >= PTrait->getLevel() && PTrait->getLevel() > 0)
		{
            PMob->addModifier(PTrait->getMod(), PTrait->getValue());
		PMob->TraitList.push_back(PTrait);
		}
	}
}

/* Gets the available spells for the specified monster. This looks up the types of spells the monster
 * can cast based on the bitmask in mob_pools (which has been preloaded into memory). It then resolves
 * the list of actual spell IDs based on the bits set. This mapping from bitmask > spellids is based
 * on numerous factors including the type of mob, the level of the mob, etc. The list of spells are
 * then stored in PMob->PSpellContainer
 */
void GetAvailableSpells(CMobEntity* PMob) {
	//make sure the mob actually has a spell list
	if (PMob->m_SpellListContainer == NULL)
	{
		return;
	}

	// setup recast times
	switch(PMob->GetMJob())
	{
		case JOB_BLM:
		case JOB_BRD:
			PMob->m_MagicRecastTime = 30000;
		break;
		case JOB_BLU:
			PMob->m_MagicRecastTime = 40000;
		break;
		case JOB_NIN:
		case JOB_WHM:
		case JOB_RDM:
			PMob->m_MagicRecastTime = 35000;
		break;
		case JOB_SMN:
			PMob->m_MagicRecastTime = 70000;
		break;
		default:
			PMob->m_MagicRecastTime = 45000;
		break;

	}

	uint16 gaChance = 40;
	uint16 buffChance = 30;
	// change spell chances
	switch(PMob->GetMJob())
	{
		case JOB_SMN:
			// smn only has "buffs"
			buffChance = 100;
		break;
		case JOB_BLM:
			gaChance = 40;
			buffChance = 15;
		break;
		case JOB_RDM:
			gaChance = 15;
			buffChance = 30;
		break;
		case JOB_NIN:
			buffChance = 32;
		break;
		case JOB_BRD:
			gaChance = 30;
			buffChance = 60;
		break;
	}

	PMob->SpellContainer->m_gaChance = gaChance;
	PMob->SpellContainer->m_buffChance = buffChance;

	if(PMob->m_Type & MOBTYPE_NOTORIOUS)
	{
		// NMs cure earlier
		PMob->SpellContainer->m_maxHPHealChance = 50;
		PMob->SpellContainer->m_healChance = 30;

	}

	// clear spell list
	PMob->SpellContainer->ClearSpells();

	//insert the rest of the spells
	for (std::vector<MobSpell_t>::iterator it = PMob->m_SpellListContainer->m_spellList.begin(); it != PMob->m_SpellListContainer->m_spellList.end() ; ++it)
	{
		if (PMob->GetMLevel() >= (*it).min_level && PMob->GetMLevel() <= (*it).max_level)
		{
			PMob->SpellContainer->AddSpell((*it).spellId);
		}
	}
}

void InitializeMob(CMobEntity* PMob)
{

        // Killer Effect
        switch (PMob->m_EcoSystem)
      {
        case SYSTEM_AMORPH:   PMob->addModifier(MOD_BIRD_KILLER,     5); break;
        case SYSTEM_AQUAN:    PMob->addModifier(MOD_AMORPH_KILLER,   5); break;
        case SYSTEM_ARCANA:   PMob->addModifier(MOD_UNDEAD_KILLER,   5); break;
        case SYSTEM_BEAST:    PMob->addModifier(MOD_LIZARD_KILLER,   5); break;
        case SYSTEM_BIRD:     PMob->addModifier(MOD_AQUAN_KILLER,    5); break;
        case SYSTEM_DEMON:    PMob->addModifier(MOD_DRAGON_KILLER,   5); break;
        case SYSTEM_DRAGON:   PMob->addModifier(MOD_DEMON_KILLER,    5); break;
        case SYSTEM_LIZARD:   PMob->addModifier(MOD_VERMIN_KILLER,   5); break;
        case SYSTEM_LUMINION: PMob->addModifier(MOD_LUMORIAN_KILLER, 5); break;
        case SYSTEM_LUMORIAN: PMob->addModifier(MOD_LUMINION_KILLER, 5); break;
        case SYSTEM_PLANTOID: PMob->addModifier(MOD_BEAST_KILLER,    5); break;
        case SYSTEM_UNDEAD:   PMob->addModifier(MOD_ARCANA_KILLER,   5); break;
        case SYSTEM_VERMIN:   PMob->addModifier(MOD_PLANTOID_KILLER, 5); break;
      }

      // setup cross family links
      switch(PMob->m_Family)
      {
        // tauris and demons link
        case 240:
          PMob->m_SubLinks[0] = 169;
        break;
        case 169:
          PMob->m_SubLinks[0] = 240;
        break;
        // warmachine and orcs link
        case 190:
          PMob->m_SubLinks[0] = 189;
        break;
        case 189:
          PMob->m_SubLinks[0] = 190;
        break;
        // tri bats and bats link
        case 46:
          PMob->m_SubLinks[0] = 47;
          // Vampyrs
          PMob->m_SubLinks[1] = 253;
        break;
        case 47:
          PMob->m_SubLinks[0] = 46;
        break;
        // treant and saplings link
        case 245:
          PMob->m_SubLinks[0] = 216;
        break;
        case 216:
          PMob->m_SubLinks[0] = 245;
        break;
        // goblin, moblin, bugbear link
        case 133:
          PMob->m_SubLinks[0] = 184;
          PMob->m_SubLinks[1] = 59;
        break;
        case 184:
          PMob->m_SubLinks[0] = 133;
          PMob->m_SubLinks[1] = 59;
        break;
        case 59:
          PMob->m_SubLinks[0] = 133;
          PMob->m_SubLinks[1] = 184;
        break;
        // Wamoura, Wamouracampa link
        case 253:
          PMob->m_SubLinks[0] = 254;
        break;
        case 254:
          PMob->m_SubLinks[0] = 253;
        break;
        // Vampyrs, giant bats link
        case 252:
          PMob->m_SubLinks[0] = 46;
        break;
        // Poroggos, toads (toads dont link with each other) link
        /*case 196:
          PMob->m_SubLinks[0] = 196;
        break;
        case 196:
          PMob->m_SubLinks[0] = 196;
        break;*/
        case 359:
        	// dynamis hydra link with ahriman
        	PMob->m_SubLinks[0] = 4;
    	break;
    	case 358:
        	PMob->m_SubLinks[0] = 4;
    	break;
        case 4:
        	PMob->m_SubLinks[0] = 359;
        	PMob->m_SubLinks[0] = 358;
    	break;
        case 92:
        	// goblin statue link with dynamis gobs
        	PMob->m_SubLinks[0] = 327;
    	break;
    	case 327:
    		PMob->m_SubLinks[0] = 92;
		break;
        case 93:
        // orc statue link with dynamis orcs
        	PMob->m_SubLinks[0] = 334;
    	break;
        case 334:
        	PMob->m_SubLinks[0] = 93;
    	break;
        case 94:
        // quad statue link with dynamis quads
        	PMob->m_SubLinks[0] = 337;
    	break;
    	case 337:
    		PMob->m_SubLinks[0] = 94;
		break;
        case 95:
        // yagudo statue link with dynamis yagudo
        	PMob->m_SubLinks[0] = 360;
    	break;
        case 360:
        	PMob->m_SubLinks[0] = 95;
    	break;
      }
}

}; // namespace mobutils
