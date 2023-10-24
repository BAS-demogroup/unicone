#include "gameloop.h"


#include <stdlib.h>


#include "chips.h"
#include "constants.h"
#include "difficulty.h"
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
	while (end_of_level_timer > 0) {
		
		while (VIC4.FNRASTERLSB != (matrix_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((matrix_raster & 0x0f00) >> 8));
		
		VIC2.BORDERCOL = 0;
		
		// bank the tile and attribute maps from $20000-$21fff into $a000-$bfff
		__asm(" lda #0x00\n"
			  " tax\n"
			  " ldy #0x80\n"
			  " ldz #0x31\n"
			  " map\n"
			  " nop");

		// clear the screens
		run_dma_job((__far char *)&clear_tilemap);

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

		VIC2.BORDERCOL = 10;
		
		draw_falling_stacked();

		VIC2.BORDERCOL = 4;
		
		draw_icecream_stack();

		VIC2.BORDERCOL = 13;
		
		draw_cone();
		
		VIC2.BORDERCOL = 3;

		draw_lives();
		draw_level();

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
		
		if (player_dying || next_level) {
			--end_of_level_timer;
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

void draw_falling_icecream() {
	if (falling_icecream_state == 0 || falling_icecream_state == 3) return;
	
	unsigned short y_adj = falling_icecream_y;
	
	char yoff = y_adj >> 3;
	char last_yoff = yoff;
	char ymod = (~(char)y_adj & 0x07);
	
	for (char y = 0; y < icecream_top_height; y++) {
		set_icecream_pos(0, falling_icecream_x, y + yoff, ymod);
		
		for (char x = 0; x < icecream_top_width; x++) {
			paint_icecream_top_tile(x, y, yoff);
		}
	}
	
	y_adj += icecream_top_y_add;

	signed char layer = scale == 0 ? 2 : 4;
	
	for (char ribbon = 0; ribbon < 2; ribbon++) {
		char yoff = y_adj >> 3;
		char ymod = (~(char)y_adj & 0x07);
		
		if (yoff != last_yoff) {
			last_yoff = yoff;
			layer = scale == 0 ? 2 : 4;
		}
	
		for (char y = 0; y < icecream_bottom_height; y++) {
			set_icecream_pos(layer, falling_icecream_x, y + yoff, ymod);
			
			for (char x = 0; x < icecream_bottom_width; x++) {
				paint_icecream_bottom_tile(layer, x, y, yoff);
			}
			
			if (--layer < 0) {
				layer = scale == 0 ? 2 : 4;
			}		
		}
		
		y_adj += icecream_bottom_y_add;
	}
}

void draw_falling_stacked() {
	if (!falling_stacked_state) return;
	
	unsigned short y_adj = falling_stacked_y;
	
	char yoff = y_adj >> 3;
	char last_yoff = yoff;
	char ymod = (~(char)y_adj & 0x07);
	
	for (char y = 0; y < icecream_top_height; y++) {
		set_icecream_pos(0, falling_stacked_x, y + yoff, ymod);
		
		for (char x = 0; x < icecream_top_width; x++) {
			paint_icecream_top_tile(x, y, yoff);
		}
	}
	
	y_adj += icecream_top_y_add;

	signed char layer = scale == 0 ? 2 : 4;
	
	for (char ribbon = 0; ribbon < 2; ribbon++) {
		char yoff = y_adj >> 3;
		char ymod = (~(char)y_adj & 0x07);
		
		if (yoff != last_yoff) {
			last_yoff = yoff;
			layer = scale == 0 ? 2 : 4;
		}
	
		for (char y = 0; y < icecream_bottom_height; y++) {
			set_icecream_pos(layer, falling_stacked_x, y + yoff, ymod);
			
			for (char x = 0; x < icecream_bottom_width; x++) {
				paint_icecream_bottom_tile(layer, x, y, yoff);
			}
			
			if (--layer < 0) {
				layer = scale == 0 ? 2 : 4;
			}		
		}
		
		y_adj += icecream_bottom_y_add;
	}
}

void draw_icecream_stack() {
	if (stack_size == 0) return;

	unsigned short y_adj = stack_render_top;
	short last_pos = 0;
	
	char yoff = y_adj >> 3;
	char last_yoff = yoff;
	char ymod = (~(char)y_adj & 0x07);
	
	
	for (char y = 0; y < icecream_top_height; y++) {
		short pos = player_x + stack_offsets[stack_size - 1];
		if (icecream_swing < 0) {
			pos -= (short)(swing_table[abs(icecream_swing)][stack_size - 1]
				>> scale);
		} else {
			pos += (short)(swing_table[icecream_swing][stack_size - 1]
				>> scale);
		}
		last_pos = pos;
		
		set_stacked_pos(0, pos, y + yoff, ymod);
		
		for (char x = 0; x < icecream_top_width; x++) {
			paint_stacked_top_tile(x, y, yoff);
		}
	}
	
	y_adj += icecream_top_y_add;

	signed char layer = scale == 0 ? 2 : 5;
	
	for (char ribbon = 0; ribbon < stack_size - 1; ribbon++) {
		yoff = y_adj >> 3;
		ymod = (~(char)y_adj & 0x07);
		
		if (yoff != last_yoff) {
			last_yoff = yoff;
			layer = scale == 0 ? 2 : 5;
		}
	
		for (char y = 0; y < icecream_bottom_height; y++) {
			short pos = player_x + 
				stack_offsets[stack_size - ribbon - 2];
				
			if (icecream_swing < 0) {
				
				pos -= (short)(swing_table[abs(icecream_swing)]
					[stack_size - ribbon - 1] >> scale);
					
			} else {
				
				pos += (short)(swing_table[icecream_swing]
					[stack_size - ribbon - 1] >> scale);
					
			}

			set_stacked_pos(layer, pos, y + yoff, ymod);
			
			// has the top of the stack fallen?
			if (y == 0 && abs(last_pos - pos) >= lose_distance) {
				char add = icecream_top_y_add + 
					(icecream_bottom_y_add << 1);
					
				falling_stacked_x = last_pos;
				falling_stacked_y = stack_render_top;
				falling_stacked_state = 2;

				if (falling_icecream_state == 1) {
					falling_icecream_state = 2;
				}
				
				// erase dropped icecream
				//erase_dropped_stack();

				stack_size -= 5;	// It feels like this should be 3, but 5 is
									// what works.  NFI why.
				
				stack_top += add; 
				stack_render_top += add;
				
				return;
			}
			
			for (char x = 0; x < icecream_bottom_width; x++) {
				paint_stacked_bottom_tile(layer, x, y, yoff);
			}
			
			if (--layer < 0) {
				layer = scale == 0 ? 2 : 5;
			}		
		}
		
		y_adj += icecream_bottom_y_add;
	}
}

char _cone_drawn = 0;
void draw_cone() {
	for (char y = 0; y < cone_height; y++) {
		char ytile = y + 6 - cone_height;
		cone_shadow_position[ytile]->XPOS = player_x;
		       cone_position[ytile]->XPOS = player_x;
		
		for (char x = 0; x < cone_width; x++) {
			cone_shadow_tiles[x][ytile]->TILE = get_cone_tile(1, x, y + 1);
				   cone_tiles[x][ytile]->TILE = get_cone_tile(0, x, y + 1);
		}
	}
	_cone_drawn = 1;
}

void reset_level() {
	// clear the screens
	run_dma_job((__far char *)&load_attrmap);
	
	_cone_drawn = 0;

	falling_icecream_y = 0;
	falling_icecream_state = 0;
	falling_stacked_x = 0;
	falling_stacked_y = 0;
	falling_stacked_state = 0;

	player_input = 0;
	key_down = 0;
	
	stack_size = 0;
	player_dying = 0;
	icecream_swing = 0;
	target_swing = 0;
	dollops = 0;
	next_level = 0;

	unicorn_y = 0;
	unicorn_facing = 0;
	unicorn_frame_index = 0;
	unicorn_pooping = 0;
	unicorn_drop_poop = 0;
	unicorn_animation_delay = 0;
	vertical_sinus_index = 0;
	unicorn_countdown = 0;
	
	acceleration = 1;
	
	//unicorn_speed = 1;
	
	end_of_level_timer = 100;
	
	stack_top = 281 - cone_height_pix;
	stack_render_top = stack_top;

	//_last_stacked_yoff = 0xff;
	
	falling_icecream_x = 304;
	player_x = 304;
	unicorn_x = 304;
	
	for (char i = 0; i < 50; i++) {
		stack_offsets[i] = 0;
		stack_x[i] = 0;
	}
}

void draw_lives() {
	unsigned short xpos = 0x250;

	for (char x = 0; x < player_lives; x++) {
		for (char y = 0; y < 2; y++) {
			lives_shadow_position[x][y]->XPOS = xpos;
			lives_position[x][y]->XPOS = xpos;
		}
			
		xpos += 0x10;
	}
}

void draw_level() {
	char digit_index = 0;
	
	if (level > 9) {
		char tens = level / 10;
		
		for (char y = 0; y < 5; y++) {
			for (char x = 0; x < 2; x++) {
				level_number_tiles[digit_index][x][y]->TILE = 
					numbers[tens][x][y];
			}
		}
		
		++digit_index;
	}
	
	char ones = level % 10;
		
	for (char y = 0; y < 5; y++) {
		for (char x = 0; x < 2; x++) {
			level_number_tiles[digit_index][x][y]->TILE = numbers[ones][x][y];
		}
	}
	
	unsigned short pos = 310;
	
	for (char digit_index = 0; digit_index < 2; digit_index++) {
		for (char y = 0; y < 5; y++) {
			level_number_position[digit_index][y]->XPOS = pos;
		}
		
		pos += 22;
	}
}

unsigned short end_of_level_timer;
char level;
