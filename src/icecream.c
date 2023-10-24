#include "icecream.h"


#include <stdlib.h>


#include "chips.h"
#include "difficulty.h"
#include "gameloop.h"
#include "player.h"
#include "pixies.h"
#include "maps.h"


void update_falling_icecream() {
	if (falling_stacked_state == 2) {
		if (falling_stacked_y < 248) {
			falling_stacked_y += 3;
		} else {
			// done doing failure state
			player_dying = 1;
			--player_lives;
			falling_stacked_y = 248;
			falling_stacked_state = 3;
		}
	}
	
	switch (falling_icecream_state) {
		case 0:
			return;
		case 1:
			// stack_top = top of cone - if it passes that, then the ice cream 
			// has either been caught, if it's close enough to the cone, or 
			// the player has lost a life
			if (falling_icecream_y < stack_top) {
				++falling_icecream_y;
			} else {
				short top_pos = player_x;
				if (stack_size) {
					
					top_pos = stack_x[stack_size - 1] +
						stack_offsets[stack_size - 1];
						
				}
					
				// determine if the player caught the ice cream
				if (abs(falling_icecream_x - top_pos) < lose_distance) {
					// catch the ice cream and add it to the cone
					for (char i = 0; i < 3; i++) {
						
						stack_offsets[stack_size + i] = falling_icecream_x 
							- player_x;
							
					}
					stack_size += 3;
					++dollops;
					stack_top -= (icecream_bottom_y_add << 1) + 
						icecream_bottom_y_add;
					stack_render_top = falling_icecream_y;
					
					if (dollops < level) {
						falling_icecream_state = 0;
					} else {
						falling_icecream_state = 3;
						next_level = 1;
					}
				} else {
					// if not, then do some failure thing.
					falling_icecream_state = 2;
				}
			}
			return;
		case 2:
			if (falling_icecream_y < 248) {
				falling_icecream_y += 3;
			} else {
				// done doing failure state
				if (!player_dying) {
					--player_lives;
				}
				player_dying = 1;
				falling_icecream_y = 248;
				falling_icecream_state = 3;
			}
			
			return;
	}
}

void clear_falling_icecream() {
	signed char max_layer = scale == 0 ? 3 : 5;
	
	unsigned short y_adj = falling_icecream_y;
	
	char yoff = y_adj >> 3;
	
	for (char y = 0; y < 7; y++) {
		for (char layer = 0; layer < max_layer; layer++) {
			set_icecream_pos(layer, 0x280, y + yoff, 0);
		}
	}
}

unsigned short falling_icecream_y     = 0;
char           falling_icecream_state = 0;

unsigned short falling_stacked_x      = 0;
unsigned short falling_stacked_y      = 0;
char           falling_stacked_state  = 0;

unsigned short stack_top              = 224;
unsigned short stack_render_top       = 224;

unsigned short falling_icecream_x     = 304;
