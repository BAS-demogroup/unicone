/// \file	titleloop.c
/// 
/// \brief	This file the code for the title loop
///
/// This header file contains the code for the title loop.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "titleloop.h"


#include "chips.h"
#include "input.h"
#include "macros.h"
#include "rng.h"
#include "setup.h"


/// \brief	This procedure is the title screen loop
///
/// This procedure handles the title screen loop, processing player input until
/// the player presses a fire button, playing the title screen music in the
/// meantime.
void title_loop() {
	// loop until the player has pressed fire
	while (!(player_input & 0b00010000)) {
		// what for the raster to reach the lower border
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
	
		// process the player's input
		process_input();
		// play the music
		musicPlay();
		
		// if the music is supposed to be muted, then we need to re-execute 
		// that here so that the mute persists between title screen and 
		// in-game.
		if (!muted) {
			SID1.VOLUME_FTYPE = 0x3f;
			SID2.VOLUME_FTYPE = 0x74;
			SID3.VOLUME_FTYPE = 0x7f;
			SID4.VOLUME_FTYPE = 0x2f;
		} else {
			SID1.VOLUME_FTYPE = 0x30;
			SID2.VOLUME_FTYPE = 0x70;
			SID3.VOLUME_FTYPE = 0x70;
			SID4.VOLUME_FTYPE = 0x20;
		}

		// we call the random procedure every frame of the title screen to make
		// sure the randomness is as good as can be when the player gets in
		// game, since we're using a pseudo-RNG instead of the built-in random
		// registers.
		random();
		
		// this all should have happened very quickly, so make sure that we are
		// not still on the same raster line to avoid bad timing.
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
	}
}
