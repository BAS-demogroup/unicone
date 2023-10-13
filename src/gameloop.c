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
		
		// bank the tile and attribute maps from $ff80000 into $8000-$bfff
		// since the source if $ff80000, this means it's an extended MAP
		__asm(" lda #0xff\n"
			  " ldx #0x0f\n"
			  " ldy #0x00\n"
			  " ldz #0x00\n"
			  " map\n"
			  " lda #0x00\n"
			  " tax\n"
			  " ldy #0x80\n"
			  " ldz #0x37\n"
			  " map\n"
			  " nop");
			  
		// bank the music from $10000 into $4000-$bfff
		// this also resets the MB mapping from above.
		__asm(" lda #0x00\n"
			  " ldx #0x0f\n"
			  " tay\n"
			  " taz\n"
			  " map\n"
			  " lda #0xc0\n"
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
