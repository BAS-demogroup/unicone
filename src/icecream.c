#include "icecream.h"


#include <stdlib.h>


#include "player.h"


char _stack_top = 224;
// char _delay = 10;
void update_falling_icecream() {
	if (!falling_icecream_state) return;
	// if (--_delay > 0) return;
	// _delay = 10;
	
	switch (falling_icecream_state) {
		case 0:
			return;
		case 1:
			// 224 = top of large cone - if it passes that, then the ice cream 
			// has either been caught, if it's close enough to the cone, or 
			// the player has lost a life
			if (falling_icecream_y < _stack_top) {
				++falling_icecream_y;
			} else {
				// determine if the player caught the ice cream
				// experiment with whether 24 is a reasonable distance or not
				if (abs(falling_icecream_x - player_x) < 24) {
					// catch the ice cream and add it to the cone
					for (char i = 0; i < 3; i++) {
						stack_offsets[stack_size + i] = falling_icecream_x - 
							player_x;
					}
					stack_size += 3;
					_stack_top -= 24;
					
					falling_icecream_state = 0;
				} else {
					// if not, then do some failure thing.
					falling_icecream_state = 2;
				}
			}
			if (falling_icecream_state > _stack_top) {
				falling_icecream_state = _stack_top;
			}
			return;
		case 2:
			if (falling_icecream_y < 248) {
				falling_icecream_y += 3;
			} else {
				// done doing failure state
				falling_icecream_y = 248;
			}
			
			return;
	}
}

unsigned short falling_icecream_x = 304;
unsigned short falling_icecream_y = 0;
char falling_icecream_state = 0;
