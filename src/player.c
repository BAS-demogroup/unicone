#include "player.h"


#include "input.h"


unsigned short _acceleration = 1;
void update_player() {
	// left?
	if ((player_input & 0b00000100) && player_position > 1 ) {
		player_position -= _acceleration;
		if (player_position < 1) {
			player_position = 1;
		}
		if (_acceleration < 16) {
			++_acceleration;
		}
		return;
	} 
	
	// right?
	if ((player_input & 0b00001000) && player_position < 608) {
		player_position += _acceleration;
		if (player_position > 607) {
			player_position = 607;
		}
		if (_acceleration < 16) {
			++_acceleration;
		}
		return;
	}
	
	_acceleration = 1;
}

short player_position = 304;
