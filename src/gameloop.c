#include "gameloop.h"


#include "chips.h"
#include "dma.h"
#include "dma_jobs.h"
#include "icecream.h"
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
		
		update_unicorn();
		update_falling_icecream();

		process_input();
		update_player();
		
		// draw the screen in vertical order, so unicorn first, then falling 
		// ice cream, then ice cream stack, then cone
		
		VIC2.BORDERCOL = 11;
		
		draw_unicorn();
		
		VIC2.BORDERCOL = 14;
		
		draw_falling_icecream();

		VIC2.BORDERCOL = 4;
		
		draw_cone();
		
		VIC2.BORDERCOL = 10;
		
		musicPlay();

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
		unicorn_tiles[0][y]->TILE = unicorn_pixie_tiles[_frame][unicorn_facing ? 2 : unicorn_pooping][y];
		unicorn_tiles[1][y]->TILE = unicorn_pixie_tiles[_frame][unicorn_facing ? unicorn_pooping : 2][y];
		
		unicorn_attr[0][y]->HFLIP = unicorn_facing;
		unicorn_attr[1][y]->HFLIP = unicorn_facing;
		
		if (y < 4) {
			tail_position[y]->XPOS = unicorn_x + (unicorn_facing ? 16 : 0);
			tail_position[y]->YOFF = unicorn_y;
			
			tail_tiles[y]->TILE = tail_pixie_tiles[unicorn_pooping][_frame][y];
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

void draw_falling_icecream() {
	if (!falling_icecream_state) return;
	
	char yoff = falling_icecream_y >> 3;
	char ymod = ~(falling_icecream_y & 0x07);
	
	for (char y = 0; y < 5; y++) {
		icecream_shadow_position[0][y + yoff]->XPOS = falling_icecream_x;
		icecream_shadow_position[0][y + yoff]->YOFF = ymod;
		icecream_position[0][y + yoff]->XPOS = falling_icecream_x;
		icecream_position[0][y + yoff]->YOFF = ymod;
		
		for (char x = 0; x < 2; x++) {
			icecream_shadow_tiles[0][x][y + yoff]->TILE = large_icecream_top_pixie_tiles[1][x][y];
			icecream_tiles[0][x][y + yoff]->TILE = large_icecream_top_pixie_tiles[0][x][y];
		}
	}

	for (char ribbon = 0; ribbon < 2; ribbon++) {
		for (char y = 0; y < 3; y++) {
			icecream_shadow_position[2 - y][3 + ribbon + yoff + y]->XPOS = falling_icecream_x;
			icecream_shadow_position[2 - y][3 + ribbon + yoff + y]->YOFF = ymod;
			icecream_position[2 - y][3 + ribbon + yoff + y]->XPOS = falling_icecream_x;
			icecream_position[2 - y][3 + ribbon + yoff + y]->YOFF = ymod;
		
			for (char x = 0; x < 2; x++) {
				icecream_shadow_tiles[2 - y][x][3 + ribbon + yoff + y]->TILE = large_icecream_bottom_pixie_tiles[1][x][y];
				icecream_tiles[2 - y][x][3 + ribbon + yoff + y]->TILE = large_icecream_bottom_pixie_tiles[0][x][y];
			}
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
