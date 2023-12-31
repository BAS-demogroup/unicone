/// \file	player.c
/// 
/// \brief	This file contains the code and variables for managing the player 
///			state
///
/// This C file contains the code and variables for that are used to manage the 
/// cone and the stack of ice cream on top
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "player.h"


#include <stdlib.h>


#include "chips.h"
#include "icecream.h"
#include "input.h"


/// \brief	This procedure manages the player state
///
/// This procedure manages the state of the player and the ice cream stack on
/// top of the cone, including calculating the swing of the stack.
void update_player() {
	for (char i = stack_size; i > 0; i--) {
		stack_x[i] = stack_x[i - 1];
	}
	
	stack_x[0] = player_x;

	if (falling_icecream_state < 2 && falling_stacked_state < 2) {
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
				} else if (icecream_swing > acceleration) {
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
char		dollops        = 0;
char        next_level     = 0;

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
