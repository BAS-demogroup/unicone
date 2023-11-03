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
#include "titleloop.h"


void main() {
	run_loader();

	while (1) {
		// title screen
		title_setup();
		// need a title loop
		title_loop();
		
		SID1.CONTROL_1    = 0x00;
		SID1.CONTROL_2    = 0x00;
		SID1.CONTROL_3    = 0x00;
		SID2.CONTROL_1    = 0x00;
		SID2.CONTROL_2    = 0x00;
		SID2.CONTROL_3    = 0x00;
		SID3.CONTROL_1    = 0x00;
		SID3.CONTROL_2    = 0x00;
		SID3.CONTROL_3    = 0x00;
		SID4.CONTROL_1    = 0x00;
		SID4.CONTROL_2    = 0x00;
		SID4.CONTROL_3    = 0x00;
		
		// reset game
		player_lives = 3;
		level = 1;
		
		// switch to ingame mode
		ingame_setup();
		
		do {
			set_level_difficulty();

			reset_level();
			
			game_loop();
			
			if (next_level) {
				++level;
			}	
		} while (player_lives > 0);
		
		SID1.CONTROL_1    = 0x00;
		SID1.CONTROL_2    = 0x00;
		SID1.CONTROL_3    = 0x00;
		SID2.CONTROL_1    = 0x00;
		SID2.CONTROL_2    = 0x00;
		SID2.CONTROL_3    = 0x00;
		SID3.CONTROL_1    = 0x00;
		SID3.CONTROL_2    = 0x00;
		SID3.CONTROL_3    = 0x00;
		SID4.CONTROL_1    = 0x00;
		SID4.CONTROL_2    = 0x00;
		SID4.CONTROL_3    = 0x00;
				
		gameover_setup();
		
		unsigned short timer;
		unsigned short part_2;

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
	};
}
