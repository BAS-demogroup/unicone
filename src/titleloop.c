#include "titleloop.h"


#include "chips.h"
#include "input.h"
#include "macros.h"
#include "rng.h"
#include "setup.h"


void title_loop() {
	while (!(player_input & 0b00010000)) {
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
	
		process_input();
		musicPlay();
		
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

		random();
		
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
	}
}
