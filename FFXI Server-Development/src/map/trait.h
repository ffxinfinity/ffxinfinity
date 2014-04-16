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

#ifndef _CTRAIT_H
#define _CTRAIT_H

#include "../common/cbasetypes.h"

#include <vector>

enum TRAITTYPE
{
    TRAIT_ACCURACY_BONUS     = 1,
    TRAIT_EVASION_BONUS      = 2,
    TRAIT_ATTACK_BONUS       = 3,
    TRAIT_DEFENSE_BONUS      = 4,
    TRAIT_MAGIC_ATK_BONUS    = 5,
    TRAIT_MAGIC_DEF_BONUS    = 6,
    TRAIT_MAX_HP_BOOST       = 7,
    TRAIT_MAX_MP_BOOST       = 8,
    TRAIT_AUTO_REGEN         = 9,
    TRAIT_AUTO_REFRESH       = 10,
    TRAIT_RAPID_SHOT         = 11,
    TRAIT_FAST_CAST          = 12,
    TRAIT_CONSERVE_MP        = 13,
    TRAIT_STORE_TP           = 14,
    TRAIT_DOUBLE_ATTACK      = 15,
    TRAIT_TRIPLE_ATTACK      = 16,
    TRAIT_COUNTER            = 17,
    TRAIT_DUAL_WIELD         = 18,
    TRAIT_TREASURE_HUNTER    = 19,
    TRAIT_GILFINDER          = 20,
    TRAIT_ALERTNESS          = 21,
    TRAIT_STEALTH            = 22,
    TRAIT_MARTIAL_ARTS       = 23,
    TRAIT_CLEAR_MIND         = 24,
    TRAIT_SHIELD_MASTERY     = 25,
    TRAIT_BEAST_KILLER       = 32,
    TRAIT_PLANTOID_KILLER    = 33,
    TRAIT_VERMIN_KILLER      = 34,
    TRAIT_LIZARD_KILLER      = 35,
    TRAIT_BIRD_KILLER        = 36,
    TRAIT_AMORPH_KILLER      = 37,
    TRAIT_AQUAN_KILLER       = 38,
    TRAIT_UNDEAD_KILLER      = 39,
    TRAIT_ARCANA_KILLER      = 41,
    TRAIT_DEMON_KILLER       = 42,
    TRAIT_DRAGON_KILLER      = 43,
    TRAIT_RESIST_SLEEP       = 48,
    TRAIT_RESIST_POISON      = 49,
    TRAIT_RESIST_PARALYZE    = 50,
    TRAIT_RESIST_BLIND       = 51,
    TRAIT_RESIST_SILENCE     = 52,
    TRAIT_RESIST_PETRIFY     = 53,
    TRAIT_RESIST_VIRUS       = 54,
    TRAIT_RESIST_CURSE       = 55,
    TRAIT_RESIST_STUN        = 56,
    TRAIT_RESIST_BIND        = 57,
    TRAIT_RESIST_GRAVITY     = 58,
    TRAIT_RESIST_SLOW        = 59,
    TRAIT_RESIST_CHARM       = 60,
    TRAIT_TREASURE_HUNTER_II = 64,
    TRAIT_GILFINDER_II       = 65,
    TRAIT_KICK_ATTACKS       = 66,
    TRAIT_SUBTLE_BLOW        = 67,
    TRAIT_ASSASSIN           = 68,
    TRAIT_DIVINE_VEIL        = 69,
    TRAIT_ZANSHIN            = 70,
    TRAIT_SAVAGERY           = 71,
    TRAIT_AGGRESSIVE_AIM     = 72,
    TRAIT_INVIGORATE         = 73,
    TRAIT_PENANCE            = 74,
    TRAIT_AURA_STEAL         = 75,
    TRAIT_AMBUSH             = 76,
    TRAIT_IRON_WILL          = 77,
    TRAIT_GUARDIAN           = 78,
    TRAIT_MUTED_SOUL         = 79,
    TRAIT_DESPERATE_BLOWS    = 80,
    TRAIT_BEAST_AFFINITY     = 81,
    TRAIT_BEAST_HEALER       = 82,
    TRAIT_SNAPSHOT           = 83,
    TRAIT_RECYCLE            = 84,
    TRAIT_IKISHOTEN          = 85,
    TRAIT_OVERWHELM          = 86,
    TRAIT_NINJA_TOOL_EXPERT  = 87,
    TRAIT_EMPATHY            = 88,
    TRAIT_STRAFE             = 89,
    TRAIT_ENCHAINMENT        = 90,
    TRAIT_ASSIMILATION       = 91,
    TRAIT_WINNING_STREAK     = 92,
    TRAIT_LOADED_DECK        = 93,
    TRAIT_FINE_TUNING        = 94,
    TRAIT_OPTIMIZATION       = 95,
    TRAIT_CLOSED_POSITION    = 96,
    TRAIT_STORMSURGE         = 97,
};

#define MAX_TRAIT_ID    100

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

class CTrait
{
public:

    CTrait(uint8 id);

    uint8   getID();
    uint8   getJob();
    uint8   getLevel();
    uint16  getMod();
    int16   getValue();

    void    setJob(int8 job);
    void    setLevel(uint8 level);
    void    setMod(uint16 mod);
    void    setValue(int16 value);

private:

    uint8   m_id;
    uint8   m_job;
    uint8   m_level;
    uint16  m_mod;
    int16   m_value;
};

/************************************************************************
*                                                                       *
*  namespase для работы с traits                                        *
*                                                                       *
************************************************************************/

typedef std::vector<CTrait*> TraitList_t;

namespace traits
{
    void LoadTraitsList();

    TraitList_t* GetTraits(uint8 JobID);
};

#endif