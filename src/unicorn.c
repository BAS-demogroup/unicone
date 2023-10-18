#include "unicorn.h"


#include "rng.h"
#include "icecream.h"


char _vertical_sinus[] = {
	0,1,2,3,3,4,5,5,6,6,7,7,7,7,7,7,6,6,5,5,4,3,3,2,1
};

// char _test_delay = 0;
void update_unicorn() {
	// if (++_test_delay < 10) return;
	// _test_delay = 0;
	if (++unicorn_animation_delay > 4) {
	
		unicorn_animation_delay = 0;
		if (++unicorn_frame_index > 6) {
			unicorn_frame_index = 0;
		}
	}
	
	// we only move the unicorn for frames 2-6, as for the first two frames,
	// the unicorn is standing on the ground.
	if (unicorn_frame_index > 1) {
		if (unicorn_facing == 0) {
			if (unicorn_x + unicorn_speed < 607) {
				unicorn_x += unicorn_speed;
			} else {
				unicorn_facing = 1;
			}
		} else {
			if (unicorn_x - unicorn_speed > 1) {
				unicorn_x -= unicorn_speed;
			} else {
				unicorn_facing = 0;
			}
		}
		
		unicorn_y = _vertical_sinus[vertical_sinus_index++];
	} else {
		unicorn_y = 0;
		vertical_sinus_index = 0;
	}
	
	unsigned long rng = random();
	if (!falling_icecream_state && !unicorn_pooping && (rng & 0x1ff) == 0x00) {
		unicorn_pooping = 1;
		unicorn_countdown = 50;
	} else {
		if (unicorn_countdown) {
			--unicorn_countdown;
		} else if (unicorn_pooping) {
			unicorn_pooping = 0;
			unicorn_drop_poop = 1;
		}
	}
	
	if ((rng & 0x7fe00) == 0x00) {
		unicorn_facing = unicorn_facing ? 0 : 1;
	}
	
	if (unicorn_drop_poop) {
		falling_icecream_state = 1;
		falling_icecream_x = unicorn_x;
		falling_icecream_y = 0;
		unicorn_drop_poop = 0;
	}
}

char           unicorn_y               = 0;
char           unicorn_facing          = 0;
char           unicorn_frame_index     = 0;
char           unicorn_pooping         = 0;
char           unicorn_drop_poop       = 0;
char           unicorn_animation_delay = 0;
char           vertical_sinus_index    = 0;
char           unicorn_countdown       = 0;

char           unicorn_speed           = 1;

unsigned short unicorn_x               = 304;

char unicorn_frame_lookup[7] = {
	0, 1, 2, 2, 3, 3, 4
};
