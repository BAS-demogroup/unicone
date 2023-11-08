/// \file	input.c
/// 
/// \brief	This file contains the code and variables for handling player input ///
/// \copyright 2023 by BAS and deathy (AKA Clifford A. Anderson).  
/// All rights reserved.
#include "input.h"


#include "chips.h"
#include "gameloop.h"


/// \brief	This procedure processes the player input
///
/// This procedure processes all of the player input, mergin the input of both
/// joysticks as well as keyboard controls into a single input bitmask to allow
/// us to be input agnostic (not counting mouse and paddles, of course).
void process_input() {
	// is M pressed?  This is a special keyboard command for muting the music
	KEYSCAN.MATRIXPEEK = 0x04;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x04)) == 0) {
		// if it is pressed, and it wasn't the last time we test it,
		if (!key_down) {
			// then we can toggle the muting
			muted = ~muted;
			// and flag that the M key is down, so that we can wait for the key
			// to be released before toggline again.  This is so we don't very
			// rapidly toggle the music on and off every frame this input is
			// called
			key_down = 1;
		}
	} else {
		// otherwise, if the M key is not pressed, then we clear the key_down
		// flag.
		key_down = 0;
	}
	
	// load joystick two.  we mask it to just the relevant bits, and we also
	// invert the values because the default is for the bits being off to
	// indicate movement and fire button.  we invert it to make the code more
	// readable elsewhere without having to constantly explain this oddity
	// inherited from the c64.
	player_input = ~CIA1.PORTA & 0x1f;
	
	// load joystick one.  masked and inverted just like the joystick in port 2
	player_input |= ~CIA1.PORTB & 0x1f;
	
	// the order of how the keys are processed is to avoid changing the fields
	// more than necessary.
	
	// is W pressed?  set the up bit
	KEYSCAN.MATRIXPEEK = 0x01;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x01)) == 0) {
		player_input |= 0b00000001;
	}
	
	// is S pressed?  set the down bit
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x05)) == 0) {
		player_input |= 0b00000010;
	}
	
	// is A pressed?  set the left bit
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x02)) == 0) {
		player_input |= 0b00000100;
	}
	
	// is left shift pressed? set the fire bit
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x07)) == 0) {
		player_input |= 0b00010000;
	}

	// is D pressed?  set the right bit
	KEYSCAN.MATRIXPEEK = 0x02;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x02)) == 0) {
		player_input |= 0b00001000;
	}
	
	// is right shift pressed?  set the fire bit
	KEYSCAN.MATRIXPEEK = 0x06;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x04)) == 0) {
		player_input |= 0b00010000;
	}
}

/// \brief	This variable contains the player input
///
/// This variable contains the player input, using a bit mask as follows:
///
/// Mask      | Input Result
/// --------- | ------------
/// %00000001 | Up
/// %00000010 | Down
/// %00000100 | Left
/// %00001000 | Right
/// %00010000 | Fire
///
/// This is basically the same bitmask as the CIA joystick bitmask, only 
/// inverted and without using the top 3 bits.
char player_input = 0;

/// \brief	This is used to wait for the M key to be released before responding
///			to it again.
char key_down     = 0;

/// \brief	Whether or not the music is muted.
char muted;
