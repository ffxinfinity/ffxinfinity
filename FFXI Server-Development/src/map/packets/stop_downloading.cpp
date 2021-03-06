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

#include "../../common/socket.h"

#include <string.h>

#include "stop_downloading.h"
#include "../charentity.h"

// действительное назначение пакета неизвестно, но без него перестают работать
// эмоции, некоторые сообщения действий монстров, некоторые стандартные сообщения,
// постоянно появляются пустые пакеты 0x3c. Название пакета выбрано случайным образом.
// очень похож на окончание таблицы меритов (0x81)
// ключевыми данными в данном случае является байт 0xF4

CStopDownloadingPacket::CStopDownloadingPacket(CCharEntity * PChar) 
{
	this->type = 0x41;
	this->size = 0x7c;

	uint8 packet[] = {
						    0x3a, 0x00, 0x00, 0x00, 0xc4, 0x09, 0x03, 0x00, 0xc6, 0x09, 0x03, 0x00,
	0x00, 0x0a, 0x03, 0x00, 0x02, 0x0a, 0x03, 0x00, 0x04, 0x0a, 0x03, 0x00, 0x06, 0x0a, 0x03, 0x00,
	0x40, 0x0a, 0x03, 0x00, 0x42, 0x0a, 0x03, 0x00, 0x44, 0x0a, 0x03, 0x00, 0x46, 0x0a, 0x03, 0x00,
	0x80, 0x0a, 0x03, 0x00, 0x82, 0x0a, 0x03, 0x00, 0x84, 0x0a, 0x03, 0x00, 0x86, 0x0a, 0x03, 0x00,
	0xc0, 0x0a, 0x03, 0x00, 0xc2, 0x0a, 0x03, 0x00, 0xc4, 0x0a, 0x03, 0x00, 0xc6, 0x0a, 0x03, 0x00,
	0x00, 0x0b, 0x03, 0x00, 0x02, 0x0b, 0x03, 0x00, 0x04, 0x0b, 0x03, 0x00, 0x06, 0x0b, 0x03, 0x00,
	0x08, 0x0b, 0x03, 0x00, 0x0a, 0x0b, 0x03, 0x00, 0x0c, 0x0b, 0x03, 0x00, 0x0e, 0x0b, 0x03, 0x00,
	0x40, 0x0b, 0x03, 0x00, 0x42, 0x0b, 0x03, 0x00, 0x44, 0x0b, 0x03, 0x00, 0x46, 0x0b, 0x03, 0x00,
	0x80, 0x0b, 0x03, 0x00, 0x82, 0x0b, 0x03, 0x00, 0x84, 0x0b, 0x03, 0x00, 0x86, 0x0b, 0x03, 0x00,
	0x88, 0x0b, 0x03, 0x00, 0x8a, 0x0b, 0x03, 0x00, 0xc0, 0x0b, 0x03, 0x00, 0xc2, 0x0b, 0x03, 0x00,
	0xc4, 0x0b, 0x03, 0x00, 0xc6, 0x0b, 0x03, 0x00, 0x00, 0x0c, 0x03, 0x00, 0x02, 0x0c, 0x03, 0x00,
	0x04, 0x0c, 0x03, 0x00, 0x06, 0x0c, 0x03, 0x00, 0x40, 0x0c, 0x03, 0x00, 0x42, 0x0c, 0x03, 0x00,
	0x44, 0x0c, 0x03, 0x00, 0x46, 0x0c, 0x03, 0x00, 0x80, 0x0c, 0x03, 0x00, 0x82, 0x0c, 0x03, 0x00,
	0x84, 0x0c, 0x03, 0x00, 0x86, 0x0c, 0x03, 0x00, 0xc0, 0x0c, 0x03, 0x00, 0xc2, 0x0c, 0x03, 0x00,
	0xc4, 0x0c, 0x03, 0x00, 0xc6, 0x0c, 0x03, 0x00, 0xc8, 0x0c, 0x03, 0x00, 0xca, 0x0c, 0x03, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00};

	memcpy(data,packet,244);
}
