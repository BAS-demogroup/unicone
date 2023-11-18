/// \file	gameoverloop.h
/// 
/// \brief	This file is the header file that declares the loop code at the end
///			of the game
///
/// This header file declares the code and variables for the game over loop of 
/// the game.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __GAMEOVERLOOP_H
#define __GAMEOVERLOOP_H

void gameover_loop();

void draw_gameover();

extern unsigned short gameover_x_pos;
extern char           gameover_facing;
extern char           gameover_y_index;

#endif
