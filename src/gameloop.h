#ifndef __GAMELOOP_H
#define __GAMELOOP_H

void game_loop();
void draw_unicorn();
void draw_falling_icecream();
void draw_icecream_stack();
void draw_cone();

void reset_level();
void draw_lives();

extern unsigned short matrix_raster;

// this might fit in a char
extern unsigned short lost_life_timer;

#endif