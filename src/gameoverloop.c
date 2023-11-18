/// \file	gameoverloop.h
/// 
/// \brief	This file contains the code for the loop at the end of the game
///
/// This file contains the code and variables for the game over loop of the 
/// game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "gameoverloop.h"


#include "audio.h"
#include "chips.h"
#include "input.h"
#include "maps.h"
#include "setup.h"
#include "unicorn.h"


/// \brief	This is the loop for the game over state
///
/// This is the loop for the game over state.  It plays the game over sound
/// effects, as well as causing the game over text to dance across the top of
/// the screen.  It loops until the player has hit fire to dismiss it.
void gameover_loop() {
	// the total timer for how long the samples play
	unsigned short timer;
	// the time into the timer at which the second sample needs to be triggered
	unsigned short part_2;

	// the x position of the game over text
	gameover_x_pos = 640;
	// the starting facing of the game over text.  0 = right, 1 = left
	gameover_facing = 1;
	// The y position of the game over text.  8 pixels wide.
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

	// we first start with the loop for managing the sound effects playback
	while (timer > 0) {
		// simple raster loop
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
		
		// draw the game over text
		draw_gameover();
		
		// make sure we have used at least one scanline of rastertime
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
		
		// if the timer has hit part 2
		if (--timer == part_2) {
			// play second game over sfx
			play_sample(game_over_sample_start[1], game_over_sample_end[1], 
				0);
		}
	};
	// now, loop until the player has hit fire in some way
	while ((player_input & 0b00010000) == 0) {
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
		
		// Process the input for this frame
		process_input();
		// draw the game over text
		draw_gameover();
		
		// make sure a scanline has passed
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
	};
	// this is a hack - basically, wait for the player to RELEASE fire
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
	
	// if we're facing left and we're not at the left edge of the screen
	if (gameover_facing == 1 && gameover_x_pos > 0) {
		// keep moving the game over logo left
		--gameover_x_pos;
	} else if (gameover_facing == 0 && gameover_x_pos < 496) {
		// otherwise, if facing right and we're not at the right edge of the
		// screen, keep moving the logo right
		++gameover_x_pos;
	} else {
		// otherwise, swap the facing
		gameover_facing = gameover_facing ? 0 : 1;
	}
	
	// increment the sinus index used for looking up the vertical movement
	if((++gameover_y_index)==25) {
		gameover_y_index = 0;
	}
}

/// \brief	The current horizontal position of the game over logo
unsigned short gameover_x_pos;
/// \brief	The current facing of the game over logo
///
/// The current facing of the game over logo.  0 = right, 1 = left
char           gameover_facing;
/// \brief	The current index into the sinus used for bouncing the game over 
///			logo
char		   gameover_y_index;
