#include "player.h"


#include "icecream.h"
#include "input.h"


void update_player() {
	if (falling_icecream_state != 2) {
		// left?
		if ((player_input & 0b00000100) && player_x > 1 ) {
			player_x -= acceleration;
			if (player_x < 1) {
				player_x = 1;
			}
			if (acceleration < 16) {
				++acceleration;
			}
			return;
		} 
		
		// right?
		if ((player_input & 0b00001000) && player_x < 607) {
			player_x += acceleration;
			if (player_x > 607) {
				player_x = 607;
			}
			if (acceleration < 16) {
				++acceleration;
			}
			return;
		}
	}
	
	acceleration = 1;
}

short player_x = 304;
char stack_size = 0;
char acceleration = 1;

signed char stack_offsets[50] = {
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0
};