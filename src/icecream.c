/// \file	icecream.c
/// 
/// \brief	This file contains the code and variables for managing the data 
/// 		specific to the ice cream
///
/// This C file contains the code and variables that are used to manage the ice 
/// cream in the ways the game uses it.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "icecream.h"


#include <stdlib.h>


#include "audio.h"
#include "chips.h"
#include "difficulty.h"
#include "dma.h"
#include "dma_jobs.h"
#include "gameloop.h"
#include "player.h"
#include "pixies.h"
#include "maps.h"
#include "swing.h"


/// \brief	This procedure does all the updating of the ice cream
///
/// This procedure is called to process all of the necessary updates for the
/// ice cream, doing both possible kinds of falling ice cream.
void update_falling_icecream() {
	// check to see if we have a falling ice cream that's fallen off the stack
	if (falling_stacked_state == 2) {
		// calculate the lowest point an ice cream dollop can fall
		unsigned short calc_done = 292 - icecream_top_y_add - 
			(icecream_bottom_y_add << 1);
			
		// if the stacked ice cream dollop has not fallen to that point, then 
		// it keeps falling
		if (falling_stacked_y < calc_done) {
			falling_stacked_y += (falling_speed << 2);
		// otherwise, the dollop has finished falling, and we need to trigger
		// the player losing their life.
		} else {
			// play the sound effect
			play_sample(runtime_sample_start[5], runtime_sample_end[5], 1);
			// mark the player as dying
			player_dying = 1;
			// if the player may have finished the level but tipped in the
			// process, make sure to undo the level completion
			next_level = 0;
			// deduct a life
			--player_lives;
			// make sure we don't try to draw the dollop below the bottom
			// while the main game loop handles the timing of the animation
			falling_stacked_y = calc_done;
			// and make it so the stacked state is stopped
			falling_stacked_state = 3;
		}
	}
	
	// Process a couple of different states for the recently pooped falling ice 
	// cream dollop.
	switch (falling_icecream_state) {
		// state 1 is the normal state where an ice cream dollop is falling
		case 1:
			// stack_top = top of cone - if it passes that, then the ice cream 
			// has either been caught, if it's close enough to the cone, or 
			// the player has lost a life
			if (falling_icecream_y < stack_top) {
				// but if not, keep falling
				falling_icecream_y += falling_speed;
			} else {
				// we need to do some math to calculate the x offset of the top
				// of the stack
				short calc_x = player_x;
				// if there is no stack yet, skip this part - the top is just
				// the top of the cone
				if (stack_size) {
					// but if there is, then we do some quick math to calculate
					// the x position of the top of the stack
					calc_x = stack_x[stack_size - 1] +
						stack_offsets[stack_size - 1];
				}
				// then, we add or subtract the value we look up on the swing table
				// based on which direction the stack is swinging, shifted right to
				// reduce the swing for the scale differences
				if (icecream_swing < 0) {
					calc_x -= (short)(swing_table[abs(icecream_swing)]
						[stack_size - 1] >> scale);
					
				} else {
					calc_x += (short)(swing_table[icecream_swing]
						[stack_size - 1] >> scale);
				}

				short val = falling_icecream_x > calc_x ?
							falling_icecream_x - calc_x :
							calc_x - falling_icecream_x;
				// determine if the player caught the ice cream
				if (val < lose_distance) {
					// catch the ice cream and add it to the cone
					for (char i = 0; i < 3; i++) {
						// by setting the offset of the new top piece
						stack_offsets[stack_size + i] = falling_icecream_x 
							- player_x;
							
					}
					// the dollop adds three new layers to the stack
					stack_size += 3;
					// and we increase the dollop count, which is used to test
					// if the level has been completed
					++dollops;
					
					// calculate the new y pixel top of the stack
					stack_top -= (icecream_bottom_y_add << 1) + 
						icecream_bottom_y_add;
					
					// and the top of where it's rendered from
					stack_render_top = falling_icecream_y;
					
					// if we haven't completed the level yet
					if (dollops < level && dollops < 25) {
						// then return to the default state and let the game
						// carry on
						falling_icecream_state = 0;
					} else {
						// otherwise, set the state to the level being done
						falling_icecream_state = 3;
						next_level = 1;
					}
					
					catch_timer = 50;
					
					// and play the sound effect for the dollop landing on the
					// stack
					play_sample(runtime_sample_start[4], runtime_sample_end[4], 
						1);
						
				} else {
					// if not, then do some failure thing.
					falling_icecream_state = 2;
				}
			}
			return;
		// state 2 indicates that we are in the middle of letting the dollop 
		// drop the rest of the way to the ground before failing the level.
		case 2:
			{
				// calculate the lowest point an ice cream dollop can fall
				unsigned short calc_done = 295 - icecream_top_y_add - 
					(icecream_bottom_y_add << 1);

				// if the falling recently pooped ice cream dollop has not 
				// fallen to that point, then it keeps falling
				if (falling_icecream_y < calc_done) {
					falling_icecream_y += (falling_speed << 3);
					if (falling_icecream_y > calc_done) {
						falling_icecream_y = calc_done;
					}
				} else {
					// otherwise, time to trigger the player losing a life and
					// the level resetting, first by playing the failure sound
					// sample
					play_sample(runtime_sample_start[5], 
						runtime_sample_end[5], 1);
						
					// if this is the first part of the animation, take away
					// one of the player's lives
					if (!player_dying) {
						--player_lives;
					}
					// indicate that we are animating their death
					player_dying = 1;
					// if the player may have finished the level but tipped in 
					// the process, make sure to undo the level completion
					next_level = 0;
					// make sure we don't try to draw the dollop below the 
					// bottom of the playfield
					falling_icecream_y = calc_done;
					// and set the state to 3, which indicates we're in the
					// middle of the current level loop ending
					falling_icecream_state = 3;
				}
			}
			
			return;
	}
}

/// \brief	This is the y pixel position of the recently pooped falling ice
///			cream
unsigned short falling_icecream_y     = 0;

/// \brief	This is the state of the recently pooped falling ice cream
///
/// This is the state of the recently pooped falling ice cream.  Possible 
/// values are 0, indicating no falling poop at the moment, 1 for a falling 
/// poop that can still be caught, 2 for a falling poop that has been missed, 
/// but is still animating, and 3 to stop having falling ice cream because the
/// level loop needs to terminate.
char           falling_icecream_state = 0;

/// \brief	The x pixel position of the falling ice cream that fell off the top
///			of the stack
unsigned short falling_stacked_x      = 0;
/// \brief	The y pixel position of the falling ice cream off the stack
unsigned short falling_stacked_y      = 0;
/// \brief	The state of a falling ice cream dollop from the top of the stack
///
/// The state of a falling ice cream dollop from the top of the stack.  The 
/// states are basically the same as the recently pooped dollop, minus state 1,
/// since there is no case where one can re-catch a dollop that fell off the
/// top of the stack.
char           falling_stacked_state  = 0;

/// \brief	The top y pixel position of the stack, not including the empty 
///			space at the top of the tiles
unsigned short stack_top              = 224;

/// \brief	The top y pixel position of the stack, not including the empty 
///			space at the top
///
/// The difference between the stack_render_top and the stack_top is that this
/// value is used to determine if a newly pooped falling ice cream has reached
/// the point where it is either caught or missed.
unsigned short stack_render_top       = 224;

/// \brief	The x pixel position of the newly pooped falling ice cream
unsigned short falling_icecream_x     = 304;
