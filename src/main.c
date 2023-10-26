// UniCone main
//
// This contains the main method that starts the game.


#include "audio.h"
#include "chips.h"
#include "difficulty.h"
#include "dma.h"
#include "dma_jobs.h"
#include "macros.h"
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
	
		// initalize the music
		musicInit();

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
		
		SID1.VOLUME_FTYPE = 0x60;
		SID2.VOLUME_FTYPE = 0x60;
		SID3.VOLUME_FTYPE = 0x20;
		SID4.VOLUME_FTYPE = 0x30;
		
		unsigned short timer;
		unsigned short part_2;

		// load the game over banks
		if (current_loaded_state != 1) {
			run_dma_job((__far char *)&load_game_over_samples_1);
			run_dma_job((__far char *)&load_game_over_samples_2);
			
			current_loaded_state = 1;
		}
		
		// second part starts = 1.255s
		// full length = 5.137s
		
		// pal - full length = 257 frames
		// pal - second part starts = 63 frames
		if (!VIC4.PALNTSC) {
			timer = 257;
			part_2 = 194;
		// ntsc - full length = 308 frames
		// ntsc - second part starts = 75 frames
		} else {
			timer = 308;
			part_2 = 233;
		}		
		
		// play first game over sfx
		play_sample(game_over_sample_start[0], game_over_sample_end[0], 1);

		while (timer > 0) {
			while (VIC4.FNRASTERLSB != (matrix_raster & 0xff) || 
				VIC4.FNRASTERMSB != ((matrix_raster & 0x0f00) >> 8));
				
			while (VIC4.FNRASTERLSB == (matrix_raster & 0xff));
			
			if (--timer == part_2) {
				// play second game over sfx
				play_sample(game_over_sample_start[1], game_over_sample_end[1], 
					0);
			}
		}
		// this is just for now, once we have a title screen, then rip this out.
		VIC2.BORDERCOL = 0;
		while (1);
	};
}
