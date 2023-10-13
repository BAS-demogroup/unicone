#include "gameloop.h"


#include "chips.h"
#include "dma.h"
#include "dma_jobs.h"
#include "macros.h"
#include "maps.h"
#include "pixies.h"


unsigned short matrix_raster;

void game_loop() {
	while (1) {
		while (VIC4.FNRASTERLSB != (matrix_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((matrix_raster & 0x0f00) >> 8));
		
		VIC2.BORDERCOL = 0;
		VIC2.SCREENCOL = 0;
		
		// clear the screen
		run_dma_job((__far char *)&clear_tilemap);
		
		// bank the tile and attribute maps from $20000-$21fff into $a000-$bfff
		__asm(" lda #0x00\n"
			  " tax\n"
			  " ldy #0x60\n"
			  " ldz #0x31\n"
			  " map\n"
			  " nop");

		VIC2.BORDERCOL = 5;
		VIC2.SCREENCOL = 5;
		
		// draw the screen in vertical order, so unicorn first, then falling 
		// ice cream, then ice cream stack, then cone
		
		draw_cone();
		
		VIC2.BORDERCOL = 11;
		VIC2.SCREENCOL = 11;
		
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
		
		VIC2.BORDERCOL = 15;
		VIC2.SCREENCOL = 15;
	};
}

void draw_cone() {
	for (char y = 0; y < 6; y++) {
		cone_shadow_position[y]->XPOS = 304;
		cone_position[y]->XPOS = 304;
		
		for (char x = 0; x < 2; x++) {
			cone_shadow_tiles[x][y]->TILE = large_cone_pixie_tiles[1][x][y];
			cone_tiles[x][y]->TILE = large_cone_pixie_tiles[0][x][y];
		}
	}
}
