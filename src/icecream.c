#include "icecream.h"


#include <stdlib.h>


#include "player.h"
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
			// 224 = top of large cone - if it passes that, then the ice cream 
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
				// experiment with whether 24 is a reasonable distance or not
				if (abs(falling_icecream_x - top_pos) < 24) {
					// clear the falling cone
					clear_falling_icecream();
					// catch the ice cream and add it to the cone
					for (char i = 0; i < 3; i++) {
						
						stack_offsets[stack_size + i] = falling_icecream_x 
							- player_x;
							
					}
					stack_size += 3;
					stack_top -= 24;
					
					falling_icecream_state = 0;
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
	char yoff = falling_icecream_y >> 3;
	
	for (char y = 0; y < 5; y++) {
		falling_icecream_shadow_position[0][y + yoff]->XPOS = 0x280;
		falling_icecream_position[0][y + yoff]->XPOS = 0x280;
	}
	
	for (char ribbon = 0; ribbon < 2; ribbon++) {
		for (char y = 0; y < 3; y++) {
			
			falling_icecream_shadow_position[2 - y][3 + ribbon + y + yoff]->
				XPOS = 0x280;
				
			falling_icecream_position[2 - y][3 + ribbon + y + yoff]->XPOS = 
				0x280;
				
		}
	}
}

unsigned short falling_icecream_y     = 0;
char           falling_icecream_state = 0;

unsigned short falling_stacked_x      = 0;
unsigned short falling_stacked_y      = 0;
char           falling_stacked_state  = 0;

char           stack_top              = 224;

unsigned short falling_icecream_x     = 304;
