/// \file	unicorn.h
/// 
/// \brief	This file is the header file that declares the procedures and
///			variables for the unicorn.
///
/// This header file declares the code and variables for the unicorn, mostly
/// related to how to update it.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __UNICORN_H
#define __UNICORN_H

void update_unicorn();

extern unsigned short unicorn_x;
extern char unicorn_y;
extern char unicorn_facing;
extern char unicorn_frame_lookup[7];
extern char unicorn_frame_index;
extern char unicorn_speed;
extern char unicorn_pooping;
extern char unicorn_animation_delay;
extern char vertical_sinus_index;
extern char unicorn_countdown;
extern unsigned long random_poop_mask;
extern unsigned long random_poop_value;
extern unsigned long random_facing_mask;
extern unsigned long random_facing_value;

#endif
