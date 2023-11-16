/// \file	unicorn.c
/// 
/// \brief	This file is contains the procedures and variables for the unicorn.
///
/// This C file contains the code and variables for the unicorn, mostly
/// related to how to update it.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "unicorn.h"


#include "audio.h"
#include "rng.h"
#include "icecream.h"


/// \brief	This array contains a simple sinus for the vertical movement of the
///			unicorn while it trots
char vertical_sinus[25] = {
	0,1,2,3,3,4,5,5,6,6,
	7,7,7,7,7,7,6,6,5,5,
	4,3,3,2,1
};

/// \brief	This procedure updates the unicorn's state every frame
///
/// This procedure updates the unicorn's state every frame, moving it both
/// horizontally and vertically, updating its animation indices, randomly
/// determining when to change direction and poop, and playing any sound 
/// effects related to its behavior.
void update_unicorn() {
	// we use the last_frame_index to determine if we should play the trot
	// sample
	char last_frame_index = unicorn_frame_index;
	
	// we only change animation frames every unicorn_frame_rate video frames at 
	// the fastest, so start by running that counter
	if (++unicorn_animation_delay > unicorn_frame_rate) {
		// reset the delay when it has completed
		unicorn_animation_delay = 0;
		
		// if we are not in the middle of ice cream falling or the animation
		// frame is not 0 (this is so that the unicorn will stop trotting when
		// the player has either finished the level or is losing a life).
		if ((falling_icecream_state != 3 && falling_stacked_state != 3) ||
			unicorn_frame_index != 0) {
			// increment the animation frame index, and if necessary, reset it.
			if (++unicorn_frame_index > 6) {
				unicorn_frame_index = 0;
			}
		}
	}
	
	// if the unicorn has just started moving again
	if (last_frame_index == 0 && unicorn_frame_index == 1) {
		// play the trot sample
		play_sample(runtime_sample_start[1], runtime_sample_end[1], 1);
	}
	
	
	// we only move the unicorn for frames 2-6, as for the first two frames,
	// the unicorn is standing on the ground.
	if (unicorn_frame_index > 1) {
		// if the unicorn is facing right
		if (unicorn_facing == 0) {
			// and if the unicorn is not on the edge of the screen
			if (unicorn_x + unicorn_speed < 607) {
				// then move the unicorn
				unicorn_x += unicorn_speed;
			// otherwise, if it is on the edge of the screen
			} else {
				// toggle the direction it's facing
				unicorn_facing = 1;
			}
		// facing left is basically the same thing, just a different edge and
		// subtraction instead of addition.
		} else {
			if (unicorn_x - unicorn_speed > 1) {
				unicorn_x -= unicorn_speed;
			} else {
				unicorn_facing = 0;
			}
		}
		
		// and set the unicorn's vertical position based on the sinus we use
		// to give a nice curve to its vertical movement when trotting
		unicorn_y = vertical_sinus[vertical_sinus_index++];
	// or, if we're in the first two frames
	} else {
		// it does not move vertically, so reset both its y position and its
		// sinus index
		unicorn_y = 0;
		vertical_sinus_index = 0;
	}
	
	// this will be used to indicate if the unicorn should be dropping a poop
	// this frame.
	char unicorn_drop_poop = 0;
	
	// now to start determining the random behavior of the unicorn, get a 
	// random number from the pseudo-RNG.
	unsigned long rng = random();
	
	// if there are no falling dollops of ice cream, and the unicorn has not
	// already started pooping, then check to see if the RNG indicates that it
	// should trigger a new poop
	if (!falling_icecream_state && !unicorn_pooping && !falling_stacked_state) {
		--cur_poop_delay;
		if ( ((rng & random_poop_mask) < random_poop_value) || 
			cur_poop_delay == 0 ) {
		
			// and if so, then flag that the unicorn is in the middle of pooping, 
			// and set the frame counter for how long the tail will be lifted 
			// before the unicorn poops.
			unicorn_pooping = 1;
			unicorn_countdown = 50;
			cur_poop_delay = max_poop_delay;
		}
	
	// if the unicorn hasn't just started pooping...
	} else {
		// and the pooping timer hasn't expired, then count down to it
		if (unicorn_countdown) {
			--unicorn_countdown;
		// otherwise, if the unicorn is trying to poop, then it's done pooping
		// and it's time to drop the ice cream dollop.
		} else if (unicorn_pooping) {
			unicorn_pooping = 0;
			unicorn_drop_poop = 1;
		}
	}
	
	// grab another random number from the pseudo-RNG.
	rng = random();
	
	// Now check to see if the RNG has determined that it's time for the 
	// unicorn to swap horizontal direction;
	if ((rng & random_facing_mask) < random_facing_value || 
		--cur_facing_delay == 0) {
		unicorn_facing = unicorn_facing ? 0 : 1;
		cur_facing_delay = max_facing_delay;
	}
	
	// If it's time to drop the ice cream dollop
	if (unicorn_drop_poop) {
		// play the samples that indicate pooping has happened
		play_sample(runtime_sample_start[3], runtime_sample_end[3], 1);
		play_sample(runtime_sample_start[2], runtime_sample_end[2], 1);
		
		// set the starting position for the falling ice cream, and the state
		// to indicate that ice cream is falling
		falling_icecream_state = 1;
		falling_icecream_x = unicorn_x;
		falling_icecream_y = 0;
		
		// and turn off poop dropping
		unicorn_drop_poop = 0;
	}
}

/// \brief	The vertical position of the unicorn
///
/// The vertical position of the unicorn.  This can only be a value from 0-7, 
/// as the unicorn's vertical movement is limited to no more than one tile.
char           unicorn_y               = 0;

/// \brief	What direction the unicorn is facing
///
/// What direction the unicorn is facing - 0 for right, 1 for left.
char           unicorn_facing          = 0;

/// \brief	The current frame of the unicorn's animation
char           unicorn_frame_index     = 0;

/// \brief	Indicates that the unicorn is preparing to poop
///
/// If true, then the unicorn is preparing to poop, and its tail should be 
/// lifted.
char           unicorn_pooping         = 0;

/// \brief	This is used to time how frequently to update the unicorn's 
///			animation.
char           unicorn_animation_delay = 0;

/// \brief	This is the lookup index for the vertical movement of the unicorn
char           vertical_sinus_index    = 0;

/// \brief	This is the timer used to set how long the unicorn's tail is lifted
///			before it poops.
char           unicorn_countdown       = 0;

/// \brief	How many pixels horizontally the unicorn moves each frame.
char           unicorn_speed           = 1;

/// \brief	How many vertical retraces are there per unicorn animation update
char		   unicorn_frame_rate	   = 4;

/// \brief	The unicorn's current horizontal position.
unsigned short unicorn_x               = 304;

/// \brief	This table is used because frames 2 and 3 of the 5 frame animation
///			are played twice as long as the others.
char unicorn_frame_lookup[7] = {
	0, 1, 2, 2, 3, 3, 4
};

/// \brief	This is the mask used to isolate the relevant number of bits we use
///			to determine if it's time for the unicorn to poop.
unsigned long random_poop_mask;	// $1ff < $1

/// \brief	This is the value that the masked random number must be less than 
///			to trigger pooping.
unsigned long random_poop_value;

/// \brief	This counter is used to avoid random chance causing it to take a
///			long time to poop
unsigned short cur_poop_delay;

/// \brief	This is the maximum time to wait for a random poop before forcing 
/// 		it
unsigned short max_poop_delay;

/// \brief	This is the mask used to isolate the relevant number of bits we use
///			to determine if it's time for the unicorn to change direction
unsigned long random_facing_mask; // $7fe00 < $1

/// \brief	This is the value that the masked random number must be less than
///			to trigger changing direction.
unsigned long random_facing_value;

/// \brief	This counter is used to avoid random chance causing a direction
///			change to not happen.
unsigned short cur_facing_delay;

/// \brief	This is the maximum time to wait for a direction change before
///			forcing one
unsigned short max_facing_delay;
