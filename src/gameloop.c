#include "gameloop.h"


#include "chips.h"
#include "dma.h"
#include "dma_jobs.h"
#include "macros.h"


unsigned short matrix_raster;

void game_loop() {
	while (1) {
		while (VIC4.FNRASTERLSB != (matrix_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((matrix_raster & 0x0f00) >> 8));
		
		// clear the screen
		run_dma_job((__far char *)&clear_tilemap);
		run_dma_job((__far char *)&clear_attrmap);
		
		// bank the tile and attribute maps from $20000-$23fff into $8000-$bfff
		// since the source if $ff80000, this means it's an extended MAP
		__asm(" lda #0x00\n"
			  " tax\n"
			  " ldy #0x80\n"
			  " ldz #0x31\n"
			  " map\n"
			  " nop");
		
		// copy changed attribute map data out to $ff8 0000
		// at this time, I'm pretty sure the attribute map is completely 
		// static.
		//run_dma_job((__far char *)&pageflip_attrmap);
		
		// bank the music from $10000 into $4000-$bfff
		__asm(" lda #0xc0\n"
			  " tax\n"
			  " tay\n"
			  " ldz #0x30\n"
			  " map\n"
			  " nop");
			  
		musicPlay();
		
		// restore the original bank configuration
		__asm(" lda #0x00\n"
			  " tax\n"
			  " tay\n"
			  " taz\n"
			  " map\n"
			  " nop");

		while (VIC4.FNRASTERLSB == (matrix_raster & 0xff));
	};
}
