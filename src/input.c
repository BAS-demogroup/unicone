#include "input.h"


#include "chips.h"
#include "gameloop.h"


void process_input() {
	// is M pressed?
	KEYSCAN.MATRIXPEEK = 0x04;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x04)) == 0) {
		if (!key_down) {
			if (muted) {
				if (current_loaded_state == 0) {
					SID1.VOLUME_FTYPE = 0x3f;
					SID2.VOLUME_FTYPE = 0x74;
					SID3.VOLUME_FTYPE = 0x7f;
					SID4.VOLUME_FTYPE = 0x2f;
				} else {
					SID1.VOLUME_FTYPE = 0x6f;
					SID2.VOLUME_FTYPE = 0x6a;
					SID3.VOLUME_FTYPE = 0x2b;
					SID4.VOLUME_FTYPE = 0x3b;
				}
			} else {
				if (current_loaded_state == 0) {
					SID1.VOLUME_FTYPE = 0x30;
					SID2.VOLUME_FTYPE = 0x70;
					SID3.VOLUME_FTYPE = 0x70;
					SID4.VOLUME_FTYPE = 0x20;
				} else {
					SID1.VOLUME_FTYPE = 0x60;
					SID2.VOLUME_FTYPE = 0x60;
					SID3.VOLUME_FTYPE = 0x20;
					SID4.VOLUME_FTYPE = 0x30;
				}
			}
			muted = ~muted;
			key_down = 1;
		}
	} else {
		key_down = 0;
	}
	
	// load joystick two
	player_input = ~CIA1.PORTA & 0x1f;
	
	// load joystick one
	player_input |= ~CIA1.PORTB & 0x1f;
	
	// is W pressed?
	KEYSCAN.MATRIXPEEK = 0x01;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x01)) == 0) {
		player_input |= 0b00000001;
	}
	
	// is S pressed?
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x05)) == 0) {
		player_input |= 0b00000010;
	}
	
	// is A pressed?
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x02)) == 0) {
		player_input |= 0b00000100;
	}
	
	// is left shift pressed?
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x07)) == 0) {
		player_input |= 0b00010000;
	}

	// is D pressed?
	KEYSCAN.MATRIXPEEK = 0x02;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x02)) == 0) {
		player_input |= 0b00001000;
	}
	
	// is right shift pressed?
	KEYSCAN.MATRIXPEEK = 0x06;
	if ((KEYSCAN.CRTACSCNT & (0x01 << 0x04)) == 0) {
		player_input |= 0b00010000;
	}
}

char player_input = 0;
char key_down     = 0;
char muted;
