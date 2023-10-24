// UniCone main
//
// This contains the main method that starts the game.

#include "chips.h"
#include "difficulty.h"
#include "setup.h"
#include "gameloop.h"
#include "player.h"

void main() {
	setup();
	
	while (1) {
		// title screen
		// reset game
		
		player_lives = 3;
		level = 1;

		do {
			// the graphics will scale smaller as the level increases, because
			// we can only fit about 10 ice cream stacks on the screen at the
			// initial resolution.  The graphics are already drawn, and my guess
			// is that the first scale change should happen after level 6.
			set_level_difficulty();

			reset_level();
			
			game_loop();
			
			if (next_level) {
				++level;
			}	
		} while (player_lives > 0);
		
		// this is just for now, once we have a title screen, then rip this out.
		VIC2.BORDERCOL = 0;
		while (1);
	};
}
