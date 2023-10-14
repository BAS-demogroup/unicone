#include "gameloop.h"


#include "chips.h"
#include "dma.h"
#include "dma_jobs.h"
#include "input.h"
#include "macros.h"
#include "maps.h"
#include "pixies.h"
#include "player.h"
#include "unicorn.h"


unsigned short matrix_raster;

void game_loop() {
	while (1) {
		while (VIC4.FNRASTERLSB != (matrix_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((matrix_raster & 0x0f00) >> 8));
		
		VIC2.BORDERCOL = 0;
		// VIC2.SCREENCOL = 0;
		
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
		// VIC2.SCREENCOL = 5;
		
		update_unicorn();
		
		process_input();
		update_player();
		
		// draw the screen in vertical order, so unicorn first, then falling 
		// ice cream, then ice cream stack, then cone
		
		draw_unicorn();
		draw_cone();
		
		VIC2.BORDERCOL = 11;
		// VIC2.SCREENCOL = 11;
		
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
		// VIC2.SCREENCOL = 15;
	};
}

void draw_unicorn() {
	for (char y = 0; y < 5; y++) {
		unicorn_position[y]->XPOS = unicorn_x;
		unicorn_position[y]->YOFF = unicorn_y;
		
		char _frame = unicorn_frame_lookup[unicorn_frame_index];
		unicorn_tiles[0][y]->TILE = unicorn_pixie_tiles[_frame][unicorn_facing ? 2 : 0][y];
		unicorn_tiles[1][y]->TILE = unicorn_pixie_tiles[_frame][unicorn_facing ? 0 : 2][y];
		
		unicorn_attr[0][y]->HFLIP = unicorn_facing;
		unicorn_attr[1][y]->HFLIP = unicorn_facing;
		
		if (y < 4) {
			tail_position[y]->XPOS = unicorn_x + (unicorn_facing ? 16 : 0);
			tail_position[y]->YOFF = unicorn_y;
			
			tail_tiles[y]->TILE = tail_pixie_tiles[0][_frame][y];
			tail_attr[y]->HFLIP = unicorn_facing;
		}
		
		if (y < 3) {
			mane_position[y]->XPOS = unicorn_x + (unicorn_facing ? 0 : 16);
			mane_position[y]->YOFF = unicorn_y;
			
			mane_tiles[y]->TILE = mane_pixie_tiles[_frame][y];
			mane_attr[y]->HFLIP = unicorn_facing;
		}
	}
}

void draw_cone() {
	for (char y = 0; y < 6; y++) {
		cone_shadow_position[y]->XPOS = player_x;
		cone_position[y]->XPOS = player_x;
		
		for (char x = 0; x < 2; x++) {
			cone_shadow_tiles[x][y]->TILE = large_cone_pixie_tiles[1][x][y];
			cone_tiles[x][y]->TILE = large_cone_pixie_tiles[0][x][y];
		}
	}
}
