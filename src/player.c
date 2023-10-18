#include "player.h"


#include <stdlib.h>


#include "chips.h"
#include "icecream.h"
#include "input.h"


void update_player() {
	for (char i = stack_size; i > 0; i--) {
		if (i > 49) {
			VIC2.BORDERCOL = 5;
			while (1);
		}
		stack_x[i] = stack_x[i - 1];
	}
	stack_x[0] = player_x;

	if (falling_icecream_state < 2) {
		// left?
		if ((player_input & 0b00000100) && player_x > 1 ) {
			player_x -= acceleration;
			if (player_x < 1) {
				player_x = 1;
			}
			if (acceleration < 10) {
				++acceleration;
			}
			if (icecream_swing < 0) {
				++icecream_swing;
			} else {
				if (icecream_swing < acceleration) {
					++icecream_swing;
				} else if (icecream_swing < acceleration) {
					--icecream_swing;
				}
			}
			target_swing = -acceleration;
			return;
		} 
		
		// right?
		if ((player_input & 0b00001000) && player_x < 607) {
			player_x += acceleration;
			if (player_x > 607) {
				player_x = 607;
			}
			if (acceleration < 10) {
				++acceleration;
			}
			if (icecream_swing >= 0) {
				--icecream_swing;
			} else {
				if (icecream_swing < -acceleration) {
					++icecream_swing;
				} else if (icecream_swing > -acceleration) {
					--icecream_swing;
				}
			}
			target_swing = acceleration;
			return;
		}
	}
	
	if (icecream_swing < target_swing) {
		++icecream_swing;
	} else if (icecream_swing > target_swing) {
		--icecream_swing;
	} else if (target_swing != 0) {
		if (target_swing > 2) {
			--target_swing;
		} else if (target_swing < -2) {
			++target_swing;
		}
		if (target_swing > 1) {
			--target_swing;
		} else if (target_swing < -1) {
			++target_swing;
		}
		if (target_swing > 0) {
			--target_swing;
		} else if (target_swing < 0) {
			++target_swing;
		}
		target_swing = -target_swing;
	}
	
	acceleration = 1;
}

char        stack_size     = 0;
char        player_dying   = 0;
signed char icecream_swing = 0;
signed char target_swing   = 0;

char        acceleration   = 1;

char        player_lives   = 3;

short       player_x       = 304;

signed char stack_offsets[50] = {
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0
};

short stack_x[50] = {
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0
};
