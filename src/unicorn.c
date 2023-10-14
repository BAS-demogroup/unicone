#include "unicorn.h"



char _unicorn_animation_delay = 0;

char _vertical_sinus[] = {
	1,2,3,4,5,5,6,6,7,7,7,7,7,6,6,5,5,4,3,2
};

char _vertical_sinus_index = 0;

void update_unicorn() {
	if (++_unicorn_animation_delay > 4) {
	
		_unicorn_animation_delay = 0;
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
		
		unicorn_y = _vertical_sinus[_vertical_sinus_index++];
	} else {
		unicorn_y = 0;
		_vertical_sinus_index = 0;
	}
}

unsigned short unicorn_x = 304;
char unicorn_y = 0;
char unicorn_facing = 0;
char unicorn_frame_index = 0;
char unicorn_speed = 1;

char unicorn_frame_lookup[7] = {
	0, 1, 2, 2, 3, 3, 4
};