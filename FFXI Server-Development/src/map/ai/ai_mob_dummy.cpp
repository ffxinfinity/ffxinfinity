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

#include "../../common/showmsg.h"
#include "../../common/utils.h"

#include "../battleutils.h"
#include "../blueutils.h"
#include "../charutils.h"
#include "../itemutils.h"
#include "../mobskill.h"
#include "../mobutils.h"
#include "../status_effect.h"
#include "../petentity.h"
#include "../petutils.h"
#include "../spell.h"
#include "../zone.h"
#include "../alliance.h"
#include "../map.h"
#include "../targetfind.h"

#include "ai_mob_dummy.h"

#include "../lua/luautils.h"

#include "../packets/action.h"
#include "../packets/entity_update.h"
#include "../packets/fade_out.h"
#include "../packets/message_basic.h"


/************************************************************************
*																		*
*  Инициализируем владельца интеллекта (может добавить проверку на		*
*  пустой указатель с выводом FatalError ?)								*
*																		*
************************************************************************/

CAIMobDummy::CAIMobDummy(CMobEntity* PMob)
{
	m_PMob = PMob;
    m_PTargetFind = new CTargetFind(PMob);
    m_PPathFind = new CPathFind(PMob);

	m_PSpecialSkill = NULL;
	m_firstSpell = true;
	m_LastSpecialTime = 0;
	m_skillTP = 0;
	m_ChaseThrottle = 0;
	m_LastStandbackTime = 0;
	m_DeaggroTime = 0;
	m_NeutralTime = 0;
	m_CanStandback = false;
}

/************************************************************************
*																		*
*  Основная часть интеллекта - главный цикл								*
*																		*
************************************************************************/

void CAIMobDummy::CheckCurrentAction(uint32 tick)
{
	m_Tick = tick;

	m_PMob->PEnmityContainer->DecayEnmity();

	switch(m_ActionType)
	{
		case ACTION_NONE:                                           break;
		case ACTION_ROAMING:			  ActionRoaming();          break;
		case ACTION_ENGAGE:				  ActionEngage();           break;
		case ACTION_DISENGAGE:			  ActionDisengage();        break;
		case ACTION_FALL:				  ActionFall();             break;
		case ACTION_DROPITEMS:			  ActionDropItems();        break;
		case ACTION_DEATH:				  ActionDeath();            break;
		case ACTION_FADE_OUT:			  ActionFadeOut();          break;
		case ACTION_SPAWN:				  ActionSpawn();            break;
		case ACTION_ATTACK:				  ActionAttack();           break;
        case ACTION_SLEEP:                ActionSleep();            break;
		case ACTION_MOBABILITY_START:     ActionAbilityStart();     break;
		case ACTION_MOBABILITY_USING:	  ActionAbilityUsing();     break;
		case ACTION_MOBABILITY_FINISH:	  ActionAbilityFinish();  	break;
        case ACTION_MOBABILITY_INTERRUPT: ActionAbilityInterrupt(); break;
        case ACTION_STUN: 			  	  ActionStun();			    break;
		case ACTION_MAGIC_START:		  ActionMagicStart();		break;
		case ACTION_MAGIC_CASTING:		  ActionMagicCasting();		break;
		case ACTION_MAGIC_INTERRUPT:	  ActionMagicInterrupt();	break;
		default : DSP_DEBUG_BREAK_IF(true);
	}
}

/************************************************************************
*																		*
*  Здесь должен быть алгоритм путешествия по зоне, а также переход в	*
*  режим боевой стойки, если его обладатель (атакующий) не равен нулю.	*
*																		*
************************************************************************/

void CAIMobDummy::ActionRoaming()
{
	// If there's someone on our enmity list, go from roaming -> engaging
	if (m_PMob->PEnmityContainer->GetHighestEnmity() != NULL)
	{
		m_ActionType = ACTION_ENGAGE;
		ActionEngage();
		return;
	}
	else if (m_PMob->m_OwnerID.id != 0) 
	{
		// i'm claimed by someone and need hate towards this person
        m_PBattleTarget = (CBattleEntity*)m_PMob->loc.zone->GetEntity(m_PMob->m_OwnerID.targid, TYPE_PC | TYPE_MOB | TYPE_PET);

		battleutils::ClaimMob(m_PMob, m_PBattleTarget);

        // TODO: возможно необходимо добавлять цели базовое количество ненависти

		m_ActionType = ACTION_ENGAGE;
		ActionEngage();
		return;
	}
	else if (m_PMob->GetDespawnTimer() > 0 && m_PMob->GetDespawnTimer() < m_Tick)
	{
		m_LastActionTime = m_Tick - 12000;
		m_PMob->PBattleAI->SetCurrentAction(ACTION_DEATH);
		return;
	}

	// wait my time
	if(m_Tick - m_LastWaitTime < m_WaitTime){
		m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob,ENTITY_UPDATE));
		return;
	}

	// don't aggro a little bit after I just disengaged
	m_PMob->m_neutral = m_PMob->CanBeNeutral() && (m_Tick - m_NeutralTime) <= MOB_NEUTRAL_TIME;

	if(m_PPathFind->IsFollowingPath())
	{
		FollowPath();

		m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob,ENTITY_UPDATE));

	}
	else if ((m_Tick - m_LastActionTime) >= m_PMob->m_RoamCoolDown)
	{
		// lets buff up or move around

		// recover health
		if(!m_PMob->Rest(0.1f))
		{
			// undirty exp
			m_PMob->m_giveExp = true;
		}

		// if i'm too far away from spawn move back to it
		if(m_PMob->IsFarFromHome())
		{
			if(m_PMob->CanRoamHome() && m_PPathFind->PathTo(m_PMob->m_SpawnPoint, PATHFLAG_WALLHACK))
			{
				// walk back to spawn if too far away

				// limit total path to just 10 or
				// else we'll move straight back to spawn
				m_PPathFind->LimitDistance(10.0f);

				FollowPath();

				m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob,ENTITY_UPDATE));

				// move back every 5 seconds
				m_LastActionTime = m_Tick - m_PMob->m_RoamCoolDown + MOB_NEUTRAL_TIME;
			}
			else
			{
				// despawn
				m_ActionType = ACTION_DEATH;
			}
		}
		else if(m_PSpecialSkill != NULL && TrySpecialSkill())
		{
			// I spawned a pet
		}
		else if(CanCastSpells() && rand()%10 < 3 && m_PMob->SpellContainer->HasBuffSpells())
		{
			// cast buff
			CastSpell(m_PMob->SpellContainer->GetBuffSpell());
		}
		else if(m_PMob->m_roamFlags & ROAMFLAG_EVENT)
		{
			// allow custom event action
			luautils::OnMobRoamAction(m_PMob);
			m_LastActionTime = m_Tick;
		}
		else if(m_PMob->m_roamFlags & ROAMFLAG_AMBUSH)
		{
			// stay underground
			m_PMob->HideName(true);
			m_PMob->animationsub = 0;
		}
		else if(m_PMob->CanRoam() && m_PPathFind->RoamAround(m_PMob->m_SpawnPoint, m_PMob->m_roamFlags))
		{

			if(m_PMob->m_roamFlags & ROAMFLAG_WORM)
			{
				// move down
				m_PMob->animationsub = 1;
				m_PMob->HideName(true);

				// don't move around until i'm fully in the ground
				Wait(2000);
			}
			else
			{
				FollowPath();
			}

			m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob,ENTITY_UPDATE));

		}
		else
		{
			m_LastActionTime = m_Tick;
		}

	}

	if ((m_Tick - m_SpawnTime) % 3000 <= 400)
	{
		luautils::OnMobRoam(m_PMob);
	}
}

/************************************************************************
*                                                                       *
*  Монстр переходит в боевую стойку, включается режим атаки             *
*                                                                       *
************************************************************************/

void CAIMobDummy::ActionEngage()
{
	SetupEngage();
	m_ActionType = ACTION_ATTACK;

	//if (m_PMob->animationsub == 1 || m_PMob->animationsub == 3) m_PMob->animationsub = 2;  //need a better way to do this: it only applies to some mobs!

	if (m_PBattleTarget != NULL)
	{

		if((m_PMob->m_roamFlags & ROAMFLAG_AMBUSH) && m_PMob->IsNameHidden())
		{
			// jump out at you
			TrySpecialSkill();

			m_PMob->animationsub = 1;
			m_PMob->HideName(false);
			m_PMob->m_unknown = 0;
		}
		else
		{
			ActionAttack();
		}

	}
	else
	{
		m_ActionType = ACTION_DISENGAGE;
	}

	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE));
}

/************************************************************************
*																		*
*  Монстр выходит из режима атаки по каким-либо причинам. Если при этом	*
*  он слишком далеко от точки появления, то запускается перерождение.	*
*																		*
************************************************************************/

void CAIMobDummy::ActionDisengage()
{
	m_PPathFind->Clear();

	// this will let me decide to walk home or despawn
	m_LastActionTime = m_Tick - m_PMob->m_RoamCoolDown + MOB_NEUTRAL_TIME;
	m_PMob->m_neutral = true;

	m_NeutralTime = m_Tick;

	m_PBattleTarget  = NULL;

	m_PMob->SetMainSkin(m_PMob->id);
    m_PMob->delRageMode();
    m_PMob->m_OwnerID.clean();
	m_PMob->m_CallForHelp = 0;
	m_PMob->animation = ANIMATION_NONE;

	//if (m_PMob->animationsub == 2) m_PMob->animationsub = 3;

	TransitionBack();

	luautils::OnMobDisengage(m_PMob);

	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE));
}

/************************************************************************
*																		*
*  Монстр падает на землю после получения смертельного удара.			*
*																		*
************************************************************************/

void CAIMobDummy::ActionFall()
{
	m_PMob->PEnmityContainer->Clear();
	m_PPathFind->Clear();

	m_ActionType = ACTION_DROPITEMS;
	m_LastActionTime = m_Tick;
	m_PMob->animation = ANIMATION_DEATH;

	// my pet should fall as well
	if(m_PMob->PPet != NULL && !m_PMob->PPet->isDead() && m_PMob->GetMJob() == JOB_SMN)
	{
		m_PMob->PPet->health.hp = 0;
		m_PMob->PPet->PBattleAI->SetCurrentAction(ACTION_FALL);
	}

	m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob,ENTITY_UPDATE));
}

/************************************************************************
*																		*
*  Здесь выполняется скрипт после смерти монстра, распределяется опыт	*
*  и определяются выпавшие предметы										*
*																		*
************************************************************************/

void CAIMobDummy::ActionDropItems()
{
    if ((m_Tick - m_LastActionTime) >= m_PMob->m_DropItemTime)
	{
        CCharEntity* PChar = (CCharEntity*)m_PMob->loc.zone->GetEntity(m_PMob->m_OwnerID.targid, TYPE_PC);

        if (PChar != NULL && PChar->id == m_PMob->m_OwnerID.id)
		{
			luautils::OnMobDeath(m_PMob, PChar);

			m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CMessageBasicPacket(PChar,m_PMob,0,0, MSGBASIC_DEFEATS_TARG));

			if (m_PMob->m_CallForHelp == 0)
			{
				blueutils::TryLearningSpells(PChar, m_PMob);
				m_PMob->m_UsedSkillIds.clear();

				if(m_PMob->m_giveExp)
				{
	                charutils::DistributeExperiencePoints(PChar, m_PMob);
				}

                DropList_t* DropList = itemutils::GetDropList(m_PMob->m_DropID);

			    if (DropList != NULL && PChar != NULL && DropList->size())
			    {
					uint8 highestTH = charutils::GetHighestTreasureHunter(PChar, m_PMob);

                    for(uint8 i = 0; i < DropList->size(); ++i)
				    {
						//highestTH is the number of 'extra chances' at an item. If the item is obtained, then break out.
						uint8 tries = 0;
						while(tries < 1+highestTH)
						{
							if(rand()%100 < DropList->at(i).DropRate)
							{
								PChar->PTreasurePool->AddItem(DropList->at(i).ItemID, m_PMob);
								break;
							}
							tries++;
						}
				    }
					//check for gil (beastmen drop gil, some NMs drop gil)
					if(m_PMob->m_EcoSystem == SYSTEM_BEASTMEN || m_PMob->m_Type & MOBTYPE_NOTORIOUS)
                    {
						charutils::DistributeGil(PChar, m_PMob); // TODO: REALISATION MUST BE IN TREASUREPOOL
					}
					//check for seal drops
					/* MobLvl >= 1 = Beastmen Seals ID=1126
					          >= 50 = Kindred Seals ID=1127
							  >= 75 = Kindred Crests ID=2955
							  >= 90 = High Kindred Crests ID=2956
					*/
					uint8 Pzone = PChar->getZone();
					if(charutils::GetRealExp(PChar->GetMLevel(),m_PMob->GetMLevel())>0 &&
						rand()%100 < 40 && m_PMob->m_Type == MOBTYPE_NORMAL && ((Pzone > 0 &&
						Pzone < 39) || (Pzone > 42 && Pzone < 134) || (Pzone > 135 && Pzone < 185) || (Pzone > 188 && Pzone < 255))){ //exp-yielding monster and drop is successful
						//TODO: The drop is actually based on a 5 minute timer, and not a probability of dropping!

						//RULES: Only 1 kind may drop per mob
						if(m_PMob->GetMLevel() < 50){ //b.seal only
							PChar->PTreasurePool->AddItem(1126, m_PMob);
						}
						else if(m_PMob->GetMLevel() < 75){ //b.seal & k.seal only
							if(rand()%2 == 0){
								PChar->PTreasurePool->AddItem(1126, m_PMob);
							}
							else{
								PChar->PTreasurePool->AddItem(1127, m_PMob);
							}
						}
						else if(m_PMob->GetMLevel() < 90){ //b.seal & k.seal & k.crest
							switch(rand()%3){
							case 0:
								PChar->PTreasurePool->AddItem(1126, m_PMob);
								break;
							case 1:
								PChar->PTreasurePool->AddItem(1127, m_PMob);
								break;
							case 2:
								PChar->PTreasurePool->AddItem(2955, m_PMob);
								break;
							}
						}
						else if(m_PMob->GetMLevel() >= 90){ //all 4
							switch(rand()%4){
							case 0:
								PChar->PTreasurePool->AddItem(1126, m_PMob);
								break;
							case 1:
								PChar->PTreasurePool->AddItem(1127, m_PMob);
								break;
							case 2:
								PChar->PTreasurePool->AddItem(2955, m_PMob);
								break;
							case 3:
								PChar->PTreasurePool->AddItem(2956, m_PMob);
								break;
							}
						}
					}

			    }
			}
			PChar->setWeaponSkillKill(false);
		}
        m_ActionType = ACTION_DEATH;
	}
}

/************************************************************************
*																		*
*  Время ожидания до исчезновения (монстр не обязательно мертв) 		*
*																		*
************************************************************************/

void CAIMobDummy::ActionDeath()
{
	if ((m_Tick - m_LastActionTime) > 12000)
	{
        m_PMob->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DEATH, true);

		m_ActionType = ACTION_FADE_OUT;
		m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CFadeOutPacket(m_PMob));
		//if (m_PMob->animationsub == 2) m_PMob->animationsub = 1;

		luautils::OnMobDespawn(m_PMob);
	}
    else if (!m_PMob->isDead())
    {
        if (m_PMob->PEnmityContainer->GetHighestEnmity() != NULL)
	    {
		    m_ActionType = ACTION_ENGAGE;
		    ActionEngage();
	    }
    }
}

/************************************************************************
*                                                                       *
*  Здесь модель пропадает после постепенного ичезновения, так же        *
*  решается вопрос, а нужно ли включать процесс возрождения монстра.    *
*  Если его тип возрождения равен нулю, значит он был вызван и в        *
*  возрождении не нуждается, иначе запускаем процесс                    *
*                                                                       *
************************************************************************/

void CAIMobDummy::ActionFadeOut()
{
	if ((m_Tick - m_LastActionTime) > 15000 )
	{
		// reset pet cast time to now
		if(m_PMob->PMaster != NULL && m_PMob->PMaster->objtype == TYPE_MOB)
		{
			CAIMobDummy* PBattleAI = (CAIMobDummy*)m_PMob->PMaster->PBattleAI;
			PBattleAI->m_LastSpecialTime = m_Tick - rand()%10000;
		}

		m_PMob->status = STATUS_DISAPPEAR;
        m_PMob->PEnmityContainer->Clear();

        m_ActionType  = m_PMob->m_AllowRespawn ? ACTION_SPAWN : ACTION_NONE;

	}
}

/************************************************************************
*                                                                       *
*  Возрождение монстра                                                  *
*                                                                       *
************************************************************************/

// TODO: ночные монстры должны появляться только ночью

void CAIMobDummy::ActionSpawn()
{
	if ((m_Tick - m_LastActionTime) >= m_PMob->m_RespawnTime)
	{
		m_NeutralTime = m_Tick;
		m_LastActionTime = m_Tick + rand() % 8000 + 2000;
		m_SpawnTime = m_Tick;
		m_firstSpell = true;
		m_ActionType = ACTION_ROAMING;
		m_PBattleTarget = NULL;
		m_PBattleSubTarget = NULL;
		m_PSpecialSkill = NULL;
		m_PMobSkill = NULL;
		m_PMob->m_giveExp = true;
		m_PMob->m_SkillStatus = 0;
        m_PMob->m_OwnerID.clean();
		m_PMob->m_CallForHelp = 0;
		m_PMob->m_HiPCLvl = 0;
		m_PMob->m_THLvl = 0;
		m_PMob->m_THPCID = 0;
        m_PMob->m_DropItemTime = 1000;
		m_PMob->status = STATUS_UPDATE;
		m_PMob->animation = ANIMATION_NONE;
		m_PMob->HideName(false);

		// event mob types will always have custom roaming
		if(m_PMob->m_Type & MOBTYPE_EVENT)
		{
			m_PMob->m_roamFlags = ROAMFLAG_EVENT;
		}

        m_PMob->PEnmityContainer->Clear();
        m_PPathFind->Clear();

		uint8 level = m_PMob->m_minLevel;

		// Generate a random level between min and max level
		if (m_PMob->m_maxLevel != m_PMob->m_minLevel)
		{
			level += rand()%(m_PMob->m_maxLevel - m_PMob->m_minLevel);
		}

		m_PMob->SetMLevel(level);
		m_PMob->SetSLevel(level);//calculated in function
        m_PMob->delRageMode();

		mobutils::CalculateStats(m_PMob);
		mobutils::GetAvailableSpells(m_PMob);

		// get my special skill
		if(m_PMob->m_SpecialSkill)
		{
			m_PSpecialSkill = battleutils::GetMobSkill(m_PMob->m_SpecialSkill);
		}

		// spawn somewhere around my point
		m_PMob->loc.p = m_PMob->m_SpawnPoint;

		if(m_PMob->m_roamFlags & ROAMFLAG_AMBUSH)
		{
			m_PMob->HideName(true);
			m_PMob->animationsub = 0;
			// this will hide the mob
			m_PMob->m_unknown = 2181;
		}

        luautils::OnMobSpawn( m_PMob );

		m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_SPAWN));
	}
}

/************************************************************************
*                                                                       *
*  Начало специальной атаки монстра (эффект начала)                     *
*                                                                       *
************************************************************************/

void CAIMobDummy::ActionAbilityStart()
{
	DSP_DEBUG_BREAK_IF(m_PBattleTarget == NULL);

    std::vector<CMobSkill*> MobSkills = battleutils::GetMobSkillsByFamily(m_PMob->m_Family);

    // не у всех монстов прописаны способности, так что выходим из процедуры, если способность не найдена
	// We don't have any skills we can use, so let's go back to attacking
    if (MobSkills.size() == 0)
    {
    	ShowWarning("CAIMobDummy::ActionAbilityStart No TP moves found for family (%d)\n", m_PMob->m_Family);
        m_PMob->health.tp = 0;
        TransitionBack(true);
		return;
    }

	bool valid = false; //Assume no valid moves exist

	// lets try to use my two hour
	// two hour is assumed to be at the front
	if(m_PMob->m_SkillStatus == 0)
	{
		if(MobSkills[0]->isTwoHour() && m_PMob->CanUseTwoHour()){
			// get my job two hour
			m_PMobSkill = battleutils::GetTwoHourMobSkill(m_PMob->GetMJob());

			valid = (m_PMobSkill != NULL && luautils::OnMobSkillCheck(m_PBattleTarget, m_PMob, m_PMobSkill) == 0);
		}
	}

	// no 2 hour picked, lets find a normal skill
	if(valid == false)
	{
		float currentDistance = distance(m_PMob->loc.p, m_PBattleTarget->loc.p);

		std::random_shuffle(MobSkills.begin(), MobSkills.end()); //Start the selection process by randomizing the container

		for(int i=0;i<MobSkills.size();i++){
			m_PMobSkill = MobSkills.at(i);
			if(!m_PMobSkill->isTwoHour() && luautils::OnMobSkillCheck(m_PBattleTarget, m_PMob, m_PMobSkill) == 0){ //A script says that the move in question is valid
				if(currentDistance <= m_PMobSkill->getDistance()) {
					valid = true;
					break;
				}
			}
		}
	}


	if(!valid) {
		// couldn't find anything so go back to attack
		m_PMob->health.tp = 0;
		TransitionBack(true);
		return;
	}

	if(m_PMobSkill->getValidTargets() == TARGET_ENEMY){ //enemy
	    m_PBattleSubTarget = m_PBattleTarget;
	}
	else if(m_PMobSkill->getValidTargets() == TARGET_SELF){ //self
	    m_PBattleSubTarget = m_PMob;
	}
	else
	{
		m_PMob->health.tp = 0;
		TransitionBack(true);
		return;
	}

    m_PPathFind->LookAt(m_PBattleSubTarget->loc.p);
    m_LastActionTime = m_Tick;
    
	// store the TP the mob currently has as the mob skill TP modifier
	m_skillTP = m_PMob->health.tp;

	// remove tp
	if(m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_MEIKYO_SHISUI))
	{
		if(m_PMob->health.tp <= 100)
		{
			m_PMob->health.tp = 0;
		} else {
			m_PMob->health.tp -= 100;
		}
	} else {
		m_PMob->health.tp = 0;
	}

	m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE));

	if( m_PMobSkill->getActivationTime() == 0)
	{
		m_ActionType = ACTION_MOBABILITY_FINISH;
		ActionAbilityFinish();
	}
	else
	{

	    apAction_t Action;
	    m_PMob->m_ActionList.clear();
		// charge up time
		Action.ActionTarget = m_PBattleSubTarget;
		Action.reaction   = REACTION_HIT;
		Action.speceffect = SPECEFFECT_HIT;
		Action.animation  = 0;
		Action.param	  = m_PMobSkill->getMsgForAction();
		Action.messageID  = 43; //readies message
		Action.flag		  = 0;

		m_PMob->m_ActionList.push_back(Action);
		m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));
		m_ActionType = ACTION_MOBABILITY_USING;
	}

}

/***********************************************************************
		In the readying animation to use a TP move
************************************************************************/
void CAIMobDummy::ActionAbilityUsing()
{
	DSP_DEBUG_BREAK_IF(m_PMobSkill == NULL);
	DSP_DEBUG_BREAK_IF(m_PBattleSubTarget == NULL);

	// If our target dies or zones whilst readying, then interrupt the TP move.
	if(m_PMobSkill->getValidTargets() == TARGET_ENEMY && m_PBattleSubTarget->isDead() ||
		m_PMobSkill->getValidTargets() == TARGET_ENEMY && m_PBattleSubTarget->getZone() != m_PMob->getZone()){
		m_ActionType = ACTION_MOBABILITY_INTERRUPT;
		ActionAbilityInterrupt();
		return;
	}

	// always face my target
	m_PPathFind->LookAt(m_PBattleSubTarget->loc.p);

	//TODO: Any checks whilst the monster is preparing.
	//NOTE: RANGE CHECKS ETC ONLY ARE DONE AFTER THE ABILITY HAS FINISHED PREPARING.
	//      THE ONLY CHECK IN HERE SHOULD BE WITH STUN/SLEEP/TERROR/ETC

	if ((m_Tick - m_LastActionTime) >= m_PMobSkill->getActivationTime())
    {
		//Range check
		if(m_PMobSkill->getValidTargets() == TARGET_ENEMY &&
			m_PBattleSubTarget!=m_PMob &&
			distance(m_PBattleSubTarget->loc.p,m_PMob->loc.p) > m_PMobSkill->getDistance()){

			m_ActionType = ACTION_MOBABILITY_INTERRUPT;
			ActionAbilityInterrupt();
			return;
		}

		m_LastActionTime = m_Tick;
		m_ActionType = ACTION_MOBABILITY_FINISH;
		ActionAbilityFinish();
	}
	m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE)); //need to keep HP updating

}

/************************************************************************
*                                                                       *
*  Окончание специальной атаки монстра (анимация эффекта).              *
*  После выполения специальной атаки не обнуляем m_PMobSkill, позднее   *
*  по этому значению blu будет учить заклинания.                        *
*                                                                       *
************************************************************************/

void CAIMobDummy::ActionAbilityFinish()
{
    DSP_DEBUG_BREAK_IF(m_PMobSkill == NULL);

	// crash fix, a null target made it into CActionPacket
	if (m_PBattleSubTarget == NULL)
	{
		m_ActionType = ACTION_ATTACK;
		return;
	}

	m_DeaggroTime = m_Tick;

	// I think this should be saved for all skills used by the mob
	// this is useful for funguar remembering its used moves
	// drg can use their two hour multiple times
	if (m_PMobSkill->isTwoHour() && m_PMob->GetMJob() != JOB_DRG) // 2h
	{
		m_PMob->m_SkillStatus = 1;

		// force magic spam on chainspell, manafont and soul voice
		int16 skillID = m_PMobSkill->getID();
		if(skillID == 436 || skillID == 440 || skillID == 435)
		{
			m_LastMagicTime = 0;
		}
	}

	// store the skill used
	m_PMob->m_UsedSkillIds[m_PMobSkill->getID()] = m_PMob->GetMLevel();

    m_PTargetFind->reset();
    m_PMob->m_ActionList.clear();

    float distance = m_PMobSkill->getDistance();

    if(m_PTargetFind->isWithinRange(m_PBattleSubTarget, distance))
    {
		if(m_PMobSkill->isAoE())
		{
	        m_PTargetFind->findWithinArea(m_PBattleSubTarget, (AOERADIUS)m_PMobSkill->getAoe(), m_PMobSkill->getRadius());
		}
		else if(m_PMobSkill->isConal())
		{
			float angle = 45.0f;
			m_PTargetFind->findWithinCone(m_PBattleSubTarget, distance, angle);
		}
		else
		{
			m_PTargetFind->findSingleTarget(m_PBattleSubTarget);
		}
	}

    uint16 actionsLength = m_PTargetFind->m_targets.size();

    m_PMobSkill->setTotalTargets(actionsLength);
	m_PMobSkill->setTP(m_skillTP);

	apAction_t Action;
	Action.ActionTarget = m_PBattleSubTarget;
	Action.reaction   = REACTION_HIT;
	Action.speceffect = SPECEFFECT_HIT;
	Action.animation  = m_PMobSkill->getAnimationID();
	Action.subparam   = m_PMobSkill->getID() + 256;
	Action.messageID  = m_PMobSkill->getMsg();
	Action.flag		  = 0;


    uint16 msg = 0;
    for (std::vector<CBattleEntity*>::iterator it = m_PTargetFind->m_targets.begin() ; it != m_PTargetFind->m_targets.end(); ++it)
	{
        CBattleEntity* PTarget = *it;

        Action.ActionTarget = PTarget;

	        // set default message
        m_PMobSkill->resetMsg();

		Action.param = luautils::OnMobWeaponSkill(PTarget, m_PMob, m_PMobSkill);

		if(msg == 0){
			msg = m_PMobSkill->getMsg();
		} else {
			msg = m_PMobSkill->getAoEMsg();
		}

		Action.messageID = msg;

		if(m_PMobSkill->hasMissMsg())
		{
		    Action.reaction   = REACTION_MISS;
		} else {
		    Action.reaction   = REACTION_HIT;
		}


		m_PMob->m_ActionList.push_back(Action);
	}

	if (m_ActionType == ACTION_FALL)
	{
		//  set when you kill the mob in a script, but need
		//  it to be ACTION_MOBABILITY_FINISH for pushing the packet.
		m_ActionType = ACTION_MOBABILITY_FINISH;
	}

	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));


	if (m_PMob->isDead()) //e.g. self-destruct. Needed here AFTER sending the action packets.
	{
		m_ActionType = ACTION_FALL;
		ActionFall();
	}
	else
	{
		// increase magic / ranged timer so its not used right after
		m_LastMagicTime += m_PMobSkill->getAnimationTime() + 2000;
		m_LastSpecialTime += m_PMobSkill->getAnimationTime() + 2000;

		m_ActionType = ACTION_ATTACK;
	}

}

/************************************************************************
*																		*
*  Прерывание специальной атаки монстра                 				*
*																		*
************************************************************************/

void CAIMobDummy::ActionAbilityInterrupt()
{
    m_LastActionTime = m_Tick;
	//cancel the whole readying animation
	apAction_t Action;
    m_PMob->m_ActionList.clear();

		Action.ActionTarget = m_PMob;
		Action.reaction   = REACTION_NONE;
		Action.speceffect = SPECEFFECT_NONE;
		Action.animation  = m_PMobSkill->getID();
	    Action.param	  = 0;
		Action.messageID  = 0;
        Action.flag       = 0;

	m_PMob->m_ActionList.push_back(Action);
	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));

    m_PMobSkill = NULL;
    m_ActionType = ACTION_ATTACK;
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

void CAIMobDummy::ActionSleep()
{
	if (m_PMob->isDead()) {
		m_ActionType = ACTION_FALL;
		ActionFall();
		return;
	}

    if (!m_PMob->StatusEffectContainer->HasPreventActionEffect())
    {
		m_ActionType = ACTION_ATTACK;
    }

	if(m_PMob->animation == ANIMATION_NONE)
	{
		SetupEngage();
	}

	m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE));

}


void CAIMobDummy::ActionStun()
{

	// lets just chill here for a bit
	if(m_Tick - m_LastStunTime >= m_StunTime){
		m_PBattleSubTarget = NULL;
		TransitionBack();
	}

	if(m_PBattleSubTarget != NULL)
	{	
	    // always face target
	    m_PPathFind->LookAt(m_PBattleSubTarget->loc.p);
	}

	m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE));
}

void CAIMobDummy::ActionMagicStart()
{
	DSP_DEBUG_BREAK_IF(m_PSpell == NULL);

	m_interruptSpell = false;
	// this must be at the top to RESET magic cast timer
	m_LastActionTime = m_Tick;
	m_LastMagicTime = m_Tick;

	// don't use special right after magic
	m_LastSpecialTime += rand()%3000 + 1000;

	// check valid targets
	if (m_PSpell->getValidTarget() & TARGET_SELF) {
		m_PBattleSubTarget = m_PMob;

		// only buff other targets if i'm roaming
		if((m_PSpell->getValidTarget() & TARGET_PLAYER_PARTY))
		{
			// chance to target my master
			if(m_PMob->PMaster != NULL && rand()%2 == 0)
			{
				// target my master
				m_PBattleSubTarget = m_PMob->PMaster;
			}
			else if(rand()%2 == 0)
			{
				// chance to target party
				m_PTargetFind->reset();
				m_PTargetFind->findWithinArea(m_PMob, AOERADIUS_ATTACKER, MOB_SPELL_MAX_RANGE);

				uint16 totalTargets = m_PTargetFind->m_targets.size();

				if(totalTargets)
				{
					// randomly select a target
					m_PBattleSubTarget = m_PTargetFind->m_targets[rand()%totalTargets];
				}

			}
		}

	}
	else
	{
		m_PBattleSubTarget = m_PBattleTarget;
	}

	if ( (m_PSpell->getValidTarget() & TARGET_ENEMY) && m_PBattleSubTarget->objtype == TYPE_MOB) {
		if(m_PBattleSubTarget->PMaster == NULL || m_PBattleSubTarget->PMaster->objtype != TYPE_PC){
			TransitionBack(true);
			ShowDebug("Monster Magic Cast on self but spell is enemy... spellId: %d \n", m_PSpell->getID());
			return;
		}
	}

	if(luautils::OnMagicCastingCheck(m_PMob, m_PBattleSubTarget, m_PSpell) != 0)
	{
		//fail
		TransitionBack(true);
		return;
	}

	apAction_t Action;
    m_PMob->m_ActionList.clear();

	Action.ActionTarget = m_PBattleSubTarget;
	Action.reaction   = REACTION_NONE;
	Action.speceffect = SPECEFFECT_NONE;
	Action.animation  = 0;
	Action.param	  = m_PSpell->getID();
	Action.messageID  = 327;
	Action.flag		  = 0;

	m_PMob->m_ActionList.push_back(Action);

	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));
    m_ActionType = ACTION_MAGIC_CASTING;
}

void CAIMobDummy::ActionMagicCasting()
{
	DSP_DEBUG_BREAK_IF(m_PBattleSubTarget == NULL);

	if (m_PBattleSubTarget->isDead() || m_PBattleSubTarget->getZone() != m_PMob->getZone()) {
		m_ActionType = ACTION_MAGIC_INTERRUPT;
		ActionMagicInterrupt();
		return;
	}

	if (m_PMob->isDead()) {
		m_ActionType = ACTION_FALL;
		ActionFall();
		return;
	}

	m_PPathFind->LookAt(m_PBattleSubTarget->loc.p);

	if ( ((m_Tick - m_LastMagicTime) >= (float)m_PSpell->getCastTime()*((100.0f-(float)dsp_cap(m_PMob->getMod(MOD_FASTCAST),-100,50))/100.0f)) ||
        m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL,0))
	{	
		m_LastMagicTime = m_Tick - rand()%(uint32)((float)m_PMob->m_MagicRecastTime / 2);

		if(m_interruptSpell)
		{
			// I got force interrupted			
			m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CMessageBasicPacket(m_PMob,m_PBattleSubTarget,0,0, MSGBASIC_IS_INTERRUPTED));
			m_ActionType = ACTION_MAGIC_INTERRUPT;
			ActionMagicInterrupt();
			return;
		}
		else if(m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_SILENCE))
        {
			m_ActionType = ACTION_MAGIC_INTERRUPT;
			ActionMagicInterrupt();
			return;
		}
		else if (battleutils::IsParalised(m_PMob))
		{
			m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CMessageBasicPacket(m_PMob,m_PBattleSubTarget,0,0,MSGBASIC_IS_PARALYZED));
			m_ActionType = ACTION_MAGIC_INTERRUPT;
			ActionMagicInterrupt();
			return;
		}
		else if (!(m_PSpell->getValidTarget() & TARGET_SELF) && battleutils::IsIntimidated(m_PMob, m_PBattleSubTarget))
		{
		    m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CMessageBasicPacket(m_PMob,m_PBattleSubTarget,0,0,MSGBASIC_IS_INTIMIDATED));
		    m_ActionType = ACTION_MAGIC_INTERRUPT;
			ActionMagicInterrupt();
			return;
		}

		float currentDistance = distance(m_PMob->loc.p, m_PBattleSubTarget->loc.p);
		if (currentDistance > 28.5) {
			m_ActionType = ACTION_MAGIC_INTERRUPT;
			ActionMagicInterrupt();
			return;
		}

		m_ActionType = ACTION_MAGIC_FINISH;
		ActionMagicFinish();

	}

	m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE)); //need to keep HP updating
}

void CAIMobDummy::ActionMagicInterrupt()
{
	DSP_DEBUG_BREAK_IF(m_PBattleSubTarget == NULL);

	apAction_t Action;
    m_PMob->m_ActionList.clear();

	Action.ActionTarget = m_PMob;
	Action.reaction   = REACTION_NONE;
	Action.speceffect = SPECEFFECT_NONE;
	Action.animation  = m_PSpell->getAnimationID();
	Action.param	  = 0;
	Action.messageID  = 0;
	Action.flag		  = 0;

	m_PMob->m_ActionList.push_back(Action);

	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));
	m_LastMagicTime = m_Tick; // reset this in case the spell is long casting, don't want to immediately recast
	m_PSpell = NULL;
	m_PBattleSubTarget = NULL;

	TransitionBack();
}

void CAIMobDummy::ActionMagicFinish()
{

	DSP_DEBUG_BREAK_IF(m_PBattleSubTarget == NULL || m_PSpell == NULL);

	m_DeaggroTime = m_Tick;

    m_PTargetFind->reset();
    m_PMob->m_ActionList.clear();

    uint8 aoeType = battleutils::GetSpellAoEType(m_PMob, m_PSpell);

    if(m_PTargetFind->isWithinRange(m_PBattleSubTarget, MOB_SPELL_MAX_RANGE))
    {
		if (aoeType == SPELLAOE_RADIAL) {
			float distance = spell::GetSpellRadius(m_PSpell, m_PMob);

	        m_PTargetFind->findWithinArea(m_PBattleSubTarget, AOERADIUS_TARGET, distance);

        } else if (aoeType == SPELLAOE_CONAL)
        {
            //TODO: actual angle calculation
            float radius = spell::GetSpellRadius(m_PSpell, m_PMob);

            m_PTargetFind->findWithinCone(m_PBattleSubTarget, radius, 45);
		} else {
			// only add target
			m_PTargetFind->findSingleTarget(m_PBattleSubTarget);
		}
	}

    uint16 actionsLength = m_PTargetFind->m_targets.size();

	m_PSpell->setTotalTargets(actionsLength);

	apAction_t Action;
	Action.ActionTarget = m_PBattleSubTarget;
	Action.reaction   = REACTION_NONE;
	Action.speceffect = SPECEFFECT_NONE;
	Action.animation  = m_PSpell->getAnimationID();
	Action.param      = 0;
	Action.messageID  = 0;
	Action.flag		  = 0;

	uint16 msg = 0;
    int16 ce = 0;
    int16 ve = 0;
	for (std::vector<CBattleEntity*>::iterator it = m_PTargetFind->m_targets.begin() ; it != m_PTargetFind->m_targets.end(); ++it)
	{

        CBattleEntity* PTarget = *it;

        Action.ActionTarget = PTarget;


		m_PSpell->resetMessage();
        ce = m_PSpell->getCE();
        ve = m_PSpell->getVE();

        // take all shadows
        if(m_PSpell->canTargetEnemy() && aoeType > 0)
        {
        	PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_BLINK);
        	PTarget->StatusEffectContainer->DelStatusEffect(EFFECT_COPY_IMAGE);
        }

        // TODO: this is really hacky and should eventually be moved into lua
        if(m_PSpell->canTargetEnemy() && aoeType == SPELLAOE_NONE && battleutils::IsAbsorbByShadow(PTarget))
        {
        	// take shadow
        	msg = 31;
        	Action.param = 1;
            ve = 0;
            ce = 0;
        }
        else
        {
	        Action.param = luautils::OnSpellCast(m_PMob, PTarget);

		    // remove effects from damage
			if (m_PSpell->canTargetEnemy() && Action.param > 0 && m_PSpell->dealsDamage())
			{
				PTarget->StatusEffectContainer->DelStatusEffectsByFlag(EFFECTFLAG_DAMAGE);
			}

			if(msg == 0)
			{
		        msg = m_PSpell->getMessage();
		    }
		    else
		    {
				msg = m_PSpell->getAoEMessage();
		    }

	    }

	    Action.messageID = msg;

		if (PTarget->objtype == TYPE_MOB && m_PMob->id != PTarget->id && !m_PSpell->isBuff())
        {
            if (PTarget->isDead())
            {
                ((CMobEntity*)PTarget)->m_DropItemTime = m_PSpell->getAnimationTime();
            }
            ((CMobEntity*)PTarget)->m_OwnerID.id = m_PMob->id;
            ((CMobEntity*)PTarget)->m_OwnerID.targid = m_PMob->targid;
            ((CMobEntity*)PTarget)->PEnmityContainer->UpdateEnmity(m_PMob, ce, ve);
        }

        m_PMob->m_ActionList.push_back(Action);
    }

	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));

	if (m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL,0)){
		// let's make CSing monsters actually use lots of spells.
		m_LastMagicTime = m_Tick - m_PMob->m_MagicRecastTime;
	}
	else if(m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT,0) ||
	    m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_SOUL_VOICE,0)) 
	{
		// cast magic sooner
		m_LastMagicTime = m_Tick - (float)(m_PMob->m_MagicRecastTime/2);
	}

	m_PSpell = NULL;
	m_PBattleSubTarget = NULL;

	// display animation, then continue fighting

	Stun(1000);
}

/************************************************************************
*																		*
*  Обычная физическая атака без нанесения какого-либо урона				*
*																		*
************************************************************************/

void CAIMobDummy::ActionAttack()
{
	m_PBattleTarget = m_PMob->PEnmityContainer->GetHighestEnmity();

	if(TryDeaggro())
	{
		if(m_PBattleTarget == NULL)
		{
			m_ActionType = ACTION_DISENGAGE;
			ActionDisengage();
		}
		else
		{
			ActionAttack();
		}
		
		return;
	}

    float currentDistance = distance(m_PMob->loc.p, m_PBattleTarget->loc.p);

	TryLink();

    // always face target
    m_PPathFind->LookAt(m_PBattleTarget->loc.p);

    if(m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_BIND))
    {
    	// bind prevents deaggro
    	m_DeaggroTime = m_Tick;
    }

	// Try to spellcast (this is done first so things like Chainspell spam is prioritised over TP moves etc.
	if (currentDistance <= MOB_SPELL_MAX_RANGE && (m_Tick - m_LastMagicTime) >= m_PMob->m_MagicRecastTime && TryCastSpell())
	{
		FinishAttack();
		return;
	}
	else if(m_PSpecialSkill != NULL && (m_Tick - m_LastSpecialTime) >= m_PMob->m_SpecialCoolDown && TrySpecialSkill())
	{
		FinishAttack();
		return;
	}
	else if (rand()%100 < m_PMob->TPUseChance())
	{
		m_ActionType = ACTION_MOBABILITY_START;
		ActionAbilityStart();
		FinishAttack();
		return;
	}

    // try to standback if I can
	if(m_PMob->m_StandbackTime)
	{
		if(currentDistance > 30)
		{
			// you're so far away i'm going to standback when I get closer
			m_CanStandback = true;
		}
		else if(m_PSpecialSkill == NULL && !CanCastSpells() || m_PMob->GetHPP() <= 65)
		{
			// can't standback anymore cause I don't have any ranged moves
			m_CanStandback = false;

			// don't stand back again
			m_LastStandbackTime = m_Tick + m_PMob->m_StandbackTime;
		}
		else if(currentDistance < 20 && currentDistance > m_PMob->m_ModelSize * 2)
		{

			if(m_CanStandback && currentDistance > m_PMob->m_ModelSize)
		    {
		    	uint16 halfStandback = (float)m_PMob->m_StandbackTime/3;
		    	m_LastStandbackTime = m_Tick + m_PMob->m_StandbackTime - rand()%(halfStandback);
		    	m_CanStandback = false;
		    }

			if((m_Tick - m_LastStandbackTime) > m_PMob->m_StandbackTime)
			{
				// speed up my ranged attacks cause i'm waiting here
				m_LastSpecialTime -= 1000;
				m_LastMagicTime -= 1000;
				FinishAttack();
				return;
			}

		}
		else
		{
			// if i'm chasing too much, just melee attack
			m_LastStandbackTime -= 1000;
		}
	}


	// move closer to enemy
	if(currentDistance > m_PMob->m_ModelSize && m_PMob->speed != 0)
	{
		// mobs will find a new path only when enough ticks pass
		// this is so the server is not overloaded
		if(!m_PPathFind->IsFollowingPath() || ++m_ChaseThrottle == 4)
		{
			m_ChaseThrottle = 0;
			m_PPathFind->PathAround(m_PBattleTarget->loc.p, 2.0f, PATHFLAG_WALLHACK | PATHFLAG_RUN);
		}

		if(m_PPathFind->IsFollowingPath())
		{
			// m_PPathFind->CurvePath(0.5f);
			m_PPathFind->FollowPath();

			// recalculate
		    currentDistance = distance(m_PMob->loc.p, m_PBattleTarget->loc.p);
		}
	}

	// attack enemy if close enough
	if (currentDistance <= m_PMob->m_ModelSize)
	{
		m_CanStandback = true;
		int32 WeaponDelay = m_PMob->m_Weapons[SLOT_MAIN]->getDelay();
		if (m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_HUNDRED_FISTS,0))
		{
			WeaponDelay = 600;
		} else {
			int16 hasteMagic = (m_PMob->getMod(MOD_HASTE_MAGIC) > 448) ? 448 : m_PMob->getMod(MOD_HASTE_MAGIC);
			int16 hasteAbility = (m_PMob->getMod(MOD_HASTE_ABILITY) > 256) ? 256 : m_PMob->getMod(MOD_HASTE_ABILITY);
			WeaponDelay -= (((float)(hasteMagic + hasteAbility) * WeaponDelay) / 1024);
		}

		if (m_AutoAttackEnabled && (m_Tick - m_LastActionTime) > WeaponDelay)
		{
			if (battleutils::IsParalised(m_PMob))
			{
				m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CMessageBasicPacket(m_PMob,m_PBattleTarget,0,0, MSGBASIC_IS_PARALYZED));
			}
			else if (battleutils::IsIntimidated(m_PMob, m_PBattleTarget))
			{
				m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CMessageBasicPacket(m_PMob,m_PBattleTarget,0,0, MSGBASIC_IS_INTIMIDATED));
			}
			else
			{
				apAction_t Action;
				m_PMob->m_ActionList.clear();

				Action.ActionTarget = m_PBattleTarget;

				uint8 numAttacks = battleutils::CheckMultiHits(m_PMob, m_PMob->m_Weapons[SLOT_MAIN]);

				for(uint8 i=0; i<numAttacks; i++){
					Action.reaction   = REACTION_EVADE;
					Action.speceffect = SPECEFFECT_NONE;
					Action.animation  = 0;
					Action.param	  = 0;
					Action.messageID  = 15;
					Action.flag		  = 0;
					if(m_PBattleTarget->isDead()){
						break;
					}

					uint16 damage = 0;
					bool isCountered = false;
					bool isParried = false;
					bool isGuarded = false;
					bool isDodge = false;
					if (m_PBattleTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_DODGE))
					{
						Action.messageID = 32;
						isDodge = true;
					}
					else if ( rand()%100 < battleutils::GetHitRate(m_PMob, m_PBattleTarget) )
					{
						if (battleutils::IsParried(m_PMob, m_PBattleTarget))
						{
							isParried = true;
							Action.messageID = 70;
							Action.reaction   = REACTION_PARRY;
							Action.speceffect = SPECEFFECT_NONE;
						}
						else if (battleutils::IsAbsorbByShadow(m_PBattleTarget))
						{
							Action.messageID = 0;
							m_PBattleTarget->loc.zone->PushPacket(m_PBattleTarget,CHAR_INRANGE_SELF, new CMessageBasicPacket(m_PBattleTarget,m_PBattleTarget,0,1, MSGBASIC_SHADOW_ABSORB));
						}
						else if (battleutils::IsAnticipated(m_PBattleTarget,false,false))
						{
							Action.messageID = 30;
						}
						else
						{
							Action.reaction   = REACTION_HIT;
							Action.speceffect = SPECEFFECT_HIT;
							Action.messageID  = 1;

							// if victim is a player, get the players counter merits
							uint8 meritCounter = 0;
							if (m_PBattleTarget->objtype == TYPE_PC && charutils::hasTrait((CCharEntity*)m_PBattleTarget,TRAIT_COUNTER))
							{
								if (m_PBattleTarget->GetMJob() == JOB_MNK || m_PBattleTarget->GetMJob() == JOB_PUP)
									meritCounter = ((CCharEntity*)m_PBattleTarget)->PMeritPoints->GetMeritValue(MERIT_COUNTER_RATE,(CCharEntity*)m_PBattleTarget);
							}


							//counter check (rate AND your hit rate makes it land, else its just a regular hit)
							if (rand()%100 < (m_PBattleTarget->getMod(MOD_COUNTER) + meritCounter) &&
								rand()%100 < battleutils::GetHitRate(m_PBattleTarget,m_PMob) &&
								(charutils::hasTrait((CCharEntity*)m_PBattleTarget,TRAIT_COUNTER) ||
								m_PBattleTarget->StatusEffectContainer->HasStatusEffect(EFFECT_SEIGAN)))
							{
								isCountered = true;
								Action.messageID = 33; //counter msg  32
								Action.reaction   = REACTION_HIT;
								Action.speceffect = SPECEFFECT_NONE;

								bool isCritical = ( rand()%100 < battleutils::GetCritHitRate(m_PBattleTarget, m_PMob,false) );
								bool isHTH = m_PBattleTarget->m_Weapons[SLOT_MAIN]->getDmgType() == DAMAGE_HTH;
								if (!isHTH && m_PBattleTarget->objtype == TYPE_MOB && m_PBattleTarget->GetMJob() == JOB_MNK)
								{
									isHTH = true;
								}
								int16 naturalh2hDMG = 0;
								if (isHTH)
								{
									naturalh2hDMG = (float)(m_PBattleTarget->GetSkill(SKILL_H2H) * 0.11f)+3;
								}

								float DamageRatio = battleutils::GetDamageRatio(m_PBattleTarget, m_PMob,isCritical, 0);
								damage = (uint16)((m_PBattleTarget->GetMainWeaponDmg() + naturalh2hDMG + battleutils::GetFSTR(m_PBattleTarget, m_PMob,SLOT_MAIN)) * DamageRatio);

								Action.subparam = (damage * 2);
								Action.flag = 2;
							}
							else if (m_PBattleTarget->StatusEffectContainer->HasStatusEffect(EFFECT_PERFECT_COUNTER))
							{ //Perfect Counter only counters hits that normal counter misses
								isCountered = true;

							}
							else
							{
								bool isCritical = ( rand()%100 < battleutils::GetCritHitRate(m_PMob, m_PBattleTarget,false) );

								if(m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_MIGHTY_STRIKES,0))
								{
									isCritical=true;
								}

								float DamageRatio = battleutils::GetDamageRatio(m_PMob, m_PBattleTarget,isCritical, 0);

								if(isCritical)
								{
									Action.speceffect = SPECEFFECT_CRITICAL_HIT;
									Action.messageID  = 67;
								}

								// Guard
								if(battleutils::IsGuarded(m_PMob, m_PBattleTarget))
								{
									isGuarded = true;
									//Action.messageID = 0;
									Action.reaction = REACTION_GUARD;
									Action.speceffect = SPECEFFECT_NONE;
									DamageRatio -= 1.0f; // Guard lowers pDif by 1.0
								}

								damage = (uint16)((m_PMob->m_Weapons[SLOT_MAIN]->getDamage() + battleutils::GetFSTR(m_PMob, m_PBattleTarget,SLOT_MAIN)) * DamageRatio);

								//  Guard skill up
								if(m_PBattleTarget->objtype == TYPE_PC && isGuarded || ((map_config.newstyle_skillups & NEWSTYLE_GUARD) > 0))
								{
									if(battleutils::GetGuardRate(m_PMob, m_PBattleTarget) > 0)
									{
										charutils::TrySkillUP((CCharEntity*)m_PBattleTarget,SKILL_GRD, m_PBattleTarget->GetMLevel());
									}
								} // Guard skill up
							}

							if(!isCountered)
							{
								bool isBlocked = battleutils::IsBlocked(m_PMob, m_PBattleTarget);
								if(isBlocked){ Action.reaction = REACTION_BLOCK; }
								if (m_PBattleTarget->objtype == TYPE_PC)
								{
									damage = battleutils::HandleSpecialPhysicalDamageReduction((CCharEntity*)m_PBattleTarget,damage,&Action);
								}

								Action.param = battleutils::TakePhysicalDamage(m_PMob, m_PBattleTarget, damage, isBlocked ,SLOT_MAIN, 1, NULL, true);
								m_PMob->PEnmityContainer->UpdateEnmityFromAttack(m_PBattleTarget, Action.param);

								// Block skill up
								if(m_PBattleTarget->objtype == TYPE_PC && isBlocked || ((map_config.newstyle_skillups & NEWSTYLE_BLOCK) > 0))
								{
									if(battleutils::GetBlockRate(m_PMob, m_PBattleTarget) > 0)
									{
										charutils::TrySkillUP((CCharEntity*)m_PBattleTarget, SKILL_SHL, m_PMob->GetMLevel());
									}
								} // Block skill up


								// spike effect
								// spikes take priority
								if(!battleutils::HandleSpikesDamage(m_PMob, m_PBattleTarget, &Action, damage)){
		                    		// no spikes, handle enspell
		                    		// TODO: enspell method needs to be refactored to accept just battleentity
		                    		// battleutils::HandleEnspell(m_PMob, m_PBattleTarget, &Action, i, WeaponDelay, damage);
								}
							}
							else
							{
								Action.param = battleutils::TakePhysicalDamage(m_PBattleTarget, m_PMob, damage, false, SLOT_MAIN, 1, NULL, true);
								if(m_PBattleTarget->objtype == TYPE_PC)
								{
									uint8 skilltype = (m_PBattleTarget->m_Weapons[SLOT_MAIN] == NULL ? SKILL_H2H : m_PBattleTarget->m_Weapons[SLOT_MAIN]->getSkillType());
									charutils::TrySkillUP((CCharEntity*)m_PBattleTarget, (SKILLTYPE)skilltype, m_PMob->GetMLevel());
								}
							}

						}

						// Parry skill up
						if(m_PBattleTarget->objtype == TYPE_PC && isParried || ((map_config.newstyle_skillups & NEWSTYLE_PARRY) > 0))
						{
							if(battleutils::GetParryRate(m_PMob, m_PBattleTarget) > 0)
							{
								charutils::TrySkillUP((CCharEntity*)m_PBattleTarget,SKILL_PAR,m_PBattleTarget->GetMLevel());
							}
						} // Parry skill up
					}

					if (m_PBattleTarget->objtype == TYPE_PC && !isCountered && !isParried && !isDodge)
					{
						charutils::TrySkillUP((CCharEntity*)m_PBattleTarget, SKILL_EVA, m_PMob->GetMLevel());
					}

					m_PMob->m_ActionList.push_back(Action);
				}

				m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));
			}
            m_LastActionTime = m_Tick;
            m_DeaggroTime = m_Tick;
		}
	}
	else if (rand()%100 < m_PMob->TPUseChance())
	{
		// not in range to attack my target
		// so try an other tp move
		m_ActionType = ACTION_MOBABILITY_START;
		ActionAbilityStart();
	}

	FinishAttack();
}

void CAIMobDummy::FinishAttack()
{

	if(m_PMob->m_Type & MOBTYPE_NOTORIOUS && (m_Tick - m_StartBattle) % 3000 <= 400) // launch OnMobFight every 3 sec (not everytime at 0 but 0~400)
	{
		luautils::OnMobFight(m_PMob,m_PBattleTarget);
	}

	m_PMob->loc.zone->PushPacket(m_PMob,CHAR_INRANGE, new CEntityUpdatePacket(m_PMob, ENTITY_UPDATE));
}

bool CAIMobDummy::TryDeaggro()
{

	if(m_PBattleTarget == NULL) // we have no target, so disengage
    {
		return true;
	}

	// mob should not attack another mob with no master
	if(m_PBattleTarget != NULL && (m_PBattleTarget->objtype == TYPE_MOB || m_PBattleTarget->objtype == TYPE_PET) && m_PBattleTarget->PMaster == NULL)
	{

        if (m_PMob->m_OwnerID.id == m_PBattleTarget->id)
        {
            m_PMob->m_OwnerID.clean();
        }

		m_PMob->PEnmityContainer->Clear(m_PBattleTarget->id);
		return true;
	}


	// target is dead, on a choco or zoned, so wipe them from our enmity list
    if (m_PBattleTarget->isDead() ||
        m_PBattleTarget->animation == ANIMATION_CHOCOBO ||
		m_PBattleTarget->loc.zone->GetID() != m_PMob->loc.zone->GetID())
	{
        if (m_PMob->m_OwnerID.id == m_PBattleTarget->id)
        {
            m_PMob->m_OwnerID.clean();
        }
		m_PMob->PEnmityContainer->Clear(m_PBattleTarget->id);
		return true;
	}

	bool tryDetectDeaggro = false;
	bool tryTimeDeaggro = true;

	if((m_PMob->m_Behaviour & BEHAVIOUR_SCENT))
	{
		// if mob is in water it will instant aggro if target cannot be detected
		if(m_PPathFind->InWater())
		{
			tryDetectDeaggro = true;
		}

		// certain weather / deodorize will turn on time deaggro
		if(m_PMob->m_disableScent ||
			m_PBattleTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DEODORIZE))
		{
			tryTimeDeaggro = true;
		}
	}
	
	if(tryTimeDeaggro && m_Tick - m_DeaggroTime >= MOB_DEAGGRO_TIME && m_PMob->CanDeaggro())
	{
		tryDetectDeaggro = true;
	}

	// I will now deaggro if I cannot detect my target
	if(tryDetectDeaggro && !m_PMob->CanDetectTarget(m_PBattleTarget))
	{
		if (m_PMob->m_OwnerID.id == m_PBattleTarget->id)
        {
            m_PMob->m_OwnerID.clean();
        }
		m_PMob->PEnmityContainer->Clear(m_PBattleTarget->id);
		return true;
	}

	return false;
}

void CAIMobDummy::TryLink()
{
	if(m_PBattleTarget == NULL)
	{
		return;
	}

	//handle pet behaviour on the targets behalf (faster than in ai_pet_dummy)
	// Avatars defend masters by attacking mobs if the avatar isn't attacking anything currently (bodyguard behaviour)
	if(m_PBattleTarget->PPet != NULL && m_PBattleTarget->PPet->PBattleAI->GetBattleTarget()==NULL) {
		if(((CPetEntity*)m_PBattleTarget->PPet)->getPetType()==PETTYPE_AVATAR) {
			m_PBattleTarget->PPet->PBattleAI->SetBattleTarget(m_PMob);
		}
	}

    // my pet should help as well
	if(m_PMob->PPet != NULL && m_PMob->PPet->PBattleAI->GetCurrentAction() == ACTION_ROAMING)
	{
		((CMobEntity*)m_PMob->PPet)->PEnmityContainer->AddLinkEnmity(m_PBattleTarget);
	}

	// Handle monster linking if they are close enough
    if (m_PMob->PParty != NULL)
    {
        for (uint16 i = 0; i < m_PMob->PParty->members.size(); ++i)
        {
            CMobEntity* PPartyMember = (CMobEntity*)m_PMob->PParty->members[i];

            if(!PPartyMember->m_neutral && CanLink(PPartyMember)){
		        PPartyMember->PEnmityContainer->AddLinkEnmity(m_PBattleTarget);
            }
        }
    }

    // ask my master for help
    if(m_PMob->PMaster != NULL && m_PMob->PMaster->PBattleAI->GetCurrentAction() == ACTION_ROAMING)
    {
    	CMobEntity* PMaster = (CMobEntity*)m_PMob->PMaster;

        if(CanLink(PMaster)){
	        PMaster->PEnmityContainer->AddLinkEnmity(m_PBattleTarget);
        }
    }

}

bool CAIMobDummy::CanCastSpells()
{

	if ( !m_MagicCastingEnabled || !m_PMob->SpellContainer->HasSpells()) return false;

	// check for spell blockers e.g. silence
	if(m_PMob->StatusEffectContainer->HasStatusEffect(EFFECT_SILENCE)) {
		return false;
	}

	// smn can only cast spells if it has an existing pet
	if(m_PMob->GetMJob() == JOB_SMN && m_PMob->PPet == NULL){
		return false;
	}

	return true;
}

bool CAIMobDummy::TryCastSpell()
{
	if(!CanCastSpells())
	{
		return false;
	}

	int chosenSpellId = -1;
	if (m_PMob->m_HasSpellScript) {
		// skip logic and follow script
		chosenSpellId = luautils::OnMonsterMagicPrepare(m_PMob, m_PBattleTarget);
		if(chosenSpellId > -1){
			CastSpell(chosenSpellId);
			return true;
		}
	} else {
		// find random spell

		if(m_firstSpell){
			// mobs first spell, should be aggro spell
			chosenSpellId = m_PMob->SpellContainer->GetAggroSpell();
			m_firstSpell = false;
		} else {
			chosenSpellId = m_PMob->SpellContainer->GetSpell();
		}

		if(chosenSpellId > -1){
			CastSpell(chosenSpellId);
			return true;
		}

	}

	// the script doesn't want to cast a spell at the moment, but it should still be treated as a magic attempt
	m_LastMagicTime = m_Tick;
	return false;
}

void CAIMobDummy::ActionSpecialSkill()
{

	if(m_PSpecialSkill == NULL){
		m_PBattleSubTarget = NULL;
		m_ActionType = ACTION_ATTACK;
		return;
	}


	// this will be read by the packets layer
	m_PMobSkill = m_PSpecialSkill;

	// this makes sure the proper packet is sent
	m_ActionType = ACTION_MOBABILITY_FINISH;

    DSP_DEBUG_BREAK_IF(m_PBattleSubTarget == NULL);

    m_LastActionTime = m_Tick;
    m_DeaggroTime = m_Tick;

    uint32 halfSpecial = (float)m_PMob->m_SpecialCoolDown/2;

    m_LastSpecialTime = m_Tick - rand()%(halfSpecial);

    apAction_t Action;
    m_PMob->m_ActionList.clear();

    m_PPathFind->LookAt(m_PBattleSubTarget->loc.p);

    m_PMobSkill->resetMsg();

	Action.speceffect = SPECEFFECT_HIT;
    Action.ActionTarget = m_PBattleSubTarget;
	Action.animation  = m_PMobSkill->getAnimationID();
	Action.subparam   = m_PMobSkill->getMsgForAction();
	Action.param	  = luautils::OnMobWeaponSkill(m_PBattleSubTarget, m_PMob, m_PMobSkill);
	Action.messageID  = m_PMobSkill->getMsg();
	Action.flag       = 0;

	// display hit or miss
	if(m_PMobSkill->hasMissMsg())
	{
	    Action.reaction   = REACTION_MISS;
	} else {
	    Action.reaction   = REACTION_HIT;
	}

	m_PMob->m_ActionList.push_back(Action);

	m_PMob->loc.zone->PushPacket(m_PMob, CHAR_INRANGE, new CActionPacket(m_PMob));

	// this stops the mob from chasing
	Stun(m_PMobSkill->getAnimationTime());

	m_PMobSkill = NULL;
}

void CAIMobDummy::CastSpell(uint16 spellId)
{
	m_PSpell = spell::GetSpell(spellId);

	if(m_PSpell == NULL){
		ShowWarning(CL_YELLOW"ai_mob_dummy::CastSpell: SpellId <%i> is not found\n" CL_RESET, spellId);
	} else {
		m_ActionType = ACTION_MAGIC_START;
		ActionMagicStart();
	}
}

bool CAIMobDummy::CanLink(CMobEntity* PTarget)
{
	if (PTarget->PBattleAI->GetCurrentAction() == ACTION_ROAMING){

		// link only if I see him
		if((PTarget->m_Behaviour & BEHAVIOUR_AGGRO_SIGHT) || (PTarget->m_Behaviour & BEHAVIOUR_AGGRO_TRUESIGHT)){

		   if(!isFaceing(PTarget->loc.p, m_PMob->loc.p, 40)) return false;
		}

		if(distance(m_PMob->loc.p, PTarget->loc.p) <= m_PMob->m_linkRadius)
		{
	        return true;
	    }
	}
	return false;
}

bool CAIMobDummy::TrySpecialSkill()
{
	if(m_PSpecialSkill == NULL) return false;

	if((m_PMob->m_specialFlags & SPECIALFLAG_HIDDEN) && !m_PMob->IsNameHidden())
	{
		return false;
	}

	if(m_PSpecialSkill->getValidTargets() & TARGET_SELF)
	{
		m_PBattleSubTarget = m_PMob;
	}
	else if(m_PBattleTarget != NULL)
	{
		// distance check for special skill
	    float currentDistance = distance(m_PMob->loc.p, m_PBattleTarget->loc.p);

		if(currentDistance <= m_PSpecialSkill->getDistance())
		{
			m_PBattleSubTarget = m_PBattleTarget;
		}
		else
		{
			return false;
		}
	}
	else
	{
		return false;
	}

	if(luautils::OnMobSkillCheck(m_PBattleSubTarget, m_PMob, m_PSpecialSkill) == 0)
	{
		ActionSpecialSkill();
		return true;
	}

	return false;
}

void CAIMobDummy::FollowPath()
{
	m_PPathFind->FollowPath();

	if(m_ActionType == ACTION_ROAMING)
	{
		CBattleEntity* PPet = m_PMob->PPet;
		if(PPet != NULL && PPet->PBattleAI->GetCurrentAction() == ACTION_ROAMING)
		{

			// pet should follow me if roaming
	        position_t targetPoint = nearPosition(m_PMob->loc.p, 2.1f, M_PI);

	        PPet->PBattleAI->MoveTo(&targetPoint);

			PPet->loc.zone->PushPacket(PPet,CHAR_INRANGE, new CEntityUpdatePacket(PPet,ENTITY_UPDATE));
		}

		// if I just finished reset my last action time
		if(!m_PPathFind->IsFollowingPath())
		{
			m_LastActionTime = m_Tick - rand()%m_PMob->m_RoamCoolDown + 5000;

			// i'm a worm pop back up
			if(m_PMob->m_roamFlags & ROAMFLAG_WORM)
			{
				m_PMob->animationsub = 0;
				m_PMob->HideName(false);
			}
		}

		if(m_PPathFind->OnPoint()){
			luautils::OnMobPath(m_PMob);
		}
	}
}

void CAIMobDummy::Stun(uint32 stunTime)
{
	m_StunTime = stunTime;
    m_LastStunTime = m_Tick;
	m_ActionType = ACTION_STUN;
}

void CAIMobDummy::SetupEngage()
{

	m_PMob->animation = ANIMATION_ATTACK;
	m_StartBattle = m_Tick;
	m_DeaggroTime = m_Tick;
	m_LastActionTime = m_Tick - 1000; // Why do we subtract 1 sec?
	m_firstSpell = true;
	m_CanStandback = true;

	// drg shouldn't use jump right away
	if(m_PMob->GetMJob() == JOB_DRG)
	{
		m_LastSpecialTime = m_Tick;
	}

	m_PPathFind->Clear();
	m_PBattleTarget = m_PMob->PEnmityContainer->GetHighestEnmity();

	if(m_PBattleTarget != NULL)
	{
		luautils::OnMobEngaged(m_PMob, m_PBattleTarget);
	}
}

void CAIMobDummy::WeatherChange(WEATHER weather, uint8 element)
{

	// can't detect by scent in this weather
	if(m_PMob->m_Behaviour & BEHAVIOUR_SCENT)
	{
		m_PMob->m_disableScent = (weather == WEATHER_RAIN || weather == WEATHER_SQUALL || weather == WEATHER_BLIZZARDS);
	}

	if (m_PMob->m_EcoSystem == SYSTEM_ELEMENTAL && m_PMob->PMaster == NULL)
	{
		if (m_PMob->m_Element == element)
		{
			m_PMob->SetDespawnTimer(0);
			m_PMob->m_AllowRespawn = true;
			SetLastActionTime(0);
			SetCurrentAction(ACTION_SPAWN);
		}
		else
		{
			m_PMob->SetDespawnTimer(1);
			m_PMob->m_AllowRespawn = false;
		}
	}
	else if(m_PMob->m_Family == 25)
	{
		// antica gain more sound aggro range during sand weather
		if(weather == WEATHER_DUST_STORM || weather == WEATHER_SAND_STORM)
		{
			m_PMob->m_hearingRange = 12;
		}
		else
		{
			m_PMob->m_hearingRange = 8;
		}
	}
	else if(m_PMob->m_Family == 198)
	{
		// puk
		// what up I gain regain
		if(weather == WEATHER_WIND || weather == WEATHER_GALES)
		{
			m_PMob->addModifier(MOD_REGAIN, 5);
		}
		else
		{
			m_PMob->delModifier(MOD_REGAIN, 5);
		}
	}
	else if(m_PMob->m_Family == 107 || m_PMob->m_Family == 108)
	{
		// eruca
		// what up I gain regain
		if(weather == WEATHER_HOT_SPELL || weather == WEATHER_HEAT_WAVE)
		{
			m_PMob->addModifier(MOD_REGAIN, 5);
		}
		else
		{
			m_PMob->delModifier(MOD_REGAIN, 5);
		}
	}
	// TODO: slug auto-regen rain
}

bool CAIMobDummy::CanAggroTarget(CBattleEntity* PTarget)
{
	// don't aggro i'm neutral
	if(m_PMob->m_neutral) return false;
		

	if(PTarget->isDead() || PTarget->animation == ANIMATION_CHOCOBO) return false;

	if(m_PMob->PMaster == NULL && m_ActionType == ACTION_ROAMING && m_PMob->CanDetectTarget(PTarget))
	{
		return true;
	}

	return false;
}

void CAIMobDummy::TransitionBack(bool skipWait)
{
	if(m_PMob->animation == ANIMATION_ATTACK)
	{
		m_ActionType = ACTION_ATTACK;
		if(skipWait)
		{
			ActionAttack();
		}
	}
	else
	{
		m_ActionType = ACTION_ROAMING;
		if(skipWait)
		{
			ActionRoaming();
		}
	}
}
