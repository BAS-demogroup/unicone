/// \file	gameloop.c
/// 
/// \brief	This C file contains the main loop code for the game.
///
/// This C file contains the code and some of the variables for the main loop 
/// of the game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "gameloop.h"


#include <stdlib.h>


#include "audio.h"
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
#include "setup.h"
#include "swing.h"
#include "unicorn.h"


char _player_pressed_fire;
/// \brief	This procedure runs the main in-game loop.
///
/// This procedure is the main driver for the in-game loop.  It basically 
/// updates all of the variables for the frame, then renders the graphics.  It 
/// also does a few other minor things which are not detailed here, see the 
/// source code if you want to know more.
void game_loop() {
	// when the game first starts up, we set up an exception that allows us to
	// play the startup sample
	if (level == 1 && player_lives == 3) {
		// 1.175s
		// pal = 59 frames
		// ntsc = 71 frames
		play_sample(runtime_sample_start[0], runtime_sample_end[0], 1);
		
		// of course, the duration of the sample must be PAL/NTSC fixed
		if (!VIC4.PALNTSC) {
			new_game_counter = 59;
		} else {
			new_game_counter = 71;
		}
		
		// and we make sure that the game waits until the sample is complete
		// before allowing the game to properly start.
		falling_icecream_state = 3;
	}
	
	// We enter our loop until the level has ended
	while (end_of_level_timer > 0) {
		
		// do a tight loop until we reach the raster location at the beginning
		// of the bottom border
		while (VIC4.FNRASTERLSB != (update_raster & 0xff) || 
			VIC4.FNRASTERMSB != ((update_raster & 0x0f00) >> 8));
		
		// bank the tile map from $20000-$21fff into $a000-$bfff
		__asm(" lda #0x00\n"
			  " tax\n"
			  " ldy #0x80\n"
			  " ldz #0x31\n"
			  " map\n"
			  " nop");

		// clear the tilemap in the live/work space at $0020000.
		run_dma_job((__far char *)&clear_ingame_tilemap);

		// calculate the unicorn's variables for this frame
		update_unicorn();
		
		// calculate the variables for the falling ice cream dollop for this 
		// frame, if there is one
		update_falling_icecream();

		// process joystick and keyboard input
		process_input();
		//end_of_level_timer > 0
		// if (player_lives > 0 && end_of_level_timer == 0) return;
		
		// if ((player_input & 0b00010000) && end_of_level_timer == 0) {
			// _player_pressed_fire = 1;
		// } else if (_player_pressed_fire && (player_input & 0b00010000) && 
			// end_of_level_timer == 0) {
				
			// return;
		// }
		// update the player variables for this frame
		update_player();
		
		// draw the screen in vertical order, so unicorn first, then falling 
		// ice cream, then ice cream stack, then cone.  this is done to make
		// sure we stay ahead of the raster "beam."
		
		// draw the unicorn
		draw_unicorn();
		
		// if necessary, the game over logo
		//draw_gameover();
		
		// if there is a falling ice cream at the moment, then draw it
		draw_falling_pooped();
		
		// next, if the ice cream stack has slipped, then we also need to draw
		// the slipped ice cream
		draw_falling_stacked();
		
		// draw all of the ice cream held on top of the cone
		draw_icecream_stack();
		
		// draw the cone itself
		draw_cone();

		// finally draw in the lives
		draw_lives();
		
		// and the current level number
		draw_level();

		// if the game startup sample has finished playing 
		if (new_game_counter == 0) {
			// then we can play the in-game music.
			musicPlay();

			// we have to re-process the muting here, in order to make the mute
			// persist between the game and the title screen
			if (!muted) {
				SID1.VOLUME_FTYPE = 0x6f;
				SID2.VOLUME_FTYPE = 0x6a;
				SID3.VOLUME_FTYPE = 0x2b;
				SID4.VOLUME_FTYPE = 0x3b;
			} else {
				SID1.VOLUME_FTYPE = 0x60;
				SID2.VOLUME_FTYPE = 0x60;
				SID3.VOLUME_FTYPE = 0x20;
				SID4.VOLUME_FTYPE = 0x30;
			}
		}

		// this code is probably no longer necessary, but when the loop is fast 
		// enough, we have to ensure that at least 1 rasterline has passed 
		// before we end the loop
		while (VIC4.FNRASTERLSB == (update_raster & 0xff));
		
		// if we are in the midde of the player dying, or advancing to the next
		// level, we must decrement the end_of_level_timer.  we do this so the
		// player has time to register what has happened.
		if (player_dying || next_level) {
			--end_of_level_timer;
			if (!player_dying && next_level && 
				end_of_level_timer_start - end_of_level_timer == 33) {
					
				// load the level complete sound effect
				run_dma_job(
					(__far char *)&load_level_complete_bank[0]);
				current_loaded_state = 3;
				// play the sound effect
				play_sample(level_complete_sample_start[0], 
					level_complete_sample_end[0], 1);
				
			}
			
			if (player_dying && player_lives == 0 && 
				end_of_level_timer_start - end_of_level_timer == 33) {
					
				return;
			}
		}
		
		// if the game start sample has finished playing, then we can get the
		// main game moving and active
		if (new_game_counter > 0 && --new_game_counter == 0) {
			falling_icecream_state = 0;
		}
	};
}

/// \brief	This procedure draws the unicorn
///
/// This procedure draws the unicorn, animating it as it does so.
void draw_unicorn() {
	// the unicorn is made up of 5 vertical tiles
	for (char y = 0; y < 5; y++) {
		// setting the x and y position is trivial - the unicorn has at most
		// 8 pixels of vertical movement
		unicorn_position[y]->XPOS = unicorn_x;
		unicorn_position[y]->YOFF = unicorn_y;
		
		// find the actual index for the current frame.  the reason for this is
		// because frames are shown for more than one vertical retrace usually,
		// this is used as a timer.
		char _frame = unicorn_frame_lookup[unicorn_frame_index];

		// draw both tiles of this row, animated, and adjusted for its facing
		// (which swaps the left and right tiles), and if it is about to poop
		// (in which case, draw the tail lifted).
		unicorn_tiles[0][y]->TILE = unicorn_pixie_tiles[_frame]
			[unicorn_facing ? 2 : unicorn_pooping][y];

		unicorn_tiles[1][y]->TILE = unicorn_pixie_tiles[_frame]
			[unicorn_facing ? unicorn_pooping : 2][y];
		
		// and set whether or not the tiles are flipped horizontally
		unicorn_attr[0][y]->HFLIP = unicorn_facing;
		unicorn_attr[1][y]->HFLIP = unicorn_facing;
		
		// if we are in the upper 4 rows the unicorn's graphics, then we need
		// to draw its tail
		if (y < 4) {
			// the x position needs to be adjusted if the unicorn is flipped,
			// basically putting it in the correct column
			tail_position[y]->XPOS = unicorn_x + (unicorn_facing ? 16 : 0);
			
			// but the y offset remains trivial
			tail_position[y]->YOFF = unicorn_y;
			
			// draw the tail tile, adjusted for if the unicorn is about to 
			// poop, in which case the tail is drawn lifted.
			tail_tiles[y]->TILE = tail_pixie_tiles[unicorn_pooping][_frame][y];
			
			// and as above, flip it depending on which direction the unicorn 
			// is facing.s
			tail_attr[y]->HFLIP = unicorn_facing;
		}
		
		// finally, if we are in the upper 3 rows of the unicorn graphics, then
		// we also need to draw its mane
		if (y < 3) {
			// as with the fail, we need to adjust whether we're drawing the
			// mane on the left or right side of the pixie based on the 
			// unicorn's facing
			mane_position[y]->XPOS = unicorn_x + (unicorn_facing ? 0 : 16);
			
			// but the y offset continues to remain trivial.  this is the last
			// time in this file that the y offset is simple.
			mane_position[y]->YOFF = unicorn_y;
			
			// draw the mane and set the horizontal flip of the tile
			mane_tiles[y]->TILE = mane_pixie_tiles[_frame][y];
			mane_attr[y]->HFLIP = unicorn_facing;
		}
	}
}

/// \brief	This procedure draws the falling dollops of ice cream
///
/// This procedure draws the falling ice cream, both the one fresh from the
/// unicorn, as well as the one that slips off the top of the stack if it tips
/// too far.
///
/// \param	ytop	The vertical top of the cone that we start rendering from
void draw_falling_icecream(unsigned short ytop) {
	// y_adj is the top of what we're drawing, adjusted for the current layer
	// of the dollop we're drawing.  Here, we set it to the passed starting top
	unsigned short y_adj = ytop;
	
	// the current vertical tile position of the row we're drawing
	char y_tile = y_adj >> 3;
	// we use this last_y_tile so we know when we have changed rows, and can
	// stop rotating through the different reserved RRB spaces we use to get
	// good layering
	char last_y_tile = y_tile;
	
	// just the pixels of the current layer, i.e. 0-7.
	char y_pix = (~(char)y_adj & 0x07);
	
	// first, we need to draw the very top of the dollop, which has its own
	// look and height from the bottom layers
	for (char y = 0; y < icecream_top_height; y++) {
		// set the position of the row
		set_icecream_pos(0, falling_icecream_x, y + y_tile, y_pix);
		
		// and the tile(s) for the row
		for (char x = 0; x < icecream_top_width; x++) {
			paint_icecream_top_tile(x, y, y_tile);
		}
	}
	
	// adjust the top of where we're rendering
	y_adj += icecream_top_y_add;

	// we set up for the layering here - in the large scale, we only have 2
	// reserves RRB columns for the layers, but for the smaller scales, we need
	// 4.  The difference is, for the smaller ones, we only need the reserved
	// space to be 1 tile wide, so this code diferentiates so we can keep 
	// within our available RRB cycles.
	signed char layer = scale == 0 ? 2 : 4;
	
	// under the top part of the dollop, we also have two bottom layers.
	for (char ribbon = 0; ribbon < 2; ribbon++) {
		// for each layer, we need to calculate the tile where we're rendering
		char y_tile = y_adj >> 3;
		// and the pixel offset
		char y_pix = (~(char)y_adj & 0x07);
		
		// if we have moved to a new row of the tile map
		if (y_tile != last_y_tile) {
			// setup for the next loop through
			last_y_tile = y_tile;
			// and reset the layer selection
			layer = scale == 0 ? 2 : 4;
		}
		
		// for each row that our bottom layer can take up
		for (char y = 0; y < icecream_bottom_height; y++) {
			// set its position
			set_icecream_pos(layer, falling_icecream_x, y + y_tile, y_pix);
			
			// and tile(s)
			for (char x = 0; x < icecream_bottom_width; x++) {
				paint_icecream_bottom_tile(layer, x, y, y_tile);
			}
			
			// then cycle the layer selection
			if (--layer < 0) {
				layer = scale == 0 ? 2 : 4;
			}		
		}
		
		// and add the pixel height of the ice cream bottom for this scale to 
		// get the new top of the next ribbon
		y_adj += icecream_bottom_y_add;
	}
}

/// \brief	This procedure handles the animation of newly pooped ice cream
///
/// This procedure is called to draw newly pooped ice cream. All it does is 
/// have a clause for whether it should be drawing something, and if so, then
/// it calls the main draw_falling_icecream procedure.
void draw_falling_pooped() {
	// skip drawing if the state is wrong, if we are still in the middle of
	// playing the game startup sound, or if we are in the middle of changing
	// level
	if (falling_icecream_state == 0 || new_game_counter > 0 || next_level) 
		return;
	
	draw_falling_icecream(falling_icecream_y);
}

/// \brief	This procedure handles the animation of falling ice cream that has 
///			fallen off the stack
///
/// Similar to draw_falling_pooped, this procedure draws falling ice cream that
/// slipped off of the stack on the cone when it tips too far.  It has a 
/// different clause, but is otherwise identically simple.
void draw_falling_stacked() {
	// skip this if we don't have an ice cream dollop that has fallen from the
	// stack
	if (!falling_stacked_state) return;
	
	draw_falling_icecream(falling_stacked_y);
}

/// \brief	This procedure draws the ice cream stacked on top of the cone
///
/// This procedure handles drawing and animating the ice cream stacked on top
/// of the cone.  It is busier than drawing the falling ice cream, not only
/// because the stack grows, but also because it sways.
void draw_icecream_stack() {
	// If we don't have any ice cream on the stack, then we have nothing to do
	if (stack_size == 0) return;

	// y_adj is the top of what we're drawing, adjusted for the current layer
	// we're drawing.  
	unsigned short y_adj = stack_render_top;

	// this is the x position of the previous level of the stack's chunk of ice
	// cream.  it is used to detect when the stack has swung too far
	short last_x_pos = 0;
	
	// the current vertical tile position of the row we're drawing
	char y_tile = y_adj >> 3;
	char top_tile = y_tile;

	// we use this last_y_tile so we know when we have changed rows, and can
	// stop rotating through the different reserved RRB spaces we use to get
	// good layering
	char last_y_tile = y_tile;

	// just the pixels of the current layer, i.e. 0-7.
	char y_pix = (~(char)y_adj & 0x07);
	
	// the very top of the stack still has uses the twisted dollop graphic,
	// which needs to be drawn first
	for (char y = 0; y < icecream_top_height; y++) {
		// to do the swinging of the stack, we first calculate the basic x
		// position of the piece, based on where the cone is at, and the offset
		// for how the particular piece landed on the stack
		short pos = player_x + stack_offsets[stack_size - 1];
		// then, we add or subtract the value we look up on the swing table
		// based on which direction the stack is swinging, shifted right to
		// reduce the swing for the scale differences
		if (icecream_swing < 0) {
			pos -= (short)(swing_table[abs(icecream_swing)][stack_size - 1]
				>> scale);
		} else {
			pos += (short)(swing_table[icecream_swing][stack_size - 1]
				>> scale);
		}
		// and since this is the first piece, we also set our last_x_pos - we
		// will use this later to determine if the stack has slipped
		last_x_pos = pos;
		
		// set the position for this row of the top dollop on the stack
		set_stacked_pos(0, pos, y + y_tile, y_pix);
		
		// and also set its tiles
		for (char x = 0; x < icecream_top_width; x++) {
			paint_stacked_top_tile(x, y, y_tile);
		}
	}
	
	// adjust the top of where we're rendering
	y_adj += icecream_top_y_add;

	// we set up for the layering here - in the large scale, we only have 2
	// reserves RRB columns for the layers, but for the smaller scales, we need
	// 5.  The difference is, for the smaller ones, we only need the reserved
	// space to be 1 tile wide, so this code diferentiates so we can keep 
	// within our available RRB cycles.
	signed char layer = scale == 0 ? 2 : 5;
	
	// we loop over the height of our stack, minus the very top dollop
	for (char ribbon = 0; ribbon < stack_size - 1; ribbon++) {
		// for each layer, we need to calculate the tile where we're rendering
		y_tile = y_adj >> 3;
		// and the pixel offset
		y_pix = (~(char)y_adj & 0x07);
		
		// if we have moved to a new row of the tile map
		if (y_tile != last_y_tile) {
			// setup for the next loop through
			last_y_tile = y_tile;
			// and reset the layer selection
			layer = scale == 0 ? 2 : 5;
		}
	
		// for each row that our bottom layer can take up
		for (char y = 0; y < icecream_bottom_height; y++) {
			// we once again calculate the base x position of this piece
			short pos = player_x + 
				stack_offsets[stack_size - ribbon - 2];
			
			// and then cause the stack to swing using a lookup table, and
			// adjusted for the current scale
			if (icecream_swing < 0) {
				
				pos -= (short)(swing_table[abs(icecream_swing)]
					[stack_size - ribbon - 1] >> scale);
					
			} else {
				
				pos += (short)(swing_table[icecream_swing]
					[stack_size - ribbon - 1] >> scale);
					
			}

			// set the position for this row of the top dollop on the stack
			set_stacked_pos(layer, pos, y + y_tile, y_pix);
			
			// we need to determine distance between the two ribbons
			// if that distance is within warning distance, we should a little
			// splash graphic to warn the player.
			char d;
			if (last_x_pos >= pos) {
				d = last_x_pos - pos;
				
			} else {
				d = pos - last_x_pos;
				
			}
			if (d >= warn_distance) {
				warn_timer = 75;
			}
			if (warn_timer > 0) {
				effects_position[0][top_tile + icecream_top_height]->XPOS = 
					last_x_pos - 24;
				
				effects_tiles[0][top_tile + icecream_top_height]->TILE = 
					splash_pixie_tiles[scale][0];

				effects_position[1][top_tile + icecream_top_height]->XPOS = 
					last_x_pos + 40;
				
				effects_tiles[1][top_tile + icecream_top_height]->TILE =
					splash_pixie_tiles[scale][1];
				
				warn_timer--;
			}
			// has the top of the stack fallen?
			if (y == 0 && catch_timer == 0 &&  d >= lose_distance) {
				// calculate the number of pixels to move the top of the stack
				// by - the height of a top dollop and two bottom ribbon layers
				char add = icecream_top_y_add + 
					(icecream_bottom_y_add << 1);
					
				// the x position of the new falling dollop is the last_x_pos
				// calculated above and used to determine the slip
				falling_stacked_x = last_x_pos;
				
				// the y position of the new falling dollop is the top position
				// of the stack
				falling_stacked_y = stack_render_top;
				
				// set the state that indicated we have a falling stack dollop
				falling_stacked_state = 2;

				// if there is also a pooped ice cream currently on screen, 
				// then set it to a losing fall state so it will move faster
				// too
				if (falling_icecream_state == 1) {
					falling_icecream_state = 2;
				}
				
				// reduce the size of the stack
				stack_size -= 5;	// It feels like this should be 3, but 5 is
									// what works.  NFI why.
				
				// and add pixels to the top
				stack_top += add; 
				// and the rendering top
				stack_render_top += add;
				
				// we stop rendering this frame if the stack has slipped
				return;
			}
			
			// having gotten this far, paint the tile(s) for the current ribbon
			// layer of the stack
			for (char x = 0; x < icecream_bottom_width; x++) {
				paint_stacked_bottom_tile(layer, x, y, y_tile);
			}
			
			// and rotate the stack layer RRB pixie selection 
			if (--layer < 0) {
				layer = scale == 0 ? 2 : 5;
			}		
		}
		
		// add the height of the bottom ribbon graphic to the next rendering
		// position
		y_adj += icecream_bottom_y_add;
	}
	
	if (catch_timer > 0) {
		--catch_timer;
	}
}

/// \brief	This procedure draws the cone
///
/// The procedure draws the cone, the piece that the player controls directly
void draw_cone() {
	// for each of the rows of the cone at the current scale
	for (char y = 0; y < cone_height; y++) {
		// first, figure out which tile row - the purpose of this is to skip
		// the empty tiles when in smaller scales
		char ytile = y + 6 - cone_height;
		
		// set the X position of the cone and its shadow
		cone_shadow_position[ytile]->XPOS = player_x;
		       cone_position[ytile]->XPOS = player_x;
		
		// and then draw the tile(s) for the current row
		for (char x = 0; x < cone_width; x++) {
			cone_shadow_tiles[x][ytile]->TILE = get_cone_tile(1, x, y + 1);
				   cone_tiles[x][ytile]->TILE = get_cone_tile(0, x, y + 1);
		}
	}
}

char           _level_swing_counter;
/// \brief	This procedure resets all of the level variables
///
/// This function is necessary to reset all of the variables to their initial
/// state each level.  It was originally created because it was discovered that
/// for some reason that wasn't identified, the default values for these 
/// variables were not being set on the real hardware, and instead had to be
/// explicitly set.
void reset_level() {
	// not going to itemize each variable.  they are grouped by the value they
	// are being set to, for optimization, and then by what section of the code
	// files the variables originate from.
	
	run_dma_job((__far char *)&load_ingame_attrmap);
	
	new_game_counter = 0;
	_level_swing_counter = 0;
	// _gameover_facing = 0;
	_player_pressed_fire = 0;
	warn_timer = 0;
	catch_timer = 0;

	falling_icecream_y     = 0;
	falling_icecream_state = 0;
	falling_stacked_x      = 0;
	falling_stacked_y      = 0;
	falling_stacked_state  = 0;

	player_input = 0;
	key_down     = 0;
	
	stack_size     = 0;
	player_dying   = 0;
	icecream_swing = 0;
	target_swing   = 0;
	dollops        = 0;
	next_level     = 0;

	unicorn_y               = 0;
	unicorn_facing          = 0;
	unicorn_frame_index     = 0;
	unicorn_pooping         = 0;
	unicorn_animation_delay = 0;
	vertical_sinus_index    = 0;
	unicorn_countdown       = 0;
	
	acceleration = 1;
	
	end_of_level_timer = end_of_level_timer_start;
	
	stack_top        = 281 - cone_height_pix;
	stack_render_top = stack_top;
	
	falling_icecream_x = 304;
	player_x           = 304;
	unicorn_x          = 304;

	//_gameover_x_pos = 640;
	
	for (char i = 0; i < 50; i++) {
		stack_offsets[i] = 0;
		stack_x[i]       = 0;
	}
}

/// \brief	This procedure draws the number of lives indicator
///
/// This procedure is called to draw the number of lives as tiny ice cream 
/// cones in the lower right hand part of the screen
void draw_lives() {
	// the leftmost cone is drawn at x position $250
	unsigned short xpos = 0x250;

	// loop over how many lives the player has left
	for (char x = 0; x < player_lives; x++) {
		// and then over each of the columns of the cone
		for (char y = 0; y < 2; y++) {
			// setting the x position of its shadow and main tiles
			lives_shadow_position[x][y]->XPOS = xpos;
			lives_position[x][y]->XPOS = xpos;
		}
			
		// then advance the target x position for the next life by $10.
		xpos += 0x10;
	}
}

/// \brief	This procedure draws the level number on the screen
///
/// This procedure draws the level number in the lower middle of the screen,
/// right after the static text that says "level."
void draw_level() {
	// this allows us to keep track of how many digits the number contains
	char digit_index = 0;
	
	// if the current level has 2 digits
	if (level > 9) {
		// first, determine what the tends digit is
		char tens = level / 10;
		
		// then, set the tiles for that digit.
		for (char y = 0; y < 5; y++) {
			for (char x = 0; x < 2; x++) {
				level_number_tiles[digit_index][x][y]->TILE = 
					numbers[tens][x][y];
			}
		}
		
		// and increment the digit_index
		++digit_index;
	}
	
	// determine what the ones digit is
	char ones = level % 10;
		
	// and draw the tiles for that digit
	for (char y = 0; y < 5; y++) {
		for (char x = 0; x < 2; x++) {
			level_number_tiles[digit_index][x][y]->TILE = numbers[ones][x][y];
		}
	}
	
	// set the left most x position of the first digit
	signed short pos = 310;
	if (last_level != level) {
		if (_level_swing_counter < 50) {
			pos += level_swing[_level_swing_counter];
		}
	}
	if (next_level && end_of_level_timer <= 150) {
		pos = 640;
	} else if (next_level && end_of_level_timer < 200 && end_of_level_timer > 150) {
		pos += level_swing[end_of_level_timer - 150];
	}
	if (++_level_swing_counter > 50) {
		_level_swing_counter = 50;
	}
	
	// and then, for each digit
	for (char digit_index = 0; digit_index < 2; digit_index++) {
		// and each row in that digit
		for (char y = 0; y < 5; y++) {
			// set its x position
			level_number_position[digit_index][y]->XPOS = pos;
		}
		
		// then increase the position the next digit will use
		pos += 22;
	}
}

/// \brief	This timer is used to count the frames until the loop ends
///
/// When the game is over, or the player has advanced to the next level, we
/// first want to take some time to let the player register this, so we leave
/// the game screen intact with nothing going on for a couple seconds or so
char end_of_level_timer;

/// \brief	The current level of the game
char level;

/// \brief	The last level of the game
char last_level;

/// \brief	The currently loaded data for the game
///
/// The currently loaded data for the game.  0 = title screen, 1 = in-game, 
/// 2 = game over, 3 = level complete.
char current_loaded_state;

/// \brief	This variable is as a minor delay when a new game is first started
///
/// When a new game is started, this variable is set to a value to countdown
/// from in order to allow the game startup sound effect to play before the
/// game actually starts moving, or plays music.
char new_game_counter;

/// \brief	This is the amount of time we take to end the level, NTSC/PAL fixed
char end_of_level_timer_start;

/// \brief	This timer is used to make the warning stay on screen longer
char warn_timer;

/// \brief	This timer is used to keep ice cream from slipping off right after
///			it's caught
char catch_timer;
