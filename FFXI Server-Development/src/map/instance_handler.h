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

#ifndef _CINSTANCEHANDLER_H
#define _CINSTANCEHANDLER_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"

#include "instance.h"
#include <vector>

class CCharEntity;
class CMobEntity;

class CInstanceHandler
{
public:

	CInstanceHandler(uint16 zoneid);
	void	handleInstances(uint32 tick);							// called every tick to handle win/lose conditions, locking the bcnm, etc
	int		registerBcnm(uint16 bcnmid, CCharEntity* PChar);		// returns the instance id of the registration, -1 if no free bcnm.
																	// also registers all people in the characters PT, etc.

	bool	enterBcnm(uint16 bcnmid, CCharEntity* PChar);			// Enters the BCNM instance if you're registered
	bool	leaveBcnm(uint16 bcnmid, CCharEntity* PChar);			// Leaves the BCNM instance if you're registered
	bool	disconnectFromBcnm(CCharEntity* PChar);					// Disconnects/Warps you from a BCNM
	bool	winBcnm(uint16 bcnmid, CCharEntity* PChar);				// Wins a BCNM instance (e.g. the player opening the chest)

	uint8	findInstanceIDFor(CCharEntity* PChar);					// returns 1 2 3 or 255 if non-existent
	bool	hasFreeInstance();										// returns true if there is a free instance available
	uint32	pollTimeLeft(uint16 bcnmid);							// returns the shortest time left of all 3 instances of the given BCNM ID
	void	openTreasureChest(CCharEntity* PChar);
	void	wipeInstance(CInstance* inst);
	
	//Dynamis Functions
	int		getUniqueDynaID(uint16 id);								// 
	int		registerDynamis(uint16 id, CCharEntity* PChar);			// 
	int		dynamisAddPlayer(uint16 dynaid, CCharEntity* PChar);	// Add a player to the dynamis instance
	int		dynamisMessage(uint16 Param1, uint16 Param2);			// Add message on dynamis param1: messageid, param2: parameter
	void	launchDynamisSecondPart();
	bool	disconnectFromDynamis(CCharEntity* PChar);

	void	insertMonsterInList(CMobEntity* PMob);
	bool	checkMonsterInList(CMobEntity* PMob);

private:
	uint16					m_ZoneId;
	uint8					m_MaxInstances;							// usually 3 except dynamis, einherjar, besieged, ...
	CInstance*				m_Instances[3];
};

#endif