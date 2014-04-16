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

#include "../common/showmsg.h"

#include "guildutils.h"
#include "time_server.h"
#include "transport.h"
#include "vana_time.h"
#include "zoneutils.h"
#include "conquest_system.h"
#include "lua/luautils.h"


int32 time_server(uint32 tick,CTaskMgr::CTask* PTask)
{
	TIMETYPE VanadielTOTD = CVanaTime::getInstance()->SyncTime();

	if (CVanaTime::getInstance()->getHour() % 4 == 0 && CVanaTime::getInstance()->getMinute() == 30)
	{
		zoneutils::UpdateWeather();
	}

	if (CVanaTime::getInstance()->getMinute() == 0)
	{
		luautils::OnGameHourAutomatisation();
	}

    if (VanadielTOTD != TIME_NONE)
	{
		zoneutils::TOTDCharnge(VanadielTOTD);

        if (VanadielTOTD == TIME_MIDNIGHT)
        {
            guildutils::UpdateGuildsStock();
			luautils::OnGameDayAutomatisation();
			conquest::UpdateConquestSystem();

            // weekly update for conquest (monday at midnight)
	        if (CVanaTime::getInstance()->getSysWeekDay() == 1)
	        {
		        conquest::UpdateWeekConquest();
	        }
        }
	}

	CTransportHandler::getInstance()->TransportTimer();
	return 0;
}