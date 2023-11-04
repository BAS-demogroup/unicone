/// \file	setup.h
/// 
/// \brief	This file is the header file for the code responsible for loading 
/// 		and setup of the game
/// \author deathy (AKA Clifford A. Anderson)
///
/// This header file defines the procedures that load all of the data at 
/// startup, as well as the code that is called for switching between the 3
/// modes of the game - title screen, in-game loop, and game over.
///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#ifndef __SETUP_H
#define __SETUP_H


void loader();


void title_setup();
void ingame_setup();
void gameover_setup();


void load_loader();
void load_rest();


void set_480();
void set_400();


extern unsigned short update_raster;


#endif