#include "gameoverloop.h"


#include "audio.h"
#include "chips.h"
#include "setup.h"


void gameover_loop() {
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
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
			
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
		
		if (--timer == part_2) {
			// play second game over sfx
			play_sample(game_over_sample_start[1], game_over_sample_end[1], 
				0);
		}
	}
}
