#include "gameloop.h"


#include <stdlib.h>


#include "chips.h"
#include "dma.h"
#include "dma_jobs.h"
#include "icecream.h"
#include "input.h"
#include "macros.h"
#include "maps.h"
#include "pixies.h"
#include "player.h"
#include "swing.h"
#include "unicorn.h"


unsigned short matrix_raster;

void game_loop() {
	while (lost_life_timer > 0) {
		while (VIC4.FNRASTERLSB != (matrix_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((matrix_raster & 0x0f00) >> 8));
		
		VIC2.BORDERCOL = 0;
		
		// clear the screen
		//run_dma_job((__far char *)&clear_tilemap);
		
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
		
		draw_icecream_stack();

		VIC2.BORDERCOL = 10;
		
		draw_cone();
		
		VIC2.BORDERCOL = 13;

		// this is only necessary when the music is disabled.
		// it's probably not necessary at all, but just to be on the safe side
		__asm(" lda #0x00\n"
			  " tax\n"
			  " tay\n"
			  " taz\n"
			  " map\n"
			  " nop");

		// musicPlay();

		while (VIC4.FNRASTERLSB == (matrix_raster & 0xff));
		
		VIC2.BORDERCOL = 15;
		// VIC2.SCREENCOL = 15;
		
		if (player_dying) {
			--lost_life_timer;
		}
	};
}

void draw_unicorn() {
	for (char y = 0; y < 5; y++) {
		unicorn_position[y]->XPOS = unicorn_x;
		unicorn_position[y]->YOFF = unicorn_y;
		
		char _frame = unicorn_frame_lookup[unicorn_frame_index];
		unicorn_tiles[0][y]->TILE = unicorn_pixie_tiles[_frame]
			[unicorn_facing ? 2 : unicorn_pooping][y];
		unicorn_tiles[1][y]->TILE = unicorn_pixie_tiles[_frame]
			[unicorn_facing ? unicorn_pooping : 2][y];
		
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

char _last_yoff = 0xff;
void draw_falling_icecream() {
	if (!falling_icecream_state) return;
	
	char yoff = falling_icecream_y >> 3;
	char ymod = (~(char)falling_icecream_y & 0x07);
	
	for (char y = 0; y < 5; y++) {
		falling_icecream_position[0][y + yoff]->YOFF = ymod;
		falling_icecream_shadow_position[0][y + yoff]->YOFF = ymod;

		if (_last_yoff != yoff) {
			falling_icecream_shadow_position[0][y + yoff]->XPOS = 
				falling_icecream_x;
			falling_icecream_position[0][y + yoff]->XPOS = falling_icecream_x;
			falling_icecream_shadow_position[1][y + yoff]->XPOS = 
				0x280;
			falling_icecream_position[1][y + yoff]->XPOS = 0x280;
			
			for (char x = 0; x < 2; x++) {
				falling_icecream_shadow_tiles[0][x][y + yoff]->TILE = 
					large_icecream_top_pixie_tiles[1][x][y];
				falling_icecream_tiles[0][x][y + yoff]->TILE = 
					large_icecream_top_pixie_tiles[0][x][y];
			}
		}
	}

	for (char ribbon = 0; ribbon < 2; ribbon++) {
		for (char y = 0; y < 3; y++) {
			falling_icecream_shadow_position[2 - y][3 + ribbon + yoff + y]->
				YOFF = ymod;
			falling_icecream_position[2 - y][3 + ribbon + yoff + y]->YOFF = 
				ymod;

			if (_last_yoff != yoff) {
				falling_icecream_shadow_position[2 - y][3 + ribbon + yoff + y]->
					XPOS = falling_icecream_x;
				falling_icecream_position[2 - y][3 + ribbon + yoff + y]->XPOS = 
					falling_icecream_x;
			
				for (char x = 0; x < 2; x++) {
					falling_icecream_shadow_tiles[2 - y][x][3 + ribbon + yoff + y]
						->TILE = large_icecream_bottom_pixie_tiles[1][x][y];
					falling_icecream_tiles[2 - y][x][3 + ribbon + yoff + y]->TILE =
						large_icecream_bottom_pixie_tiles[0][x][y];
				}
			}
		}
	}
	_last_yoff = yoff;
}

char _last_stack_size = 0;
void draw_icecream_stack() {
	if (stack_size == 0) return;
	
	char yoff = 30 - stack_size;
	
	for (char y = 0; y < 5; y++) {
		short pos = player_x + stack_offsets[stack_size - 1];
		if (icecream_swing < 0) {
			pos -= (short)swing_table[abs(icecream_swing)][stack_size - 1];
		} else {
			pos += (short)swing_table[icecream_swing][stack_size - 1];
		}
			
		stacked_icecream_shadow_position[0][y + yoff]->XPOS = pos;
		stacked_icecream_position[0][y + yoff]->XPOS = pos;
		
		if (_last_stack_size != stack_size) {
			for (char x = 0; x < 2; x++) {
				stacked_icecream_shadow_tiles[0][x][y + yoff]->TILE = 
					large_icecream_top_pixie_tiles[1][x][y];
				stacked_icecream_tiles[0][x][y + yoff]->TILE = 
					large_icecream_top_pixie_tiles[0][x][y];
			}
		}
	}

	for (char ribbon = 0; ribbon < stack_size - 1; ribbon++) {
		for (char y = 1; y < 3; y++) {
			short pos = player_x + 
				stack_offsets[stack_size - ribbon - 2];
			if (icecream_swing < 0) {
				pos -= (short)swing_table[abs(icecream_swing)][stack_size - ribbon - 1];
			} else {
				pos += (short)swing_table[icecream_swing][stack_size - ribbon - 1];
			}
			
			stacked_icecream_shadow_position[2 - y][3 + ribbon + yoff + y]->
				XPOS = pos;
			stacked_icecream_position[2 - y][3 + ribbon + yoff + y]->XPOS = 
				pos;
				
			if (_last_stack_size == stack_size) continue;
			
			// this doesn't work right, need to come back to this
			// for now, the performance gains are enough.
			//if (ribbon < _last_stack_size - 3) continue;
			
			for (char x = 0; x < 2; x++) {
				stacked_icecream_shadow_tiles[2 - y][x][3 + ribbon + yoff + y]
					->TILE = large_icecream_bottom_pixie_tiles[1][x][y];
				stacked_icecream_tiles[2 - y][x][3 + ribbon + yoff + y]->TILE =
					large_icecream_bottom_pixie_tiles[0][x][y];
			}
		}
	}
	_last_stack_size = stack_size;
}

char _cone_drawn = 0;
void draw_cone() {
	for (char y = 0; y < 6; y++) {
		cone_shadow_position[y]->XPOS = player_x;
		cone_position[y]->XPOS = player_x;
		
		if (!_cone_drawn) {
			for (char x = 0; x < 2; x++) {
				cone_shadow_tiles[x][y]->TILE = large_cone_pixie_tiles[1][x][y];
				cone_tiles[x][y]->TILE = large_cone_pixie_tiles[0][x][y];
			}
		}
	}
	_cone_drawn = 1;
}

void reset_level() {
	// clear the screens
	run_dma_job((__far char *)&clear_tilemap);
	run_dma_job((__far char *)&load_attrmap);
	
	_last_stack_size = 0;
	_cone_drawn = 0;

	falling_icecream_y = 0;
	falling_icecream_state = 0;

	player_input = 0;
	key_down = 0;
	
	stack_size = 0;
	player_dying = 0;
	icecream_swing = 0;
	target_swing = 0;

	unicorn_y = 0;
	unicorn_facing = 0;
	unicorn_frame_index = 0;
	unicorn_pooping = 0;
	unicorn_drop_poop = 0;
	unicorn_animation_delay = 0;
	vertical_sinus_index = 0;
	unicorn_countdown = 0;
	
	acceleration = 1;
	
	unicorn_speed = 1;
	
	lost_life_timer = 100;
	
	stack_top = 224;

	_last_yoff = 0xff;
	
	falling_icecream_x = 304;
	player_x = 304;
	unicorn_x = 304;
	
	for (char i = 0; i < 50; i++) {
		stack_offsets[i] = 0;
		stack_x[i] = 0;
	}
	
	draw_lives();
}

void draw_lives() {
	// this isn't pretty, but there was a compiler error that needed a 
	// workaround... and this IS fast.
	if (player_lives > 0) {
		farpoke(0x2215C,0x50);
		farpoke(0x22218,0x50);
		farpoke(0x22168,0x50);
		farpoke(0x22224,0x50);
	}
	if (player_lives > 1) {
		farpoke(0x22160,0x60);
		farpoke(0x2221C,0x60);
		farpoke(0x2216C,0x60);
		farpoke(0x22228,0x60);
	}
	if (player_lives > 2) {
		farpoke(0x22164,0x70);
		farpoke(0x22220,0x70);
		farpoke(0x22170,0x70);
		farpoke(0x2222C,0x70);
	}
}

unsigned short lost_life_timer;
