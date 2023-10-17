#ifndef __PLAYER_H
#define __PLAYER_H

void update_player();

extern short player_x;
extern char stack_size;
extern signed char stack_offsets[50];
extern short stack_x[50];
extern char acceleration;
extern signed char icecream_swing;
extern signed char target_swing;
extern char player_lives;
extern char player_dying;

#endif
