#include "titleloop.h"


#include "chips.h"
#include "gameloop.h"
#include "input.h"
#include "macros.h"
#include "rng.h"


void title_loop() {
	while (!(player_input & 0b00010000)) {
		while (VIC4.FNRASTERLSB != (matrix_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((matrix_raster & 0x0f00) >> 8));
	
		VIC2.DEN = 1;
		
		process_input();
		musicPlay();
		random();
		
		while (VIC4.FNRASTERLSB == (matrix_raster & 0xff));
	}
}
