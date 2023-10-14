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
extern char unicorn_drop_poop;

#endif
