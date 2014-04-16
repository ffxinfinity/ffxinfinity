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

#include "item_armor.h"

#include <string.h>


CItemArmor::CItemArmor(uint16 id) : CItemUsable(id)
{
	setType(ITEM_ARMOR);

	m_jobs         = 0;
	m_modelID      = 0;
	m_removeSlotID = 0;
	m_shieldSize   = 0;
	m_scriptType   = 0;
	m_reqLvl       = 255;
	m_equipSlotID  = 255;
    m_absorption   = 0;
    m_trialNumber  = 0;

    memset(&m_augments, 0, sizeof(m_augments));
}

CItemArmor::~CItemArmor()
{
	// ни в коем случае не освобождать здесь указатели на модификатоты и спецеффекты. они глобальны.
}

uint16 CItemArmor::getModelId()
{
	return m_modelID;
}

uint8 CItemArmor::getShieldSize()
{
	return m_shieldSize;
}

uint16 CItemArmor::getEquipSlotId()
{
	return m_equipSlotID;
}

uint8 CItemArmor::getRemoveSlotId()
{
	return m_removeSlotID;
}

uint8 CItemArmor::getReqLvl()
{
	return m_reqLvl;
}

uint32 CItemArmor::getJobs()
{
	return m_jobs;
}

void CItemArmor::setReqLvl(uint8 lvl)
{
	m_reqLvl = lvl;
}

void CItemArmor::setJobs(uint32 jobs)
{
	m_jobs = jobs;
}

void CItemArmor::setModelId(uint16 mdl)
{
	m_modelID = mdl;
}

void CItemArmor::setShieldSize(uint8 shield)
{
	m_shieldSize = shield;
}

void CItemArmor::setEquipSlotId(uint16 equipSlot)
{
	m_equipSlotID = equipSlot;
}

void CItemArmor::setRemoveSlotId(uint8 removSlot)
{
	m_removeSlotID = removSlot;
}

uint8 CItemArmor::getSlotType()
{
	uint32 result = 0;
	getMSB(&result,(uint32)m_equipSlotID);
	return result;
}

/************************************************************************
*																		*
*  Процент урона, блокируемого щитом                                    *
*																		*
************************************************************************/

uint8 CItemArmor::getShieldAbsorption()
{
    return m_absorption;
}

/************************************************************************
*																		*
*  Проверяем, является ли проедмет щитом                                *
*																		*
************************************************************************/

bool CItemArmor::IsShield()
{
    return m_shieldSize > 0 && m_shieldSize < 6;
}

/************************************************************************
*																		*
*  Проверяем необходимость выполнения скрипта для экипировки при		*
*  возникновении какого-либо из событий (экипировка, смена зоны и т.п.)	*
*																		*
*  Функция возвращает типы событий на которые предмет реагирует, что	*
*  избавляет нас от необходимости проверять	предмет во всех событиях	*
*																		*
************************************************************************/

uint16 CItemArmor::getScriptType()
{
	return m_scriptType;
}

void CItemArmor::setScriptType(uint16 ScriptType)
{
	m_scriptType = ScriptType;
}

/************************************************************************
*                                                                       *
*  Добавляем модификатор к предмету                                     *
*                                                                       *
************************************************************************/

void CItemArmor::addModifier(CModifier* modifier)
{
    if (IsShield() && modifier->getModID() == MOD_DEF)
    {
        // reduction calc source: www.bluegartr.com/threads/84830-Shield-Asstery

		int16 pdt = modifier->getModAmount() / 2;

		switch(m_shieldSize)
        {
			case 1: pdt += 22; break; // Bucker 22%
			case 2: pdt += 40; break; // Round  40%
			case 3: pdt += 50; break; // Kite   50%
			case 4: pdt += 55; break; // Tower  55%
			case 5: pdt += 60; break; // Aegis  60%
		}
        m_absorption = dsp_min(pdt,100);
    }
    modList.push_back(modifier);
}

int16 CItemArmor::getModifier(uint16 mod)
{
	for (uint16 i = 0; i < modList.size(); ++i)
	{
		if (modList.at(i)->getModID() == mod)
		{
			return modList.at(i)->getModAmount();
		}
	}
	return 0;
}

void CItemArmor::addLatent(CLatentEffect* latent)
{
	latentList.push_back(latent);
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

void CItemArmor::setTrialNumber(uint16 trial)
{
	m_trialNumber = trial;
}

uint16 CItemArmor::getTrialNumber()
{
	return m_trialNumber;
}

/************************************************************************
*                                                                       *
*  Augments: 5 bits for value, 11 bits for augment ID                   *
*                                                                       *
************************************************************************/

void CItemArmor::LoadAugment(uint8 slot, uint16 augment)
{
    DSP_DEBUG_BREAK_IF(getAugment(slot) != 0);

    m_augments[slot] = augment;

    SetAugmentMod(
        unpackBitsBE((uint8*)(m_augments+slot), 0, 11), 
        unpackBitsBE((uint8*)(m_augments+slot), 11, 5)
    );
}

void CItemArmor::setAugment(uint8 slot, uint16 type, uint8 value)
{
    DSP_DEBUG_BREAK_IF(getAugment(slot) != 0);

    packBitsBE((uint8*)(m_augments+slot), type, 0, 11);
    packBitsBE((uint8*)(m_augments+slot), value, 11, 5);

    SetAugmentMod(type, value);
}

void CItemArmor::SetAugmentMod(uint16 type, uint8 value)
{
    // TODO: если augmenttype совпадает с modtype, то мы може установить значение сразу,
    //       либо придется использовать дополнительную логику

    if (type != 0) 
    {
        setSubType(ITEM_AUGMENTED);       
    }
    //addModifier(new CModifier(type,value));
}

uint16 CItemArmor::getAugment(uint8 slot)
{
    DSP_DEBUG_BREAK_IF(slot >= ARRAYLENGTH(m_augments));

	return m_augments[slot];
}