#include "gameoverloop.h"


#include "audio.h"
#include "chips.h"
#include "input.h"
#include "maps.h"
#include "setup.h"
#include "unicorn.h"


void gameover_loop() {
	unsigned short timer;
	unsigned short part_2;

	gameover_x_pos = 640;
	gameover_facing = 1;
	gameover_y_index = 0;

	// bank the tile map from $20000-$21fff into $a000-$bfff
	__asm(" lda #0x00\n"
		  " tax\n"
		  " ldy #0x80\n"
		  " ldz #0x31\n"
		  " map\n"
		  " nop");

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
		
		draw_gameover();
		
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
		
		if (--timer == part_2) {
			// play second game over sfx
			play_sample(game_over_sample_start[1], game_over_sample_end[1], 
				0);
		}
	};
	while ((player_input & 0b00010000) == 0) {
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
		
		process_input();
		draw_gameover();
		
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
	};
	while (player_input & 0b00010000) {
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
		
		process_input();
		draw_gameover();
		
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
	};
	// reset the bank
	__asm(" lda #0x00\n"
		  " tax\n"
		  " tay\n"
		  " taz\n"
		  " map\n"
		  " nop");

}

/// \brief	Animate the game over logo
void draw_gameover() {
	// the left of the first letter
	unsigned short logo_left = gameover_x_pos;
	char logo_sinus = gameover_y_index;
	// for each letter and the rows of that letter
	for (char x_tile = 0; x_tile < 9; x_tile++) {
		for (char y_tile = 0; y_tile < 4; y_tile++) {
			// move it across the screen
			gameover_logo_position[x_tile][y_tile]->XPOS = logo_left;
			// need to make it prance vertically like the unicorn
			gameover_logo_position[x_tile][y_tile]->YOFF = 
				vertical_sinus[logo_sinus];
		}
		
		// advance to the next letter's position
		logo_left += 16;
		logo_sinus += 16;
		while (logo_sinus >= 25) {
			logo_sinus -= 25;
		}
	}
	
	if (gameover_facing == 1 && gameover_x_pos > 0) {
		--gameover_x_pos;
	} else if (gameover_facing == 0 && gameover_x_pos < 496) {
		++gameover_x_pos;
	} else {
		gameover_facing = gameover_facing ? 0 : 1;
	}
	
	if((++gameover_y_index)==25) {
		gameover_y_index = 0;
	}
}

unsigned short gameover_x_pos;
char           gameover_facing;
char		   gameover_y_index;