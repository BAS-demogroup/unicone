#include "difficulty.h"


#include "gameloop.h"
#include "unicorn.h"


void set_level_difficulty() {
	// set scale values
	if (level < 9) {
		scale = 0;

		cone_height = 6;
		cone_height_pix = 60;
		cone_width = 2;

		lose_distance = 32;
		
		icecream_top_height = 5;
		icecream_top_width = 2;
		icecream_top_y_add = 24;
		
		icecream_bottom_height = 3;
		icecream_bottom_width = 2;
		icecream_bottom_y_add = 8;
		
		falling_speed = 2;
		
		if (level < 6) {
			unicorn_speed = 1;
		} else {
			unicorn_speed = 2;
		}
	} else if (level < 17) {
		scale = 1;

		cone_height = 3;
		cone_height_pix = 21;
		cone_width = 1;

		lose_distance = 16;
		
		icecream_top_height = 3;
		icecream_top_width = 1;
		icecream_top_y_add = 12;
		
		icecream_bottom_height = 2;
		icecream_bottom_width = 1;
		icecream_bottom_y_add = 4;
		
		falling_speed = 2;
		
		if (level < 14) {
			unicorn_speed = 1;
		} else {
			unicorn_speed = 2;
		}
	} else {
		scale = 2;

		cone_height = 2;
		cone_height_pix = 0;
		cone_width = 1;

		lose_distance = 8;
		
		icecream_top_height = 2;
		icecream_top_width = 1;
		icecream_top_y_add = 3;
		
		icecream_bottom_height = 2;
		icecream_bottom_width = 1;
		icecream_bottom_y_add = 2;
		
		falling_speed = 3;

		if (level < 22) {
			unicorn_speed = 1;
		} else {
			unicorn_speed = 2;
		}
	}
}


char scale;

char cone_height;
char cone_height_pix;
char cone_width;

char lose_distance;

char icecream_top_height;
char icecream_top_width;
char icecream_top_y_add;

char icecream_bottom_height;
char icecream_bottom_width;
char icecream_bottom_y_add;

char falling_speed;
