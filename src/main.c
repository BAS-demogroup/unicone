// UniCone main
//
// This contains the main method that starts the game.

#include "chips.h"
#include "setup.h"
#include "gameloop.h"
#include "player.h"

void main() {
	setup();
	
	while (1) {
		// title screen
		// reset game
		
		player_lives = 3;

		do {
			reset_level();
			game_loop();
		} while (player_lives > 0);
		
		VIC2.BORDERCOL = 0;
		while (1);
	};
}
