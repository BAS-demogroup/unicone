#ifndef __MAPS_H
#define __MAPS_H


#include "rrb.h"


#define TILE_MAP 0x8000
#define ATTR_MAP 0xff80000


// unicorn tiles
extern       RRB_TILE_GOTOX_t  *unicorn_position[5];
extern       RRB_TILE_NORMAL_t *unicorn_tiles[2][5];
extern __far RRB_ATTR_NORMAL_t *unicorn_attr[2][5];

extern       RRB_TILE_GOTOX_t  *tail_position[4];
extern       RRB_TILE_NORMAL_t *tail_tiles[4];
extern __far RRB_ATTR_NORMAL_t *tail_attr[4];

extern       RRB_TILE_GOTOX_t  *mane_position[3];
extern       RRB_TILE_NORMAL_t *mane_tiles[3];
extern __far RRB_ATTR_NORMAL_t *mane_attr[3];


// cone tiles
extern       RRB_TILE_GOTOX_t  *cone_shadow_position[6];
extern       RRB_TILE_NORMAL_t *cone_shadow_tiles[2][6];
	         
extern       RRB_TILE_GOTOX_t  *cone_position[6];
extern       RRB_TILE_NORMAL_t *cone_tiles[2][6];


// ice cream tiles
extern       RRB_TILE_GOTOX_t  *stacked_icecream_shadow_position[3][38];
extern       RRB_TILE_NORMAL_t *stacked_icecream_shadow_tiles[3][2][38];
	         
extern       RRB_TILE_GOTOX_t  *small_stacked_shadow_position[3][38];
extern       RRB_TILE_NORMAL_t *small_stacked_shadow_tiles[3][38];
	         
extern       RRB_TILE_GOTOX_t  *falling_icecream_shadow_position[3][38];
extern       RRB_TILE_NORMAL_t *falling_icecream_shadow_tiles[3][2][38];
	         
extern       RRB_TILE_GOTOX_t  *small_icecream_shadow_position[2][38];
extern       RRB_TILE_NORMAL_t *small_icecream_shadow_tiles[2][38];
	         
extern       RRB_TILE_GOTOX_t  *effect_shadow_position[38];
extern       RRB_TILE_NORMAL_t *effect_shadow_tiles[38];
	         
extern       RRB_TILE_GOTOX_t  *stacked_icecream_position[3][38];
extern       RRB_TILE_NORMAL_t *stacked_icecream_tiles[3][2][38];
	         
extern       RRB_TILE_GOTOX_t  *small_stacked_position[3][38];
extern       RRB_TILE_NORMAL_t *small_stacked_tiles[3][38];
	         
extern       RRB_TILE_GOTOX_t  *falling_icecream_position[3][38];
extern       RRB_TILE_NORMAL_t *falling_icecream_tiles[3][2][38];
	         
extern       RRB_TILE_GOTOX_t  *small_icecream_position[2][38];
extern       RRB_TILE_NORMAL_t *small_icecream_tiles[2][38];
	         
extern       RRB_TILE_GOTOX_t  *effect_position[38];
extern       RRB_TILE_NORMAL_t *effect_tiles[38];

// stats tiles
extern       RRB_TILE_GOTOX_t  *lives_shadow_position[3][2];
extern       RRB_TILE_GOTOX_t  *lives_position[3][2];

extern		 RRB_TILE_GOTOX_t  *level_number_position[2][5];
extern       RRB_TILE_NORMAL_t *level_number_tiles[2][2][5];

extern		 RRB_TILE_GOTOX_t  *gameover_logo_position[9][4];

#endif
