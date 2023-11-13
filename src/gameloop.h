/// \file	gameloop.h
/// 
/// \brief	This file is the header file that declares the main loop code for
///			the game.
///
/// This header file declares the code and variables for the main loop of the
/// game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __GAMELOOP_H
#define __GAMELOOP_H

void game_loop();
void draw_unicorn();
void draw_falling_icecream(unsigned short ytop);
void draw_falling_pooped();
void draw_falling_stacked();
void draw_icecream_stack();
void draw_cone();

void reset_level();
void draw_lives();
void draw_level();

extern char end_of_level_timer;
extern char end_of_level_timer_start;
extern char level;
extern char last_level;
extern char current_loaded_state;
extern char new_game_counter;
extern char warn_timer;
extern char catch_timer;

#endif