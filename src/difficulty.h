/// \file	difficulty.h
/// 
/// \brief	This file is the header file that declares the code and variables 
///			that define the difficulty
///
/// This header file declares the code and all of the variables that are used
/// to describe the difficulty curve of the game, although the swing of the
/// stack is also a part of the difficulty and is defined in a file of its own.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __DIFFICULTY_H
#define __DIFFICULTY_H

void set_level_difficulty();

extern char scale;

extern char cone_height;
extern char cone_height_pix;
extern char cone_width;

extern char lose_distance;
extern char warn_distance;
extern signed char splash_offset[3][2];

extern char icecream_top_height;
extern char icecream_top_width;
extern char icecream_top_y_add;

extern char icecream_bottom_height;
extern char icecream_bottom_width;
extern char icecream_bottom_y_add;

extern char falling_speed;

extern char unicorn_frame_rates[24];

#endif
