#ifndef __MAPS_H
#define __MAPS_H


#include "rrb.h"


#define TILE_MAP 0x8000
#define ATTR_MAP 0xa000


// unicorn tiles
extern RRB_TILE_GOTOX_t  *unicorn_position[5];
extern RRB_TILE_NORMAL_t *unicorn_tiles[2][5];

extern RRB_TILE_GOTOX_t  *tail_position[4];
extern RRB_TILE_NORMAL_t *tail_tiles[4];

extern RRB_TILE_GOTOX_t  *mane_position[3];
extern RRB_TILE_NORMAL_t *mane_tiles[3];


// cone tiles
extern RRB_TILE_GOTOX_t  *cone_shadow_position[6];
extern RRB_TILE_NORMAL_t *cone_shadow_tiles[2][6];

extern RRB_TILE_GOTOX_t  *cone_position[6];
extern RRB_TILE_NORMAL_t *cone_tiles[2][6];

// ice cream tiles
extern RRB_TILE_GOTOX_t  *icecream_shadow_position[2][38];
extern RRB_TILE_NORMAL_t *icecream_shadow_tiles[2][2][38];

extern RRB_TILE_GOTOX_t  *small_icecream_shadow_position[2][38];
extern RRB_TILE_NORMAL_t *small_icecream_shadow_tiles[2][38];

extern RRB_TILE_GOTOX_t  *effect_shadow_position[2][38];
extern RRB_TILE_NORMAL_t *effect_shadow_tiles[2][38];

extern RRB_TILE_GOTOX_t  *icecream_position[2][38];
extern RRB_TILE_NORMAL_t *icecream_tiles[2][2][38];

extern RRB_TILE_GOTOX_t  *small_icecream_position[2][38];
extern RRB_TILE_NORMAL_t *small_icecream_tiles[2][38];

extern RRB_TILE_GOTOX_t  *effect_position[2][38];
extern RRB_TILE_NORMAL_t *effect_tiles[2][38];

#endif
