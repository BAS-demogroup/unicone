/// \file	main.c
/// 
/// \brief	This file contains the entry point for Unicone.
///
/// The entry point for Unicone.  This is also where the very top level loop 
/// runs, first loading all the game data, then looping between the title 
/// screen, the in-game levels, and then the game over state, before returning
/// to the title screen.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.


#include "audio.h"
#include "chips.h"
#include "difficulty.h"
#include "dma.h"
#include "dma_jobs.h"
#include "gameoverloop.h"
#include "input.h"
#include "macros.h"
#include "setup.h"
#include "gameloop.h"
#include "player.h"
#include "titleloop.h"


/// \brief	This is the main entry point, and the top level loop, for the game.
///
/// This procedure is the main entry point for the game.  It first loads all of
/// the assets for the game, and then enters an infinite loop that cycles
/// between the display of the title screen, the main gameplay loop and level
/// advancement in the game, and the end game state, before returning back to
/// the title screen.
void main() {
	// load all of the assets off of disk and put them in the attic
	loader();

	while (1) {
		// show the title screen
		title_setup();

		level = 17;
		// loop waiting for the player to start the game
		title_loop();
		
		// stop all the music voices so we can change tunes without noticable
		// audio artifacts audible to the user.
		stop_all_SID_voices();
		
		// reset the game
		player_lives = 3;
		last_level = 0;
		
		// load the assets for the ingame loop, and configure the registers
		ingame_setup();

		do {
			// configure the various difficulty settings
			set_level_difficulty();

			// reset all of the global variables used in-game.  these are all
			// variables that need to be reset every time the level is 
			// refreshed or advanced.
			reset_level();
			
			// start the inner game loop
			game_loop();
			
			// advance to the next level (the inner loop can exit for multiple
			// reasons, so we can't just assume the level advanced)
			last_level = level;
			if (next_level) {
				if (++level > 24) {
					level = 24;
				}
			}
			
			// and all samples
			stop_all_samples();
		
			// reload bank 3
			run_dma_job((__far char *)&load_ingame_banks[4]);
		// continue to run the in-game loop until the player runs out of lives
		} while (player_lives > 0);
		
		// again, stop all sid sounds
		stop_all_SID_voices();
			
		// and all samples
		stop_all_samples();
		
		// load the assets to do the game over.
		gameover_setup();
		
		// run the game over loop
		gameover_loop();
	};
}
