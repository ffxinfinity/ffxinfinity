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

#ifndef _BASICPACKET_H
#define _BASICPACKET_H

#include "../../common/cbasetypes.h"

#include <stdio.h>
#include <string.h>

enum ENTITYUPDATE
{
	ENTITY_SPAWN,
    ENTITY_SHOW,
	ENTITY_UPDATE,
    ENTITY_HIDE,
	ENTITY_DESPAWN,
};

/************************************************************************
*																		*
*  Базовый пакет для всех пакетов										*
*  максимальный размер пакета 4+256 (0x82*2)							*
*																		*
************************************************************************/

class CBasicPacket
{
protected:

	uint8	type;
	uint8	size;
	uint16	code;
	uint8   data[256];

public:

	uint8	getSize();
	uint8	getType();
	void	setCode(uint16);

	CBasicPacket();
};

#endif
