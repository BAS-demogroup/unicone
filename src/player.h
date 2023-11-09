/// \file	player.h
/// 
/// \brief	This file is the header file that declares the code and variables 
///			for managing the player state
///
/// This header file declares the code and variables for that are used to 
///	manage the cone and the stack of ice cream on top
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __PLAYER_H
#define __PLAYER_H

void update_player();

extern short       player_x;
extern char        stack_size;
extern signed char stack_offsets[50];
extern short       stack_x[50];
extern char        acceleration;
extern signed char icecream_swing;
extern signed char target_swing;
extern char        player_lives;
extern char        player_dying;
extern char        dollops;
extern char        next_level;

#endif
