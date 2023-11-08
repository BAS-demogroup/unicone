/// \file	difficulty.h
/// 
/// \brief	This file contains the code and variables that define the 
///			difficulty
///
/// This header file declares the code and all of the variables that are used
/// to describe the difficulty curve of the game, although the swing of the
/// stack is also a part of the difficulty and is defined in a file of its own.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "difficulty.h"


#include "constants.h"
#include "dma.h"
#include "dma_jobs.h"
#include "gameloop.h"
#include "unicorn.h"


/// \brief	This procedure is called to set the difficulty and flavor
///
/// This procedure is called to set the difficulty based on the current level,
/// and load the ice cream flavor onto the color palette.
void set_level_difficulty() {
	// cur_level is used to help set the offset into the flavor storage.  there
	// are only 24 flavors, after that, it just keeps the highest flavor.
	char cur_level = level > 24 ? 24 : level;
	// level is 1 indexed, so we correct for that.
	cur_level -= 1;
	// and the level is then multiplied by 16, as that is how long a palette
	// slice is.
	cur_level <<= 4;

	// set the DMA job pointers for the flavor being loaded
	load_flavor[0].source = FLAVORS_RED   + cur_level & 0xffff;
	load_flavor[1].source = FLAVORS_GREEN + cur_level & 0xffff;
	load_flavor[2].source = FLAVORS_BLUE  + cur_level & 0xffff;

	// and load the flavor
	run_dma_job((__far char *)&load_flavor);
	
	// there are variables in place to vary the behavior of the unicorn, but at 
	// this time, it's the same throughout the game.
	random_poop_mask    = 0x000001ff; // $1ff < $1
	random_poop_value   = 0x00000001;
	random_facing_mask  = 0x0007fe00; // $7fe00 < $1
	random_facing_value = 0x00000001;
	
	unicorn_frame_rate = 4;
	
	// at this time, there are really only 3 major divisions in difficulty,
	// after 8 and after 16, so these blocks select each o those.
	if (level < 9) {
		// Set the graphics scale to 0 - the largest scale
		scale = 0;

		// set the cone measurements
		cone_height = 6;
		cone_height_pix = 60;
		cone_width = 2;

		// set the distance from the center of one piece and the one below it
		// at which the stack will slip
		lose_distance = 32;
		
		// set the ice cream top measurements
		icecream_top_height = 5;
		icecream_top_width = 2;
		icecream_top_y_add = 24;
		
		// set the ice cream bottom measurements
		icecream_bottom_height = 3;
		icecream_bottom_width = 2;
		icecream_bottom_y_add = 8;
		
		// set the speed at which the ice cream falls to 2 pixels per frame
		falling_speed = 2;
		
		// for levels 7 and 8, the unicorn moves twice as fast
		if (level < 7) {
			unicorn_speed = 1;
		} else {
			unicorn_speed = 2;
		}
	} else if (level < 17) {
		// set the graphics scale to 1, the middle scale
		scale = 1;

		// set the cone measurements
		cone_height = 3;
		cone_height_pix = 21;
		cone_width = 1;

		// set the distance from the center of one piece and the one below it
		// at which the stack will slip
		lose_distance = 16;
		
		// set the ice cream top measurements
		icecream_top_height = 3;
		icecream_top_width = 1;
		icecream_top_y_add = 12;
		
		// set the ice cream bottom measurements
		icecream_bottom_height = 2;
		icecream_bottom_width = 1;
		icecream_bottom_y_add = 4;
		
		// set the speed at which the ice cream falls to 2 pixels per frame
		falling_speed = 2;
		
		// for levels 15 and 16, the unicorn moves twice as fast again
		if (level < 15) {
			unicorn_speed = 1;
		} else {
			unicorn_speed = 2;
		}
	} else {
		// set the graphics scale to 2, the smallest scale
		scale = 2;

		// set the cone measurements
		cone_height = 2;
		cone_height_pix = 0;
		cone_width = 1;

		// set the distance from the center of one piece and the one below it
		// at which the stack will slip
		lose_distance = 8;
		
		// set the ice cream top measurements
		icecream_top_height = 2;
		icecream_top_width = 1;
		icecream_top_y_add = 3;
		
		// set the ice cream bottom measurements
		icecream_bottom_height = 2;
		icecream_bottom_width = 1;
		icecream_bottom_y_add = 2;
		
		// set the speed at which the ice cream falls to 3 pixels per frame -
		// this is quite difficult
		falling_speed = 3;

		// for levels 23 and higher, the unicorn moves twice as fast for the
		// rest of the game
		if (level < 23) {
			unicorn_speed = 1;
		} else {
			unicorn_speed = 2;
		}
	}
}


/// \brief	This variable sets the scale of the graphics
///
/// This variable sets the scale of the graphics - the cone and the ice cream.
/// There are three sizes - 0 is the largest, 1 is the middle, and 2 is the
/// smallest.  The primary purpose of this is so that we can fit the higher
/// stacks on top of the ice cream, and serves the secondary purpose of the
/// smaller scale graphics increasing the difficulty.
char scale;

/// \brief	This variable is the height of the cone in tiles
///
/// This variable is the height of the cone at the current scale, in tiles.
char cone_height;

/// \brief	This variable is the height of the cone in pixels
///
/// This variable is the height of the cone at the current scale, in pixels.
/// It differs from the exact height in tiles, as it allows overlap so that the
/// ice cream appears to sit snugly in the sone.
char cone_height_pix;

/// \brief	This variable is the width of the cone in tiles
///
/// This variable is the width of the cone at the current scale, in tiles.
char cone_width;


/// \brief	This variable is the distance between ice cream on the stack at
///			which they slip.
///
/// This variable represents the distance at which the player will lose a life
/// if one of the pieces of ice cream on the stack's center differs from the 
/// piece below it.
char lose_distance;


/// \brief	This variable is the height of the top dollop of the ice cream at
///			the current scale, in tiles.
char icecream_top_height;

/// \brief	This variable is the width of the top dollop of the ice cream at
///			the current scale, in tiles.
char icecream_top_width;

/// \brief	This variable is how many pixels to add to offset the top dollop of
///			ice cream, at the current scale.
///
/// This variable is how many pixels to add to offset the top dollop of ice
/// cream at the current level's scale.  This value is separate from the others 
/// to allow overlap, which is necessary to achieve the graphical look of the 
/// game.
char icecream_top_y_add;


/// \brief	This variable is the height of the lower layer of the ice cream at
///			the current scale, in tiles.
char icecream_bottom_height;

/// \brief	This variable is the width of the lower layer of the ice cream at
///			the current scale, in tiles.
char icecream_bottom_width;

/// \brief	This variable is how many pixels to add to offset the lower layer 
/// 		of ice cream, at the current scale.
///
/// This variable is how many pixels to add to offset the lower layer of ice
/// cream at the current level's scale.  This value is separate from the others 
/// to allow overlap, which is necessary to achieve the graphical look of the 
/// game.
char icecream_bottom_y_add;

/// \brief	How fast the ice cream falls
///
/// This is how fast new ice cream falls when it can still be caught.  If it is
/// missed, or if the stack slips, then this speed is used as the basis but
/// multiplied.
char falling_speed;
