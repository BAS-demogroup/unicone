#include "player.h"


#include "input.h"


unsigned short _acceleration = 1;
void update_player() {
	// left?
	if ((player_input & 0b00000100) && player_x > 1 ) {
		player_x -= _acceleration;
		if (player_x < 1) {
			player_x = 1;
		}
		if (_acceleration < 16) {
			++_acceleration;
		}
		return;
	} 
	
	// right?
	if ((player_input & 0b00001000) && player_x < 607) {
		player_x += _acceleration;
		if (player_x > 607) {
			player_x = 607;
		}
		if (_acceleration < 16) {
			++_acceleration;
		}
		return;
	}
	
	_acceleration = 1;
}

short player_x = 304;
