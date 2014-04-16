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

#ifndef _LATENTEFFECTCONTAINER_H
#define _LATENTEFFECTCONTAINER_H

#include "../common/cbasetypes.h"
#include "../common/taskmgr.h"

#include "latent_effect.h"
#include "petentity.h"

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

class CCharEntity;

class CLatentEffectContainer
{
public:

	void CheckLatentsHP(int32 hp);
	void CheckLatentsTP(float tp);
	void CheckLatentsMP(int32 mp);
	void CheckLatentsEquip(uint8 slot);
	void CheckLatentsWeaponDraw(bool drawn);
	void CheckLatentsStatusEffect();
	void CheckLatentsRollSong(bool active);
	void CheckLatentsDay();
	void CheckLatentsPartyMembers(uint8 members);
	void CheckLatentsPartyAvatar();
	void CheckLatentsJobLevel();
	void CheckLatentsPetType(PETTYPE petID);
	void CheckLatentsTime();
	void CheckLatentsWeaponBreak(uint8 slot);
	void CheckLatentsZone();

	void AddLatentEffect(CLatentEffect* LatentEffect);
	void AddLatentEffects(std::vector<CLatentEffect*> *latentList, uint8 slot);
	void DelLatentEffects(uint8 slot);   

    CLatentEffect* GetLatentEffect(uint8 slot, uint16 modId);

	 CLatentEffectContainer(CCharEntity* PEntity);
	~CLatentEffectContainer();

private:

	CCharEntity* m_POwner;

	std::vector<CLatentEffect*>	m_LatentEffectList;
};

#endif

