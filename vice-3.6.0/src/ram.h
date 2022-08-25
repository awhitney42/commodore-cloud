/*
 * ram.h - RAM stuff.
 *
 * Written by
 *  Andreas Matthies <andreas.matthies@gmx.net>
 *
 * This file is part of VICE, the Versatile Commodore Emulator.
 * See README for copyright notice.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
 *  02111-1307  USA.
 *
 */

#ifndef VICE_RAM_H
#define VICE_RAM_H

#include "types.h"

typedef struct _RAMINITPARAM {
    int start_value;
    int value_invert;
    int value_offset;

    int pattern_invert;
    int pattern_invert_value;

    int random_start;
    int random_repeat;
    int random_chance;
} RAMINITPARAM;

extern int ram_resources_init(void);
extern int ram_cmdline_options_init(void);

extern void ram_init(uint8_t *memram, unsigned int ramsize);
extern void ram_init_with_pattern(uint8_t *memram, unsigned int ramsize, RAMINITPARAM *ramparam);
extern void ram_init_print_pattern(char *s, int len, char *eol);

#endif