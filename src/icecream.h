/// \file	icecream.h
/// 
/// \brief	This file is the header file that declares the code for managing
///			the data specific to the ice cream
///
/// This header file declares the code and variables that are used to describe
/// the ice cream in the ways the game uses it.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __ICECREAM_H
#define __ICECREAM_H

void update_falling_icecream();

extern unsigned short falling_icecream_x;
extern unsigned short falling_icecream_y;
extern char           falling_icecream_state;

extern unsigned short stack_top;
extern unsigned short stack_render_top;

extern unsigned short falling_stacked_x;
extern unsigned short falling_stacked_y;
extern char           falling_stacked_state;

#endif
