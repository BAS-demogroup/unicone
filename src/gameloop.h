#ifndef __GAMELOOP_H
#define __GAMELOOP_H

void game_loop();
void draw_unicorn();
void draw_falling_icecream();
void draw_falling_stacked();
void draw_icecream_stack();
void draw_cone();

void reset_level();
void draw_lives();
void draw_level();
//void erase_dropped_stack();

extern unsigned short matrix_raster;

// this might fit in a char
extern unsigned short end_of_level_timer;
extern char level;

#endif